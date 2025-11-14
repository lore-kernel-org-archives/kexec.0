Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3708BCE8D4E
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kKhHd1KgPWmocj3LIkR2PSOdJapJ90TJO0FtGZ1fNlc=; b=E5kgfE8/o90iz5WEj1VtXUfxwM
	x2HZLsIXqKjLN8ZXJ8rRIpfn2OmaJZNlX05KmfFbqK9n6FsYDnqcXLl5qlRei32HTpfIlxdcClg1b
	fQHeqKBpESyaZSJFiuZ+QanHlkRKOfVfk08sOcLZEZDoAIoaU2m4gw/RpnKbmGNm052WvONoqe50e
	RJKrOlP8xWopQIcZnZyS2jh02E5MQzMncvwJ0xc1yw6GPgBQ49XRKjZolMs6RK0WaPEKczHCT2KnT
	bqcuBzGRiXWa6yw8SE/Fo9GDP4ueF33bS6Q/MhHQnJCo9BQL0Vg8cRjSgYg0kdez9/x6PmcWfQ+0Q
	AVTelUZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7x-0000000Ccvg-1tZ7;
	Fri, 14 Nov 2025 15:54:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7u-0000000CcrC-3BLt
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 15:54:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=kKhHd1KgPWmocj3LIkR2PSOdJapJ90TJO0FtGZ1fNlc=; b=eHGAMJNF+Gq/GS1Fild2CQaj1M
	xbHo9pyDDVRdPLpW2sWQEFCbl5bdIiGZAnxQNFi9sHij5AIHKqoEWeiMFEhfF1lXMuVHor93eTuc6
	uWjJgH9YdYkgjOl7qyJ/HByg9uuzTIdBlZs+a6EXIUJu/VysisGWnBT6T2cQlU06KcNIq4PnfWtRS
	GVpH0G1yTliIjBEjudOth2UUuHJqfNOyd4ULfxSFVFJ60Th+aWTdADVICIfWMGOk+cG9UdrxydQRc
	Lt/yR6BnWVSJM/0/pe85sReINN+Sn2fHoJLKXShbL6sAJzUnVCeAhPPPgghDuOAy1hDtSwiwIlgnu
	artg2/uQ==;
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJvGD-00000002tDX-0mLg
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 14:58:51 +0000
Received: by mail-yx1-xb134.google.com with SMTP id 956f58d0204a3-63fca769163so2009574d50.2
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135654; x=1763740454; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKhHd1KgPWmocj3LIkR2PSOdJapJ90TJO0FtGZ1fNlc=;
        b=ND6k+zgWUh7Cziv64CD2aCICJs03jhMg5BXTBvLB/g5NJrU9MlauEg4ppAvMaej0d3
         if48qDXUorcxgfF+vHVPZKmWgzfvEpUB9E4Ahwfv/XSjqLPwvejs+yTPKxBaBMEDcu08
         kDBkodzuABjii88oo6zqJfYbtxufs3ja45ZyeAYDr455SdMtVdcQg1R5QcKGUPcNhQZY
         jw/Gem/4PO7ENCTXXWSMaVpmV9M9BuwfvLfcIzgfB33cnPdkoxrTSx47YhlvpZC7vCkM
         g8xDs9wK2E+SbJdAgCqjogdlqciEd+KhqjqQHDZ6QMTOTeySIPercsij7bxOpLlRMgKT
         UV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135654; x=1763740454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kKhHd1KgPWmocj3LIkR2PSOdJapJ90TJO0FtGZ1fNlc=;
        b=DmNfBFFhz/dz6Z0fIofOTYZLzP5yiJ3dCCT5XzisonYsuPBRXd/srC85+Ypk6v8cYU
         KDsa5IFOCIRcD42AJL+RC/jBoqWx8a4iMVybdR/d3N4c25MI/OE17xJceq7fGlbtLicK
         2O806Hp5f7bib8mc+qRPTuzFdkqLj2j4MerPF44yoDTbP/Y5+Ax51Y6RGGUEK1Wz9oTl
         HXIUdrQTXB7a5AwKaSpgcvsd5uGk81JvBAXeS0OKMOI/c05MYtBmwwpVhztUGnwFb2PJ
         zfTgcY0bDvlzxLctT5nKb0ftg+qUKQf8JmH5ELuYqKVjblL0QuIaujefd9Ut9rJLwADH
         vsOw==
X-Forwarded-Encrypted: i=1; AJvYcCWwX+BYjBqlhKHg5pCoVlf1xiEWclcU+Fu9oZIUP6zj0tOTIogLdnIjXuIDFE16Tz80knBEkg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxsbzdtn/GXHbVnGGITssvxeo573q15mtQvGM2H3B5AAuKxqD7D
	uSRK9yHKhC48hMC7FWgTxknqLrvnxt/l3LRE43N0L1u/LjCM1klJL4dqD90vTC8DhTA=
X-Gm-Gg: ASbGncskZ7HPDS6tVt/rF5IlpyPPdF1DdNXcA+OzBWIyxYKp+uHxdJx3Bhlrt0hTKuv
	oeIXeuLI9rPGKQbq0Lzeh+O96S36NO6xATPe+yC16XiK5X81ZNyY282vPcOvSaU6qQ/ycKJ4EwX
	+5SrD5ag/YZC532JSloNayRkLJrRn/QJTfxgQGqPmOzNShdh17uPTUyZBHFDPQCkiznAcS9TuM6
	VkyuY4cQyM1PgbDjb4p0DgP/zJAykqVR9nb7gw75n/6111sscKxcIquLqezV57SlQU9q0hMCL39
	6/Cq9k6gyKBvqcr9CMyWoy+zPcaD6LTiiTMe6F/o2rbmNxn4MAnDwcU3zcfeZBJiL5jugvyIj/u
	U9QAdIounGhHM7nPX16F119Q8V321miblOKL77xhQrFOm4b5XzbOXy2SVSCLVcZDXJfY1jqROsO
	ghY66xI7ZrKbadZhdDp3R2srzn1xgIcHylEjaOO6MYCUR8VKkGdxQDQTrhtdbz2IKTg75g
X-Google-Smtp-Source: AGHT+IGiDMpoF1/OziCNFf3dCo0jW3YOO3Yc+5BO/O7YGqjVq/L6uWOIGV+2HHGmACM7asKY55998g==
X-Received: by 2002:a05:690e:1508:b0:636:d4ab:a507 with SMTP id 956f58d0204a3-641e74d6eaemr2931309d50.16.1763135654039;
        Fri, 14 Nov 2025 07:54:14 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:13 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v1 11/13] kho: Allow memory preservation state updates after finalization
Date: Fri, 14 Nov 2025 10:53:56 -0500
Message-ID: <20251114155358.2884014-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_145849_530667_3AB74B24 
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently, kho_preserve_* and kho_unpreserve_* return -EBUSY if
KHO is finalized. This enforces a rigid "freeze" on the KHO memory
state.

With the introduction of re-entrant finalization, this restriction is
no longer necessary. Users should be allowed to modify the preservation
set (e.g., adding new pages or freeing old ones) even after an initial
finalization.

The intended workflow for updates is now:
1. Modify state (preserve/unpreserve).
2. Call kho_finalize() again to refresh the serialized metadata.

Remove the kho_out.finalized checks to enable this dynamic behavior.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 27ef20565a5f..87e9b488237d 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -183,10 +183,6 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 	const unsigned long pfn_high = pfn >> order;
 
 	might_sleep();
-
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	physxa = xa_load(&track->orders, order);
 	if (!physxa) {
 		int err;
@@ -815,9 +811,6 @@ int kho_unpreserve_folio(struct folio *folio)
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	__kho_unpreserve_order(track, pfn, order);
 	return 0;
 }
@@ -885,9 +878,6 @@ int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
 	const unsigned long start_pfn = page_to_pfn(page);
 	const unsigned long end_pfn = start_pfn + nr_pages;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	__kho_unpreserve(track, start_pfn, end_pfn);
 
 	return 0;
@@ -1066,9 +1056,6 @@ EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
  */
 int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
 {
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	kho_vmalloc_free_chunks(preservation);
 
 	return 0;
-- 
2.52.0.rc1.455.g30608eb744-goog


