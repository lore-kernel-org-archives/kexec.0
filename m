Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gNAZw-0005GG-M7
 for kexec@lists.infradead.org; Thu, 15 Nov 2018 05:52:38 +0000
Received: by mail-yb1-xb41.google.com with SMTP id n140-v6so7938329yba.1
 for <kexec@lists.infradead.org>; Wed, 14 Nov 2018 21:52:26 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v16 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
Date: Thu, 15 Nov 2018 14:52:42 +0900
Message-Id: <20181115055254.2812-4-takahiro.akashi@linaro.org>
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: ard.biesheuvel@linaro.org, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, prudo@linux.ibm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

Since s390 already knows where to locate buffers, calling
arch_kexec_mem_walk() has no sense. So we can just drop it as kbuf->mem
indicates this while all other architectures sets it to 0 initially.

This change is a preparatory work for the next patch, where all the
variant memory walks, either on system resource or memblock, will be
put in one common place so that it will satisfy all the architectures'
need.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 10 ----------
 include/linux/kexec.h                 |  8 ++++++++
 kernel/kexec_file.c                   |  4 ++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index f413f57f8d20..32023b4f9dc0 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -134,16 +134,6 @@ int kexec_file_add_initrd(struct kimage *image, struct s390_load_data *data,
 	return ret;
 }
 
-/*
- * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
- * and provide kbuf->mem by hand.
- */
-int arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			int (*func)(struct resource *, void *))
-{
-	return 1;
-}
-
 int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     Elf_Shdr *section,
 				     const Elf_Shdr *relsec,
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 49ab758f4d91..f378cb786f1b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -145,6 +145,14 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len);
 int kexec_image_post_load_cleanup_default(struct kimage *image);
 
+/*
+ * If kexec_buf.mem is set to this value, kexec_locate_mem_hole()
+ * will try to allocate free memory. Arch may overwrite it.
+ */
+#ifndef KEXEC_BUF_MEM_UNKNOWN
+#define KEXEC_BUF_MEM_UNKNOWN 0
+#endif
+
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
  * @image:	kexec image in which memory to search.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 9ce6672f4fa3..9e6529da12ed 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -532,6 +532,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 {
 	int ret;
 
+	/* Arch knows where to place */
+	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
+		return 0;
+
 	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
-- 
2.19.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
