<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">


  <h1 align="center">LQR and LQG control for double pendulum on moving cart </h1>


</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary><h3>Table of Contents</h3></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li><a href="#open-loop-system">Open Loop System</a></li>
    <li><a href="#linear-quadratic-regulator">Linear Quadratic Regulator</a></li>
    <li><a href="#lqr-reference-tracking">LQR Reference Tracking</a></li>
    <li><a href="#luenberger-observer">Luenberger Observer</a></li>
    <li><a href="#lqg-reference-tracking">LQG Reference Tracking</a></li>
    <li><a href="#kalman-filter">Kalman Filter</a></li>
    <li>
      <a href="#prerequisites">Prerequisites</a>
    </li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project



This is a Matlab code collection of control experiments.

System to be controlled:
- A crane that moves along 1-dimensional track.
- It behaves as a frictionless cart with mass M actuated by an external force F that constitutes the input of the system.
- There are two loads suspended from cables attached to the crane.
- The loads have mass m1 and m2, and the lengths of the cables are l1 and l2 respectively


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- Open Loop System -->
## Open Loop System

This is a open loop system with M=1000Kg, m1=100, m2=100, L1 = 20m, L2=10m.

Since the original system is non liner, At first it is linearized around the equilibrium point.

<div align="center">
  <h4 align="center"> System animation </h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/open_loop.gif?raw=true" width="640" alt="Open loop pic"> 

</div>

This system has 6 state variables, namely: 
   1. cart position (x)
   2. cart velocity (xd)
   3. mass 1 angle (t1)
   4. mass 1 angular velocity (t1d)
   5. mass 2 angle (t2)
   6. mass 2 angular velocity (t2d),
 
<div align="center">
  <h4 align="center"> Graph of x, theta1 and theta2 w.r.t. time </h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/open_loop_system.jpg?raw=true" width="640" alt="Open loop pic"> 

</div>
   
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- Linear Quadratic Regulator -->
## Linear Quadratic Regulator

LQR (Linear Quadratic Regulator) controller provides the optimal feedback gain considering the relative penalization between the state error and input effort.
For controlling the system, following initial and desired state were used.

<div align="center">

State variables | x | xd | t1 (deg) | t1d | t2 (deg) | t2d
--- | :---: | :---: | :---: | :---: | :---: | ---
Initial State | 0 | 0 | 10 | 0 | -10 | 0
Desired State | 0 | 0 |  0 | 0 |  0 | 0

</div>

While Q and R were chosen experimentally.

<div align="center">
  <h4 align="center"> Response after tuning the gains: </h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/closed_loop_lqr.gif?raw=true" width="640" alt="Open loop pic"> 

</div>
   
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LQR Reference Tracking -->
## LQR Reference Tracking
After setting non zero position in desired state

<div align="center">

State variables | x | xd | t1 (deg) | t1d | t2 (deg) | t2d
--- | :---: | :---: | :---: | :---: | :---: | ---
Initial State | 0 | 0 | 10 | 0 | -10 | 0
Desired State | 10 | 0 |  0 | 0 |  0 | 0

</div>

<div align="center">
  <h4 align="center"> Response after tuning the gains: </h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/lqr_reference_tracking.gif?raw=true" width="640" alt="Open loop pic"> 

</div>

<div align="center">
  <h4 align="center"> Graph of x, theta1, theta2 and input force w.r.t. time </h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/closed_loop_lqr.jpg?raw=true" width="640" alt="Open loop pic"> 

</div>

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- Luenberger Observer -->
## Luenberger Observer
In the LQR control it is assumed that complete state of the system (6 variables) are known at every time step. And the entire state is fed back to the system after multiplying with LQR gain.

But, in real systems, we can get only few states of the systems as output, hence it is required to estimate the full state of the system using another model of the same system. The state estimate of the observer system can have different initial estimate, but it should attain the actual system state. The error difference between the observer and real system is reduced by setting the Luenberger observer gain experimentally.

Below animation shows the convergence of the observer when 6 system poles are placed at,
-2 -3 -4 -5 -6 and -7.

<div align="center">

State variables | x | xd | t1 (deg) | t1d | t2 (deg) | t2d
--- | :---: | :---: | :---: | :---: | :---: | ---
Initial State | 0 | 0 | 10 | 0 | -10 | 0
Initial Estimate | 5 | 0 |  -8 | 0 |  5 | 0

</div>

In this system only 3 states (x, t1, t2) out of 6 states are observable.

<div align="center">
  <h4 align="center">Slow motion visualization of Luenberger state observer approaching the original system state </h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/Luenberger_observer_slow_motion.gif?raw=true" width="640" alt="Open loop pic"> 

</div>

<div align="center">
  <h4 align="center">Graph of observable states x, t1, t2 w.r.t. time:</h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/observer_slow_mo1.jpg?raw=true" width="850" alt="Open loop pic"> 

</div>

From below graph It can be seen that the observer can precisely estimate the unobservable states.

<div align="center">
  <h4 align="center">Graph of unobservable states xd, t1d, t2d w.r.t. time: </h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/observer_slow_mo2.jpg?raw=true" width="850" alt="Open loop pic"> 

</div>

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LQG Reference Tracking -->
## LQG Reference Tracking
The complete state estimated by the observer can then be used as a feed back with LQR gain to control the desired position of the crane.

<div align="center">

State variables | x | xd | t1 (deg) | t1d | t2 (deg) | t2d
--- | :---: | :---: | :---: | :---: | :---: | ---
Initial State | 0 | 0 | 10 | 0 | -10 | 0
Initial Estimate | 5 | 0 |  -8 | 0 |  5 | 0
Desired State | 10 | 0 |  0 | 0 |  0 | 0

</div>

<div align="center">
  <h4 align="center">System animation:</h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/lqg_reference_tracking.gif?raw=true" width="640" alt="Open loop pic"> 

</div>

<div align="center">
  <h4 align="center">Graph of observable states x, t1, t2 w.r.t. time: </h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/obsv_ref_track1.jpg?raw=true" width="850" alt="Open loop pic"> 

</div>

<div align="center">
  <h4 align="center">Graph of unobservable states xd, t1d, t2d w.r.t. time: </h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/obsv_ref_track2.jpg?raw=true" width="850" alt="Open loop pic"> 

</div>

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- Kalman Filter -->
## Kalman Filter
In the observer example, exact output of the 3 observable states of the system were visible. But in reality, systems get affected by the disturbances and the sensors are used to measure these system states. And sensors have noise in their readings. Sensors with high noise make it difficult to estimate the actual state of the system.

If this sensor noise can be approximated as zero mean gaussian noise with known variance, then Kalman filter can be designed to trade-off between the sensor measurement and prediction by the estimator.

In this experiment the filter was designed to consider lower variance in the disturbance (process noise) and higher variance in the measurement noise.

It can be seen that in few seconds after starting the estimated state converges and closely with the actual state while not getting affected by the measurement noise present in all the observable states.

<div align="center">

State variables | x | xd | t1 (deg) | t1d | t2 (deg) | t2d
--- | :---: | :---: | :---: | :---: | :---: | ---
Initial State | 1 | 0 | -10 | 0 | 10 | 0
Initial Estimate | 1.2 | 0 |  -6 | 0 |  7 | 0

</div>

<div align="center">
  <h4 align="center">System animation: </h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/kalman_filter.gif?raw=true" width="640" alt="Open loop pic"> 

</div>

<div align="center">
  <h4 align="center">Graph of observable states x, t1, t2 w.r.t. time: </h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/kalman_filter1.jpg?raw=true" width="850" alt="Open loop pic"> 

</div>

<div align="center">
  <h4 align="center">Graph of unobservable states xd, t1d, t2d w.r.t. time: </h4>
</div>

<div align="center">

<img src="https://github.com/KACHAPPILLY2021/667_final-_Project/blob/main/doc/kalman_filter2.jpg?raw=true" width="850" alt="Open loop pic"> 

</div>

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Prerequisites
For running this code:
- [Matlab](https://www.mathworks.com/)



<!-- CONTACT -->
## Contact

Jeffin Johny K - [![MAIL](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:jeffinjk@umd.edu)
	
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://kachappilly2021.github.io/)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](http://www.linkedin.com/in/jeffin-johny-kachappilly-0a8597136)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See [MIT](https://choosealicense.com/licenses/mit/) for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: images/screenshot.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com
