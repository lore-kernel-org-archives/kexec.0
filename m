Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400051.outbound.protection.outlook.com
 ([40.107.140.51] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kscbl-0001EI-WD
 for kexec@lists.infradead.org; Fri, 25 Dec 2020 02:13:35 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [RFC PATCH 0/3] makedumpfile: about failing on arm64 with kernel
 > 5.4
Date: Fri, 25 Dec 2020 02:13:23 +0000
Message-ID: <OSBPR01MB19918A083E73A330713E1A62DDDC0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
Content-Language: ja-JP
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Alexander Kamensky <alexander.kamensky42@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Bhupesh Sharma <bhsharma@redhat.com>
Cc: "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>

Hi Alexander, Bhupesh,

Thank you for working on this, and sorry for the long delay.

For the 1/3 patch, Bhupesh and I got an offlist report that makedumpfile
could not be built with the patch in an old environment, which was a
similar error to kexec-tools patch [1].  And "make TARGET=aarch64" on
x86_64 also fails, though probably this is a rare usage.

Also there is the limitation that Alexander and I pointed out [2].

So my suggestion is to remove the part of fetching register value for
now.  This would not make makedumpfile support all arm64 kernels, so
it might be good to put it aside as a separate patch for distributions
with a description of the limitation.  or they can merge Bhupesh's kernel
commit bbdbc11804ff into their kernel.

Any other ideas?  e.g. a trial-and-error might be more acceptable
in this case..

Anyway, there has been a long time since I understood the arm64 changes,
I need to digest it again.  I might clean up your patches.
Please wait for a while.

[1] http://lists.infradead.org/pipermail/kexec/2020-September/021503.html
[2] http://lists.infradead.org/pipermail/kexec/2020-November/021797.html

Thanks,
Kazu

-----Original Message-----
> Hi Kazu, Bhupesh,
> 
> I am hitting the linear mapping swap issue with makedumpfile failing on
> arm64 Yocto Project qemuarm64 machine with 5.8 kernel as it was discussed
> several times on this mailing list:
> 
> root@qemuarm64:~# makedumpfile -c -F /proc/vmcore > /dev/null
> readpage_elf: Attempt to read non-existent page at 0x0.
> readmem: type_addr: 1, addr:440, size:8
> vaddr_to_paddr_arm64: Can't read pmd
> readmem: Can't convert a virtual address(ffffffc01107f94c) to physical address.
> readmem: type_addr: 0, addr:ffffffc01107f94c, size:390
> check_release: Can't get the address of system_utsname.
> 
> I've have tried Bhupesh's remaining third patch [1] from [2] series,
> it does help. But I am a bit hesitant to submit it to the Yocto Project,
> since Kazu pointed out [3] that this patch uses current kernel version to
> make decision how __pa is handled and it may mismatch the version where
> vmcore was collected, and in such case it may not operate correctly.
> 
> In this RFC series I have tried to implement Kazu's suggestion and use
> kernel version retrieved from OSRELEASE string from vmcoreinfo note. I
> wonder whether it will help to merge arm64 5.4+ makedumpfile fix? Is
> there anything else outstanding that prevents such merge?
> 
> My RFC patches series does include Bhupesh's patch [1], and I posted
> my modifications on top of it as separate patch for readability.
> 
> Thanks,
> Alexander
> 
> [1] http://lists.infradead.org/pipermail/kexec/2020-September/021336.html
> [2] http://lists.infradead.org/pipermail/kexec/2020-September/021333.html
> [3] http://lists.infradead.org/pipermail/kexec/2020-September/021488.html
> 
> Alexander Kamensky (2):
>   added way to determine kernel version that vmcore is from
>   arm64: use kernel version from OSRELEASE to determine linear mapping
>     position
> 
> Bhupesh Sharma (1):
>   makedumpfile/arm64: Add support for ARMv8.2-LVA (52-bit kernel VA
>     support)
> 
>  arch/arm64.c   | 229 ++++++++++++++++++++++++++++++++++++++++++-------
>  common.h       |  10 +++
>  makedumpfile.c |  23 +++++
>  makedumpfile.h |   6 +-
>  4 files changed, 234 insertions(+), 34 deletions(-)
> 
> --
> 2.26.2
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
