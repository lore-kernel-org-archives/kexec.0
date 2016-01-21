Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vms173019pub.verizon.net ([206.46.173.19])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMHK2-0000f4-AM
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 15:38:56 +0000
Received: from serve.minyard.net ([173.57.176.17]) by vms173019.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul
 16 2014))
 with ESMTPA id <0O1B003F47FJL8N0@vms173019.mailsrvcs.net> for
 kexec@lists.infradead.org; Thu, 21 Jan 2016 09:38:07 -0600 (CST)
Subject: Re: [RFC PATCH 0/4] purgatory: Add basic support for IPMI command
 execution
References: <20160120103734.4234.64015.stgit@softrs>
From: Corey Minyard <minyard@acm.org>
Message-id: <56A0FB5E.5080606@acm.org>
Date: Thu, 21 Jan 2016 09:38:06 -0600
MIME-version: 1.0
In-reply-to: <20160120103734.4234.64015.stgit@softrs>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: minyard@acm.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org

I understand what you are trying to accomplish here, but I'm not sure of
the wisdom of this approach.  I'll give some more information and the
kexec maintainers can decide, I suppose.

The KCS interface given here probably covers ~70% of the systems out there
right now.  Other systems have:
   * KCS interfaces at a different port or in a different place like 
memory, PCI,
     and with different register sizes and spacing.
   * Other standard interfaces.  SMIC (probably not relevant), BT 
(faster, it does
     block transfers) and SSIF (which is IPMI over I2C).
   * Those other standard interfaces can be in different places, just 
like KCS.
     Hundreds of I2C interfaces exist.
   * Non-standard interfaces.  Power systems have their own IPMI interfaces,
     for instance.  Some systems have IPMI over serial ports, though 
hopefully
     that has pretty much gone away.

I'd guess that over half of the IPMI SI driver is discovering and 
handling all the
various interface types, locations from all the sources it can come from.

As time goes on that 70% number is decreasing in favour of other faster
and more convenient interfaces.  I expect that SSIF will become much more
popular over time because it has block transfer capability and all the 
hardware
is already there on systems.

This is no different, of course, than any other common hardware 
interface out
there.  USB, ATA, etc.  But it makes it hard to cover all the 
possibilities in something
like purgatory.

I know how valuable this information can be.  It has saved my butt on 
occasions,
which is why I go through the inconvenience of handling it in the IPMI 
driver.
But it seems to me that the failure rate of doing this in the crashing 
kernel should
be pretty low.  Not zero of course.  But I have no idea what it is.

-corey

On 01/20/2016 04:37 AM, Hidehiro Kawai wrote:
> If the second kernel for crash dumping hangs up while booting, no
> information related to the first kernel will be saved.  This makes
> crash cause analysis difficult.  So, some enterprise users want to
> save minimal information befor booting the second kernel.
>
> One of the approaches is to use panic notifier call or pstore
> feature.  For example, a panic notifier callback registered by IPMI
> driver saves the panic message to BMC's SEL before booting the second
> kernel.  Similarly, pstore saves kernel logs to a non-volatile memory
> on the server.  However, since these functionalities run with crashed
> kernel, they may fail to complete their work and boot the second
> kernel.
>
> So, another approach; saving minimal information to BMC's SEL in the
> purgatory.  Since the purgatory code doesn't rely on the crashed
> kernel, we can run it safely after verifying the hash of the code.
>
> This patch set is the first step to the final goal; it provides
> a basic support for IPMI command execution in purgatory.  IPMI
> specification defines multiple interfaces to BMC, and this patch set
> uses one of them, KCS I/F, which talks with BMC via I/O port like
> keyboard controllers.  As a use case for that, options to start/stop
> BMC's watchdog timer before booting the second kernel are also
> provided.  These options are useful for the cases where:
>
>   - you want to automatically reboot the server when the second kernel
>     hangs up while booting
>   - you want to prevent the second kernel from being stopped by the
>     watchdog timer enabled while the first kernel is running
>
> If the BMC doesn't work well, the IPMI command execution can take
> indefinite time and fail to boot the second kernel.  To avoid this,
> timeout logic based on RTC polling is also implemented.
>
> NOTE: This is an RFC version, so some parts are incomplete; these
> codes are unconditionally built into the kexec binary, and I/O ports
> for KCS I/F and timeout (5 seconds) are hard-coded, and etc.
>
> Future plan:
> Add an option to save the panic message and instruction pointers to
> BMC's SEL in purgatory.  To realize this, we first need to pass the
> panic message to the purgatory.  Instruction pointers are already
> passed to the second kernel through ELF notes, so just read them.
>
> ---
>
> Hidehiro Kawai (4):
>        purgatory/ipmi: Support BMC watchdog timer start/stop in purgatory
>        purgatory: Introduce timeout API
>        purgatory/x86: Support CMOS RTC
>        purgatory/ipmi: Add timeout logic to IPMI command processing
>
>
>   kexec/ipmi.h                   |    9 +
>   kexec/kexec.c                  |   18 ++
>   kexec/kexec.h                  |    6 +
>   purgatory/Makefile             |    5 +
>   purgatory/arch/i386/Makefile   |    1
>   purgatory/arch/i386/rtc_cmos.c |  104 ++++++++++++++
>   purgatory/arch/x86_64/Makefile |    1
>   purgatory/include/purgatory.h  |    3
>   purgatory/include/time.h       |   33 +++++
>   purgatory/ipmi.c               |  293 ++++++++++++++++++++++++++++++++++++++++
>   purgatory/purgatory.c          |    4 +
>   purgatory/time.c               |   58 ++++++++
>   12 files changed, 533 insertions(+), 2 deletions(-)
>   create mode 100644 kexec/ipmi.h
>   create mode 100644 purgatory/arch/i386/rtc_cmos.c
>   create mode 100644 purgatory/include/time.h
>   create mode 100644 purgatory/ipmi.c
>   create mode 100644 purgatory/time.c
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
