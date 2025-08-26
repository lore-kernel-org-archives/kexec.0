Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A22CA0EFA
	for <kexec@archiver.kernel.org>; Tue, 26 Aug 2025 12:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fnZPQ9i52dF3KFBSw6s2UAOkbaudTyEedBQwR5Zwpl8=; b=AMFxt1Bj/v0mRVcK0fWpoiGBMS
	qhIbrVZxzqYHa3zh4ae5nEtiql9E4BqBVNTrQogJCxLqAWOjgwJ10n3siEos0pFw0AInGrCn0D4ic
	BgTY18viJ5zmdC/YAAWZ6IsrAo7dhU23uRLw8q4uL8omtxRoXUyNAkdk8NsMm4zKO6RCXpmkA4Bh0
	8G9O931HVbJ8Vn8E99GyNKhhCLPYoqGaZpY9NxFHnG5sV+KmKM3cBWyafEE/qiCQgv9Vh6JIfT6ou
	MKkR02MoosPsVRZx76s//Hgc8GA4DdVlvjpd7SMkLL8YFueFpF3ffZ6mk2+rUZxRo4j3KYxeSEHQ8
	IPBVde+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqsZT-0000000BujP-28Ko;
	Tue, 26 Aug 2025 12:14:39 +0000
Received: from mail-ej1-f45.google.com ([209.85.218.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqsUC-0000000BtvF-23MB;
	Tue, 26 Aug 2025 12:09:13 +0000
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ace3baso993491866b.3;
        Tue, 26 Aug 2025 05:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210151; x=1756814951;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnZPQ9i52dF3KFBSw6s2UAOkbaudTyEedBQwR5Zwpl8=;
        b=NDziAA4ATMpit32xe/J4czQIUxa/46UTrI6q7gsXIJ3y8LyuWSeQa55o2gQvVaws6u
         zRET9xY55QEhnsVftCm1dU+w9fffOHQcpC6DCmPLEzv3t9SgxLtYoq4Ll33CufK5u1/3
         bsz8/DjxdwD+nJimoRL4XrhIX2QGnCX96k6DatDeJuC5Yr2iGuOyITy7eg3pvdYVtXd+
         pDNhxvnIbry6hJccuooaryB9EHImjh3psaKgpGP9LNvinATJTuRO4FLFkqrvXbWaEgYv
         UXh/hHdrJbZ5EQrFwMuQm/d3CJCnCIZHglIT2E/IwnXT5sHCoH0XSeQ8B5x3Ukegj9qQ
         GflA==
X-Forwarded-Encrypted: i=1; AJvYcCVX4D7P4+Llwi9Jl0u24o+saSrxGGfPEPVyBsnC9SKGR7fUA+KRN/Zpny3IDpmN0DiLCyaGEg==@lists.infradead.org
X-Gm-Message-State: AOJu0YznY+aMsB/fjCZ0OdbTN8hGFUAOFHTB9e1GQUT9n72wUrNKCusH
	XE3Q96aILa5T6fyxIgiXSnReSGvh/YR7wzQChZK8eUFlJhSjYBKCA34h
X-Gm-Gg: ASbGncuQr8jlLzaQzTaFY9RQM1GXEsDqeNiJjSy6YuROk6bGjlksNkX8HG1EJWwV+PM
	cpQZ0XnDK6SIBfzbma22cAscN8EImWomo2ra2Fo+8lU2SwiR/vpB6gW/3GPQU37zZYy4HiFQd8G
	FBOZAk2ceLEJYegbv5Y3fKBEvTxTiQV22x4a1H2KBbbMuFMQTTv3Y1Nn3N0IcdbGTz1tsAP5dQT
	gijTup4GHFa0rcdwG80/ASV8JFcOM34Njiro2NVV8GX3ri2fJyXuoNP98QTx6S4trWGxbV4REvQ
	a1CXpI2ZM+uTyAkdhNdmt98duEX5sS9QfiNeAWQgMrYToV9H5PlWhduXCk6I0EgFoo/l+QNXZsq
	e4+sSjOGT84DaesHPtlxReLv3
X-Google-Smtp-Source: AGHT+IFXfwKdwQy9L/iDhxQV4Dtj+nleX6usHo1EXmx4Rg1qgQ+BIVTWUPx0QHTGWZ24uy02cSt7dg==
X-Received: by 2002:a17:906:7308:b0:ae6:c23f:3cf with SMTP id a640c23a62f3a-afe28fc55e7mr1412861966b.16.1756210150317;
        Tue, 26 Aug 2025 05:09:10 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48e853b3sm788943466b.12.2025.08.26.05.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:09:09 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 26 Aug 2025 05:08:51 -0700
Subject: [PATCH] arm64: kexec: Initialize kexec_buf struct in image_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
X-B4-Tracking: v=1; b=H4sIANKjrWgC/6tWKk4tykwtVrJSqFYqSi3LLM7Mz1OyUjDUUVBKz
 kjMS0/VzUxRslJQMjIwMjWwMDLTTcwuyNU1tEg0NU81TjS2TEtR0lFQKihKTcusABsTHVtbCwC
 VQhH7VgAAAA==
X-Change-ID: 20250826-akpm-18a57e3a39fd
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, kexec@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bhe@redhat.com, linux-arm-kernel@lists.infradead.org, oxu@redhat.com, 
 berrange@redhat.com, kernel-team@meta.com, 
 Andrew Morton <akpm@linux-foundation.org>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=leitao@debian.org;
 h=from:subject:message-id; bh=4v6c1/SuN2XBwZ50PJG6PxSplQuP+IBULqjkSZZ05mg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoraPkzCMlrgJoVHjTxY6CWYJ4qnKJpiFt+KrRe
 Cxb9YW04tmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaK2j5AAKCRA1o5Of/Hh3
 ba6SD/wOd+iTOQspDn1FBn49r47VwUIch7D1WIFJN9Kbms5RLwJOT9Dj2U+ASaiz5A9miWo5sl0
 m960HatusN+DH2CMfzLArTbTAJL56rWacWrmT46wROXC1JnlyyxJ4IJf3BpXPok5mCiSlS7pA7s
 NtnbjVI/Zi01sYoQvEMfKolgB3EJPCP+J1maGWpvzKJX8aM0DnNcwXnMZwYMKMQcv9cjnEHytdO
 bbifs3IznmEWtBsa5g8GpIdyBXN87X9BUfQXRET3eWo7iSUv2rwdnQTwkAKhD0e9mCJk3t5U9Sd
 pV/b/PeH6PVhtGR+TKg1188qa/l/Nj2ytRyj35Ruz1KiD47USfFBJZfmQf/3JPNYFveB0XWtiAo
 MCVki0oFa9cCLq5+wfX1i3PxZlt1lDsK0/6mgbHHbYV9HIqOrFlo0adex1fOI9zite9HWVS8Q2p
 sKhcAkzzoBH2EtcEwAYB5S+e8aCZHWdhM3O7tIOG15dZFEN7WZbvdIZXmpfKgzMQFsRPAYqE4go
 /+uZRLDVuJuYODHoiqG0u6WvPQZzNA7rMI1yY8JeJ8n3j6/Vx63Yey39t9W6t+/KV/Ybg7lrEgv
 Jrt++eUrd802b5ogkawLHDGVTrRUYZTpO+ZaQvChhq9EiYnJnegG2M+n43XgsI8gyyt7BRxpnok
 5w04Hln/DSpiuFw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_050912_538329_7399C6F9 
X-CRM114-Status: GOOD (  11.65  )
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

The kexec_buf structure was previously declared without initialization
in image_load(). This led to a UBSAN warning when the structure was
expanded and uninitialized fields were accessed [1].

Zero-initializing kexec_buf at declaration ensures all fields are
cleanly set, preventing future instances of uninitialized memory being
used.

Andrew Morton suggested that this function is only called 3x a week[2],
thus, the memset() cost is inexpressive.

Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
Link: https://lore.kernel.org/all/20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org/ [2]
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/kernel/kexec_image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 532d72ea42ee8..b70f4df15a1ae 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -41,7 +41,7 @@ static void *image_load(struct kimage *image,
 	struct arm64_image_header *h;
 	u64 flags, value;
 	bool be_image, be_kernel;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	unsigned long text_offset, kernel_segment_number;
 	struct kexec_segment *kernel_segment;
 	int ret;

---
base-commit: 7a77c6b5ce68a71b9102760a988a4564ff6d4106
change-id: 20250826-akpm-18a57e3a39fd

Best regards,
--  
Breno Leitao <leitao@debian.org>


