Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TtYJ8-0007CP-OE
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 06:41:40 +0000
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Fri, 11 Jan 2013 12:10:00 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2D4F0E004D
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2013 12:11:42 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0B6fPfk30212126
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2013 12:11:25 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0B6fQUW004326
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2013 17:41:26 +1100
Subject: [PATCH 0/3] kexec: Support for uImage RAMDisks
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Fri, 11 Jan 2013 12:11:26 +0530
Message-ID: <20130111063547.11490.28174.stgit@suzukikp.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: bigeasy@linutronix.de, lethal@linux-sh.org, kexec@lists.infradead.org, mat@brain-dump.org

The following series adds support for uImage RAMDisks in kexec-tools.

The first two patches in the series modifies the common uImage handling code.

The third patch in the series adds PPC support for processing the ramdisks.

NOTE: Tested *only* on PPC. Though the other archs are not affected much,
I would appreciate some help in (compile) testing these patches on ARM and SH,
just to make sure we are safe there.

With these patches, one can easily add support in other archs for supporting
the uImage RAMDisks.

---

Suzuki K. Poulose (3):
      kexec/uImage: Return the image type for uImage_probe
      kexec/uImage: Recognize uImage RAM Disks
      ppc/uImage: Add support for RAM Disks


 kexec/arch/arm/kexec-uImage-arm.c |    8 +++++++-
 kexec/arch/ppc/kexec-uImage-ppc.c |   30 ++++++++++++++++++++++++++++--
 kexec/arch/sh/kexec-uImage-sh.c   |    9 ++++++++-
 kexec/kexec-uImage.c              |   18 ++++++++++++------
 4 files changed, 55 insertions(+), 10 deletions(-)

-- 
Suzuki


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
