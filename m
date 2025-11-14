Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728DECE8D4E
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nCJEgobzRYn/tItBVhI3XMcNL4Ytkb3Xbpl8L0K4v8I=; b=TpTgMxZUYY8TEw8w9hNDb0KYnf
	kZK9bpClWycVx+1l/qOckz2ZVQaHUKinCnsaAttVWUuqLHZ06QjIUhuuMJSDUvqtimFlXLGUKqLt3
	6BvbL1d6c9sxdPcNvS+lMWfJF4lJty96K6qUjoGw447/Za/k94BTAWNxEksSyqFR3z/NG7vCsKWcK
	vIeQ/VkXm7F5edGRy5BSiT/IJV6EmZbbgCO7fPWNc3GLCNhVGAgqS8zZgkuyOWiI2LHvoSQGILs8R
	6GABt23T5xTMwItybBVN6AzjqmArenK5dETgKdKqg66KJU3TJDpiIymzt76jCma6vy5O3sVcU3sij
	Du0jTMyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7o-0000000Ccmf-3QDH;
	Fri, 14 Nov 2025 15:54:12 +0000
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7l-0000000Ccib-09ZN
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 15:54:11 +0000
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-640d0895d7cso2705417d50.1
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135648; x=1763740448; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCJEgobzRYn/tItBVhI3XMcNL4Ytkb3Xbpl8L0K4v8I=;
        b=WeJFkOEloPeRHCi7I6R/QHK7X5q4ByG/XbgTt08f159ng8506/XrlGmCIA/HOj3Hha
         kyTpxT30x2NDJ7dpmF3j5xxx0Fpl6T4C2phjJEsNCs+8F2VsIJ3SGGQj3r5ClIa8xyIL
         kwSK2iSoFT2QHhUWDkn48ItMIiEiCmKeH1mrz9JLPpB8C+qGU3XEYSo64LwRNwzfgSJA
         EIzrFJECihabH/p8unB99X8jK7pF740hLXEpzVASkKKnja2kwdtx2EM10GHH9sr3i0mu
         OjPaEOdm/e9h47YYRfx3/bg7/st0SkhpyWyfVkCTIsTqPK2iCPPw3D8S2PlMGJB7GvBL
         QeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135648; x=1763740448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nCJEgobzRYn/tItBVhI3XMcNL4Ytkb3Xbpl8L0K4v8I=;
        b=VaJ+7OfuuCbJmXf+Gp88l6OndKqIL1k0gvnoGJsXNuGLH+2GZi9i5/X4QKT2AO/cmI
         8KuhgPFQoWmmUZqe0AQGPXiVilXpn2eiec+KvRL2DvStikHtbSynurx3nqbES0fxvHaK
         LTBiPepW4jKVFa7jT93BvLRZxA7U9T8tXfNx2UYqUw+OAIvPVt9zIEVSZM0QuNkYjZtN
         ovZPt0DnVfJTbITPf7KSi52RAn+IDuyhCRXdlOoHVc9J/EgM4OZOdQwYDyOh4CIm146z
         qtaMZVSBcUjZHnbElj5DAd5umJZIGkXeYv0/c78cJVRh85oMWt01V6W+U5GnjrK2CFxT
         fClg==
X-Forwarded-Encrypted: i=1; AJvYcCWwTwAA4P81M4nRp/uZxErSxP+UonE0eKkhM7fg4Yw7mldzbReE9ozsQ1EeK6Sn0/FKD+i/Ow==@lists.infradead.org
X-Gm-Message-State: AOJu0YzBjrf9e/dAgh2+ZG1nlxa4QQOnBP8BRGo7ga5wk5joqNECzMLt
	MTTDXuCUItslJr+l9iQjhDrNK9aLhbL/LphAGJlcxJvePhamgXGgCuKtS49Qz1G5pEc=
X-Gm-Gg: ASbGncvDaYg5REaRRt0+XmSZV6x740AfDML+VKUWwB43DR1f0lWa2I07jbNvJwo8Fyx
	1iu8Yc6GsScKyGqmC3TNEAQaqxBb+L47cxoIh9EmridGeh6jE+4OGsc3XOYt80Tpd1gsewEnXT8
	nBE5ozy1aFFWFg1UAg+bYfa7aE6/X32UPWJ2D3JkofzGVzSTb7yAaQZTP/SbTfuuqs+Iz9f3+X6
	yeOiK95isa7qWzkdeqv8R+k8e/5OSIvqr8pLZK/C5vvDg1grd1zTi3PqFQM7bdgqzGkU2Cp7nJ5
	ZfyKrAmzEDA7Kf+xPwzI6IPwvoHGwlVi79W63OeCOn4ZknqLZLK3na7xCNwMs0zL06AGYF1F8kq
	jJ73s8Yzyl9pqafdgLvgtd0eFOE9+fEsYo+qr3Q00RcJlSuBZPEnN7vfePweKV9AxqSEpUGy8FK
	9QSV4W9Bwi19Gvl6+a4ts/xRIGC03SDUbD3WBnSm6jgDszmea16V6ownKEMOMpov8lSP9E
X-Google-Smtp-Source: AGHT+IGqvP0vwg6guTwhcdsa6bT4+I6iFV9vusGDhb+GF/sTNONxEyRk8zCeLELCWn/eYnZOTmVaMg==
X-Received: by 2002:a05:690e:1544:20b0:63e:3546:6fc5 with SMTP id 956f58d0204a3-6410d194f9fmr5217183d50.32.1763135647923;
        Fri, 14 Nov 2025 07:54:07 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:07 -0800 (PST)
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
Subject: [PATCH v1 05/13] kho: Always expose output FDT in debugfs
Date: Fri, 14 Nov 2025 10:53:50 -0500
Message-ID: <20251114155358.2884014-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_075409_078846_66F8B5C0 
X-CRM114-Status: GOOD (  11.58  )
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

Currently, the output FDT is added to debugfs only when KHO is
finalized and removed when aborted.

There is no need to hide the FDT based on the state. Always expose it
starting from initialization. This aids the transition toward removing
the explicit abort functionality and converting KHO to be fully
stateless.

Also, pre-zero the FDT tree so we do not expose random bits to the
user and to the next kernel.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 83aca3b4af15..cd8641725343 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1147,8 +1147,6 @@ int kho_abort(void)
 	__kho_abort();
 	kho_out.finalized = false;
 
-	kho_debugfs_fdt_remove(&kho_out.dbg, kho_out.fdt);
-
 	return 0;
 }
 
@@ -1219,9 +1217,6 @@ int kho_finalize(void)
 
 	kho_out.finalized = true;
 
-	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
-					 kho_out.fdt, true));
-
 	return 0;
 }
 
@@ -1310,7 +1305,7 @@ static __init int kho_init(void)
 	if (!kho_enable)
 		return 0;
 
-	fdt_page = alloc_page(GFP_KERNEL);
+	fdt_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!fdt_page) {
 		err = -ENOMEM;
 		goto err_free_scratch;
@@ -1344,6 +1339,9 @@ static __init int kho_init(void)
 			init_cma_reserved_pageblock(pfn_to_page(pfn));
 	}
 
+	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
+					 kho_out.fdt, true));
+
 	return 0;
 
 err_free_fdt:
-- 
2.52.0.rc1.455.g30608eb744-goog


