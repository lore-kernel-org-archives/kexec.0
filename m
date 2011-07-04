Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate6.uk.ibm.com ([194.196.100.166])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qdmem-0001dg-He
	for kexec@lists.infradead.org; Mon, 04 Jul 2011 17:10:06 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate6.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p64H9tlF018946
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 17:09:55 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p64H9tFo2502872
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 18:09:55 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p64H9tsj002835
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 11:09:55 -0600
Message-Id: <20110704170958.874632821@linux.vnet.ibm.com>
Date: Mon, 04 Jul 2011 19:09:24 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 2/9] kdump: Add machine_kexec_finish()
References: <20110704170922.976299676@linux.vnet.ibm.com>
Content-Disposition: inline; filename=02-s390-kdump-common-kexec_finish.patch
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
To: ebiederm@xmission.com, vgoyal@redhat.com, hbabu@us.ibm.com, mahesh@linux.vnet.ibm.com
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, horms@verge.net.au, schwidefsky@de.ibm.com

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

On s390 we create checksums for the loaded kexec segments case of kdump.
Therefore we need an additional callback at the end of the kexec_load()
system call. This patch introduces machine_kexec_finish() with an empty
implementation for all architectures that do not need the callback.

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
