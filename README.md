# Kubernetes Playground

> **DISCLAIMER**: This project is being developed for educational purposes only and is not complete, nor supported. It's publishment is only intended for helping others automate environments for delivering workshops with Kubernetes and/or Dynatrace. Even though the exposed endpoints of this cluster may have valid SSL certificates generated with Cert-Manager and Let's Encrypt, does not mean the Cluster is secure. 

> ## ***🥼⚗ Spend more time innovating and less time configuring***

The `Kubernetes Playground` is a single node Kubernetes Cluster based on [microk8s](https://microk8s.io/)  which is a simple production-grade upstream certified Kubernetes made for developers and DevOps.

The mantra behind all this is that you
> Spend **more** time **innovating** 😄⚗️ and *less* time *configuring* 😣🛠

*K8s-Playground is a 🚀 rocket launcher for enabling tutorials or workshops in an easy, fast and resource efficient way.* All tutorials can be automatized and versioned so that the student can at anytime spin the cluster and start exactly with the task at hand so he'll focus on the subject to learn without losing any time configuring trivial stuff.


![k8s-playground](doc/img/k8splay.jpg)


## Get Started
Most Likely the machine has been already provisioned for you. Here are some cool tips and tricks to get you started so you can get the most out of it. The machine has some cool [alias](doc/bash_aliases.md) installed already. Enter into the webshell in the iFrame or open it in a new tab for a better UX. Before starting to type, click on the right mouse to set the colors and settings of the webshell to your pleasing. Once the settings are as you want, log in and type the following commands:
- [k9s](https://k9scli.io/) (really cool tool for navigating in kubernetes like butter)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/) (comes with autocomplete)
- [docker](https://www.docker.com/) (for building your own images and installing them in the private regitry of your cluster)
- [istioctl](https://istio.io/latest/docs/reference/commands/istioctl/) 
- [helm](https://helm.sh/) (for installing any other app in seconds)
- [alias](/doc/bash_aliases.md)

for deploying apps, just go to `cd ~/k8s-play/apps` and enter the folder of the app you want to deploy. Inside the folder you'll find a script for deploying and undeploying. It should be self-explanatory. The shell is normally for helping generate the Ingress rule with a subdomain so the app can be exposed with the help of one IP and a magic domain ([nip.io](https://nip.io))

## Deploy your app with just 1-click 🚀!

The following apps can be found under the [apps](apps) folder. Inside each app there is one bash script for deploying the app and one for removing it. When provisioning the machine this repo will be cloned as `k8s-play`in the home directory like: `~/k8s-play`
<table style="table-layout: fixed; width: 100%; text-align: center;" >
<tr valign="top">
  <td style="width:25%;"><a href="apps/bookinfo" target="_blank">BookInfo<img src="https://istio.io/latest/docs/examples/bookinfo/noistio.svg"/></a></td>
  <td style="width:25%;"><a href="apps/easytravel-k8s" target="_blank">EasyTravel<img src="https://community.dynatrace.com/t5/image/serverpage/image-id/4521iDEBB4D8F00CAB877"/></a></td>
  <td style="width:25%;"><a href="apps/etherpad" target="_blank">Etherpad<img src="https://etherpad.org/img/etherpad_demo.gif"/></a></td>
  <td style="width:25%;"><a href="apps/frontail" target="_blank">Frontail<img src="https://user-images.githubusercontent.com/455261/29570317-660c8122-8756-11e7-9d2f-8fea19e05211.gif"/></a></td>
</tr>
<tr valign="top">
  <td style="width:25%;"><a href="apps/gitea" target="_blank">Gitea<img src="https://gitea.io/images/screenshot.png"/></a></td>
  <td style="width:25%;"><a href="apps/hipstershop" target="_blank">Hipstershop<img src="https://raw.githubusercontent.com/mreider/microservices-demo-dt/master/docs/img/online-boutique-frontend-1.png"/></a></td>
  <td style="width:25%;"><a href="apps/simplcommerce" target="_blank">Simplcommerce<img src="doc/img/simplcommerce.png"/></a></td>
  <td style="width:25%;"><a href="apps/simplenode" target="_blank">Simplenode<img src="https://github.com/grabnerandi/simplenodeservice/raw/master/images/simplenodesersviceui.png"/></a></td>
</tr>
<tr valign="top">
  <td style="width:25%;"><a href="apps/tictactoe" target="_blank">TicTacToe<img src="doc/img/tictactoe.png"/></a></td>
  <td style="width:25%;"><a href="apps/webshell" target="_blank">Webshell<img src="doc/img/webshell.png"/></a></td>
  <td style="width:25%;"></td>
  <td style="width:25%;"></td>
</tr>
</table>

## Monitoring with Dynatrace

By default your instance will be monitored with the Dynatrace credentials you provisioned (`tenant`, `api_token`, `data_ingest_token`) which are required when you monitor a [Kubernetes Cluster with Dynatrace](https://www.dynatrace.com/support/help/setup-and-configuration/setup-on-container-platforms/kubernetes/get-started-with-kubernetes-monitoring). 

The default deployment mode is [Classic full-stack injection](dynatrace.com/support/help/setup-and-configuration/setup-on-container-platforms/kubernetes/get-started-with-kubernetes-monitoring/deployment-options-k8s#classic) but you can easily swap 🔄 to the [CloudNative full-stack injection](https://www.dynatrace.com/support/help/setup-and-configuration/setup-on-container-platforms/kubernetes/get-started-with-kubernetes-monitoring/deployment-options-k8s#cloud-native), (yeah, how cool is that!?). [Go here to learn more](cluster-setup/resources/dynatrace).

## Provisioning your own Kubernetes Playground

K8s-Playground is programmed natively for Linux sytems, specially Ubuntu. The Kubernetes Playground can run in any Ubuntu machine, whether is on the cloud, locally or a VM. Thanks to the modularity and versioning of the code, you can be sure that the environment that you create will always work the same so you can match it to a step-by-step tutorial or workshop at any given time.

Go to the [Cluster-Setup](cluster-setup) to learn more how to spin an instance manually or via automations.

## Contributing
If you have any ideas for improvements or want to contribute that's great. Create a pull request or file an issue.

## Author 
sergio.hinojosa@dynatrace.com
