import string

from logger import log
from robot.libraries.BuiltIn import BuiltIn
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.by import By

ROBOT_LIBRARY_VERSION = "0.1"


def select_database_instance(
    instance_elem: string,
    click_elem: string,
    alert_elem: string = "//*[contains(.,'AlreadyExists')]",
):
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
    sl = BuiltIn().get_library_instance("SeleniumLibrary")
    element = sl.find_element(sort_elem)
    element.click()
    log.info(element.get_attribute(attribute))
    if not order in element.get_attribute(attribute):
        element.click()
        log.info("Element sorted " + order + " order")
    else:
        log.info("Element sorted with " + order + " order already")
