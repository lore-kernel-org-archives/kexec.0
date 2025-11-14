Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFC4CE8D4D
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jWYmoe6n/rjfMRyVwGOHWBt0L0ANxnxo2HoEY+1LNsc=; b=crXyDNFZAuCce3RFV7WO9lTe4t
	FDc663oHEoPQLUrphYWr2AMj7h7xMMlfzfl5Xuk/rJXVqGC2FF4o2NJSr9MqA5GtoUIYFjA0kOIn/
	w4xkl+5Os5gTYrsg961Wo8luwTc+a5wrLQXEFCo+27q+faaHLtX/7ddHdbtZYnYgs2Y5fjIfg8AHB
	/88L0VLg/1VgV/ZoZGPujd214nEMxHfSHz232UpTfQBwE4v8zo0TngGy7lrPBVxgZJDdQp7vlY1y9
	D6Rb2G1iZFqXEfak/te7g/ViHmmIyh/gsi3qQdWpnjP8X1AsrcW/za8Q/v6sqi9wtBWBTIqChR2tQ
	IJMk/3Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7v-0000000CctM-1vnF;
	Fri, 14 Nov 2025 15:54:19 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7q-0000000Ccne-0f4K
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 15:54:15 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-787eb2d86bfso22563417b3.2
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135653; x=1763740453; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWYmoe6n/rjfMRyVwGOHWBt0L0ANxnxo2HoEY+1LNsc=;
        b=LDDDH4pIRKS8SW9Ud75eK1VTwme/ehbOmygxRhTPnQyVHs84mFwzf4UnSdJxRIhHZn
         MoXK23Xq5TOGh8rQmGojXlOmsDkytJz6cr8fh2OiWJthw5RkgQbe1BvgJn+pOwEI6z/r
         Jk83je0bqrkix15gSJ69DxzWV+qwEmZV+YMkPUFUX7PCPrYCX0hdTc9ffOT14FJ/gjtl
         guJt8ZAruucdKpPFO/TcfA7Uwia525juPCs3VOC/Z7e2o+tOrtPAfdFBvoVwAALBMJQJ
         PVj6AWERvl7eHsssGED9pVzEPGUbDwqBHazxyw5lSiwsfXrvB9om1phepxHmTJj2G78k
         rdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135653; x=1763740453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jWYmoe6n/rjfMRyVwGOHWBt0L0ANxnxo2HoEY+1LNsc=;
        b=w3y90P2bTRXkHr3fEuPikRNmHi54eDEIG6v5lDMXa5Uww9+WF4ykfAjHs9zbL/a0F1
         rECP/Z+fYVx4JzmSXLPr8bj4LOvmzwGHoFdCz7oqWmUWAOVP1F/bork1bOpzN9rh6zGC
         /sWD4pK23lYkm9wITcuTO/X3uri8t4WG5ZhTTgggJx9CIsNx73wFji6Acmremo5qB/8S
         5wb2zkjBM76UXYpAKElQeXW+XH5zwT2Tmh0TG+X9vBeSMQh3Ex+I5uu3tnjjthCJw7ca
         856CUUTydFyv05QghsSi49KVc1ApVjTBxVp8xWRmtThkzGI/wsksZZ3jTARFvZ83U0pc
         jMUA==
X-Forwarded-Encrypted: i=1; AJvYcCWiKiceGCKRE9eUj5M6WQGqkmaQGmUdopxTRfBXwvQwL6601x7fo8lMrbKc6Z7Fag5+TpqgjA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4a2qz2YgYxwaY2V+Tuwq0wjLIN55+Qw31dz5pax+dBBEpflGl
	H/Oebak9NXO+AbFaobOU0uvFcbFPNLLPc4dqy9bBTFjnaMvjv3k+2dyVzrW0vs8nlEc=
X-Gm-Gg: ASbGncsyh9gIwxZ7L+qljMu8Rx4VPL0BoWhd/RD1DQFjFQ2mUq2XLX57SBMiRwh2qI+
	grbtgmtthNSTUNEoofA70KPmtQuMUoNwHpUGK3KABYhdgL5UHvT331inmvPF8cfby9Xl9dDxk1t
	g0DSzDXwEVjz38tA34ZFynrh37XbhtVZNnwFyEJuGkRn4d1ggCxQkEVkO75s7vRtHl6yRAjc0CK
	Fvr1WV5dt061oPShRa/eB1GYGsOtUUqeqFTpbIvgmReynkpsurYh2Mdbo8BrklmNJZQk5TkW7IP
	29kuE6gOeyqw/JA4Qm6Zrg46rTFDvXghTvodzcjgIKYFhzNw6/iUhNDS5dUBfw0QB30nJjsCRQW
	vRHmG6GR527R4UoU5ZVlI6/C82CsGp3I9iXz0+Z0nbv4lsWVsBK0lJrQMa0Plpot+P4BPmKWxUN
	sRoUEqrqYHarHCuYGOoq1sn4yfnWh25GbxQzUXAVtSh7W2f23s5uTAjJE0O8nwBmo6+ZGa
X-Google-Smtp-Source: AGHT+IGJaOAJGksp5OzW6VIWGJ2oj2MfQScBcshD9izy6AP7xHUYC50lOdqdoRgMNZveVGy2Y0wOug==
X-Received: by 2002:a05:690c:c047:b0:784:8994:297c with SMTP id 00721157ae682-78929e49844mr28762387b3.24.1763135653040;
        Fri, 14 Nov 2025 07:54:13 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:12 -0800 (PST)
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
Subject: [PATCH v1 10/13] kho: Allow kexec load before KHO finalization
Date: Fri, 14 Nov 2025 10:53:55 -0500
Message-ID: <20251114155358.2884014-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_075414_204360_C1C9E0AA 
X-CRM114-Status: GOOD (  12.34  )
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

Currently, kho_fill_kimage() checks kho_out.finalized and returns
early if KHO is not yet finalized. This enforces a strict ordering where
userspace must finalize KHO *before* loading the kexec image.

This is restrictive, as standard workflows often involve loading the
target kernel early in the lifecycle and finalizing the state (FDT)
only immediately before the reboot.

Since the KHO FDT resides at a physical address allocated during boot
(kho_init), its location is stable. We can attach this stable address
to the kimage regardless of whether the content has been finalized yet.

Relax the check to only require kho_enable, allowing kexec_file_load
to proceed at any time.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 822da961d4c9..27ef20565a5f 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1467,7 +1467,7 @@ int kho_fill_kimage(struct kimage *image)
 	int err = 0;
 	struct kexec_buf scratch;
 
-	if (!kho_out.finalized)
+	if (!kho_enable)
 		return 0;
 
 	image->kho.fdt = virt_to_phys(kho_out.fdt);
-- 
2.52.0.rc1.455.g30608eb744-goog


