import os
import re
import string
import time
import util

import yaml
from logger import log
from OpenShiftLibrary import OpenShiftLibrary
from robot.libraries.BuiltIn import BuiltIn
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.by import By

ROBOT_LIBRARY_VERSION = "0.4"


def select_database_instance(
    instance_elem: string,
    click_elem: string,
    alert_elem: string = "//*[contains(.,'AlreadyExists')]",
):
    """To select a valid DB instance from Instance table on Developer view"""
    sl = BuiltIn().get_library_instance("SeleniumLibrary")
    count = sl.find_elements(instance_elem)
    if not count:
        log.error("No Database Instances Available for Selected Account")
    for elem_iter in range(1, len(count) + 1):
        target = "(" + instance_elem + "/td[1]/input)[" + str(elem_iter) + "]"
        instance_name = "(" + instance_elem + "/td[2])[" + str(elem_iter) + "]"
        sl.find_element(target).click()
        element_attribute = sl.find_element(instance_name).get_attribute("innerHTML")
        sl.scroll_element_into_view(click_elem)
        sl.click_element(click_elem)
        try:
            sl.driver.find_element(By.XPATH, alert_elem)
        except NoSuchElementException:
            log.info("returning element : " + element_attribute)
            return element_attribute
    log.error("Database Instance Selection Failed")


def sort_webtable_column(
    sort_elem: string, order: string, attribute: string = "aria-sort"
):
    """To sort Webtable column for given order"""
    sl = BuiltIn().get_library_instance("SeleniumLibrary")
    element = sl.find_element(sort_elem)
    element.click()
    log.info(element.get_attribute(attribute))
    if not order in element.get_attribute(attribute):
        element.click()
        log.info("Element sorted " + order + " order")
    else:
        log.info("Element sorted with " + order + " order already")


def write_yaml_to_textbox(isv: string, target_elem: string):
    """To Import YAML into Openshift"""
    sl = BuiltIn().get_library_instance("SeleniumLibrary")
    file_path = os.getcwd() + "/utils/data/oc_" + isv + "_application.yaml"
    with open(file_path, "r") as f:
        text = f.read()
    element = sl.find_element(target_elem)
    element.click()
    sl.input_text(target_elem, text)


def get_import_application_name(isv: string):
    """To retrieve Application name from input YAML"""
    file_path = os.getcwd() + "/utils/data/oc_" + isv + "_application.yaml"
    try:
        with open(file_path, "r") as f:
            for data in yaml.load_all(f, Loader=yaml.FullLoader):
                return data["metadata"]["name"]
    except yaml.YAMLError as e:
        log.error("Error while parsing data file: " + str(e.context))


def update_service_binding(project_name, pa_name, app_name):
    """To update the Service binding yaml file"""
    binder = os.getcwd() + "/utils/data/oc_source_binding.yaml"
    with open(binder, "r") as fh:
        data = yaml.safe_load(fh)
    data["metadata"] = {}
    data["metadata"]["name"] = project_name + "-" + pa_name
    data["metadata"]["namespace"] = project_name
    data["spec"]["application"]["name"] = app_name
    data["spec"]["services"][0]["name"] = pa_name
    with open(binder, "w") as yaml_file:
        yaml_file.write(yaml.dump(data, default_flow_style=False, sort_keys=False))
    log.info("Updated Service binding!")
    return data["metadata"]["name"]


def create_service_binding(namespace):
    """To Create Service Binding between DB instance to Openshift Application"""
    oc_cli = BuiltIn().get_library_instance("OpenshiftLibrary")
    kind = "ServiceBinding"
    src = "utils/data/oc_source_binding.yaml"
    api_version = "binding.operators.coreos.com/v1alpha1"
    oc_cli.oc_apply(kind, src, api_version, namespace)
    log.info("Create Service binding Successfully!")


def get_quarkus_application_url(console_url, connection):
    """To return application connection URL from console URL"""
    application_url = console_url.replace("console-openshift-console", connection)
    application_url = re.sub(r"/$", "", application_url) + "/fruits.html"
    log.info(application_url)
    return application_url.replace("https", "http")


def create_secret_yaml(isv_lower, valid, namespace):
    """To configure secrets yaml template parameters basis
    input ISV(Database Provider)"""
    secret_temp = "./utils/data/oc_secrets.yaml"
    test_variables = "./test-variables.yaml"
    with open(secret_temp, "r") as sf:
        data = yaml.safe_load(sf)
    with open(test_variables, "r") as sf2:
        variables = yaml.safe_load(sf2)
    global secret_name
    secret_name = (
        str(data["metadata"]["name"])
        + "-"
        + isv_lower
        + "-"
        + str(time.time_ns())[-10:]
    )
    data["metadata"]["name"] = secret_name
    data["metadata"]["namespace"] = namespace
    if "mongo" in isv_lower:
        data["metadata"]["labels"]["atlas.mongodb.com/type"] = "credentials"
        data["stringData"] = variables["MONGO"]
    elif "crunchy" in isv_lower:
        data["stringData"] = variables["CRUNCHY"]
        data["metadata"]["labels"]["db-operator/type"] = "credentials"
    elif "cockroach" in isv_lower:
        data["stringData"] = variables["COCKROACH"]
        data["metadata"]["labels"]["db-operator/type"] = "credentials"
    if valid == "False":
        last_key = list(data["stringData"].keys())[-1]
        data["stringData"][last_key] = "invalidData"
    return yaml.dump(data, sort_keys=False)


def create_secret_cli(isv, valid, namespace="redhat-dbaas-operator"):
    """To create the Secret Credentials Resource using the secrets yaml"""
    oc_cli = BuiltIn().get_library_instance("OpenshiftLibrary")
    kind = "Secret"
    src = create_secret_yaml(isv.lower(), valid, namespace)
    api_version = "v1"
    oc_cli.oc_apply(kind, src, api_version)
    log.info("Secret Created successfully!")
    BuiltIn().set_suite_variable("\${SECRET_NAME}", secret_name)


def create_provider_account_yaml(isv_lower, namespace):
    """To configure provider account yaml template parameters basis
    input ISV(Database Provider)"""
    pa_yaml_temp = "./utils/data/oc_provider_account.yaml"
    with open(pa_yaml_temp, "r") as sf:
        data = yaml.safe_load(sf)
    global prov_acc_name
    prov_acc_name = util.get_provider_account_name(isv_lower)
    data["metadata"]["name"] = prov_acc_name
    data["metadata"]["namespace"] = namespace
    data["spec"]["credentialsRef"]["name"] = secret_name
    if "mongo" in isv_lower:
        data["spec"]["providerRef"]["name"] = "mongodb-atlas-registration"
    elif "crunchy" in isv_lower:
        data["spec"]["providerRef"]["name"] = "crunchy-bridge-registration"
    elif "cockroach" in isv_lower:
        data["spec"]["providerRef"]["name"] = "cockroachdb-cloud-registration"
    return yaml.dump(data, sort_keys=False)


def import_provider_account_cli(isv, namespace="redhat-dbaas-operator"):
    """To import a Provider Account using the configured
    Provider Account yaml"""
    oc_cli = BuiltIn().get_library_instance("OpenshiftLibrary")
    kind = "DBaaSInventory"
    src = create_provider_account_yaml(isv.lower(), namespace)
    api_version = "dbaas.redhat.com/v1alpha1"
    oc_cli.oc_apply(kind, src, api_version)
    log.info("Provider Account Imported!")
    BuiltIn().set_suite_variable("\${provaccname}", prov_acc_name)
