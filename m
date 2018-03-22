Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1eyr2y-0002hG-N1
 for kexec@lists.infradead.org; Thu, 22 Mar 2018 03:37:52 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/2] resource: add walk_system_ram_res_rev()
Date: Thu, 22 Mar 2018 11:37:21 +0800
Message-Id: <20180322033722.9279-2-bhe@redhat.com>
In-Reply-To: <20180322033722.9279-1-bhe@redhat.com>
References: <20180322033722.9279-1-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: prudo@linux.vnet.ibm.com, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, takahiro.akashi@linaro.org, ebiederm@xmission.com, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This function, being a variant of walk_system_ram_res() introduced in
commit 8c86e70acead ("resource: provide new functions to walk through
resources"), walks through a list of all the resources of System RAM
in reversed order, i.e., from higher to lower.

It will be used in kexec_file code.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Baoquan He <bhe@redhat.com>

---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..f12d95fe038b 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -277,6 +277,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+			int (*func)(struct resource *, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
diff --git a/kernel/resource.c b/kernel/resource.c
index e270b5048988..f456fc95f1b2 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -23,6 +23,8 @@
 #include <linux/pfn.h>
 #include <linux/mm.h>
 #include <linux/resource_ext.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 
 
@@ -470,6 +472,67 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 }
 
 /*
+ * This function, being a variant of walk_system_ram_res(), calls the @func
+ * callback against all memory ranges of type System RAM which are marked as
+ * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
+ * higher to lower.
+ */
+int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+				int (*func)(struct resource *, void *))
+{
+	struct resource res, *rams;
+	int rams_size = 16, i;
+	int ret = -1;
+
+	/* create a list */
+	rams = vmalloc(sizeof(struct resource) * rams_size);
+	if (!rams)
+		return ret;
+
+	res.start = start;
+	res.end = end;
+	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+	i = 0;
+	while ((res.start < res.end) &&
+		(!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
+		if (i >= rams_size) {
+			/* re-alloc */
+			struct resource *rams_new;
+			int rams_new_size;
+
+			rams_new_size = rams_size + 16;
+			rams_new = vmalloc(sizeof(struct resource)
+							* rams_new_size);
+			if (!rams_new)
+				goto out;
+
+			memcpy(rams_new, rams,
+					sizeof(struct resource) * rams_size);
+			vfree(rams);
+			rams = rams_new;
+			rams_size = rams_new_size;
+		}
+
+		rams[i].start = res.start;
+		rams[i++].end = res.end;
+
+		res.start = res.end + 1;
+		res.end = end;
+	}
+
+	/* go reverse */
+	for (i--; i >= 0; i--) {
+		ret = (*func)(&rams[i], arg);
+		if (ret)
+			break;
+	}
+
+out:
+	vfree(rams);
+	return ret;
+}
+
+/*
  * This function calls the @func callback against all memory ranges, which
  * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
  */
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
