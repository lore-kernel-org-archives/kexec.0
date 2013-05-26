Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pb0-x22a.google.com ([2607:f8b0:400e:c01::22a])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgRnR-0000Lg-Jw
 for kexec@lists.infradead.org; Sun, 26 May 2013 03:39:02 +0000
Received: by mail-pb0-f42.google.com with SMTP id uo1so5638437pbc.15
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 20:38:37 -0700 (PDT)
Message-ID: <51A183B0.7000607@gmail.com>
Date: Sun, 26 May 2013 11:38:24 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 0/4] kexec-tools: Remove saved_max_mem
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

When loading the dump-capture kernel, in some architectures(mips/ppc/ppc64),
we should add the parameter "savemaxmem=" in the dump-capture kernel
commandline to tell the new kernel the amount of memory that the previous
kernel used.

Then in the dump-capture kernel, we parse this parameter and assign the
value to saved_max_pfn. In these architectures, the only user of
saved_max_pfn is the read interface read_oldmem for /dev/oldmem.

But, no one actually uses the /dev/oldmem interface. And we have decided
to remove the /dev/oldmem interface. A kernel side patch to remove this
interface have been sent. See https://lkml.org/lkml/2013/5/24/451.

So in kexec-tools, we don't need to pass this parameter anymore. This
patchset aims to remove the related variables and funtions in kexec-tools.

Zhang Yanfei (4):
  kexec-tools: mips: Remove saved_max_mem
  kexec-tools: ppc: Remove saved_max_mem
  kexec-tools: ppc64: Remove saved_max_mem
  kexec-tools: sh: Remove saved_max_mem

 kexec/arch/mips/crashdump-mips.c   |   34 ----------------------------------
 kexec/arch/ppc/crashdump-powerpc.c |   19 -------------------
 kexec/arch/ppc64/crashdump-ppc64.c |   19 -------------------
 kexec/arch/sh/crashdump-sh.c       |    6 ------
 4 files changed, 0 insertions(+), 78 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
