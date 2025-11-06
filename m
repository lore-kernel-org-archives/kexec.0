Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D19CCFA03
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LbyAEgDnJGsPB9foIQ8o4d15eE5i+swWjLhqn7YTe70=; b=WvFYBt0SOaF4LFyjqW5+h7s+Y2
	Gm/lKkECjUpTBskhGX38MXo26d1evWn4pT4iNx7c1qHm13Nn9txVJN8Dynku7gEc3FConwMYZXkJH
	uBr9V6pwZ1GPFQOUJ4GTxbPuvP9BVOyY/xlOBevxl3Njeeq/OVjj/bn/O7YqxhnXiAjyC+lX9WjHH
	eDf9JWQrtAORoEuZzBiE+1JzjYTQR4qDsZWiTJ4nbBm8QOdArQYc22lB3yjpizfY3ZBl9zO1PmoMn
	1g/hU3G8JnXW/ijZRcKQaEAZXY3+OWC9FTOwpFoDu7Dvv8iRh/Mm/WOVUXhsevF8IVyOaI1MhINYT
	Z4y8f10Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGyim-0000000FPz1-01OT;
	Thu, 06 Nov 2025 12:04:08 +0000
Received: from esa4.hc555-34.eu.iphmx.com ([207.54.77.171])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGyih-0000000FPxj-0Ab0
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 12:04:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1762430642; x=1793966642;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cNfxgOQuWs1JF6rvNLqtJujdXitEZmAXi/TntVweYso=;
  b=R4jN8pCZUQSXgH1cgNNmc3sAiuFVZCoLQIAcrJIJEhUdANozoAt+Temz
   VKMdu3twflEgI7DLjmuovwbfhFjXNmwdTXjL3GT4SmWYP/4/GWX3SRezt
   QW+BeOB4NTkpbIJF2gtkA1DV//idlzBFj+PW5bnuct9APT2PDXeFi35sE
   1UvxowqmKZ9oDKsgLJu34uuMrN5DXxMQlFSnb2oNbmsI4T5sRFcUexsOy
   kbhDYerY5L8csyAkkaXJfVSr3oVwlB0I/PnLNtREQgcxizIeSgLqWVah/
   2Lec0QbAbC0JtCnJv2DymdUIiSc6NYuNw+hZeU+JSISsuHE+qgiwaIqe2
   w==;
X-CSE-ConnectionGUID: jFIsLvRtQL+3dYn4G2CaQA==
X-CSE-MsgGUID: IW+3toKsRICwMrhwXJyF5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 14:03:57 +0200
X-CSE-ConnectionGUID: y/zLHxB6TuWlcqGezwVLVA==
X-CSE-MsgGUID: 33g8M7SESS2KuHxclaBMMg==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 06 Nov 2025 14:04:16 +0200
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Thu, 06 Nov 2025 14:03:56 +0200
From: Pnina Feder <pnina.feder@mobileye.com>
To: horms@verge.net.au
Cc: kexec@lists.infradead.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH] util_lib: Add direct map fallback in vaddr_to_offset()
Date: Thu,  6 Nov 2025 14:03:44 +0200
Message-ID: <20251106120344.2382695-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_040403_543662_23768680 
X-CRM114-Status: GOOD (  18.92  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The vmcore-dmesg tool could fail with the message:
"No program header covering vaddr 0x%llx found kexec bug?"

This occurred when a virtual address belonged to the kernel’s direct
mapping region, which may not be covered by any PT_LOAD segment in
the vmcore ELF headers.

Add a direct-map fallback in vaddr_to_offset() that converts such
virtual addresses using the known page and physical offsets. This
allows resolving these addresses correctly.

Tested on Linux 6.16 (RISC-V)

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 util_lib/elf_info.c | 58 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index b005245..589bc1a 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -72,6 +72,7 @@ static uint16_t log_offset_len = UINT16_MAX;
 static uint16_t log_offset_text_len = UINT16_MAX;
 
 static uint64_t phys_offset = UINT64_MAX;
+static uint64_t page_offset = UINT64_MAX;
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define ELFDATANATIVE ELFDATA2LSB
@@ -115,7 +116,26 @@ static uint64_t vaddr_to_offset(uint64_t vaddr)
 			continue;
 		return (vaddr - phdr[i].p_vaddr) + phdr[i].p_offset;
 	}
-	fprintf(stderr, "No program header covering vaddr 0x%llxfound kexec bug?\n",
+
+	/* Direct map fallback */
+	if (page_offset != UINT64_MAX &&
+		phys_offset != UINT64_MAX &&
+		vaddr >= page_offset) {
+
+		uint64_t paddr = 0;
+
+		paddr = vaddr - (page_offset - phys_offset);
+
+		for (i = 0; i < ehdr.e_phnum; i++) {
+			if (phdr[i].p_paddr > paddr)
+				continue;
+			if ((phdr[i].p_paddr + phdr[i].p_memsz) <= paddr)
+				continue;
+			return phdr[i].p_offset + (paddr - phdr[i].p_paddr);
+		}
+	}
+
+	fprintf(stderr, "No program header covering vaddr 0x%llx found kexec bug?\n",
 		(unsigned long long)vaddr);
 	exit(30);
 }
@@ -309,6 +329,20 @@ int get_pt_load(int idx,
 	return 1;
 }
 
+static inline int parse_phys_offset(const char *str, char *pos)
+{
+	char *endp;
+
+	phys_offset = strtoul(pos + strlen(str), &endp, 10);
+	if (strlen(endp) != 0)
+		phys_offset = strtoul(pos + strlen(str), &endp, 16);
+	if ((phys_offset == LONG_MAX) || strlen(endp) != 0) {
+		fprintf(stderr, "Invalid data %s\n", pos);
+		return -1;
+	}
+	return 0;
+}
+
 #define NOT_FOUND_LONG_VALUE		(-1)
 
 void (*arch_scan_vmcoreinfo)(char *pos);
@@ -319,7 +353,7 @@ void scan_vmcoreinfo(char *start, size_t size)
 	char *pos, *eol;
 	char temp_buf[1024];
 	bool last_line = false;
-	char *str, *endp;
+	char *str;
 
 #define SYMBOL(sym) {					\
 	.str = "SYMBOL(" #sym  ")=",			\
@@ -543,17 +577,21 @@ void scan_vmcoreinfo(char *start, size_t size)
 		/* Check for PHYS_OFFSET number */
 		str = "NUMBER(PHYS_OFFSET)=";
 		if (memcmp(str, pos, strlen(str)) == 0) {
-			phys_offset = strtoul(pos + strlen(str), &endp,
-							10);
-			if (strlen(endp) != 0)
-				phys_offset = strtoul(pos + strlen(str), &endp, 16);
-			if ((phys_offset == LONG_MAX) || strlen(endp) != 0) {
-				fprintf(stderr, "Invalid data %s\n",
-					pos);
+			if (parse_phys_offset(str, pos) != 0)
 				break;
-			}
 		}
 
+		/* Check for PHYS_OFFSET number on some arch it called phys_ram_base*/
+		str = "NUMBER(phys_ram_base)=";
+		if (memcmp(str, pos, strlen(str)) == 0) {
+			if (parse_phys_offset(str, pos) != 0)
+				break;
+		}
+
+		str = "NUMBER(PAGE_OFFSET)=";
+		if (memcmp(str, pos, strlen(str)) == 0)
+			page_offset = strtoull(pos + strlen(str), NULL, 16);
+
 		if (arch_scan_vmcoreinfo != NULL)
 			(*arch_scan_vmcoreinfo)(pos);
 
-- 
2.43.0


