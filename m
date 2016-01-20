Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aLqIh-0005CL-2m
 for kexec@lists.infradead.org; Wed, 20 Jan 2016 10:47:50 +0000
Subject: [RFC PATCH 0/4] purgatory: Add basic support for IPMI command
 execution
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Wed, 20 Jan 2016 19:37:34 +0900
Message-ID: <20160120103734.4234.64015.stgit@softrs>
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
To: Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Corey Minyard <minyard@acm.org>

If the second kernel for crash dumping hangs up while booting, no
information related to the first kernel will be saved.  This makes
crash cause analysis difficult.  So, some enterprise users want to
save minimal information befor booting the second kernel.

One of the approaches is to use panic notifier call or pstore
feature.  For example, a panic notifier callback registered by IPMI
driver saves the panic message to BMC's SEL before booting the second
kernel.  Similarly, pstore saves kernel logs to a non-volatile memory
on the server.  However, since these functionalities run with crashed
kernel, they may fail to complete their work and boot the second
kernel.

So, another approach; saving minimal information to BMC's SEL in the
purgatory.  Since the purgatory code doesn't rely on the crashed
kernel, we can run it safely after verifying the hash of the code.

This patch set is the first step to the final goal; it provides
a basic support for IPMI command execution in purgatory.  IPMI
specification defines multiple interfaces to BMC, and this patch set
uses one of them, KCS I/F, which talks with BMC via I/O port like
keyboard controllers.  As a use case for that, options to start/stop
BMC's watchdog timer before booting the second kernel are also
provided.  These options are useful for the cases where:

 - you want to automatically reboot the server when the second kernel
   hangs up while booting
 - you want to prevent the second kernel from being stopped by the
   watchdog timer enabled while the first kernel is running

If the BMC doesn't work well, the IPMI command execution can take
indefinite time and fail to boot the second kernel.  To avoid this,
timeout logic based on RTC polling is also implemented.

NOTE: This is an RFC version, so some parts are incomplete; these
codes are unconditionally built into the kexec binary, and I/O ports
for KCS I/F and timeout (5 seconds) are hard-coded, and etc.

Future plan:
Add an option to save the panic message and instruction pointers to
BMC's SEL in purgatory.  To realize this, we first need to pass the
panic message to the purgatory.  Instruction pointers are already
passed to the second kernel through ELF notes, so just read them.

---

Hidehiro Kawai (4):
      purgatory/ipmi: Support BMC watchdog timer start/stop in purgatory
      purgatory: Introduce timeout API
      purgatory/x86: Support CMOS RTC
      purgatory/ipmi: Add timeout logic to IPMI command processing


 kexec/ipmi.h                   |    9 +
 kexec/kexec.c                  |   18 ++
 kexec/kexec.h                  |    6 +
 purgatory/Makefile             |    5 +
 purgatory/arch/i386/Makefile   |    1 
 purgatory/arch/i386/rtc_cmos.c |  104 ++++++++++++++
 purgatory/arch/x86_64/Makefile |    1 
 purgatory/include/purgatory.h  |    3 
 purgatory/include/time.h       |   33 +++++
 purgatory/ipmi.c               |  293 ++++++++++++++++++++++++++++++++++++++++
 purgatory/purgatory.c          |    4 +
 purgatory/time.c               |   58 ++++++++
 12 files changed, 533 insertions(+), 2 deletions(-)
 create mode 100644 kexec/ipmi.h
 create mode 100644 purgatory/arch/i386/rtc_cmos.c
 create mode 100644 purgatory/include/time.h
 create mode 100644 purgatory/ipmi.c
 create mode 100644 purgatory/time.c


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
