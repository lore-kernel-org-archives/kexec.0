Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F907C678DB
	for <kexec@archiver.kernel.org>; Mon,  6 Mar 2023 03:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7QKeiembOD1Ne+FblG0CEznSgGlrOLX0XRdn0EAXVSk=; b=iN+d8w5CgbD/M1
	sOYmjURZytLlhZi642cmyVvZUExVfiDeBVYAU6YGgt5c9hWc0w19kNxN8CYTQ4yPAFfgKLLksyESN
	rEGkgvvEQertFkYF5QlOBWfh+PzTsN7rFHAO0b3Hym2wT7hViurJ+7MWWRLzUyPtnptz7u3wcXPZ1
	d/9ptqeiosmJVW9p4B0mxxK9TeNXH95YuQyjHoD6yxhx/1DdzBUjs5VoDnCSakrsJ4e+15HMrbNea
	wnD6I2m4j/TEpmqPTMcl5xp/tMjtnJvUMHtMPAaoRDc9zH34vkl0utyZnES0lva0pd+omVtTgJUJB
	jmrPzAE/CL/0JXwitzKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ1A3-00B3Wv-Hd; Mon, 06 Mar 2023 03:05:17 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ18a-00B2VH-6C; Mon, 06 Mar 2023 03:03:46 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so11775936pjg.4;
        Sun, 05 Mar 2023 19:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678071822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOC/FNu2kgiTh2xy+eQd0EULhBRFBbwS09u1PSCaics=;
        b=NaKYVckZLYfiEuAigzcP2ETDA+KCnwCeEG6JErjf5qgu7EvyJy413kzlsIjrrmFzwB
         TIMrVi28isX3LNq1vvN8kZtZv772oFypAlZ7V2rmarNnARWhk/O32RHBNeAY38G4pjLf
         mfogJfCiYVCDZ6szaAOYjF/PBNoCcpkYyCRiPwbqyGxeNhjak22jX5BYnpyFrg9F966K
         eVFGlYDCvp/OlbnBgWUGbnn9L+jhQpxcHWsL0Wew/SDtoNrqBHZMlGn906K6whpqUEGd
         8annz1k4T1diofzyCnJvehBAZY1p1l+QOSiPrVJq6BtFBmT0AtmiHJR3WssGA6z4qWeZ
         2hgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678071822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOC/FNu2kgiTh2xy+eQd0EULhBRFBbwS09u1PSCaics=;
        b=HugLNUc9pGDgmnfBK1lR3RS1RlJbCPdsUwbmR/SnWrDp7H5Gy8NifAvTebmTc8kWAm
         pTxTKDlNN6qPbfo9CFiILJghqWP8V5VN/avsDMuxS7PWu39JEqJRsxaq1+SQqUBDL3xQ
         M62WWQwIozmZqyiQlvNFaMqHhx/bKeBJmz0bnQAJOg60EAiqMNHMznnyv4HPOE8OcP40
         7B34ndOAe0rKV2yBVdYi8ytse6YJZZR0xPuLkIiCN1ryLrT8ckPSFstLnlQq3p9Sos17
         I/wU/5xPHkRoJ90fyqV+XVZN+OxMZS3UafTaru0P5Dcxk3O2YvCKkD8D584hSu2u5JlQ
         /HkQ==
X-Gm-Message-State: AO0yUKW38mP68AVVN/KahP0mMj35vkZ7drZMu7hn9jSaWNLVJg+SCBd3
	tkhSJ9hz3uYmXt/bIDQA2Z9IoEbGxQ==
X-Google-Smtp-Source: AK7set9pFHfjgHVn9nJVc+fD+gdveI9XYNbDTQrxdQyJRmLKk2YuM3aJ0xZd+cpaGIwqbkF6D36UKQ==
X-Received: by 2002:a17:902:c40a:b0:19a:5958:15e7 with SMTP id k10-20020a170902c40a00b0019a595815e7mr10254558plk.15.1678071822090;
        Sun, 05 Mar 2023 19:03:42 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy16-20020a17090342d000b0019719f752c5sm5410439plb.59.2023.03.05.19.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 19:03:41 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	kexec@lists.infradead.org
Subject: [PATCH 4/6] lib/decompress: Keep decompress routines based on selection
Date: Mon,  6 Mar 2023 11:03:03 +0800
Message-Id: <20230306030305.15595-5-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_190344_250505_A7935CCC 
X-CRM114-Status: GOOD (  10.54  )
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

At present, many decompressing routines in lib/decompress*.c are in
__section(".init.text"). But they are required to decompress the kernel
image when kexec file load compressed kernel.

To solve this issue, define 'INIT' conditional based on the macro
CONFIG_HAVE_KEXEC_DECOMPRESS. Also make lib/decompress.c adopt this way.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 include/linux/decompress/mm.h | 9 ++++++++-
 lib/decompress.c              | 5 +++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index 9192986b1a73..33d8fd13a5c6 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -92,11 +92,18 @@ MALLOC_VISIBLE void free(void *where)
 #define large_malloc(a) vmalloc(a)
 #define large_free(a) vfree(a)
 
-#define INIT __init
 #define STATIC
 
 #include <linux/init.h>
 
+#ifndef CONFIG_HAVE_KEXEC_DECOMPRESS
+#define INIT __init
+#else
+#define INIT
+#undef __initconst
+#define __initconst
+#endif
+
 #endif /* STATIC */
 
 #endif /* DECOMPR_MM_H */
diff --git a/lib/decompress.c b/lib/decompress.c
index 8dd6f87e885f..33f097fe4b51 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/decompress/generic.h>
+#include <linux/decompress/mm.h>
 
 #include <linux/decompress/bunzip2.h>
 #include <linux/decompress/unlzma.h>
@@ -60,7 +61,7 @@ static const struct compress_format compressed_formats[] __initconst = {
 	{ {0, 0}, NULL, NULL }
 };
 
-decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
+decompress_fn INIT decompress_method(const unsigned char *inbuf, long len,
 				const char **name)
 {
 	const struct compress_format *cf;
@@ -83,7 +84,7 @@ decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
 	return cf->decompressor;
 }
 
-decompress_fn __init decompress_method_by_name(const unsigned char *name)
+decompress_fn INIT decompress_method_by_name(const unsigned char *name)
 {
 	const struct compress_format *cf;
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
