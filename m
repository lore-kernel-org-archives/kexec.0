Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91D8C433EF
	for <kexec@archiver.kernel.org>; Fri, 24 Jun 2022 09:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zo0FS3/aqzj5HPowOYjq1tBxUm2/Ox4jAC17Cttyxgk=; b=QGNXJteaUY4sjE
	eLKNOiKQJDtrz/0bBnM0Q70NS5GU4AF03J6O4yVKb+edyNOPcOGmqCOxd/WY7WanC06DAClg4WTgm
	hRpaNvJtf17JcFF3/y4zUirRhbTYpTZf2sS5DqWjuMBQZrnjsfzovEV5fSE4jVChmN9WMorKZfUgQ
	oXdaBfEwgl4y6R5MeAq3Z1opC4nOl/emUaXyu4jWVG8uQ6AZudd0XK9hth5Mk5gO5cpQ3ev59QpqJ
	8Eb0u3oQAaukxrO3x5Mo0U49+nmz4d5zwCXwSHZqJt2ikyRUi5qLeKEKKhJ8clgrB5l7BgQyrXBrM
	0z2tlFt96xTha2Qv7x+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4fg3-001Qrd-Iw; Fri, 24 Jun 2022 09:32:35 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4ffw-001QmT-Og
	for kexec@lists.infradead.org; Fri, 24 Jun 2022 09:32:31 +0000
Received: from localhost.localdomain (unknown [113.200.148.30])
	by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL9ekhLVijCpYAA--.2466S2;
	Fri, 24 Jun 2022 17:32:20 +0800 (CST)
From: Hui Li <lihui@loongson.cn>
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org
Subject: [PATCH v5] kexec-tools: mips: Pass initrd parameter via cmdline
Date: Fri, 24 Jun 2022 17:32:19 +0800
Message-Id: <20220624093219.3192-1-lihui@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CM-TRANSID: AQAAf9DxL9ekhLVijCpYAA--.2466S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4xKF48trWDtrW5KFyfZwb_yoW7tF15pw
	47ta98Gr4rXr4xtr1fAFs8uw4fWwnxA3WjqFW3W34UX3WYq3WYqrWfXF13ZryDJr4jyF1S
	yrWYqr9Y9a1xZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8uwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
	AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUyD7aUUUUU
X-CM-SenderInfo: 5olk3xo6or00hjvr0hdfq/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220624_023229_225881_EC7BF9E1 
X-CRM114-Status: GOOD (  17.69  )
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
 kexec/arch/mips/crashdump-mips.h |  4 +-
 kexec/arch/mips/kexec-elf-mips.c | 76 +++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 4 deletions(-)

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
index 7edd859..641dc50 100644
--- a/kexec/arch/mips/crashdump-mips.h
+++ b/kexec/arch/mips/crashdump-mips.h
@@ -5,7 +5,9 @@ struct kexec_info;
 int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 				unsigned long max_addr, unsigned long min_base);
 #ifdef __mips64
-#define PAGE_OFFSET	0xa800000000000000ULL
+#define PAGE_OFFSET             0xa800000000000000ULL
+#define LOONGSON_PAGE_OFFSET    0xffffffff80000000ULL
+#define OCTEON_PAGE_OFFSET      0x8000000000000000ULL
 #define MAXMEM		0
 #else
 #define PAGE_OFFSET	0x80000000
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
