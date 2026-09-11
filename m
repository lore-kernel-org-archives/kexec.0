Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCF5C88E50
	for <kexec@archiver.kernel.org>; Fri, 11 Sep 2026 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j8iAGS+LrziyuSXfPFtCeSqyPsUTS5ysL/fyj1uAcHQ=; b=3Q+2nSUbtWicjMoD7UO9WDAuOe
	sdm6y5sjOn2BdtLrlGzE+mEjLs/JwfzA/wlnSEnhFd4Y6QYKIuIeMqTg13kD9Q4vKGv0tQ7gRtoaE
	PdRK1x0NRRVfFMi1r9vkIUtJAYIeuU7QtOgAb/z29EXmoOikJ0cOM8wROrqkvVrfqr7qt0/WFGb4B
	xX44cT0d0DLLKDrEWO/4mfn12jSoJFFaNVTzruEVEAd3HWeo8BpC6kbisC4ZDYZaFjZMcKJmNSmLx
	qaJ97hR8Af863oyr6/3dugxE/vcPc/PG8dkdtItYsj1rnB5fQhRlDQEz1Q711ByRTv99UlEUTfjC0
	GEOlY4Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x52Ao-0000000Gu5U-3kNZ;
	Fri, 11 Sep 2026 14:24:14 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x52Al-0000000Gu4z-01Np
	for kexec@lists.infradead.org;
	Fri, 11 Sep 2026 14:24:12 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-90cc107c451so5826836d6.0
        for <kexec@lists.infradead.org>; Fri, 11 Sep 2026 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789136649; x=1789741449; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j8iAGS+LrziyuSXfPFtCeSqyPsUTS5ysL/fyj1uAcHQ=;
        b=hrmA+rPMPHbJohMyDfELMrOHVoacp+2tcGhhJ5SRKeAVA1RxuMkMXTIEGfXqiDuaS1
         YNs7XjsSIeQGvAMGgje1jLJQi/mb3s1vFIlcqplYSu8lNPMb12L0kGesgPz1NQ+8AKpn
         X8QodiPAgF+wRAKlEPKSaZ+ouhNXP6msLcMJpkINECAGZ3JHenCsknmy5vpnQ+Xy1nyO
         BtU01WGKBoEkquG6qrAiZToeGyEwIsfWXiR995Bv4ImfcvuKgihJRuNxPmtNdQ70FGNs
         M0csbDU5RqVA+og2lyARJ8pesqsGPNHf5r5ftd6S+oymoXiAc5SAwHrVfjKjFwCeSA5m
         9EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789136649; x=1789741449;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=j8iAGS+LrziyuSXfPFtCeSqyPsUTS5ysL/fyj1uAcHQ=;
        b=Z1dOVQR3mKDanNJPYLXApVfEWmxxUxO7Bv6gPlX+SwkCMn2OMhqi5HXI59BgEtOD4F
         FwhKRLYrRUWs7vsYFlJYCuQ2KWHUAVMTJAwhExtHKdhYfuBh21dqJD2UOap9e/7svwoK
         5UocDmvpncJi/1B6tM0ApeRYgr2nwD6oSL3T5WoeYpIXWY2Zz9smZebMF1smVU/uAaWj
         34S9rsqDVpHkTVL3PYz2PzvHL2b/FsF6dgutg+/rZL9Taw/KRMkj+fKC03LX4kG14qvu
         rS6ZdiQ0KAxNuJkiQA/e2ktxHOuOYgCmKxg41kHAnlpaEO/ofTH8b5pbsM5v3/WhT/Mk
         JXVw==
X-Gm-Message-State: AFuF++n0q1/Lnxuedga+oK8cZzWdoR3GkCgIXdXb9WQxlbNt2KYJ4ZNt
	L4BoTl5nBfChNFRiOj7M2u8VtSdPW1XDEaI74cjRQWdqmkSC+QmoMJvD
X-Gm-Gg: AYBFou1mrYqSqxEWitIcbdWAPU87pRHSH4vTqH5HNVutxDLEqjGm5Ao+9dWmzLHdpEm
	jpKqsxNZQ5OGKtjvon8ZOi5sRKvedIUuHYo88d24mjFFojqKLoRqdWHdlErca0TjP+IUpYq07Jx
	Not9JQjNtLmZPBJAvZlSHkcyv9lQ/0lQh5yRq+kOeTgTQmGfBwElx4a5oqSf9o3qTj1GH1a254Y
	JevtmcNQ1YFRWsbqChVpo8v5zmdOqKmGVRT/vZynkyNlRtRLGXUdDEnBTFee+LKYNfYckpAEFRa
	fgF68RZAStzP9UZkpLSBbwYe8iV3p8buSKXdW+wit3brSDwAE+yaF7joOxgqDmsE7MgQPKj+oZs
	tSz3HNlMkd2h9ENMluJnbN6ZscxG1sHq9pvx3BrHSnTwnBLmbRL47tOR9WJCcx3ir/LwcsenzLe
	m2CksribxYgz5aGFUOlUUFLxVgwxnq8rGicWNIGw8Lqc3ekIdRidUR1UKgwOxqU4Mz8zgTgcrXj
	uL+7NpJBale7/3JGt+tS5SxqQ==
X-Received: by 2002:a05:622a:30c:b0:51b:cdc2:fb99 with SMTP id d75a77b69052e-530c852ef36mr68458841cf.24.1789136645044;
        Fri, 11 Sep 2026 07:24:05 -0700 (PDT)
Received: from [127.0.0.1] ([2600:4040:9121:7700:c0dd:db49:1679:88fa])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca30855csm21275951cf.1.2026.09.11.07.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:24:04 -0700 (PDT)
From: Serapheim Dimitropoulos <serapheimd@gmail.com>
Date: Fri, 11 Sep 2026 10:23:51 -0400
Subject: [PATCH kexec-tools] util_lib/elf_info: bound VMCOREINFO string
 comparisons
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-codex-vmcoreinfo-bounds-mailtest-v1-1-32c9fe102018@coreweave.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqDMBAAvyJ77kKSitZ+pXjQZG2XarZkUwmIf
 2/ocWCYOUApMSncmwMS7awssYK9NOBfU3wScqgMzrjODNail0AF981LIo6L4CzfGBS3iddMmrG
 KQ98507fXG9TMJ9HC5b94wJsKecwiq8J4nj8eB555fwAAAA==
X-Change-ID: 20260911-codex-vmcoreinfo-bounds-mailtest-026976207438
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@kernel.org>, Bhupesh Sharma <bhsharma@redhat.com>, 
 Pingfan Liu <piliu@redhat.com>, Philipp Rudo <prudo@redhat.com>, 
 Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789136644; l=10643;
 i=sdimitropoulos@coreweave.com; s=20260302; h=from:subject:message-id;
 bh=qHc04VzAGdVEQdYQL7LZkXqHXJep9QTRKcjzHWYLNAM=;
 b=zhXqLuap2XQmoBdjRMsDx/jhh5vWevN5i6me/cSHVPkEjWiqirUYISik7p7ul7EYursOOc9bi
 94qpyMRzKMaABFfMKOPmx9lYlg8to8naoH7PX6ZjsJCQHf+AvHci/tT
X-Developer-Key: i=sdimitropoulos@coreweave.com; a=ed25519;
 pk=Qysvg7jaTIU0posaYFtqa5SKJlFwqzil4X0U1p1zo/g=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_072411_087644_98416E09 
X-CRM114-Status: GOOD (  15.47  )
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

From: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>

scan_vmcoreinfo() terminates each VMCOREINFO line before matching
known field prefixes. Most fields nevertheless use memcmp() with the
full prefix length, so a short line near the end of the note can make
the comparison read beyond the allocated note buffer. AddressSanitizer
reports a 24-byte read immediately past the allocation in this case.

Use strncmp() for the terminated VMCOREINFO lines and in the arm64
VMCOREINFO hook. Check the ELF note name length before comparing it,
and ignore an empty VMCOREINFO descriptor.

Fixes: f4ce0706d957 ("util_lib: Add functionality to read elf notes")
Signed-off-by: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
---
AddressSanitizer found this while running vmcore-dmesg against a minimal
arm64 ELF core. A two-byte VMCOREINFO descriptor containing "X\n" makes
scan_vmcoreinfo() request a 24-byte comparison from the final four bytes
of the 28-byte PT_NOTE allocation. ASan reports the read at
scan_vmcoreinfo(), with the allocation originating in scan_notes().

Before this patch the reproducer aborts with:

  ERROR: AddressSanitizer: heap-buffer-overflow
  READ of size 24
  0 bytes after 28-byte region

After the patch, the reproducer completes without a sanitizer report.
Empty VMCOREINFO descriptors and undersized note names were also tested.
A valid synthetic legacy vmcore exits successfully and produces the
expected output byte-for-byte.

The patch was tested on arm64 Ubuntu 24.04 with AddressSanitizer and with
make distcheck.
---
 kexec/arch/arm64/kexec-arm64.c |  2 +-
 util_lib/elf_info.c            | 78 +++++++++++++++++++++++-------------------
 2 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 58256cf..d401550 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -976,7 +976,7 @@ static void arm64_scan_vmcoreinfo(char *pos)
 	const char *str;
 
 	str = "NUMBER(VA_BITS)=";
-	if (memcmp(str, pos, strlen(str)) == 0)
+	if (strncmp(str, pos, strlen(str)) == 0)
 		va_bits = strtoul(pos + strlen(str), NULL, 10);
 }
 
diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index d6e5ffc..cfbbea3 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -349,12 +349,16 @@ void (*arch_scan_vmcoreinfo)(char *pos);
 
 void scan_vmcoreinfo(char *start, size_t size)
 {
-	char *last = start + size - 1;
+	char *last;
 	char *pos, *eol;
 	char temp_buf[1024];
 	bool last_line = false;
 	char *str;
 
+	if (!size)
+		return;
+	last = start + size - 1;
+
 #define SYMBOL(sym) {					\
 	.str = "SYMBOL(" #sym  ")=",			\
 	.name = #sym,					\
@@ -426,170 +430,170 @@ void scan_vmcoreinfo(char *start, size_t size)
 		}
 
 		str = "SIZE(printk_ringbuffer)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			printk_ringbuffer_sz = strtoull(pos + strlen(str),
 							NULL, 10);
 
 		str = "SIZE(prb_desc)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_desc_sz = strtoull(pos + strlen(str), NULL, 10);
 
 		str = "SIZE(printk_info)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			printk_info_sz = strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(printk_ringbuffer.desc_ring)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			printk_ringbuffer_desc_ring_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(printk_ringbuffer.text_data_ring)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			printk_ringbuffer_text_data_ring_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(prb_desc_ring.count_bits)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_desc_ring_count_bits_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(prb_desc_ring.descs)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_desc_ring_descs_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(prb_desc_ring.infos)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_desc_ring_infos_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(prb_data_ring.size_bits)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_data_ring_size_bits_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(prb_data_ring.data)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_data_ring_data_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(prb_desc_ring.head_id)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_desc_ring_head_id_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(prb_desc_ring.tail_id)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_desc_ring_tail_id_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(atomic_long_t.counter)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			atomic_long_t_counter_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(prb_desc.state_var)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_desc_state_var_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(prb_desc.info)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_desc_info_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(prb_desc.text_blk_lpos)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_desc_text_blk_lpos_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(prb_data_blk_lpos.begin)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_data_blk_lpos_begin_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(prb_data_blk_lpos.next)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			prb_data_blk_lpos_next_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(printk_info.seq)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			printk_info_seq_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(printk_info.caller_id)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			printk_info_caller_id_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(printk_info.ts_nsec)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			printk_info_ts_nsec_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(printk_info.level)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			printk_info_level_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(printk_info.text_len)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			printk_info_text_len_offset =
 				strtoull(pos + strlen(str), NULL, 10);
 
 		/* Check for "SIZE(printk_log)" or older "SIZE(log)=" */
 		str = "SIZE(log)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			log_sz = strtoull(pos + strlen(str), NULL, 10);
 
 		str = "SIZE(printk_log)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			log_sz = strtoull(pos + strlen(str), NULL, 10);
 
 		/* Check for struct printk_log (or older log) field offsets */
 		str = "OFFSET(log.ts_nsec)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			log_offset_ts_nsec = strtoull(pos + strlen(str), NULL,
 							10);
 		str = "OFFSET(printk_log.ts_nsec)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			log_offset_ts_nsec = strtoull(pos + strlen(str), NULL,
 							10);
 
 		str = "OFFSET(log.len)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			log_offset_len = strtoul(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(printk_log.len)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			log_offset_len = strtoul(pos + strlen(str), NULL, 10);
 
 		str = "OFFSET(log.text_len)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			log_offset_text_len = strtoul(pos + strlen(str), NULL,
 							10);
 		str = "OFFSET(printk_log.text_len)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			log_offset_text_len = strtoul(pos + strlen(str), NULL,
 							10);
 
 		/* Check for PHYS_OFFSET number */
 		str = "NUMBER(PHYS_OFFSET)=";
-		if (memcmp(str, pos, strlen(str)) == 0) {
+		if (strncmp(str, pos, strlen(str)) == 0) {
 			if (parse_phys_offset(str, pos) != 0)
 				break;
 		}
 
 		/* Check for PHYS_OFFSET number on some arch it called phys_ram_base*/
 		str = "NUMBER(phys_ram_base)=";
-		if (memcmp(str, pos, strlen(str)) == 0) {
+		if (strncmp(str, pos, strlen(str)) == 0) {
 			if (parse_phys_offset(str, pos) != 0)
 				break;
 		}
 
 		str = "NUMBER(PAGE_OFFSET)=";
-		if (memcmp(str, pos, strlen(str)) == 0)
+		if (strncmp(str, pos, strlen(str)) == 0)
 			page_offset = strtoull(pos + strlen(str), NULL, 16);
 
 		if (arch_scan_vmcoreinfo != NULL)
@@ -644,7 +648,9 @@ static int scan_notes(int fd, loff_t start, loff_t lsize)
 		if (next > (last + 1))
 			break;
 
-		if ((memcmp(n_name, "VMCOREINFO", 11) != 0) || (n_type != 0))
+		if (n_namesz < sizeof("VMCOREINFO") ||
+		    memcmp(n_name, "VMCOREINFO", sizeof("VMCOREINFO")) != 0 ||
+		    n_type != 0)
 			continue;
 		scan_vmcoreinfo(n_desc, n_descsz);
 	}

---
base-commit: 43c5cba85ad23cc69c423527d9587c59b89fa437
change-id: 20260911-codex-vmcoreinfo-bounds-mailtest-026976207438

Best regards,
-- 
Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>


