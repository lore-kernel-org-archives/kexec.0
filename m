Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1ben6V-0005lB-Qc
 for kexec@lists.infradead.org; Tue, 30 Aug 2016 17:45:46 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7UHhfxL103936
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 13:45:25 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 255365su23-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 13:45:24 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 30 Aug 2016 14:45:22 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 31B2D352005F
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 13:44:57 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7UHjIJG33554892
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 14:45:18 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7UHjHc6015835
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 14:45:18 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v4 4/5] kexec_file: Add mechanism to update kexec segments.
Date: Tue, 30 Aug 2016 14:45:04 -0300
In-Reply-To: <1472579105-26296-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1472579105-26296-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1472579105-26296-5-git-send-email-bauerman@linux.vnet.ibm.com>
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org, Eric Richter <erichte@linux.vnet.ibm.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

kexec_update_segment allows a given segment in kexec_image to have
its contents updated. This is useful if the current kernel wants to
send information to the next kernel that is up-to-date at the time of
reboot.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_core.c   | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index edadff6c86ff..ff3aa93649e2 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -256,6 +256,8 @@ extern int kexec_purgatory_get_set_symbol(struct kimage *image,
 					  unsigned int size, bool get_value);
 extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
 					     const char *name);
+int kexec_update_segment(const char *buffer, size_t bufsz,
+			 unsigned long load_addr, size_t memsz);
 extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 561675589511..d3f1ebf66222 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -721,6 +721,104 @@ static struct page *kimage_alloc_page(struct kimage *image,
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
+int kexec_update_segment(const char *buffer, size_t bufsz,
+			 unsigned long load_addr, size_t memsz)
+{
+	int i;
+	unsigned long entry;
+	unsigned long *ptr = NULL;
+	void *dest = NULL;
+
+	if (kexec_image == NULL) {
+		pr_err("Can't update segment: no kexec image loaded.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * kexec_add_buffer rounds up segment sizes to PAGE_SIZE, so
+	 * we have to do it here as well.
+	 */
+	memsz = ALIGN(memsz, PAGE_SIZE);
+
+	for (i = 0; i < kexec_image->nr_segments; i++)
+		/* We only support updating whole segments. */
+		if (load_addr == kexec_image->segment[i].mem &&
+		    memsz == kexec_image->segment[i].memsz) {
+			if (!kexec_image->segment[i].skip_checksum) {
+				pr_err("Trying to update non-modifiable segment.\n");
+				return -EINVAL;
+			}
+
+			break;
+		}
+	if (i == kexec_image->nr_segments) {
+		pr_err("Couldn't find segment to update: 0x%lx, size 0x%zx\n",
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
+			ptr = __va(entry & PAGE_MASK);
+			break;
+		case IND_SOURCE:
+			/* Shouldn't happen, but verify just to be safe. */
+			if (dest == NULL) {
+				pr_err("Invalid kexec entries list.");
+				return -EINVAL;
+			}
+
+			if (dest == (void *) load_addr) {
+				void *page_addr;
+				unsigned long offset;
+				size_t uchunk, mchunk;
+
+				page_addr = kmap_atomic(kmap_to_page(addr));
+
+				offset = load_addr & ~PAGE_MASK;
+				mchunk = min_t(size_t, memsz,
+					       PAGE_SIZE - offset);
+				uchunk = min(bufsz, mchunk);
+				memcpy(page_addr + offset, buffer, uchunk);
+
+				kunmap_atomic(page_addr);
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
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
