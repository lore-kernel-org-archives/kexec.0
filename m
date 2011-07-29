Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QmmML-0001tF-Vw
	for kexec@lists.infradead.org; Fri, 29 Jul 2011 12:40:10 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6TCe1na032009
	for <kexec@lists.infradead.org>; Fri, 29 Jul 2011 12:40:01 GMT
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6TCe1Oe1814668
	for <kexec@lists.infradead.org>; Fri, 29 Jul 2011 13:40:01 +0100
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6TCe0fn006419
	for <kexec@lists.infradead.org>; Fri, 29 Jul 2011 06:40:01 -0600
Message-Id: <20110729124000.481435260@linux.vnet.ibm.com>
Date: Fri, 29 Jul 2011 14:39:45 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 1/3] kdump: Add new machine_kexec_finish() architecture
	callback
References: <20110729123944.562622201@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-common-kexec_finish.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

In order to be able to set the "kdump active" flag on s390, this patch adds
the new kexec architecture callback "machine_kexec_finish()".

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 include/linux/kexec.h |    1 +
 kernel/kexec.c        |    8 ++++++++
 2 files changed, 9 insertions(+)

--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -115,6 +115,7 @@ struct kimage {
 /* kexec interface functions */
 extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
+extern void machine_kexec_finish(struct kimage *image, int flags);
 extern void machine_kexec_cleanup(struct kimage *image);
 extern asmlinkage long sys_kexec_load(unsigned long entry,
 					unsigned long nr_segments,
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1017,6 +1017,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 		kimage_terminate(image);
 	}
 	/* Install the new kernel, and  Uninstall the old */
+	machine_kexec_finish(image, flags);
 	image = xchg(dest_image, image);
 
 out:
@@ -1026,6 +1027,13 @@ out:
 	return result;
 }
 
+/*
+ * provide an empty default implementation here -- architecture
+ * code may override this
+ */
+void __weak machine_kexec_finish(struct kimage *image, int flags)
+{}
+
 #ifdef CONFIG_COMPAT
 asmlinkage long compat_sys_kexec_load(unsigned long entry,
 				unsigned long nr_segments,


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
