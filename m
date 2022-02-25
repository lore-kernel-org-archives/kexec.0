From: Daniel P. Smith <dpsmith@apertussolutions.com>
Date: Fri, 25 Feb 2022 13:57:46 -0500
Subject: [PATCH v5 00/12] x86: Trenchboot secure dynamic launch Linux
 kernel support
In-Reply-To: <04080c88-3e69-b4e6-0af2-0690accaa02f@intel.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
 <04080c88-3e69-b4e6-0af2-0690accaa02f@intel.com>
Message-ID: <19e88c8c-f00a-ff79-6f52-b9575cc57fbd@apertussolutions.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Dave!

Please find a response that will hopefully address the questions raised.
The answers were meant to be thorough but succinct, though if there is
any areas that are not clear for anyone, please feel free to
ask. This response and any further questions for clarity will be
incorporated into the documentation patch and the cover letter for the
next version of the series.

On 2/23/22 12:45, Dave Hansen wrote:
> On 2/16/22 19:54, Ross Philipson wrote:
>> The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
>> enhance the boot security and integrity in a unified manner. The first area of
>> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
>> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
>> Trust for Measurement). The project has been and continues to work on providing
>> a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
>> cross-architecture (x86 and Arm), with our recent involvment in the upcoming
>> Arm DRTM specification. The order of introducing DRTM to the Linux kernel
>> follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
>> Technology (TXT) is present today and only requires a preamble loader, e.g. a
>> boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
>> been present since the introduction of AMD-V but requires an additional
>> component that is AMD specific and referred to in the specification as the
>> Secure Loader, which the TrenchBoot project has an active prototype in
>> development. Finally Arm's implementation is in specification development stage
>> and the project is looking to support it when it becomes available.
> 
> What problem is this patch series solving?  Is the same problem solved
> in a different way in the kernel today?  What is wrong with that
> solution?  What effects will end users see if they apply this series?


What problem is the Secure Launch patch series solving?
-------------------------------------------------------

* This patch series begins solving the problem of maintaining a robust
  multi-architecture path of entry from DRTM into the Linux kernel.
* DRTM (Dynamic Root of Trust for Measurement) is a strong security
  capability that has been used in niche OS environments, including
  OpenXT and Qubes. For more than a decade, some have successfully
  deployed Linux with DRTM, but popular Linux distros have not yet used
  DRTM.
* The TrenchBoot project was started to improve the usability of DRTM
  with Open-Source systems software (e.g. Linux, Xen) on hardware
  architectures that provide a DRTM capability, e.g Intel x86, AMD x86,
  Arm, and OpenPOWER.
* Microsoft Secured Core enterprise PCs use DRTM as a cornerstone of
  establishing device integrity, optionally validated by Azure
  Attestation. Devices with DRTM and Linux Secure Launch will have
  necessary building blocks for attestation to local and remote
  services, including Azure.
* TrenchBoot contributors have collaborated with Arm on the development
  of their recently released DRTM specification [1], which can enable
  Windows VBS (virtualization-based security) and Linux Secure Launch
  capabilities, on DRTM-capable Arm devices such as Microsoft Secured
  Core PCs.
* From 2018-2020, possibly motivated by DRTM requirements in MS Secured
  Core, Intel Hardware Shield[2] introduced vPro hardware and firmware
  features for SMM (System Management Mode) trustworthiness via
  attestable isolation between operating systems and SMM. DRTM prevents
  any DMA interference during the Intel Hardware Shield PPAM integrity
  report exchange with Linux.

[1] https://developer.arm.com/documentation/den0113/latest
[2]
https://www.intel.com/content/dam/www/central-libraries/us/en/documents/drtm-
based-computing-whitepaper.pdf

Is the same problem solved in a different way in the kernel today?
------------------------------------------------------------------

* Today the only way to start Linux via DRTM is with Intel's tboot
  exokernel.
* The Secure Launch patch series was designed to co-exist with the
  existing tboot extensions in the Linux kernel as to not to disrupt
  existing users of tboot.
* The first beta release of the Arm DRTM specification was just made
  public on February 17th, 2022. Obviously there are currently no
  implementations available yet.

What is wrong with that solution?
---------------------------------

* A short discussion over tboot can be found in the Overview section of
  secure_launch_overview.rst in the documentation patch, which is v5
  patch 02/12.
* Functionally tboot's primary deficiency is that it is an Intel-only
  solution.
* There is no support for the AMD/Hygon, whose SKINIT capability has
  been around nearly as long as Intel TXT.
* The security merits of tboot's approach could be debated endlessly by
  security researchers depending on their view of trust and security.

What effects will end users see if they apply this series?
----------------------------------------------------------

* To provide a full answer, the capability can be completely disabled
  via the Kconfig system resulting in no new code paths.
* The other case is when a kernel is built with Secure Launch enabled
  and in this case there are two relevant aspects, impacts to user
  experience and the benefits the user will gain.
* As to the impacts to user experience, the end users should see no
  effects in the launch of the kernel from this series.
* One of the primary goals for this series was to minimize change to the
  kernel boot flow and to ensure the capability was benign if compiled
  in but not enabled/used.
* When the bootloader is configured to launch the kernel via DRTM, again
  there will be little to no effect on the user experience. There are a
  few CPU behavior differences that result from doing a DRTM but their
  effect is only seen by Linux internals, for which this series makes
  the kernel aware.
* The benefit is that it removes having to trust all the second and
  third party code in the UEFI boot chain. For instance during the
  Boothole vulnerability situation, Boothole had a near zero if not a
  zero impact for DRTM systems, i.e. it could not be used to compromise
  nor load a bad kernel.
* Removing the need to trust every driver, service, and setup code in
  firmware is not the only benefit as DRTM provides several use cases
  that are not otherwise possible. Please see my response to Paul Moore
  or visit trenchboot.org/events to see the numerous talks on usages and
  capabilities that are possible because of DRTM.


V/r,
Daniel P. Smith

