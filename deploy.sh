#!/bin/bash

APP_PATH="/vagrant/webapp"
WAR_NAME="webapp.war"
TARGET_WAR="$APP_PATH/target/$WAR_NAME"
TOMCAT_PATH="/var/lib/tomcat9/webapps"
SERVICE="tomcat9"

# Couleurs
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
NC="\e[0m"

clear
echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE}        MENU DEPLOY TOMCAT              ${NC}"
echo -e "${BLUE}=========================================${NC}"
echo "1 - Build Application (Maven)"
echo "2 - Deploy WAR"
echo "3 - Restart Tomcat"
echo "4 - Stop Tomcat"
echo "5 - Start Tomcat"
echo "6 - Status Tomcat"
echo "7 - Clean & Full Deploy"
echo "0 - Quit"
echo "========================================="
read -p "Choisissez une option: " choix

case $choix in

	1)
		    echo -e "${YELLOW}Building application...${NC}"
		        cd $APP_PATH
			    mvn clean package
			        ;;

			2)
				    echo -e "${YELLOW}Deploying WAR...${NC}"
				        sudo rm -rf $TOMCAT_PATH/webapp
					    sudo cp $TARGET_WAR $TOMCAT_PATH
					        echo -e "${GREEN}WAR deployed successfully.${NC}"
						    ;;

					    3)
						        echo -e "${YELLOW}Restarting Tomcat...${NC}"
							    sudo systemctl restart $SERVICE
							        echo -e "${GREEN}Tomcat restarted.${NC}"
								    ;;

							    4)
								        echo -e "${RED}Stopping Tomcat...${NC}"
									    sudo systemctl stop $SERVICE
									        echo -e "${GREEN}Tomcat stopped.${NC}"
										    ;;

									    5)
										        echo -e "${YELLOW}Starting Tomcat...${NC}"
											    sudo systemctl start $SERVICE
											        echo -e "${GREEN}Tomcat started.${NC}"
												    ;;

											    6)
												        echo -e "${BLUE}Tomcat Status:${NC}"
													    sudo systemctl status $SERVICE
													        ;;

													7)
														    echo -e "${YELLOW}Full Deploy (Build + Deploy + Restart)...${NC}"
														        cd $APP_PATH
															    mvn clean package
															        sudo rm -rf $TOMCAT_PATH/webapp
																    sudo cp $TARGET_WAR $TOMCAT_PATH
																        sudo systemctl restart $SERVICE
																	    echo -e "${GREEN}Application deployed successfully 🚀${NC}"
																	        ;;

																	0)
																		    echo "Bye 👋"
																		        exit
																			    ;;

																		    *)
																			        echo -e "${RED}Invalid option.${NC}"
																				    ;;

																			    esac
