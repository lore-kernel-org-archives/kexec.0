Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g3Fw4-00006f-D4
 for kexec@lists.infradead.org; Fri, 21 Sep 2018 07:35:08 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 2/3 v3] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Date: Fri, 21 Sep 2018 15:32:10 +0800
Message-Id: <20180921073211.20097-3-lijiang@redhat.com>
In-Reply-To: <20180921073211.20097-1-lijiang@redhat.com>
References: <20180921073211.20097-1-lijiang@redhat.com>
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, bp@suse.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

kdump uses walk_iomem_res_desc() to iterate io resources, then adds matched
desc to e820 table for kdump kernel.

But IORES_DESC_NONE resource type includes several different e820 types,
we need add exact e820 type to kdump kernel e820 table, thus it also needs
an extra checking in memmap_entry_callback() to match the e820 type and
resource name.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/include/asm/e820/api.h | 2 ++
 arch/x86/kernel/crash.c         | 6 +++++-
 arch/x86/kernel/e820.c          | 2 +-
 kernel/resource.c               | 1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 62be73b23d5c..6d5451b36e80 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -42,6 +42,8 @@ extern void e820__register_nosave_regions(unsigned long limit_pfn);
 
 extern int  e820__get_entry_type(u64 start, u64 end);
 
+extern const char *e820_type_to_string(struct e820_entry *entry);
+
 /*
  * Returns true iff the specified range [start,end) is completely contained inside
  * the ISA region.
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f631a3f15587..ae724a6e0a5f 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -37,6 +37,7 @@
 #include <asm/reboot.h>
 #include <asm/virtext.h>
 #include <asm/intel_pt.h>
+#include <asm/e820/api.h>
 
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
@@ -314,11 +315,14 @@ static int memmap_entry_callback(struct resource *res, void *arg)
 	struct crash_memmap_data *cmd = arg;
 	struct boot_params *params = cmd->params;
 	struct e820_entry ei;
+	const char *name;
 
 	ei.addr = res->start;
 	ei.size = resource_size(res);
 	ei.type = cmd->type;
-	add_e820_entry(params, &ei);
+	name = e820_type_to_string(&ei);
+	if (res->name && !strcmp(name, res->name))
+		add_e820_entry(params, &ei);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c88c23c658c1..f9761b2f7abb 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1012,7 +1012,7 @@ void __init e820__finish_early_params(void)
 	}
 }
 
-static const char *__init e820_type_to_string(struct e820_entry *entry)
+const char *e820_type_to_string(struct e820_entry *entry)
 {
 	switch (entry->type) {
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
diff --git a/kernel/resource.c b/kernel/resource.c
index f5d9fc70a04c..cc90633f35f9 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -366,6 +366,7 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
 		res->end = p->end;
 	res->flags = p->flags;
 	res->desc = p->desc;
+	res->name = p->name;
 	return 0;
 }
 
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
