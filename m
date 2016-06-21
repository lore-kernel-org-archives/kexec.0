Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFAkl-00055i-Qd
 for kexec@lists.infradead.org; Tue, 21 Jun 2016 01:45:25 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L1hdMd007811
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 21:45:03 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23n2fyfg0w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 21:45:03 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:45:01 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8B8A81DC0054
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 21:44:50 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L1ivMV13566226
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 22:44:57 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L1ivQQ030021
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 22:44:57 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 4/6] kexec_file: Add mechanism to update kexec segments.
Date: Mon, 20 Jun 2016 22:44:34 -0300
In-Reply-To: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1466473476-10104-5-git-send-email-bauerman@linux.vnet.ibm.com>
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
Cc: Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Eric Richter <erichte@linux.vnet.ibm.com>

kexec_update_segment allows a given segment in kexec_image to have
its contents updated. This is useful if the current kernel wants to
send information to the next kernel that is up-to-date at the time of
reboot.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_core.c   | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   |  1 +
 3 files changed, 91 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 131b1fc7820e..14d4ac070a8c 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -222,6 +222,8 @@ extern int kexec_add_buffer(struct kimage *image, char *buffer,
 			    unsigned long buf_align, unsigned long buf_min,
 			    unsigned long buf_max, bool top_down, bool checksum,
 			    unsigned long *load_addr);
+int kexec_update_segment(const char *buffer, unsigned long bufsz,
+			 unsigned long load_addr, unsigned long memsz);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
 extern int kexec_load_purgatory(struct kimage *image, unsigned long min,
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 56b3ed0927b0..8781d3e4479d 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -700,6 +700,94 @@ static struct page *kimage_alloc_page(struct kimage *image,
 	return page;
 }
 
+/**
+ * kexec_update_segment - update the contents of a kimage segment
+ * @buffer:	New contents of the segment.
+ * @bufsz:	@buffer size.
+ * @load_addr:	Segment's physical address in the next kernel.
+ * @memsz:	Segment size.
+ *
+ * This function assumes kexec_mutex is held.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int kexec_update_segment(const char *buffer, unsigned long bufsz,
+			 unsigned long load_addr, unsigned long memsz)
+{
+	int i;
+	unsigned long entry;
+	unsigned long *ptr = NULL;
+	void *dest = NULL;
+
+	for (i = 0; i < kexec_image->nr_segments; i++)
+		/* We only support updating whole segments. */
+		if (load_addr == kexec_image->segment[i].mem &&
+		    memsz == kexec_image->segment[i].memsz) {
+			if (kexec_image->segment[i].do_checksum) {
+				pr_err("Trying to update non-modifiable segment.\n");
+				return -EINVAL;
+			}
+
+			break;
+		}
+	if (i == kexec_image->nr_segments) {
+		pr_err("Couldn't find segment to update: 0x%lx, size 0x%lx\n",
+		       load_addr, memsz);
+		return -EINVAL;
+	}
+
+	for (entry = kexec_image->head; !(entry & IND_DONE) && memsz;
+	     entry = *ptr++) {
+		void *addr = (void *) (entry & PAGE_MASK);
+
+		switch (entry & IND_FLAGS) {
+		case IND_DESTINATION:
+			dest = addr;
+			break;
+		case IND_INDIRECTION:
+			ptr = __va(addr);
+			break;
+		case IND_SOURCE:
+			/* Shouldn't happen, but verify just to be safe. */
+			if (dest == NULL) {
+				pr_err("Invalid kexec entries list.");
+				return -EINVAL;
+			}
+
+			if (dest == (void *) load_addr) {
+				struct page *page;
+				char *ptr;
+				size_t uchunk, mchunk;
+
+				page = kmap_to_page(addr);
+
+				ptr = kmap(page);
+				ptr += load_addr & ~PAGE_MASK;
+				mchunk = min_t(size_t, memsz,
+					       PAGE_SIZE - (load_addr & ~PAGE_MASK));
+				uchunk = min(bufsz, mchunk);
+				memcpy(ptr, buffer, uchunk);
+
+				kunmap(page);
+
+				bufsz -= uchunk;
+				load_addr += mchunk;
+				buffer += mchunk;
+				memsz -= mchunk;
+			}
+			dest += PAGE_SIZE;
+		}
+
+		/* Shouldn't happen, but verify just to be safe. */
+		if (ptr == NULL) {
+			pr_err("Invalid kexec entries list.");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int kimage_load_normal_segment(struct kimage *image,
 					 struct kexec_segment *segment)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3aa829a78f50..79d09a7784d8 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/file.h>
 #include <linux/slab.h>
+#include <linux/highmem.h>
 #include <linux/kexec.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
