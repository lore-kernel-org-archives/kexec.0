Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9y22-0005R9-DP
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:09:44 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 15/32] arm: fix get_kernel_stext_sym() to close
 its file
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xse-0003ss-GY@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 18:00:00 +0100
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
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>

Fix get_kernel_stext_sym() so that it closes its file once it's
finsihed with it - there's no need to leak file descriptors.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index b523e5f..a390187 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -71,25 +71,34 @@ static unsigned long long get_kernel_stext_sym(void)
 	char sym[128];
 	char line[128];
 	FILE *fp;
-	unsigned long long vaddr;
+	unsigned long long vaddr = 0;
 	char type;
 
-	fp = fopen(kallsyms, "r");	if (!fp) {
+	fp = fopen(kallsyms, "r");
+	if (!fp) {
 		fprintf(stderr, "Cannot open %s\n", kallsyms);
 		return 0;
 	}
 
 	while(fgets(line, sizeof(line), fp) != NULL) {
-		if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
+		unsigned long long addr;
+
+		if (sscanf(line, "%Lx %c %s", &addr, &type, sym) != 3)
 			continue;
+
 		if (strcmp(sym, stext) == 0) {
-			dbgprintf("kernel symbol %s vaddr = %16llx\n", stext, vaddr);
-			return vaddr;
+			dbgprintf("kernel symbol %s vaddr = %#llx\n", stext, addr);
+			vaddr = addr;
+			break;
 		}
 	}
 
-	fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
-	return 0;
+	fclose(fp);
+
+	if (vaddr == 0)
+		fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
+
+	return vaddr;
 }
 
 static int get_kernel_page_offset(struct kexec_info *info,
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
