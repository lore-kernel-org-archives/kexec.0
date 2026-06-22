Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BC6CDB466
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 20:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2LY8iIOtp1iex30O14X1KTJC4C5dwKEIOtAfF1GxHsQ=; b=agxCqTc4HWlAcVVVG2El2f2FNm
	sIcyBE7AujYzTlQPOSuN7DUEjKdE78ZErqB4x/5bPYJYUWpxbRjxemqzXZwRcPJ5Q1dvTNi0I118z
	ofUzRuLnAXxlK4liOJEt3C7u3naVonGgXNH6b7L6K1S0DPe0gPnLcym2jYI7XwaMNBbs0mYI3O9v1
	yKKxeFYR6777rNSZi48q6HQnNNH5YFrlxQiqyEOrAP+wDJw2VSUOv/NYRFKwV0vIR22O8P+b6C+j+
	P4EWeApYuR7tOlxpnj97B/rNz8VcKNcXFUGRmMw62V57SPpCDV6NHyB+vmcKXntRJNJGwL3tfJAXN
	3/JF89ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgc-00000005Nh8-3KVs;
	Mon, 22 Jun 2026 20:56:06 +0000
Received: from esa1.hc555-34.eu.iphmx.com ([23.90.104.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgY-00000005Nfi-1xvU
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 20:56:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782161762; x=1813697762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Ja7GJOVlywT7UlcUGTbWbOL0u6bqC/G3fK6/yn+lmk=;
  b=I+8WxG++1RVK1SP0+amdliV7BxboOlicycZTwsONgfQfG7b/EXVIMh5H
   CPutqnIwV80zyZ5VMYws35LHKz1EE19y9/ctoyBuJ3ZAwnLZxmOS/6Utd
   b1kdHCeAalPlBk6j+sOfReomSe8upybTOimDzqg/s23oGZxoGYaGLhD0X
   niGp+hlwsxeLXMfpTYViflab1Cn0t+1yOtJNwo0YtgpsKx9wDGl1vmTrd
   btXcIVLUUhnABa6GMyskRd554M8xgsyj7S4SQnohzHPTf/0z4mQ2TjkNX
   NTxXDrcbTihcd51xHZRLAlW+09AEYJllfTOla5+S969nCm4xOadIHQ0RS
   A==;
X-CSE-ConnectionGUID: 25uvBqGFQ8maQWbClrd9hw==
X-CSE-MsgGUID: i8QIoOMtS2yQN5cSt4UL6Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:55:59 +0300
X-CSE-ConnectionGUID: OBC24lz9RAmDbrCcUKiHhw==
X-CSE-MsgGUID: eG2MCSrBSRuaxPtl/NDNQA==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 23 Jun 2026 00:01:06 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Mon, 22 Jun 2026 23:55:58 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 01/10] util_lib: add paddr_to_offset function and expose raw vmcoreinfo data
Date: Mon, 22 Jun 2026 23:54:39 +0300
Message-ID: <20260622205550.1087163-2-pnina.feder@mobileye.com>
In-Reply-To: <20260622205550.1087163-1-pnina.feder@mobileye.com>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_135602_798606_FD5A71F2 
X-CRM114-Status: GOOD (  17.96  )
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

Add paddr_to_offset() to translate physical addresses to file offsets,
complementing the existing vaddr_to_offset() for virtual addresses.

Store raw vmcoreinfo note data when parsing ELF notes and provide
elf_get_raw_vmcoreinfo() accessor to retrieve it. This allows callers
to access the unparsed vmcoreinfo content for external processing.
and fix compilation warnings.

Change-Id: Icc75c22d6b2d95b6c951ccf647819d7e9cc4e7de
Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 util_lib/elf_info.c         | 53 ++++++++++++++++++++++++++++++++-----
 util_lib/include/elf_info.h | 11 ++++----
 2 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 589bc1ad..fd7d1d5b 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -16,7 +16,8 @@
  */
 
 #include <inttypes.h>
-#include <elf_info.h>
+
+#include "elf_info.h"
 
 /* The 32bit and 64bit note headers make it clear we don't care */
 typedef Elf32_Nhdr Elf_Nhdr;
@@ -27,6 +28,9 @@ static Elf64_Phdr *phdr;
 static int num_pt_loads;
 
 static char osrelease[4096];
+/* Raw vmcoreinfo storage */
+static char *raw_vmcoreinfo = NULL;
+static size_t raw_vmcoreinfo_len = 0;
 
 /* VMCOREINFO symbols for lockless printk ringbuffer */
 static loff_t prb_vaddr;
@@ -140,6 +144,21 @@ static uint64_t vaddr_to_offset(uint64_t vaddr)
 	exit(30);
 }
 
+uint64_t paddr_to_offset(uint64_t paddr){
+	ssize_t i;
+
+	for (i = 0; i < ehdr.e_phnum; i++) {
+		if (phdr[i].p_paddr > paddr)
+			continue;
+		if ((phdr[i].p_paddr + phdr[i].p_memsz) <= paddr)
+			continue;
+		return phdr[i].p_offset + (paddr - phdr[i].p_paddr);
+	}
+	fprintf(stderr, "No program header covering paddr 0x%llx found kexec bug?\n",
+		(unsigned long long)paddr);
+	return (uint64_t)-1;
+}
+
 static unsigned machine_pointer_bits(void)
 {
 	uint8_t bits = 0;
@@ -646,6 +665,16 @@ static int scan_notes(int fd, loff_t start, loff_t lsize)
 
 		if ((memcmp(n_name, "VMCOREINFO", 11) != 0) || (n_type != 0))
 			continue;
+
+		/* Save raw vmcoreinfo for later use */
+		if (raw_vmcoreinfo)
+			free(raw_vmcoreinfo);
+		raw_vmcoreinfo = malloc(n_descsz);
+		if (raw_vmcoreinfo) {
+			memcpy(raw_vmcoreinfo, n_desc, n_descsz);
+			raw_vmcoreinfo_len = n_descsz;
+		}
+
 		scan_vmcoreinfo(n_desc, n_descsz);
 	}
 
@@ -776,7 +805,7 @@ static void dump_dmesg_legacy(int fd, void (*handler)(char*, unsigned int))
 	 * To collect full dmesg including the part before `dmesg -c` is useful
 	 * for later debugging. Use same logic as what crash utility is using.
 	 */
-	logged_chars = log_end < log_buf_len ? log_end : log_buf_len;
+	logged_chars = log_end < (unsigned int)log_buf_len ? log_end : (unsigned int)log_buf_len;
 
 	if (handler)
 		handler(buf + (log_buf_len - logged_chars), logged_chars);
@@ -873,7 +902,7 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 		uint16_t loglen;
 
 		ret = pread(fd, buf, log_sz, log_buf_offset + current_idx);
-		if (ret != log_sz) {
+		if (ret != (ssize_t)log_sz) {
 			fprintf(stderr, "Failed to read log of size %" PRId64 " bytes:"
 				" %s\n", log_sz, strerror(errno));
 			exit(65);
@@ -1165,7 +1194,7 @@ static void dump_dmesg_lockless(int fd, void (*handler)(char*, unsigned int))
 		exit(64);
 	}
 	ret = pread(fd, m.prb, printk_ringbuffer_sz, vaddr_to_offset(kaddr));
-	if (ret != printk_ringbuffer_sz) {
+	if (ret != (ssize_t)printk_ringbuffer_sz) {
 		fprintf(stderr, "Failed to read prb of size %zu bytes: %s\n",
 			printk_ringbuffer_sz, strerror(errno));
 		exit(65);
@@ -1184,7 +1213,7 @@ static void dump_dmesg_lockless(int fd, void (*handler)(char*, unsigned int))
 	}
 	ret = pread(fd, m.descs, prb_desc_sz * m.desc_ring_count,
 		    vaddr_to_offset(kaddr));
-	if (ret != prb_desc_sz * m.desc_ring_count) {
+	if (ret != (ssize_t)(prb_desc_sz * m.desc_ring_count)) {
 		fprintf(stderr,
 			"Failed to read descs of size %lu bytes: %s\n",
 			prb_desc_sz * m.desc_ring_count, strerror(errno));
@@ -1201,7 +1230,7 @@ static void dump_dmesg_lockless(int fd, void (*handler)(char*, unsigned int))
 	}
 	ret = pread(fd, m.infos, printk_info_sz * m.desc_ring_count,
 		    vaddr_to_offset(kaddr));
-	if (ret != printk_info_sz * m.desc_ring_count) {
+	if (ret != (ssize_t)(printk_info_sz * m.desc_ring_count)) {
 		fprintf(stderr,
 			"Failed to read infos of size %lu bytes: %s\n",
 			printk_info_sz * m.desc_ring_count, strerror(errno));
@@ -1222,7 +1251,7 @@ static void dump_dmesg_lockless(int fd, void (*handler)(char*, unsigned int))
 	}
 	ret = pread(fd, m.text_data, m.text_data_ring_size,
 		    vaddr_to_offset(kaddr));
-	if (ret != m.text_data_ring_size) {
+	if (ret != (ssize_t)(m.text_data_ring_size)) {
 		fprintf(stderr,
 			"Failed to read text_data of size %lu bytes: %s\n",
 			m.text_data_ring_size, strerror(errno));
@@ -1321,3 +1350,13 @@ int read_phys_offset_elf_kcore(int fd, long *phys_off)
 
 	return 2;
 }
+
+int elf_get_raw_vmcoreinfo(const char **data, size_t *size)
+{
+	if (!raw_vmcoreinfo || raw_vmcoreinfo_len == 0)
+		return -1;
+
+	*data = raw_vmcoreinfo;
+	*size = raw_vmcoreinfo_len;
+	return 0;
+}
diff --git a/util_lib/include/elf_info.h b/util_lib/include/elf_info.h
index fdf4c3d0..c2873365 100644
--- a/util_lib/include/elf_info.h
+++ b/util_lib/include/elf_info.h
@@ -24,13 +24,14 @@
 #include <ctype.h>
 
 int get_pt_load(int idx,
-	unsigned long long *phys_start,
-	unsigned long long *phys_end,
-	unsigned long long *virt_start,
-	unsigned long long *virt_end);
+		unsigned long long *phys_start,
+		unsigned long long *phys_end,
+		unsigned long long *virt_start,
+		unsigned long long *virt_end);
 int read_phys_offset_elf_kcore(int fd, long *phys_off);
 int read_elf(int fd);
 void dump_dmesg(int fd, void (*handler)(char*, unsigned int));
 extern void (*arch_scan_vmcoreinfo)(char *pos);
-
+uint64_t paddr_to_offset(uint64_t paddr);
+int elf_get_raw_vmcoreinfo(const char **data, size_t *size);
 #endif /* ELF_INFO_H */
-- 
2.43.0


