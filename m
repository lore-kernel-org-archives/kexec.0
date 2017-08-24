Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dknLs-0007ms-9c
 for kexec@lists.infradead.org; Thu, 24 Aug 2017 08:19:02 +0000
Received: by mail-pg0-x22c.google.com with SMTP id 83so13450381pgb.3
 for <kexec@lists.infradead.org>; Thu, 24 Aug 2017 01:18:36 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 06/14] kexec_file: add kexec_add_segment()
Date: Thu, 24 Aug 2017 17:18:03 +0900
Message-Id: <20170824081811.19299-7-takahiro.akashi@linaro.org>
In-Reply-To: <20170824081811.19299-1-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, akpm@linux-foundation.org, mpe@ellerman.id.au, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

In contrast to kexec_add_buffer(), this function assumes that kbuf->mem
is already assigned by caller. This type of allocation is commonly used
in kexec-tools.

This function will be used on arm64 in loading vmlinux(elf) binary.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h |  1 +
 kernel/kexec_file.c   | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index acaecd72b134..be5e99afaf77 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -162,6 +162,7 @@ struct kexec_buf {
 int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 			       int (*func)(u64, u64, void *));
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
+extern int kexec_add_segment(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 #ifdef CONFIG_CRASH_CORE
 extern int prepare_elf_headers(struct kimage *image, void **addr,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 9f48f4412297..d898dec37816 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -519,6 +519,53 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	return 0;
 }
 
+/**
+ * kexec_add_segment - place a buffer in a kexec segment
+ * @kbuf:	Buffer contents and memory parameters.
+ *
+ * In contrast to kexec_add_buffer(), this function assumes
+ * that kbuf->mem is already assigned by caller.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int kexec_add_segment(struct kexec_buf *kbuf)
+{
+
+	struct kexec_segment *ksegment;
+
+	/* Currently adding segment this way is allowed only in file mode */
+	if (!kbuf->image->file_mode)
+		return -EINVAL;
+
+	if (kbuf->image->nr_segments >= KEXEC_SEGMENT_MAX)
+		return -EINVAL;
+
+	/*
+	 * Make sure we are not trying to add buffer after allocating
+	 * control pages. All segments need to be placed first before
+	 * any control pages are allocated. As control page allocation
+	 * logic goes through list of segments to make sure there are
+	 * no destination overlaps.
+	 */
+	if (!list_empty(&kbuf->image->control_pages)) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	/* Ensure minimum alignment needed for segments. */
+	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
+
+	/* Found a suitable memory range */
+	ksegment = &kbuf->image->segment[kbuf->image->nr_segments];
+	ksegment->kbuf = kbuf->buffer;
+	ksegment->bufsz = kbuf->bufsz;
+	ksegment->mem = kbuf->mem;
+	ksegment->memsz = kbuf->memsz;
+	kbuf->image->nr_segments++;
+
+	return 0;
+}
+
 /* Calculate and store the digest of segments */
 static int kexec_calculate_store_digests(struct kimage *image)
 {
-- 
2.14.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
