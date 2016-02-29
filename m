Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aaFYb-0003B2-67
 for kexec@lists.infradead.org; Mon, 29 Feb 2016 04:35:42 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [RFC v2 PATCH 0/7] purgatory: Say last words in kexec on
 panic case
Date: Mon, 29 Feb 2016 04:35:15 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454B03702@GSjpTKYDCembx31.service.hitachi.net>
References: <20160222115617.4231.50041.stgit@softrs>
In-Reply-To: <20160222115617.4231.50041.stgit@softrs>
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
To: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?= <hidehiro.kawai.ez@hitachi.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Corey Minyard <minyard@acm.org>

Hello,

Are there any comments especially about the direction?
Currently, there are two opinions.

Corey Minyard (IPMI driver maintainer) prefers to do this kind of
works in the 1st kernel because the IPMI driver already supports
various BMC implementations. His comments can be found here with
my RFC v1 patch set:
http://thread.gmane.org/gmane.linux.kernel.kexec/15131

And, preliminary discussion related to this patch set with Eric
Biederman can be found here:
https://lkml.org/lkml/2015/8/4/301

If there is no strong objection, I just complete the missing parts...

Best regards,

Hidehiro Kawai

> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Hidehiro Kawai
> This is the version 2 of RFC patch series previously named
> "purgatory: Add basic support for IPMI command execution."
> 
> Changes since RFC v1:
> - Add --ipmi-kcs-ports option to specify I/O ports for KCS I/F
> - Add --ipmi-handle-panic option to generate an event on BMC to
>   inform and record about the panic
> - Add --output-cpu-ip option to output IP registers to console
>   and BMC's SEL
> ...and various cleanups and improvements
> 
> I performed some Web searches, and I found that major BMCs still
> support KCS I/F.  Although this patch series supports only KCS I/F, it
> should cover many recent servers with BMC.  However, I/O ports used
> for KCS I/F are varies among servers, so I added an option to specify
> port numbers for KCS.
> 
> About error handling for KCS protocol, I re-checked IPMI
> specification, and I found that simply retrying on error is
> sufficient.  So I didn't change the logic for the simplicity.  Please
> see PATCH 3/7 for details.
> 
> 
> Background and purpose
> ======================
> 
> If the second kernel for crash dumping hangs up while booting, no
> information related to the first kernel will be saved.  This makes
> crash cause analysis difficult.  Some enterprise users don't permit
> the same faults happen multiple times, so we want to save minimal
> information before booting the second kernel.
> 
> 
> Approaches
> ==========
> 
> One of the approaches is (1) to use panic notifier call or kmsg dump
> feature.  For example, a panic notifier callback registered by IPMI
> driver can save the panic message to BMC's SEL before booting the
> second kernel.  Similarly, kmsg dump saves kernel logs to a non-
> volatile memory on the server.  This approach covers multiple
> hardware/firmware implementation.  However, doing many things in
> crashed kernel will reduce the reliability.  Additionally, a part of
> the code is also used for normal operation and still evolving.  This
> would makes it difficult to keep stable.
> 
> Another approach is (2) to save minimal information to BMC's SEL in
> purgatory.  It is difficult to do complicate things in purgatory, but
> fortunately IPMI specification defines a simple interface, KCS
> (Keyboard Controller Style) I/F.  KCS is controlled by two I/O ports
> and supported by most of major BMCs.
> 
> Here, we want more reliable one for the purpose, we adopt (2).
> 
> 
> What are provided?
> ==================
> 
> This patch series provides multiple RAS features other than the main
> purpose described above.
> 
> - Timeout mechanism relying on polling RTC
> - API to access BMC via KCS I/F
> - Command line option to start/stop BMC's watchdog timer in purgatory
> - Command line option to write the value of RIP registers to SEL and/or
>   serial console (useful for kernel hang-up cases)
> - Command line option to generate a plantform event on BMC (useful for
>   server monitoring or HA clustering; you can make the BMC issue an
>   SNMP trap)
> - Command line option to change the default I/O ports of KCS I/F
> 
> 
> Limitations of RFC version
> ==========================
> 
> This patch serires is incomplete, and there are some limitations.
> 
> - Related codes are unconditionally built into the kexec binary
> - Implemented only for x86_64 (it may break the build for other
>   architectures)
> - Timeout value for IPMI operations is hard-coded
> 
> 
> Future plan
> ===========
> 
> - Add an option to save the panic message to BMC's SEL (this requires
>   some kernel modifications)
> 
> ---
> 
> Hidehiro Kawai (7):
>       purgatory: Introduce timeout API
>       purgatory/x86: Support CMOS RTC
>       purgatory/ipmi: Support IPMI KCS interface
>       purgatory/ipmi: Support BMC watchdog timer start/stop in purgatory
>       purgatory/ipmi: Add an option for purgatory to handle panic event with IPMI
>       purgatory/x86: Add an option to output IP registers to console in panic case
>       purgatory/ipmi/x86: Support logging of IP registers into SEL
> 
> 
>  kexec/arch/i386/crashdump-x86.c              |   10 -
>  kexec/arch/i386/include/arch/options.h       |    4
>  kexec/arch/i386/kexec-x86.h                  |    1
>  kexec/arch/x86_64/kexec-x86_64.c             |   15 +
>  kexec/ipmi.h                                 |    9 +
>  kexec/kexec.c                                |   51 ++++
>  kexec/kexec.h                                |   11 +
>  purgatory/Makefile                           |    6
>  purgatory/arch/i386/Makefile                 |    1
>  purgatory/arch/i386/purgatory-x86.h          |    2
>  purgatory/arch/i386/rtc_cmos.c               |  107 ++++++++
>  purgatory/arch/x86_64/Makefile               |    2
>  purgatory/arch/x86_64/purgatory-elf-x86_64.c |   82 ++++++
>  purgatory/arch/x86_64/purgatory-x86_64.c     |   35 ++-
>  purgatory/include/purgatory-elf.h            |   13 +
>  purgatory/include/purgatory.h                |    9 +
>  purgatory/include/time.h                     |   33 ++
>  purgatory/ipmi.c                             |  361 ++++++++++++++++++++++++++
>  purgatory/purgatory-elf-core.c               |   64 +++++
>  purgatory/time.c                             |   59 ++++
>  20 files changed, 866 insertions(+), 9 deletions(-)
>  create mode 100644 kexec/ipmi.h
>  create mode 100644 purgatory/arch/i386/rtc_cmos.c
>  create mode 100644 purgatory/arch/x86_64/purgatory-elf-x86_64.c
>  create mode 100644 purgatory/include/purgatory-elf.h
>  create mode 100644 purgatory/include/time.h
>  create mode 100644 purgatory/ipmi.c
>  create mode 100644 purgatory/purgatory-elf-core.c
>  create mode 100644 purgatory/time.c
> 
> 
> --
> Hidehiro Kawai
> Hitachi, Ltd. Research & Development Group

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
