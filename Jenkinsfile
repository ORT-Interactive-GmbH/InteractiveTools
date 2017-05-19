#!groovy

@Library('ort-interactive')
import static de.ortinteractive.Slack.*
import static de.ortinteractive.ReleaseType.*
import de.ortinteractive.IOSBuild

// set log rotation build discard strategy
properties([[$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', artifactNumToKeepStr: '3', numToKeepStr: '3']]])

// expected apk output file name
def ipaFile            = 'builds/InteractiveTools.ipa'
def slackChannel       = '#appdevelopment'
def appdistributionKey = '1188706907'
def releaseType        = releaseTypeFromBranch env.BRANCH_NAME
def matchBranch        = 'ort'

// create build object
def appBuild = new IOSBuild(releaseType, ipaFile, appdistributionKey, matchBranch)

node('ios') {
   stage('Checkout') {
      // checkout source code
      checkout scm
   }

   stage('Build') {
      // run build
      appBuild.build(this, slackChannel)
   }

   stage('Distribution') {
      // deliver file (either appdistribution or app store)
      appBuild.deploy this, slackChannel
   }
}

notifyBuild(this, slackChannel, "SUCCESSFUL")
