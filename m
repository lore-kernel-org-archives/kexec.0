Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hera.kernel.org ([140.211.167.34])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OqN42-0003KV-PA
	for kexec@lists.infradead.org; Tue, 31 Aug 2010 09:23:34 +0000
Message-ID: <4C7CC9E0.20501@kernel.org>
Date: Tue, 31 Aug 2010 11:22:40 +0200
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: kdump regression compared to v2.6.35
References: <2044609874.1606211283216015254.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2044609874.1606211283216015254.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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
To: caiqian@redhat.com
Cc: kexec <kexec@lists.infradead.org>, linux-next@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>

Hello,

Thanks for verifyiing.  Can you please apply this patch on top and
check that those debug messages go away?

Thanks.

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c8183b2..7855429 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -196,7 +196,7 @@ typedef cpumask_var_t mayday_mask_t;
 	cpumask_test_and_set_cpu((cpu), (mask))
 #define mayday_clear_cpu(cpu, mask)		cpumask_clear_cpu((cpu), (mask))
 #define for_each_mayday_cpu(cpu, mask)		for_each_cpu((cpu), (mask))
-#define alloc_mayday_mask(maskp, gfp)		alloc_cpumask_var((maskp), (gfp))
+#define alloc_mayday_mask(maskp, gfp)		zalloc_cpumask_var((maskp), (gfp))
 #define free_mayday_mask(mask)			free_cpumask_var((mask))
 #else
 typedef unsigned long mayday_mask_t;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
