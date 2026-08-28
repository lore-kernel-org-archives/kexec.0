Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C39AC61DCB
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S2kBN1emgsyv6c1CXhhOYzrKk+x9zAWtQ0EZ9tbmR0A=; b=gC4RgQRc2GBrDHBjbNFwhMSWb8
	Ru1sPwZP3ElUOCMITLdFXEx+dIXZGurPo50yrnl2GS6iO16WbwF+lQkksP4BtAxK0yiVELMd1TQ//
	OFlCavwbxMaGGfv3ATUT1rly3VfDt39A6mxnDnco3DWsWc2ERQ1DjIWA9m2lzc/Sa7LqcCieOcZJG
	89eTJ1jDLFskPX4Oab+kOvyGe11JUImFkBftA2GvMt6Q+uq8V7KhVUlizFBL9sBHE0Pzgotms4BBz
	1hFx8pQqv9C/4uDU/DY00saMf4TpbAFNYvE6CKAh93pDBy0tafmsJeBhVtjuXJZsUpdLiS/rv4jvD
	UQSmiR+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzyQ6-000000065Si-3PRh;
	Fri, 28 Aug 2026 15:23:06 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzyQ1-000000065SG-18YI
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 15:23:02 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-482c58a8683so896826f8f.0
        for <kexec@lists.infradead.org>; Fri, 28 Aug 2026 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787930579; x=1788535379; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S2kBN1emgsyv6c1CXhhOYzrKk+x9zAWtQ0EZ9tbmR0A=;
        b=hsDfrb9g0x9NOOBfQSRIAN/zGNr+NchgxsxtTJRT/FI0ongXNvLmJpbdsS0uy285mr
         vSOE6X4WIYkfRGzVH/WMFY61GGIk9UVyvSSxIjkBHCgitoueXkVOzOXkBdBmSypZ30V/
         /KA1qk+a/mk/jb7bMkBJNM0uyCMhPXJQsevMM4VbaGjuZJNWAm3m51A1wCO47zYxJvKt
         fPXhB/qEtYWlcSixEuavZKUpw6MIIeouKPhGBV3sXl/kTOHoCsBvnTMBbhYuVPjAy3T/
         GlX6jy7CevCYam7R7vW4hWQHConhOitBtYjGD8gouzMcW3nteKaOZFJ5W/zb2pH1cDBV
         uC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787930579; x=1788535379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2kBN1emgsyv6c1CXhhOYzrKk+x9zAWtQ0EZ9tbmR0A=;
        b=P70Bxo/sXIER4tK38fRozDhex0Wkx2CfFv2oH5dwSmT6Fi0R+kpyzKHq4O62e5HlNe
         zponv6i2VXH5N6vPGJBZdakVzHBdOQpVXnAjqKck3Wb2djQiWb+PunatblZroN+PcBxK
         AVUEWcCocGLF4efwi3oF6mruJgOe4y5zWNEjgl6xI4klchqbw9wpxs/EgpqD9b/1kCRa
         UzGwVfcDagQ0zPNjUCA+s9Yb7X/VsG5KdSpuWq7unjF3LzG8JM84UiMosDvcS13iognO
         gJtsELRdtVq/nnp1uv/K4M0Q61T9JeF6d19+KT62jZsGkK/7mAtvkmrA2Nzev/6d92Vm
         BImw==
X-Gm-Message-State: AFuF++nMbiiw9sKvgm84JRJqFivjCkPnMc9t4JpfS5YiwHB8p+QMP5jO
	WkEYe20Tj0jYI4yNzFNkr32WXzllgLPgq5PRi1uGst1jRCCF8u6ad+EcfyLE6Wg+PNk=
X-Gm-Gg: AR+sD11jgTwFOzzGES1H6loK3SnxRNzElH5PYsnGlc4LP2jc7o85rlMFuDtUJ+XPb9f
	1pG8EM8JnUzA8lwcR+f5PmVsbo9cz92hOjHT8pRDUcTKdYVuPGHs1cq8V7hp61RvDnCBeQ9vS8t
	HVtCpSCCdQBAD1+i37uv39yU6gcmVVRow/I+MrXZfYk+yaHXOmxkShsoj7QLzScIoIM0mgUzgSz
	fdMXoTpoq3syFFJZrUSGZ4qMF0JsTdoB+pJReI8vpNEyzgzXXMPKfd8TrUyQAdsqOpluaHQdsuU
	wmyKjZQHcsofhFgk43KnUYbyzRZUJwczzsVuMZJwpIVNynhsHVGOh+MJLkwp6DpvEA7yq/GmH4q
	o4WATVu+K4o5e0IwEFXlE8s48t/nNmqe8H57pwlQXGMHlV1Oq4MBI8I1Eyop8UtumwNUdl85IbX
	xEPJt90zrR8ENTnvG4Mz8LSAC2IDl9O+s6+Jjh5d4GcoaxGU6S32812JVm+qZ09aV9OkIcQoF+D
	qbFoX5ELzPyvX5Moa4fnk6HFX9KgMKm7RHJ0Oo=
X-Received: by 2002:a05:6000:2003:b0:482:eabd:642c with SMTP id ffacd0b85a97d-482f797606bmr10365669f8f.1.1787930579286;
        Fri, 28 Aug 2026 08:22:59 -0700 (PDT)
Received: from b315lp23.lnxne.boe ([129.41.47.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbab3f16sm4566401f8f.1.2026.08.28.08.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:22:58 -0700 (PDT)
From: Joseph Cathcart <cathcartj08@gmail.com>
To: kexec@lists.infradead.org,
	linux-s390@vger.kernel.org
Cc: eoin.mcnamara@ibm.com,
	iii@de.ibm.com,
	Joseph Cathcart <cathcartj08@gmail.com>
Subject: [PATCH v1] kexec-tools/s390: Improve initrd memory reservation
Date: Fri, 28 Aug 2026 17:22:56 +0200
Message-ID: <20260828152256.6892-1-cathcartj08@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_082301_335808_D205FAF9 
X-CRM114-Status: GOOD (  14.67  )
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

Improve memory reservation for initrd. Remove unnecessary initrd
range from memory_ranges[]. Initrd currently falls between
"System RAM" ranges, and is therefore already reserved.

Refactor so that arch_reuse_initrd() is responsible for populating
retained_initrd_base and retained_initrd_size, rather than
get_memory_ranges_s390().

Add die() case for when user uses --reuseinitrd while booting a
crash kernel.

Signed-off-by: Joseph Cathcart <cathcartj08@gmail.com>
---
 kexec/arch/s390/kexec-image.c |  8 ++++++--
 kexec/arch/s390/kexec-s390.c  | 19 ++++++++++---------
 kexec/arch/s390/kexec-s390.h  |  2 +-
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index 1a59a32..a9e5442 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -79,7 +79,8 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
 	}
 
 	if (reuse_initrd)
-		die("--reuseinitrd not supported with --kexec-file-syscall. Please use --kexec-syscall\n");
+		die("--reuseinitrd not supported with --kexec-file-syscall. "
+			"Please use --kexec-syscall\n");
 
 	if (ramdisk) {
 		info->initrd_fd = open(ramdisk, O_RDONLY);
@@ -143,6 +144,9 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 	if (ramdisk && reuse_initrd)
 		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
 
+	if (reuse_initrd && (info->kexec_flags & KEXEC_ON_CRASH))
+		die("Can't specify --reuseinitrd while booting a crash kernel\n");
+
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		if (parse_iomem_single("Crash kernel\n", &crash_base,
 				       &crash_end))
@@ -173,7 +177,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 				  ramdisk_origin, ramdisk_len);
 	} else if (reuse_initrd) {
 		ramdisk_origin = retained_initrd_base;
-		ramdisk_len = retained_initrd_size;
+		ramdisk_len = (off_t)retained_initrd_size;
 	}
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		if (load_crashdump_segments(info, crash_base, crash_end))
diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
index 4e77fc4..fd0d87e 100644
--- a/kexec/arch/s390/kexec-s390.c
+++ b/kexec/arch/s390/kexec-s390.c
@@ -26,10 +26,17 @@
 
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 unsigned long long retained_initrd_base, retained_initrd_size;
-unsigned int reuse_initrd = 0;
+unsigned char reuse_initrd;
 
 void arch_reuse_initrd(void)
 {
+	uint64_t start, end;
+
+	if (parse_iomem_single("initrd\n", &start, &end))
+		die("Couldn't find initrd entry in /proc/iomem\n");
+
+	retained_initrd_base = (unsigned long long)start;
+	retained_initrd_size = (unsigned long long)end - retained_initrd_base + 1;
 	reuse_initrd = 1;
 }
 
@@ -158,7 +165,6 @@ int get_memory_ranges_s390(struct memory_range memory_range[], int *ranges,
 {
 	char crash_kernel[] = "Crash kernel\n";
 	char sys_ram[] = "System RAM\n";
-	char kernel_initrd[] = "initrd\n";
 	const char *iomem = proc_iomem();
 	FILE *fp;
 	char line[80];
@@ -182,16 +188,11 @@ int get_memory_ranges_s390(struct memory_range memory_range[], int *ranges,
 		sscanf(line,"%llx-%llx : %n", &start, &end, &cons);
 		str = line+cons;
 		if ((memcmp(str, sys_ram, strlen(sys_ram)) == 0) ||
-			((memcmp(str, kernel_initrd, strlen(kernel_initrd)) == 0) && reuse_initrd) ||
-			((memcmp(str, crash_kernel, strlen(crash_kernel)) == 0) && with_crashk)) {
+		    ((memcmp(str, crash_kernel, strlen(crash_kernel)) == 0) &&
+		     with_crashk)) {
 			memory_range[current_range].start = start;
 			memory_range[current_range].end = end;
 			memory_range[current_range].type = RANGE_RAM;
-			if (memcmp(str, kernel_initrd, strlen(kernel_initrd)) == 0) {
-				retained_initrd_base = start;
-				retained_initrd_size = end - start + 1;
-			}
-
 			current_range++;
 		}
 		else {
diff --git a/kexec/arch/s390/kexec-s390.h b/kexec/arch/s390/kexec-s390.h
index a990739..7e85976 100644
--- a/kexec/arch/s390/kexec-s390.h
+++ b/kexec/arch/s390/kexec-s390.h
@@ -35,6 +35,6 @@ extern int get_memory_ranges_s390(struct memory_range range[], int *ranges,
 				  int with_crashk);
 extern int command_line_add(struct kexec_info *info, const char *str);
 extern unsigned long long retained_initrd_base, retained_initrd_size;
-extern unsigned int reuse_initrd;
+extern unsigned char reuse_initrd;
 
 #endif /* KEXEC_S390_H */
-- 
2.55.0

base commit: 43c5cba85ad23cc69c423527d9587c59b89fa437

