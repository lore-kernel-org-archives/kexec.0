Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g6t0187.atlanta.hp.com ([15.193.32.64])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDbNs-0000uW-TZ
 for kexec@lists.infradead.org; Thu, 07 Mar 2013 14:01:25 +0000
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
 by g6t0187.atlanta.hp.com (Postfix) with ESMTP id EB7CB284A3
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 14:01:22 +0000 (UTC)
Subject: [RFC PATCH 5/5] crash dump bitmap: workaround for kernel 3.9-rc1
 kdump issue
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Thu, 07 Mar 2013 22:01:19 +0800
Message-ID: <20130307140118.28372.48329.stgit@k.asiapacific.hpqcorp.net>
In-Reply-To: <20130307140020.28372.34457.stgit@k.asiapacific.hpqcorp.net>
References: <20130307140020.28372.34457.stgit@k.asiapacific.hpqcorp.net>
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
To: kexec@lists.infradead.org
Cc: lisa.mitchell@hp.com

Linux kernel 3.9-rc1 allows crashkernel above 4GB, but current
kexec-tools doesn't support it yet.
This patch is only a workaround to make kdump work again.
This patch should be removed after kexec-tools 2.0.4 release.

Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 arch/x86/kernel/setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 165c831..15321d6 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -506,7 +506,8 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 #ifdef CONFIG_X86_32
 # define CRASH_KERNEL_ADDR_MAX	(512 << 20)
 #else
-# define CRASH_KERNEL_ADDR_MAX	MAXMEM
+/* # define CRASH_KERNEL_ADDR_MAX	MAXMEM */
+# define CRASH_KERNEL_ADDR_MAX	(896 << 20)
 #endif
 
 static void __init reserve_crashkernel_low(void)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
