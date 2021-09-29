Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from unicom146.biz-email.net ([210.51.26.146])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVUeX-00AKCR-4t
 for kexec@lists.infradead.org; Wed, 29 Sep 2021 08:09:23 +0000
From: Kai Song <songkai01@inspur.com>
Subject: [PATCH] kexec:Add some necessary fclose() calls
Date: Wed, 29 Sep 2021 16:08:44 +0800
Message-ID: <20210929080844.3870-1-songkai01@inspur.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Kai Song <songkai01@inspur.com>

fclose should be called before function exits

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 kexec/arch/ppc/fixup_dtb.c         | 2 ++
 kexec/arch/ppc64/crashdump-ppc64.c | 1 +
 kexec/arch/ppc64/kexec-ppc64.c     | 4 +++-
 kexec/symbols.c                    | 2 ++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index 4524c8c..92a0bfd 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -382,6 +382,8 @@ static void save_fixed_up_dtb(char *blob_buf, off_t blob_size)
 		} else {
 			dbgprintf("Unable to write debug.dtb\n");
 		}
+
+		fclose(fp);
 	} else {
 		dbgprintf("Unable to dump flat device tree to debug.dtb\n");
 	}
diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index addd769..91f9521 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -161,6 +161,7 @@ static int get_dyn_reconf_crash_memory_ranges(void)
 				fprintf(stderr,
 				"Error: Number of crash memory ranges"
 				" excedeed the max limit\n");
+			fclose(file);
 			return -1;
 		}
 
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 4e70b13..5b17740 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -200,8 +200,10 @@ static int get_dyn_reconf_base_ranges(void)
 			fclose(file);
 			return -1;
 		}
-		if (nr_memory_ranges >= max_memory_ranges)
+		if (nr_memory_ranges >= max_memory_ranges) {
+			fclose(file);
 			return -1;
+		}
 
 		/*
 		 * If the property is ibm,dynamic-memory-v2, the first 4 bytes
diff --git a/kexec/symbols.c b/kexec/symbols.c
index e88f7f3..04377ca 100644
--- a/kexec/symbols.c
+++ b/kexec/symbols.c
@@ -24,11 +24,13 @@ unsigned long long get_kernel_sym(const char *symbol)
 		if (strcmp(sym, symbol) == 0) {
 			dbgprintf("kernel symbol %s vaddr = %16llx\n",
 					symbol, vaddr);
+			fclose(fp);
 			return vaddr;
 		}
 	}
 
 	dbgprintf("Cannot get kernel %s symbol address\n", symbol);
 
+	fclose(fp);
 	return 0;
 }
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
