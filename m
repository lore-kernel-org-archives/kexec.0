Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFRfp-0001n2-OD
 for kexec@lists.infradead.org; Tue, 21 Jun 2016 19:49:26 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5LJmrmQ074890
 for <kexec@lists.infradead.org>; Tue, 21 Jun 2016 15:49:05 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23q70234kk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 21 Jun 2016 15:49:05 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 16:49:03 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 329F51DC006E
 for <kexec@lists.infradead.org>; Tue, 21 Jun 2016 15:48:53 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5LJn0MM16449968
 for <kexec@lists.infradead.org>; Tue, 21 Jun 2016 16:49:00 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5LJn06G019645
 for <kexec@lists.infradead.org>; Tue, 21 Jun 2016 16:49:00 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Tue, 21 Jun 2016 16:48:35 -0300
In-Reply-To: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1466538521-31216-4-git-send-email-bauerman@linux.vnet.ibm.com>
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
To: linuxppc-dev@lists.ozlabs.org
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
implementation to find free memory for the purgatory stack.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/kexec.h |  4 ++++
 kernel/kexec_file.c   | 66 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 3d91bcfc180d..4ca6f5f95d66 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -227,6 +227,10 @@ extern asmlinkage long sys_kexec_load(unsigned long entry,
 					struct kexec_segment __user *segments,
 					unsigned long flags);
 extern int kernel_kexec(void);
+int kexec_locate_mem_hole(struct kimage *image, unsigned long size,
+			  unsigned long align, unsigned long min_addr,
+			  unsigned long max_addr, bool top_down,
+			  unsigned long *addr);
 extern int kexec_add_buffer(struct kimage *image, char *buffer,
 			    unsigned long bufsz, unsigned long memsz,
 			    unsigned long buf_align, unsigned long buf_min,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b1f1f6402518..85a515511925 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -449,6 +449,46 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
 }
 
+/**
+ * kexec_locate_mem_hole - find free memory to load segment or use in purgatory
+ * @image:	kexec image being updated.
+ * @size:	Memory size.
+ * @align:	Minimum alignment needed.
+ * @min_addr:	Minimum starting address.
+ * @max_addr:	Maximum end address.
+ * @top_down	Find the highest free memory region?
+ * @addr	On success, will have start address of the memory region found.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int kexec_locate_mem_hole(struct kimage *image, unsigned long size,
+			  unsigned long align, unsigned long min_addr,
+			  unsigned long max_addr, bool top_down,
+			  unsigned long *addr)
+{
+	int ret;
+	struct kexec_buf buf;
+
+	memset(&buf, 0, sizeof(struct kexec_buf));
+	buf.image = image;
+
+	buf.memsz = size;
+	buf.buf_align = align;
+	buf.buf_min = min_addr;
+	buf.buf_max = max_addr;
+	buf.top_down = top_down;
+
+	ret = arch_kexec_walk_mem(&buf, locate_mem_hole_callback);
+	if (ret != 1) {
+		/* A suitable memory range could not be found for buffer */
+		return -EADDRNOTAVAIL;
+	}
+
+	*addr = buf.mem;
+
+	return 0;
+}
+
 /*
  * Helper function for placing a buffer in a kexec segment. This assumes
  * that kexec_mutex is held.
@@ -460,8 +500,8 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 {
 
 	struct kexec_segment *ksegment;
-	struct kexec_buf buf, *kbuf;
 	int ret;
+	unsigned long addr, align, size;
 
 	/* Currently adding segment this way is allowed only in file mode */
 	if (!image->file_mode)
@@ -482,29 +522,21 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 		return -EINVAL;
 	}
 
-	memset(&buf, 0, sizeof(struct kexec_buf));
-	kbuf = &buf;
-	kbuf->image = image;
-
-	kbuf->memsz = ALIGN(memsz, PAGE_SIZE);
-	kbuf->buf_align = max(buf_align, PAGE_SIZE);
-	kbuf->buf_min = buf_min;
-	kbuf->buf_max = buf_max;
-	kbuf->top_down = top_down;
+	size = ALIGN(memsz, PAGE_SIZE);
+	align = max(buf_align, PAGE_SIZE);
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
-	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
-	if (ret != 1) {
-		/* A suitable memory range could not be found for buffer */
-		return -EADDRNOTAVAIL;
-	}
+	ret = kexec_locate_mem_hole(image, size, align, buf_min, buf_max,
+				    top_down, &addr);
+	if (ret)
+		return ret;
 
 	/* Found a suitable memory range */
 	ksegment = &image->segment[image->nr_segments];
 	ksegment->kbuf = buffer;
 	ksegment->bufsz = bufsz;
-	ksegment->mem = kbuf->mem;
-	ksegment->memsz = kbuf->memsz;
+	ksegment->mem = addr;
+	ksegment->memsz = size;
 	image->nr_segments++;
 	*load_addr = ksegment->mem;
 	return 0;
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
