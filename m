Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5mb7-0004yj-NL
 for kexec@lists.infradead.org; Fri, 28 Sep 2018 06:50:25 +0000
Received: by mail-pg1-x544.google.com with SMTP id i4-v6so3119166pgq.9
 for <kexec@lists.infradead.org>; Thu, 27 Sep 2018 23:49:36 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v15 16/16] arm64: kexec_file: add kaslr support
Date: Fri, 28 Sep 2018 15:48:41 +0900
Message-Id: <20180928064841.14117-17-takahiro.akashi@linaro.org>
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
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

Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
address randomization, at secondary kernel boot. We always do this as
it will have no harm on kaslr-incapable kernel.

We don't have any "switch" to turn off this feature directly, but still
can suppress it by passing "nokaslr" as a kernel boot argument.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 4b5ea256c84c..c2ca7c921e7a 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -16,6 +16,7 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
@@ -27,6 +28,7 @@
 #define FDT_PSTR_INITRD_STA	"linux,initrd-start"
 #define FDT_PSTR_INITRD_END	"linux,initrd-end"
 #define FDT_PSTR_BOOTARGS	"bootargs"
+#define FDT_PSTR_KASLR_SEED	"kaslr-seed"
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_image_ops,
@@ -45,6 +47,32 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
+/* crng needs to have been initialized for providing kaslr-seed */
+static int random_ready;
+
+static void random_ready_notified(struct random_ready_callback *unused)
+{
+	random_ready = 1;
+}
+
+static struct random_ready_callback random_ready_cb = {
+	.func = random_ready_notified,
+};
+
+static __init int init_random_ready_cb(void)
+{
+	int ret;
+
+	ret = add_random_ready_callback(&random_ready_cb);
+	if (ret == -EALREADY)
+		random_ready = 1;
+	else if (ret)
+		pr_warn("failed to add a callback for random_ready\n");
+
+	return 0;
+}
+late_initcall(init_random_ready_cb)
+
 static int setup_dtb(struct kimage *image,
 		unsigned long initrd_load_addr, unsigned long initrd_len,
 		char *cmdline, unsigned long cmdline_len,
@@ -54,6 +82,7 @@ static int setup_dtb(struct kimage *image,
 	int addr_cells, size_cells;
 	size_t buf_size, range_size;
 	int nodeoffset;
+	u64 value;
 	int ret;
 
 	/* duplicate dt blob */
@@ -81,6 +110,8 @@ static int setup_dtb(struct kimage *image,
 		/* can be redundant, but trimmed at the end */
 		buf_size += fdt_prop_len(FDT_PSTR_BOOTARGS, cmdline_len);
 
+	buf_size += fdt_prop_len(FDT_PSTR_KASLR_SEED, sizeof(u64));
+
 	buf = vmalloc(buf_size);
 	if (!buf) {
 		ret = -ENOMEM;
@@ -160,6 +191,20 @@ static int setup_dtb(struct kimage *image,
 		}
 	}
 
+	/* add kaslr-seed */
+	fdt_delprop(buf, nodeoffset, FDT_PSTR_KASLR_SEED);
+	if (random_ready) {
+		get_random_bytes(&value, sizeof(value));
+		ret = fdt_setprop_u64(buf, nodeoffset, FDT_PSTR_KASLR_SEED,
+							value);
+		if (ret) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+	} else {
+		pr_notice("kaslr-seed won't be fed\n");
+	}
+
 	/* trim a buffer */
 	fdt_pack(buf);
 	*dtb_buf = buf;
-- 
2.19.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
