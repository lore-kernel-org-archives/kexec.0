Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQKik-0004aS-TM
 for kexec@lists.infradead.org; Tue, 15 Nov 2011 15:14:48 +0000
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 15 Nov 2011 15:02:55 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAFFBXHQ3559630
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 02:11:33 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAFFEf5H013789
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 02:14:42 +1100
Subject: [RFC PATCH v5 9/9] fadump: Invalidate the fadump registration during
 machine shutdown.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 15 Nov 2011 20:44:37 +0530
Message-ID: <20111115151437.16533.92096.stgit@mars.in.ibm.com>
In-Reply-To: <20111115151145.16533.16384.stgit@mars.in.ibm.com>
References: <20111115151145.16533.16384.stgit@mars.in.ibm.com>
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
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>, Amerigo Wang <amwang@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Milton Miller <miltonm@bga.com>, Haren Myneni <hbabu@us.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Ananth Narayan <ananth@in.ibm.com>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

If dump is active during system reboot, shutdown or halt then invalidate
the fadump registration as it does not get invalidated automatically.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/setup-common.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 87d2465..847d638 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -110,6 +110,14 @@ EXPORT_SYMBOL(ppc_do_canonicalize_irqs);
 /* also used by kexec */
 void machine_shutdown(void)
 {
+#ifdef CONFIG_FA_DUMP
+	/*
+	 * if fadump is active, cleanup the fadump registration before we
+	 * shutdown.
+	 */
+	fadump_cleanup();
+#endif
+
 	if (ppc_md.machine_shutdown)
 		ppc_md.machine_shutdown();
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
