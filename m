Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1ben5W-0004YK-T1
 for kexec@lists.infradead.org; Tue, 30 Aug 2016 17:44:44 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7UHhfdk098193
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 13:44:22 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2553631qnq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 13:44:22 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 30 Aug 2016 14:44:20 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 8EA9F352005F
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 13:43:55 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7UHiH3t29425996
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 14:44:17 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7UHiGto010511
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 14:44:17 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v7 03/13] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Tue, 30 Aug 2016 14:43:51 -0300
In-Reply-To: <1472579041-26033-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1472579041-26033-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1472579041-26033-4-git-send-email-bauerman@linux.vnet.ibm.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
implementation to find free memory for the purgatory stack.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Acked-by: Dave Young <dyoung@redhat.com>
---
 include/linux/kexec.h |  1 +
 kernel/kexec_file.c   | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index be39903edae1..d419d0e51fe5 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -176,6 +176,7 @@ struct kexec_buf {
 int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 			       int (*func)(u64, u64, void *));
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
+int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 #endif /* CONFIG_KEXEC_FILE */
 
 struct kimage {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 25690d64e111..3401816700f3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -450,6 +450,23 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 }
 
 /**
+ * kexec_locate_mem_hole - find free memory for the purgatory or the next kernel
+ * @kbuf:	Parameters for the memory search.
+ *
+ * On success, kbuf->mem will have the start address of the memory region found.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int kexec_locate_mem_hole(struct kexec_buf *kbuf)
+{
+	int ret;
+
+	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
+
+	return ret == 1 ? 0 : -EADDRNOTAVAIL;
+}
+
+/**
  * kexec_add_buffer - place a buffer in a kexec segment
  * @kbuf:	Buffer contents and memory parameters.
  *
@@ -489,11 +506,9 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
-	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
-	if (ret != 1) {
-		/* A suitable memory range could not be found for buffer */
-		return -EADDRNOTAVAIL;
-	}
+	ret = kexec_locate_mem_hole(kbuf);
+	if (ret)
+		return ret;
 
 	/* Found a suitable memory range */
 	ksegment = &kbuf->image->segment[kbuf->image->nr_segments];
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
