Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EADCD3424
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 17:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2jdlpGF4XpPc9ZFDgVdeXjA1AFqLuNKcjK8mHttf1o=; b=g5Q2niwj3IIqLBGdmg/fVUPXD5
	SrY5K3aPl7OR7810oCyupKD93looLbdG0zU2NeNSxKnqoMYqFybleJZp7uWib08ypkvfyASxCpvHv
	yvSCFeWODvokGZpNXw40YMD5PjQxRNknGp+Wyl50irr2MUp5+ANntoZmwdoPNuPcxTG2s8igm8owa
	5WdBzsoAxsnVjud8KnwDE8CipklDQ+oa0CFj6chHAXsUIws/atwCTZY+RfIRISvyg9U+/sC2C1kmA
	53JJFk8Ad9O6SLqamPHoG8rbR/L0jMaY50VF276iyyhAIyKk+1NII3dP0T6xRGyE1vuEG6f9v7pdo
	FOSxzZ0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIriA-00000007VkR-2EoU;
	Fri, 01 May 2026 17:31:34 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIri8-00000007VjG-0pHp
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 17:31:33 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2ab46931cf1so20739955ad.0
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656691; x=1778261491; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2jdlpGF4XpPc9ZFDgVdeXjA1AFqLuNKcjK8mHttf1o=;
        b=haJ4+2Z64cNbg1tuSokj1hJSodflYQmb1AUSzyq4ApgimYq4D6g7tDk1qpGgkqjrZu
         bG+fEf79xyW0ljqn79s9KGL/VBIxL2b80S8g/oJ9HnhogHzc7IUCzCvLJ4NGDAJ0Ha3L
         dY9U4lZDoNsVdHOI3dESYYrP3I09t/ZYAoJG51OTSocGMTbpJEbnlITWVISAjdWBJlUq
         ugBf/FJhkC60giYOOORCVf2R5uapqPjawnYZK1lm/0S94WazJvwpFkukTsaq0V9pqlpD
         A2T/JbTByJb3TnFDq8sgOBV2QDf+qmsDQHt1dxx+dIxoEYoZWFGAnnIosV9NGUWJNl2O
         9VIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656691; x=1778261491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2jdlpGF4XpPc9ZFDgVdeXjA1AFqLuNKcjK8mHttf1o=;
        b=mEGE+vw6QnPWvogPJmRTHI2FE9pWC/eCctM7GiPPkNIxBwBIDrtWB2H/wmU7NA2U3s
         vlm8asZ+JU8OLGok8HWc6RT5V8EryF+d4zOGCBJIhmyhc1ZtgTu/fsw8ZWQsUq8Kj2sU
         rHi4GGJPsmrZKFaZz4hDg8GG/6jpl1zXLRWnAZNh4YL2kX8q/IgYEtlj1Pt6nDrXSYyI
         LMLlkq4c4JlEO3Uf9X7sVfWUXstVE91kDav3rDqLlWZvy39Wh1fR5w7ODV7VoMfulhH+
         2gIF1gU9pV97EK4T0+iP7nPXZ4eQPP59Tn674phehHsB8b5MVRPXtCYH1uzkLTkGYplk
         3CnA==
X-Forwarded-Encrypted: i=1; AFNElJ91/NMG+E7ZAVmMLYy4Mcyje3xfcjYkeQPaTO+ysN69/DLekkgIgceWTLPkLOy9PcHjsGSLeA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwXatcNVhn8I33fS8nxlN/KkYKD2pCcxHvzUKgi9+KXvH8a5Ewv
	uEEksH4S8Hpj96Gl8sbN3fIZ9gKmvC6ZtWOGUx00IlzFUJ84f5cA+s9+sx5S9MuV404=
X-Gm-Gg: AeBDietf/TMmY6BLGCEwsBQpNCTAF5/OoHS557LGz+ZUZNPo8exS3aBio2whP1k8oDe
	y/acu+iVdw5gE2rDb3GCisnCTszZzLhy6ayIUwr4pmkIHzxWxYOWWX8kUMOLtQ9X022ylFJY6vR
	0NvazLPuJg9lMv7C4bWomezAOUg/r6DlVJ1QuOr2RE20SYTJ6S2ubGdQlklz65NjAJ9lt5Jga3s
	Dhs6vVTrCmCCRd0yuMaTIWsLO9hgPECTnv685XBJ6C7kIPSx3c/7FOCDEjckRwGXExuJhXdPhNr
	LvDxt6Qtr9RT8KabG1eIyBmWZGFkw/18gaE17RmbtqQczty4THvtdG0rFtCJaVewaTA4dm/fAWE
	QRerWBv6rBdpCQ7gCACYkpbUeJb2DAv6Uw1xtFjXjBml4634WXbXbrMzZOtgkiQQDZMwlUYw3q0
	sQbugE+7BWmfOVWOLWynknltpbenDQq3ehz/6AUQ==
X-Received: by 2002:a17:902:e54b:b0:2b7:88f9:9c28 with SMTP id d9443c01a7336-2b9f1cede68mr3019515ad.5.1777656691129;
        Fri, 01 May 2026 10:31:31 -0700 (PDT)
Received: from laptop ([2001:4455:8025:be00:15cc:43cd:8af9:5a8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caad2459sm27094895ad.33.2026.05.01.10.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:31:30 -0700 (PDT)
From: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] liveupdate: validate LUO FDT physical address before mapping
Date: Sat,  2 May 2026 01:30:50 +0800
Message-ID: <20260501173053.73116-3-crisjacobmaamor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501173053.73116-1-crisjacobmaamor@gmail.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
 <20260501173053.73116-1-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_103132_239106_C22A6440 
X-CRM114-Status: GOOD (  12.11  )
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

LUO gets the restored FDT address from KHO and maps it with phys_to_virt().

Check the FDT size and make sure the address range is KHO-preserved before
mapping it. Reject empty or oversized FDT metadata.

Signed-off-by: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
---
 kernel/liveupdate/luo_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 803f51c84275..633a16434164 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -82,6 +82,7 @@ early_param("liveupdate", early_liveupdate_param);
 
 static int __init luo_early_startup(void)
 {
+	size_t fdt_size;
 	phys_addr_t fdt_phys;
 	int err, ln_size;
 	const void *ptr;
@@ -94,7 +95,8 @@ static int __init luo_early_startup(void)
 	}
 
 	/* Retrieve LUO subtree, and verify its format. */
-	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys, NULL);
+	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys,
+				   &fdt_size);
 	if (err) {
 		if (err != -ENOENT) {
 			pr_err("failed to retrieve FDT '%s' from KHO: %pe\n",
@@ -105,6 +107,12 @@ static int __init luo_early_startup(void)
 		return 0;
 	}
 
+	if (!fdt_size || fdt_size > LUO_FDT_SIZE ||
+	    !kho_is_preserved(fdt_phys, DIV_ROUND_UP(fdt_size, PAGE_SIZE))) {
+		pr_err("Invalid LUO FDT from KHO\n");
+		return -EINVAL;
+	}
+
 	luo_global.fdt_in = phys_to_virt(fdt_phys);
 	err = fdt_node_check_compatible(luo_global.fdt_in, 0,
 					LUO_FDT_COMPATIBLE);
-- 
2.53.0


