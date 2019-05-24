Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hU3d3-0008Rb-KK
 for kexec@lists.infradead.org; Fri, 24 May 2019 06:24:35 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 4/4] crashdump/x86: Use new introduce helper for getting
 RSDP
Date: Fri, 24 May 2019 14:23:21 +0800
Message-Id: <20190524062321.24126-5-kasong@redhat.com>
In-Reply-To: <20190524062321.24126-1-kasong@redhat.com>
References: <20190524062321.24126-1-kasong@redhat.com>
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
Cc: Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>

Use the new introduce helper for getting RSDP, this ensures RSDP is
always accessible and avoid code duplication.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 34 +++++++++------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 140f45b..a2aea31 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -787,35 +787,19 @@ static int sysfs_efi_runtime_map_exist(void)
 /* Appends 'acpi_rsdp=' commandline for efi boot crash dump */
 static void cmdline_add_efi(char *cmdline)
 {
-	FILE *fp;
-	int cmdlen, len;
-	char line[MAX_LINE], *s;
-	const char *acpis = " acpi_rsdp=";
+	uint64_t acpi_rsdp;
+	char acpi_rsdp_buf[MAX_LINE];
 
-	fp = fopen("/sys/firmware/efi/systab", "r");
-	if (!fp)
-		return;
+	acpi_rsdp = get_acpi_rsdp();
 
-	while(fgets(line, sizeof(line), fp) != 0) {
-		/* ACPI20= always goes before ACPI= */
-		if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
-		        line[strlen(line) - 1] = '\0';
-			s = strchr(line, '=');
-			s += 1;
-			len = strlen(s) + strlen(acpis);
-			cmdlen = strlen(cmdline) + len;
-			if (cmdlen > (COMMAND_LINE_SIZE - 1))
-				die("Command line overflow\n");
-			strcat(cmdline, acpis);
-			strcat(cmdline, s);
-			dbgprintf("Command line after adding efi\n");
-			dbgprintf("%s\n", cmdline);
+	if (!acpi_rsdp)
+		return;
 
-			break;
-		}
-	}
+	sprintf(acpi_rsdp_buf, " acpi_rsdp=0x%lx", acpi_rsdp);
+	if (strlen(cmdline) + strlen(acpi_rsdp_buf) > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
 
-	fclose(fp);
+	strcat(cmdline, acpi_rsdp_buf);
 }
 
 static void get_backup_area(struct kexec_info *info,
-- 
2.21.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
