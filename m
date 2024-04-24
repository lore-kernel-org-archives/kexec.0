Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FFDC4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 12:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=95er4q00aWZskNljCygcXE6Gvpq2v21pghI8hAz5PUo=; b=OF7pLsIxqPLJxF
	iUljjuAhH8bJyOftaM6IA6ugqKHSSzw4lzxzEsv9LPM9OZclV3of7qIl83rsvUsitL9ve6IQ+9CKw
	L6J7GJjqaL6aGI0/sUZLITtZvRL05aKEdImq6HFtlVWHx61gAFG5Nox7fyixNQu6MWasyNQYlI9K/
	OfZq69Z+xzFJ3/tGn0aUuMPs3GtKnbqJCwS70I/Kmhm15uDMG4R/OKsArOhAlQSLapnW2yzwh2mg+
	BwAIzM2q0XY50pGTluwG64XQ0CTvCsBeQ1qHxB4TmiMNRFGismg8PvvaYi1kqtelevWeX/BEORJW8
	80dFPbqDGHnI8qHObYxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzbZK-000000041o4-3KS5;
	Wed, 24 Apr 2024 12:17:46 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzbZF-000000041lM-17nG
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 12:17:45 +0000
From: Alexander Kanavin <alex@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713961057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0IvN+ZYtoPyOh6ED1gkdfQBK6G2ALUmJP1GrfA3P4B8=;
	b=nDC0Si/dwM9W0+VoLxZPYMtFIO1WE91+VLlSyKJqrh9VeCg02KSZjhPayUSYfJ7DnVNaxO
	taLu3I1Lsukk44ojsjeX8rnR0ChuOkgEj2SkSNBi2X+D3abug4nKHtwExV/yKSSnjbHa4L
	YjVEx51XTkdSl7grVWyaVwGvu5cJVw0zhOV0wLqsubgKhOhynbIL4A56y+uZ9C1r1KAr24
	CJcuwykVNfzpFsv5a7fC2SM0bT8ed3fozJD6GLdYmzjK/XCFkJpZxPldM56HTATXXIoJaa
	dSJnLVtSe/CAd/o5E4xvepfR81LoRPgINSsmTTOdDDo45OtfB5oz4XbFRsd3zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713961057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0IvN+ZYtoPyOh6ED1gkdfQBK6G2ALUmJP1GrfA3P4B8=;
	b=+IKM1hYtjcvHrYcQGAhEhv+tz4/J2EqhSZrHDjOfdz8NeuElzYvP5JDY3qoBQyYOWR0LW9
	l+zwu+75txNenYBw==
To: horms@kernel.org,
	kexec@lists.infradead.org
Cc: Haiqing Bai <Haiqing.Bai@windriver.com>,
	fredrik.markstrom@gmail.com,
	Alexander Kanavin <alex@linutronix.de>
Subject: [kexec-tools][PATCH] ARM: Fix add_buffer_phys_virt() align issue
Date: Wed, 24 Apr 2024 14:17:27 +0200
Message-Id: <20240424121727.979683-1-alex@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_051741_473989_3025439C 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message.
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

From: Haiqing Bai <Haiqing.Bai@windriver.com>

When "CONFIG_ARM_LPAE" is enabled,3 level page table
is used by MMU, the "SECTION_SIZE" is defined with
(1 << 21), but 'add_buffer_phys_virt()' hardcode this
to (1 << 20).

Suggested-By: fredrik.markstrom@gmail.com
Signed-off-by: Haiqing Bai <Haiqing.Bai@windriver.com>
Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 kexec/arch/arm/crashdump-arm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 1ec1826..cc20f63 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -242,6 +242,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 	void *buf;
 	int err;
 	int last_ranges;
+	unsigned short align_bit_shift = 20;
 
 	/*
 	 * First fetch all the memory (RAM) ranges that we are going to pass to
@@ -283,6 +284,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 
 		/* for support LPAE enabled kernel*/
 		elf_info.class = ELFCLASS64;
+		align_bit_shift = 21;
 
 		err = crash_create_elf64_headers(info, &elf_info,
 					 usablemem_rgns.ranges,
@@ -304,8 +306,9 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 	 * 1MB) so that available memory passed in kernel command line will be
 	 * aligned to 1MB. This is because kernel create_mapping() wants memory
 	 * regions to be aligned to SECTION_SIZE.
+	 * The SECTION_SIZE of LPAE kernel is '1UL << 21' defined in pgtable-3level.h
 	 */
-	elfcorehdr = add_buffer_phys_virt(info, buf, bufsz, bufsz, 1 << 20,
+	elfcorehdr = add_buffer_phys_virt(info, buf, bufsz, bufsz, 1 << align_bit_shift,
 					  crash_kernel_mem.start,
 					  crash_kernel_mem.end, -1, 0);
 
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
