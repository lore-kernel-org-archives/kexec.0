Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A3CC678DB
	for <kexec@archiver.kernel.org>; Mon,  6 Mar 2023 03:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VTrI0CFVP2I4t3uvYMU5/tD6hJmfEVOw4OJbFoS5A4g=; b=ELLECPNTmfGNiS
	sr18PynGX2NLlU+4TN4w/N9UGk2a1E3Qx/jScv40iKdBXKUe+7HLGvBs1NYKFBIZnV68LkuaNmN0B
	uhTG/GVGLWGz/8yIZdOstuivqygXss/cVeLXEDdrfjXMUiHSNBYQEuG8/N0DvqFb4aGvR+TNEW8yc
	2MYKZKCX3X8M2jCU8USofDl7kHfHzOKsUR+MpJMGjTd1yq40H3oz+KdoW1zuGS7k51t+aMWGq7MZA
	E/qwzU4Typi9EBe9eQuUU++qAgGGjVO3GlLuhOQa5y197ONlgRFyt3VoyfN/xh1BUQIa3d19eKAQl
	vCoyLbv63Iw6EoVDpcoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ197-00B2ul-Jl; Mon, 06 Mar 2023 03:04:17 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ18S-00B2RF-Hc; Mon, 06 Mar 2023 03:03:37 +0000
Received: by mail-pl1-x636.google.com with SMTP id p20so8724613plw.13;
        Sun, 05 Mar 2023 19:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678071815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wneh97F1nMdoO/GWBYTh+FCpx49GDmImprYvE+tMGQE=;
        b=mvYZTLnMDzqZPw0EObR6IP1bqYOQ6tPuLXfY7xHMKAH7j8jrQKrS1JHwphC8/GTqe8
         4xxtq5FjexX8PsrMWL7aNFe4yld29ji2KCki8LpGN4790OXnMpAYGVp4kBbZ8dnrGrMM
         1iaerc/FEIt5qb6xFS4ynYEU4aqQLjswq24G/gyhza1Ko09zCMolEnZT0FghHnmhV3jd
         YNShaiXqZWYoYDQ28qel8wZxtFO2dTktPcZUK9juVERYV2Qci7OCO+tFoKztyLx2HIQI
         KwOSOxHWUoWK0jJtLXLy49s/JkMdmbPQXVvuPpP7ByYWalcW31aBRc7j5Erzq35nNXj2
         STNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678071815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wneh97F1nMdoO/GWBYTh+FCpx49GDmImprYvE+tMGQE=;
        b=SR3vFN6xzIN190M86zrx18tj/CHbfJNT0LMHiQzSBpSMIoPA2fhkVUCTJ5wtCurBUs
         k9veep4Wk+dFzUhZNw6PwU2TjlrQR7R/PaR86hLjRJxtj9i2YR7XVT/Ar8mOq5nSJHD0
         tkhf5mCz+ahcOMrNtnQY28978ypRbtCRMiIREaszycb0NQil7J/aSkX7Yb2M/lMcFd0W
         bTzSZl7pIiWAHOeZHQLvO1SQ271sW0cpVZ5FgZQf2X26RAKLSs3t13V+eQjvPHByRNXJ
         Jz+fx/M7ZxgMEMjSkCOMi+jmM3puwur9eGpgNhF+1CRfn+Ah72B2qH+Owxb4FtiVNGq7
         pyXA==
X-Gm-Message-State: AO0yUKUTTldfcsiIjcrFRFTjCYE7EORblR2sWKTacl2mc9DNgGIWSRw6
	sgRaDVqYnVPDGsHHWFlrnNiyaRPDzQ==
X-Google-Smtp-Source: AK7set9ZT3V2MdQmOCnCAefBY22UCEzOMyO2IU0j9xpnm0GrmRPbiXTc8e7zd/VuGWUzN5tbfyDKKg==
X-Received: by 2002:a17:902:bd93:b0:19c:be03:d1a3 with SMTP id q19-20020a170902bd9300b0019cbe03d1a3mr8853729pls.40.1678071814870;
        Sun, 05 Mar 2023 19:03:34 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy16-20020a17090342d000b0019719f752c5sm5410439plb.59.2023.03.05.19.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 19:03:34 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	kexec@lists.infradead.org
Subject: [PATCH 2/6] lib/decompress: Introduce decompress_method_by_name()
Date: Mon,  6 Mar 2023 11:03:01 +0800
Message-Id: <20230306030305.15595-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_190336_600064_C34AC568 
X-CRM114-Status: GOOD (  10.94  )
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

The zboot image packs the compressed file in the data section. Instead
of starting with the zip file header. It records the compressing method
name 'gzip','lzma' etc in the zboot image header.

Hence it is easier to decide the decompressing method by the name than
by the magic number.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 include/linux/decompress/generic.h |  2 ++
 lib/decompress.c                   | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/decompress/generic.h b/include/linux/decompress/generic.h
index 207d80138db5..077f15ce77b9 100644
--- a/include/linux/decompress/generic.h
+++ b/include/linux/decompress/generic.h
@@ -37,4 +37,6 @@ typedef int (*decompress_fn) (unsigned char *inbuf, long len,
 decompress_fn decompress_method(const unsigned char *inbuf, long len,
 				const char **name);
 
+decompress_fn decompress_method_by_name(const unsigned char *name);
+
 #endif
diff --git a/lib/decompress.c b/lib/decompress.c
index ab3fc90ffc64..8dd6f87e885f 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -2,7 +2,7 @@
 /*
  * decompress.c
  *
- * Detect the decompression method based on magic number
+ * Detect the decompression method based on magic number or name
  */
 
 #include <linux/decompress/generic.h>
@@ -82,3 +82,15 @@ decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
 		*name = cf->name;
 	return cf->decompressor;
 }
+
+decompress_fn __init decompress_method_by_name(const unsigned char *name)
+{
+	const struct compress_format *cf;
+
+	for (cf = compressed_formats; cf->name; cf++) {
+		if (!strcmp(name, cf->name))
+			break;
+
+	}
+	return cf->decompressor;
+}
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
