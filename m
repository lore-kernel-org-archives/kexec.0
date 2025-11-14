Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B22ECE8D7B
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YXc2jA2YT77trJs8AGCJnVExYUqZkyW6ilvAJCLy6vQ=; b=WnCWhSyMiD/L3KStgnzfbilyMb
	ochNL9YfLod/P19O3dmL+4YGFrmLdh/IvKAMiDuRuTs8evxyEMeQjTm1X0nO4a4CVHw5zZkbrRifA
	oruI5UFM1csXC9VUHk3awRhIpsfoTKfAHEWHe9mhIitXTFBkAPzO8TKsOAfPh/5EmQWEqtygqw1pf
	3TTwv+jAP6S6mJyMWRaMMds8I6MbiHh3EvXiflzI8sNkz9wKZzpS0qPYir61jmme/Hf1wbLysbdj7
	cHz0lI0GhnQgK0GeP2+ZKp4snZ6R5EJxFhKv5NDm+lt5TxTszaOFuiWVBqC32MBefxPz3aqt04a8V
	o4EDlfzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1p-0000000CzLC-1ubn;
	Fri, 14 Nov 2025 19:00:13 +0000
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1m-0000000CzJN-34uJ
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 19:00:11 +0000
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-640e065991dso2288293d50.3
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146809; x=1763751609; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXc2jA2YT77trJs8AGCJnVExYUqZkyW6ilvAJCLy6vQ=;
        b=PlWWtXQglwGHI3Z+vbAROVOd7U3sZidumLIluW5XUbo3rTa2HUb3BvmJn6DjtgsL1E
         g1fxc7VpZn0o+jFTqFFS41TAMCdodm6Qmx5OPvMqktBtaKMVydPYdvznnV2cidKSa+H+
         yxXssOD49XPk6DqYKOjnCdvx0MhjolI9uDVbIP/btBWhG+8aZ2zZXlECawnGrAlxufL9
         Z5uXMUlgFZNhrrFtsq1m+Y1sDfOJA/iMDhRxWJGMYhGgmbpSTrRfQodX9nvZ3qfdbeUS
         TUZda2dedaEEQb1aeuLgcAHFq3qzwlBUq/zJyU9/c9mHtLFSaVdK1gqVDB5MXItm3Zwp
         LrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146809; x=1763751609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YXc2jA2YT77trJs8AGCJnVExYUqZkyW6ilvAJCLy6vQ=;
        b=IAc0CP9yRuIidtCouIE5w2g5Usmkgj7nA5vN/5SJPxd67ENJpRjBFYqpnlkEebdT7G
         y02rS3IgiRMmTektPfQFxeu26FVWU0qSCm5y6opHxGXOIc2OcbeEQ2liHzwTmlaDqCMo
         1mpg8ukaC805FkznjXjsx6MeA0YkqGdCgOi9Ht9txcFrizRisfII1bNF0Sy4v7zgQpPy
         r9GHFYo2DNFTZr0ozCYMQqL2vdJca9ma0G/7FBdf2UZG4mppdt3ImGFe3Sos6RihzbT3
         FgeioAIDTRryedUYgao4hU85xzPs8QrQUnTZXLQ2ViJ9ba3Cu5BCrO1NmncodXxRD/Dm
         Uu/w==
X-Forwarded-Encrypted: i=1; AJvYcCW03j8RCZl2HWGcTsSYA+vyGgtlLstzkBADZuhMdnCUXSmPIuUC+c8iPz3DUOle4eVUiMgvag==@lists.infradead.org
X-Gm-Message-State: AOJu0YyvW/po7uP+oSODdYcMdsJj8xcZu2u715+6heSRpmVlxO579KKe
	Pc01cim4DPJ1dUJg83KBUuEdEwJgEx0d0I83Y/t2t2pXvjt//cNyTNJXD6b2Fu/wcxQ=
X-Gm-Gg: ASbGncviUJ22/M48KfdFZQfqpf7y4vp1fqtsi1AYaBxN9K6JCucXm3+iGS1P2ug47kf
	WKyKWincNpssUKXYP0d/01pbFpCPc+jZrgWOY6WNB8De3GHlY3B/JvAuySegVpbSTG3afXE/gVK
	1yZDzoiMZeBKFAvpiWYno0HTLy30cRma6IVLS/SV8GnUCpazLVl29P4KJWjL3RqBgQUAQZfl0ZL
	2bclA7bn0lO7O0PQ+Wa1Xrut6odAmTRa3YwNVy6aHS77RrphGWFbndcoYTEgp5fVPnZ6w+9+8pN
	m1AUk6iC/lhwUl6rjd4HVcXgG3NMhJ78m2kBdPu8w0SoezoS9rNjrjjcWQxbWMxGyCwQV2Bxrra
	kqoLWtZV8MHvt1cvAWXT/8XVTxKNpisHmmGfgakGKpAs19qzQSXnXFzGGyzU5yQbyBgxLFajHDX
	GSgjJqHCU+GTvpFr9DnWghemmc5lyxMD/fvw+y3v12+PYPeUkJi89+l5qFJFab43Z7TjhYdeSG/
	3hilZo=
X-Google-Smtp-Source: AGHT+IGOGhN9och8baUfhKaHjASGw/VORaspSG14Cq33C7ESIM+RUb/oPIKDQj3zWRv1mHSuuySjxg==
X-Received: by 2002:a05:690e:249c:b0:63f:bab4:fdcd with SMTP id 956f58d0204a3-641e76cac43mr2599528d50.48.1763146809421;
        Fri, 14 Nov 2025 11:00:09 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:08 -0800 (PST)
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
Subject: [PATCH v2 02/13] kho: Convert __kho_abort() to return void
Date: Fri, 14 Nov 2025 13:59:51 -0500
Message-ID: <20251114190002.3311679-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_110010_774583_F5D837E2 
X-CRM114-Status: GOOD (  10.03  )
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

The internal helper __kho_abort() always returns 0 and has no failure
paths. Its return value is ignored by __kho_finalize and checked
needlessly by kho_abort.

Change the return type to void to reflect that this function cannot
fail, and simplify kho_abort by removing dead error handling code.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6ad45e12f53b..bc7f046a1313 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1117,20 +1117,16 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 }
 EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
-static int __kho_abort(void)
+static void __kho_abort(void)
 {
 	if (kho_out.preserved_mem_map) {
 		kho_mem_ser_free(kho_out.preserved_mem_map);
 		kho_out.preserved_mem_map = NULL;
 	}
-
-	return 0;
 }
 
 int kho_abort(void)
 {
-	int ret = 0;
-
 	if (!kho_enable)
 		return -EOPNOTSUPP;
 
@@ -1138,10 +1134,7 @@ int kho_abort(void)
 	if (!kho_out.finalized)
 		return -ENOENT;
 
-	ret = __kho_abort();
-	if (ret)
-		return ret;
-
+	__kho_abort();
 	kho_out.finalized = false;
 
 	kho_debugfs_fdt_remove(&kho_out.dbg, kho_out.fdt);
-- 
2.52.0.rc1.455.g30608eb744-goog


