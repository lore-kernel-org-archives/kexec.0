Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dsoKE-0000Bm-Uq
 for kexec@lists.infradead.org; Fri, 15 Sep 2017 10:58:32 +0000
Received: by mail-pg0-x236.google.com with SMTP id 7so1298767pgd.13
 for <kexec@lists.infradead.org>; Fri, 15 Sep 2017 03:58:01 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 02/10] resource: add walk_system_ram_res_rev()
Date: Fri, 15 Sep 2017 19:59:24 +0900
Message-Id: <20170915105932.25338-3-takahiro.akashi@linaro.org>
In-Reply-To: <20170915105932.25338-1-takahiro.akashi@linaro.org>
References: <20170915105932.25338-1-takahiro.akashi@linaro.org>
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
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This function, being a variant of walk_system_ram_res() introduced in
commit 8c86e70acead ("resource: provide new functions to walk through
resources"), walks through a list of all the resources of System RAM
in reversed order, i.e., from higher to lower.

It will be used in kexec_file implementation on arm64.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6230064d7f95..9a212266299f 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -271,6 +271,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(u64, u64, void *));
 extern int
+walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+			int (*func)(u64, u64, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(u64, u64, void *));
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 9b5f04404152..572f2f91ce9c 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -23,6 +23,8 @@
 #include <linux/pfn.h>
 #include <linux/mm.h>
 #include <linux/resource_ext.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 
 
@@ -469,6 +471,63 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 	return ret;
 }
 
+int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+				int (*func)(u64, u64, void *))
+{
+	struct resource res, *rams;
+	u64 orig_end;
+	int count, i;
+	int ret = -1;
+
+	count = 16; /* initial */
+
+	/* create a list */
+	rams = vmalloc(sizeof(struct resource) * count);
+	if (!rams)
+		return ret;
+
+	res.start = start;
+	res.end = end;
+	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+	orig_end = res.end;
+	i = 0;
+	while ((res.start < res.end) &&
+		(!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
+		if (i >= count) {
+			/* re-alloc */
+			struct resource *rams_new;
+			int count_new;
+
+			count_new = count + 16;
+			rams_new = vmalloc(sizeof(struct resource) * count_new);
+			if (!rams_new)
+				goto out;
+
+			memcpy(rams_new, rams, count);
+			vfree(rams);
+			rams = rams_new;
+			count = count_new;
+		}
+
+		rams[i].start = res.start;
+		rams[i++].end = res.end;
+
+		res.start = res.end + 1;
+		res.end = orig_end;
+	}
+
+	/* go reverse */
+	for (i--; i >= 0; i--) {
+		ret = (*func)(rams[i].start, rams[i].end, arg);
+		if (ret)
+			break;
+	}
+
+out:
+	vfree(rams);
+	return ret;
+}
+
 #if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
 
 /*
-- 
2.14.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
