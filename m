Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RZGmC-00061H-4x
 for kexec@lists.infradead.org; Sat, 10 Dec 2011 06:51:16 +0000
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Sat, 10 Dec 2011 06:46:47 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBA6lRt02912450
 for <kexec@lists.infradead.org>; Sat, 10 Dec 2011 17:47:27 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBA6p83r032661
 for <kexec@lists.infradead.org>; Sat, 10 Dec 2011 17:51:08 +1100
Subject: [RFC PATCH v6 07/10] fadump: Introduce cleanup routine to invalidate
 /proc/vmcore.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Sat, 10 Dec 2011 12:21:03 +0530
Message-ID: <20111210065103.10195.1172.stgit@mars.in.ibm.com>
In-Reply-To: <20111210064301.10195.3344.stgit@mars.in.ibm.com>
References: <20111210064301.10195.3344.stgit@mars.in.ibm.com>
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

With the firmware-assisted dump support we don't require a reboot when we
are in second kernel after crash. The second kernel after crash is a normal
kernel boot and has knowledge about entire system RAM with the page tables
initialized for entire system RAM. Hence once the dump is saved to disk, we
can just release the reserved memory area for general use and continue
with second kernel as production kernel.

Hence when we release the reserved memory that contains dump data, the
'/proc/vmcore' will not be valid anymore. Hence this patch introduces
a cleanup routine that invalidates and removes the /proc/vmcore file. This
routine will be invoked before we release the reserved dump memory area.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 fs/proc/vmcore.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b0f450a..0d5071d 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -700,3 +700,26 @@ static int __init vmcore_init(void)
 	return 0;
 }
 module_init(vmcore_init)
+
+/* Cleanup function for vmcore module. */
+void vmcore_cleanup(void)
+{
+	struct list_head *pos, *next;
+
+	if (proc_vmcore) {
+		remove_proc_entry(proc_vmcore->name, proc_vmcore->parent);
+		proc_vmcore = NULL;
+	}
+
+	/* clear the vmcore list. */
+	list_for_each_safe(pos, next, &vmcore_list) {
+		struct vmcore *m;
+
+		m = list_entry(pos, struct vmcore, list);
+		list_del(&m->list);
+		kfree(m);
+	}
+	kfree(elfcorebuf);
+	elfcorebuf = NULL;
+}
+EXPORT_SYMBOL_GPL(vmcore_cleanup);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
