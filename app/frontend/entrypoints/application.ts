import * as ActiveStorage from "@rails/activestorage";
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import "./scripts/input_date";
import "./scripts/mobile_navigation";
import "../../assets/stylesheets/application.css";

ActiveStorage.start();
Rails.start();
Turbolinks.start();
