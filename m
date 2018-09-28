Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5ma0-0004fv-QT
 for kexec@lists.infradead.org; Fri, 28 Sep 2018 06:48:55 +0000
Received: by mail-pg1-x542.google.com with SMTP id c10-v6so3734706pgq.4
 for <kexec@lists.infradead.org>; Thu, 27 Sep 2018 23:48:23 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v15 06/16] of/fdt: add helper functions for handling properties
Date: Fri, 28 Sep 2018 15:48:31 +0900
Message-Id: <20180928064841.14117-7-takahiro.akashi@linaro.org>
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
Cc: devicetree@vger.kernel.org, ard.biesheuvel@linaro.org, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, prudo@linux.ibm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, Rob Herring <robh+dt@kernel.org>, james.morse@arm.com, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org

These functions will be used later to handle kexec-specific properties
in arm64's kexec_file implementation.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
---
 drivers/of/fdt.c       | 56 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h |  4 +++
 2 files changed, 60 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..c65c31562ccb 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -25,6 +25,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1323,3 +1324,58 @@ late_initcall(of_fdt_raw_init);
 #endif
 
 #endif /* CONFIG_OF_EARLY_FLATTREE */
+
+#define FDT_ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
+#define FDT_TAGALIGN(x)	(FDT_ALIGN((x), FDT_TAGSIZE))
+
+int fdt_prop_len(const char *prop_name, int len)
+{
+	return (strlen(prop_name) + 1) +
+		sizeof(struct fdt_property) +
+		FDT_TAGALIGN(len);
+}
+
+static void fill_property(void *buf, u64 val64, int cells)
+{
+	__be32 val32;
+
+	while (cells) {
+		val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
+		memcpy(buf, &val32, sizeof(val32));
+		buf += sizeof(val32);
+	}
+}
+
+int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
+						u64 addr, u64 size)
+{
+	int addr_cells, size_cells;
+	char buf[sizeof(__be32) * 2 * 2];
+		/* assume dt_root_[addr|size]_cells <= 2 */
+	void *prop;
+	size_t buf_size;
+
+	addr_cells = fdt_address_cells(fdt, 0);
+	if (addr_cells < 0)
+		return addr_cells;
+	size_cells = fdt_size_cells(fdt, 0);
+	if (size_cells < 0)
+		return size_cells;
+
+	/* if *_cells >= 2, cells can hold 64-bit values anyway */
+	if ((addr_cells == 1) && (addr > U32_MAX))
+		return -FDT_ERR_BADVALUE;
+
+	if ((size_cells == 1) && (size > U32_MAX))
+		return -FDT_ERR_BADVALUE;
+
+	buf_size = (addr_cells + size_cells) * sizeof(u32);
+	prop = buf;
+
+	fill_property(prop, addr, addr_cells);
+	prop += addr_cells * sizeof(u32);
+
+	fill_property(prop, size, size_cells);
+
+	return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
+}
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index b9cd9ebdf9b9..842af6ea92ea 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -108,5 +108,9 @@ static inline void unflatten_device_tree(void) {}
 static inline void unflatten_and_copy_device_tree(void) {}
 #endif /* CONFIG_OF_EARLY_FLATTREE */
 
+int fdt_prop_len(const char *prop_name, int len);
+int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
+						u64 addr, u64 size);
+
 #endif /* __ASSEMBLY__ */
 #endif /* _LINUX_OF_FDT_H */
-- 
2.19.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
