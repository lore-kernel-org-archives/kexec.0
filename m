Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21E7C433EF
	for <kexec@archiver.kernel.org>; Sat, 25 Jun 2022 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=655xghm8ODm5fMDVARVp2EuIc5oqW4ukdHFy+WEnWNE=; b=4dT4MZZU/5HUsX
	L6qOjcOVRC+bGM66G+Pem/5jGeyIsJocFoSOFN3BBZNAfnGd+yt5DLhf7EB0CxeFVGvQP+i8/49BK
	ahLzd9QmwA1E9Cy51nQkPG1jtfv6jkCUr34LiSywhXTE+bVvlyzCDXrz7IEfnCXhpM8pSyac939O+
	lxxHX8FYv+GtMrP9QaUEgyCsoYTPzWIOCV6yMcfclunZn+1yMllmsumNBtLRJ0jdk5pL5LKFeFLrP
	zDglzvhbXlUPKB0UlwjalBfH0ucwcEOHf+x1uTBMdoVjSK1+JI+JHRIo3izRmS7Wetn9AvJ3RTG+3
	JA4U64EpYKTS6v1Sm2ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4vs0-004SDv-Ag; Sat, 25 Jun 2022 02:50:00 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4vrv-004SDK-RC
	for kexec@lists.infradead.org; Sat, 25 Jun 2022 02:49:58 +0000
Received: from localhost.localdomain (unknown [113.200.148.30])
	by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_9fNd7Zi06NYAA--.2963S2;
	Sat, 25 Jun 2022 10:49:50 +0800 (CST)
From: Hui Li <lihui@loongson.cn>
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org
Subject: [PATCH v6] kexec-tools: mips: Pass initrd parameter via cmdline
Date: Sat, 25 Jun 2022 10:49:49 +0800
Message-Id: <20220625024949.4274-1-lihui@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CM-TRANSID: AQAAf9Dx_9fNd7Zi06NYAA--.2963S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4xKF48trWDtr13Ww15Jwb_yoW7uw48pw
	43tas8Gr4rXrs7tryfAFs8Zw4fWwnxA3WjqFW3W34UX3W5Xw1YqrWfXF13ZryDJr4YvF1f
	trWYqr95ua1xZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8JwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
	AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUg9aBUUUUU
X-CM-SenderInfo: 5olk3xo6or00hjvr0hdfq/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220624_194956_304109_F7A0CB92 
X-CRM114-Status: GOOD (  17.43  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Under loongson platform, use command:
kexec -l vmlinux... --append="root=UUID=28e1..." --initrd=...
kexec -e
quick restart failed like this:

********************************************************************
[    3.420791] VFS: Cannot open root device "UUID=6462a8a4-02fb-49..."
[    3.431262] Please append a correct "root=" boot option; ...
...
...
...
[    3.543175]   0801         4194304 sda1 554e69cc-01
[    3.543175]
[    3.549494]   0802        62914560 sda2 554e69cc-02
[    3.549495]
[    3.555818]   0803         8388608 sda3 554e69cc-03
[    3.555819]
[    3.562139]   0804       174553229 sda4 554e69cc-04
[    3.562139]
[    3.568463] 0b00         1048575 sr0
[    3.568464]  driver: sr
[    3.574524] Kernel panic - not syncing: VFS: Unable to mount root fs...
[    3.582750] ---[ end Kernel panic - not syncing: VFS:...
*******************************************************************

The kernel cannot parse the UUID, the UUID is parsed in the initrd.
For compatibility with previous platforms, loongson platform obtain
initrd parameter through cmdline in kernel, the kernel supports use
cmdline to parse initrd. But under the mips architecture, kexec-tools
pass the initrd through DTB.

Made the following modifications:

(1) in kexec/arch/mips/kexec-elf-mips.c
    Add patch_initrd_info(), at runtime to distinguish different cpu,
    only for loongson cpu, add initrd parameter to cmdline.

(2) in kexec/arch/mips/crashdump-mips.c
    Because loongson uses a different page_offset, it should be modified
    to ensure that crashdump functionality is correct and reliable.

(3) in kexec/arch/mips/crashdump-mips.h
    Added platform-specific page_offset macro definition.

Signed-off-by: Hui Li <lihui@loongson.cn>
---
 kexec/arch/mips/crashdump-mips.c |  5 ++-
 kexec/arch/mips/crashdump-mips.h |  2 +
 kexec/arch/mips/kexec-elf-mips.c | 76 +++++++++++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index aa09c83..d9f4515 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -334,7 +334,10 @@ static int patch_elf_info(void)
 		if (strncmp(line, "cpu model", 9) == 0) {
 			/* OCTEON uses a different page_offset. */
 			if (strstr(line, "Octeon"))
-				elf_info64.page_offset = 0x8000000000000000ULL;
+				elf_info64.page_offset = OCTEON_PAGE_OFFSET;
+			/* LOONGSON uses a different page_offset. */
+			else if (strstr(line, "Loongson"))
+				elf_info64.page_offset = LOONGSON_PAGE_OFFSET;
 			break;
 		}
 	}
diff --git a/kexec/arch/mips/crashdump-mips.h b/kexec/arch/mips/crashdump-mips.h
index 7edd859..55c9925 100644
--- a/kexec/arch/mips/crashdump-mips.h
+++ b/kexec/arch/mips/crashdump-mips.h
@@ -13,6 +13,8 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 #endif
 #define __pa(x)		((unsigned long)(X) & 0x7fffffff)
 
+#define LOONGSON_PAGE_OFFSET	0xffffffff80000000ULL
+#define OCTEON_PAGE_OFFSET	0x8000000000000000ULL
 
 #define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
 #define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index a2d11fc..31f4c47 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -40,6 +40,77 @@ static const int probe_debug = 0;
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
+
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
+/* add initrd to cmdline to compatible with previous platforms. */
+static int patch_initrd_info(char *cmdline, unsigned long base,
+			     unsigned long size)
+{
+	const char cpuinfo[] = "/proc/cpuinfo";
+	char line[MAX_LINE];
+	FILE *fp;
+	unsigned long page_offset = PAGE_OFFSET;
+
+	fp = fopen(cpuinfo, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %s\n",
+		cpuinfo, strerror(errno));
+		return -1;
+	}
+	while (fgets(line, sizeof(line), fp) != 0) {
+		if (strncmp(line, "cpu model", 9) == 0) {
+			if (strstr(line, "Loongson")) {
+				/* LOONGSON64  uses a different page_offset. */
+				if (arch_options.core_header_type ==
+				    CORE_TYPE_ELF64)
+					page_offset = LOONGSON_PAGE_OFFSET;
+				cmdline_add_initrd(cmdline,
+					     page_offset + base, " rd_start=");
+				cmdline_add_initrd(cmdline, size, " rd_size=");
+				break;
+			}
+		}
+	}
+	fclose(fp);
+	return 0;
+}
+
 int elf_mips_probe(const char *buf, off_t len)
 {
 	struct mem_ehdr ehdr;
@@ -171,9 +242,10 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 		/* Now that the buffer for initrd is prepared, update the dtb
 		 * with an appropriate location */
 		dtb_set_initrd(&dtb_buf, &dtb_length, initrd_base, initrd_base + initrd_size);
-	}
-
 
+		/* Add the initrd parameters to cmdline */
+		patch_initrd_info(cmdline_buf, initrd_base, initrd_size);
+	}
 	/* This is a legacy method for commandline passing used
 	 * currently by Octeon CPUs only */
 	add_buffer(info, cmdline_buf, sizeof(cmdline_buf),
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
