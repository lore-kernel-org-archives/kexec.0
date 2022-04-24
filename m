From: Hui Li <lihui@loongson.cn>
Date: Sun, 24 Apr 2022 10:35:23 +0800
Subject: [PATCH v2 2/2] kexec-tools: mips: Add initrd parameter to cmdline
In-Reply-To: <20220424023523.16869-1-lihui@loongson.cn>
References: <20220424023523.16869-1-lihui@loongson.cn>
Message-ID: <20220424023523.16869-3-lihui@loongson.cn>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Loongson platform obtain the initrd parameter through cmdline in kernel.
But kexec-tools pass the initrd through DTB.So add initrd parameter
to cmdline in order to compatible with some platforms.It is still
to pass the initrd parameter via command line.

Signed-off-by: Hui Li <lihui@loongson.cn>
---
 kexec/arch/mips/kexec-elf-mips.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index a2d11fc..1de418e 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -40,6 +40,44 @@ static const int probe_debug = 0;
 #define CMDLINE_PREFIX "kexec "
 static char cmdline_buf[COMMAND_LINE_SIZE] = CMDLINE_PREFIX;
 
+/* Converts unsigned long to ascii string. */
+static void ultoa(unsigned long i, char *str)
+{
+	int j = 0, k;
+	char tmp;
+
+	do {
+		str[j++] = i % 10 + '0';
+	} while ((i /= 10) > 0);
+	str[j] = '\0';
+	/* Reverse the string. */
+	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
+		tmp = str[k];
+		str[k] = str[j];
+		str[j] = tmp;
+	}
+}
+
+/* Adds initrd parameters to command line. */
+static int cmdline_add_initrd(char *cmdline, unsigned long addr, char *new_para)
+{
+	int cmdlen, len;
+	char str[30], *ptr;
+
+	ptr = str;
+	strcpy(str, new_para);
+	ptr += strlen(str);
+	ultoa(addr, ptr);
+	len = strlen(str);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str);
+
+	return 0;
+}
+
+
 int elf_mips_probe(const char *buf, off_t len)
 {
 	struct mem_ehdr ehdr;
@@ -171,6 +209,11 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 		/* Now that the buffer for initrd is prepared, update the dtb
 		 * with an appropriate location */
 		dtb_set_initrd(&dtb_buf, &dtb_length, initrd_base, initrd_base + initrd_size);
+
+		/* Add the initrd parameters to cmdline */
+		cmdline_add_initrd(cmdline_buf, PAGE_OFFSET + initrd_base, " rd_start=");
+		cmdline_add_initrd(cmdline_buf, initrd_size, " rd_size=");
+
 	}
 
 
-- 
2.20.1


