#!/usr/bin/env bash
#function waitForAptDpkgLocks() {
#    echo "Checking apt/dpkg locks"
#    while lsof /var/lib/dpkg/lock-frontend; do sleep 10; echo 'waiting for dpkg lock-frontend'; done;
#    while lsof /var/lib/apt/lists/lock; do sleep 10; echo 'waiting for dpkg lock'; done;
#}



function waitForAptDpkgLocks {
  isLocked="yes"
  while [[ "$isLocked" == "yes" ]]; do
      lsof /var/lib/apt/lists/lock > /dev/null
      apt_is_locked="$?"
      lsof /var/lib/dpkg/lock > /dev/null
      dpkg_is_locked="$?"
      lsof /var/lib/dpkg/lock-frontend > /dev/null
      dpkg_frontend_is_locked="$?"
      if [[ "$apt_is_locked" == "0" || "$dpkg_is_locked" == "0" || "$dpkg_frontend_is_locked" == "0" ]]; then
        echo "Waiting for another installation to finish"
        echo "apt_is_locked=$apt_is_locked,  apt_is_locked=$apt_is_locked, dpkg_frontend_is_locked=$dpkg_frontend_is_locked"
        sleep 5
      else
        isLocked="no"
      fi
  done;
}
