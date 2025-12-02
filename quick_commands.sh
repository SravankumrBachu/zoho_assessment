#!/bin/bash

# Admission Management System - Quick Reference Commands
# This script contains useful commands for building, running, and testing the application

# ============================================================================
# BUILD & RUN COMMANDS
# ============================================================================

# Clean and build the project
build_project() {
    echo "Building project..."
    mvn clean install
}

# Run the application in development mode
run_app() {
    echo "Starting application..."
    mvn spring-boot:run
}

# Build and run in one command
build_and_run() {
    echo "Building and running application..."
    mvn clean install spring-boot:run
}

# Skip tests during build (faster)
build_skip_tests() {
    echo "Building without tests..."
    mvn clean package -DskipTests
}

# Build JAR for production
build_jar() {
    echo "Building JAR..."
    mvn clean package
    echo "JAR created at: target/admission-management-system-1.0.0.jar"
}

# ============================================================================
# TEST COMMANDS
# ============================================================================

# Run all tests
run_tests() {
    echo "Running all tests..."
    mvn test
}

# Run specific test class
run_test_class() {
    if [ -z "$1" ]; then
        echo "Usage: run_test_class <TestClassName>"
        return 1
    fi
    mvn test -Dtest=$1
}

# Run tests with coverage
run_tests_coverage() {
    echo "Running tests with code coverage..."
    mvn clean test jacoco:report
}

# ============================================================================
# API TESTING COMMANDS (curl examples)
# ============================================================================

# Create a course
create_course() {
    echo "Creating course..."
    curl -X POST http://localhost:8080/api/courses \
        -H "Content-Type: application/json" \
        -d '{
            "courseName": "Java Advanced",
            "description": "Advanced Java Programming",
            "duration": 3,
            "level": "Advanced",
            "active": true
        }'
}

# Get all courses
get_courses() {
    echo "Fetching all courses..."
    curl http://localhost:8080/api/courses | jq .
}

# Get active courses
get_active_courses() {
    echo "Fetching active courses..."
    curl http://localhost:8080/api/courses/active | jq .
}

# Get course by ID
get_course_by_id() {
    if [ -z "$1" ]; then
        echo "Usage: get_course_by_id <courseId>"
        return 1
    fi
    echo "Fetching course $1..."
    curl http://localhost:8080/api/courses/$1 | jq .
}

# Submit an application
submit_application() {
    echo "Submitting application..."
    curl -X POST http://localhost:8080/api/applications/submit \
        -H "Content-Type: application/json" \
        -d '{
            "applicantName": "John Doe",
            "email": "john@example.com",
            "phoneNumber": "1234567890",
            "address": "123 Main Street",
            "additionalInformation": "Experienced programmer",
            "courseId": 1
        }'
}

# Get all applications (admin)
get_applications() {
    echo "Fetching all applications..."
    curl http://localhost:8080/api/applications | jq .
}

# Get pending applications
get_pending_applications() {
    echo "Fetching pending applications..."
    curl http://localhost:8080/api/applications/status/pending | jq .
}

# Get selected applications (Students report)
get_selected_applications() {
    echo "Fetching selected applications..."
    curl http://localhost:8080/api/applications/status/selected | jq .
}

# Get application by ID
get_application_by_id() {
    if [ -z "$1" ]; then
        echo "Usage: get_application_by_id <applicationId>"
        return 1
    fi
    echo "Fetching application $1..."
    curl http://localhost:8080/api/applications/$1 | jq .
}

# Update application status to SELECTED
select_application() {
    if [ -z "$1" ]; then
        echo "Usage: select_application <applicationId>"
        return 1
    fi
    echo "Selecting application $1..."
    curl -X PUT http://localhost:8080/api/applications/$1/status \
        -H "Content-Type: application/json" \
        -d '{"status": "SELECTED"}'
}

# Update application status to REJECTED
reject_application() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: reject_application <applicationId> <rejectionReason>"
        return 1
    fi
    echo "Rejecting application $1..."
    curl -X PUT http://localhost:8080/api/applications/$1/status \
        -H "Content-Type: application/json" \
        -d "{\"status\": \"REJECTED\", \"rejectionReason\": \"$2\"}"
}

# Get all students
get_students() {
    echo "Fetching all students..."
    curl http://localhost:8080/api/applications/students/all | jq .
}

# Get students by course
get_students_by_course() {
    if [ -z "$1" ]; then
        echo "Usage: get_students_by_course <courseId>"
        return 1
    fi
    echo "Fetching students in course $1..."
    curl http://localhost:8080/api/applications/students/course/$1 | jq .
}

# Get application statistics
get_statistics() {
    echo "Fetching application statistics..."
    curl http://localhost:8080/api/applications/statistics | jq .
}

# ============================================================================
# MAVEN UTILITY COMMANDS
# ============================================================================

# Display dependency tree
show_dependencies() {
    echo "Displaying Maven dependency tree..."
    mvn dependency:tree
}

# Check for outdated dependencies
check_outdated_deps() {
    echo "Checking for outdated dependencies..."
    mvn versions:display-dependency-updates
}

# Update dependencies
update_dependencies() {
    echo "Updating project dependencies..."
    mvn versions:use-latest-versions -DallowSnapshots=false
    mvn versions:commit
}

# Clean all build artifacts
clean_build() {
    echo "Cleaning build artifacts..."
    mvn clean
    rm -rf target/
}

# ============================================================================
# DATABASE COMMANDS
# ============================================================================

# Clear local Maven repository (use if dependency issues)
clear_maven_cache() {
    echo "Clearing Maven cache..."
    rm -rf ~/.m2/repository
    echo "Cache cleared. Run: mvn clean install"
}

# ============================================================================
# APPLICATION LIFECYCLE
# ============================================================================

# Check if application is running
check_app_status() {
    echo "Checking application status..."
    curl -s http://localhost:8080/actuator/health | jq . || echo "Application is not running"
}

# Kill application on port 8080
kill_app() {
    echo "Stopping application on port 8080..."
    lsof -ti:8080 | xargs kill -9
    echo "Application stopped"
}

# ============================================================================
# HELP & DOCUMENTATION
# ============================================================================

# Display this help message
show_help() {
    echo "Admission Management System - Quick Reference Commands"
    echo ""
    echo "Build & Run:"
    echo "  build_project              - Clean and build the project"
    echo "  run_app                    - Run application in development mode"
    echo "  build_and_run              - Build and run in one command"
    echo "  build_skip_tests           - Build without running tests"
    echo "  build_jar                  - Build JAR for production"
    echo ""
    echo "Testing:"
    echo "  run_tests                  - Run all tests"
    echo "  run_test_class [name]      - Run specific test class"
    echo "  run_tests_coverage         - Run tests with code coverage"
    echo ""
    echo "API Testing:"
    echo "  create_course              - Create a sample course"
    echo "  get_courses                - Get all courses"
    echo "  get_active_courses         - Get active courses only"
    echo "  get_course_by_id [id]      - Get course by ID"
    echo "  submit_application         - Submit sample application"
    echo "  get_applications           - Get all applications"
    echo "  get_pending_applications   - Get pending applications"
    echo "  get_selected_applications  - Get selected applications"
    echo "  get_application_by_id [id] - Get application by ID"
    echo "  select_application [id]    - Mark application as SELECTED"
    echo "  reject_application [id] [reason] - Reject application with reason"
    echo "  get_students               - Get all enrolled students"
    echo "  get_students_by_course [id] - Get students by course"
    echo "  get_statistics             - Get application statistics"
    echo ""
    echo "Maven Utilities:"
    echo "  show_dependencies          - Display dependency tree"
    echo "  check_outdated_deps        - Check for outdated dependencies"
    echo "  update_dependencies        - Update project dependencies"
    echo "  clean_build                - Clean all build artifacts"
    echo ""
    echo "Database:"
    echo "  clear_maven_cache          - Clear local Maven cache"
    echo ""
    echo "Application Lifecycle:"
    echo "  check_app_status           - Check if application is running"
    echo "  kill_app                   - Stop application on port 8080"
    echo ""
    echo "Documentation:"
    echo "  show_help                  - Display this help message"
}

# ============================================================================
# MAIN
# ============================================================================

# If script is sourced, functions are available
# If script is executed, show help
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    if [ -z "$1" ]; then
        show_help
    else
        # Try to execute the function passed as argument
        "$@"
    fi
fi
