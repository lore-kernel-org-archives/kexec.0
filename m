Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580AECD4F25
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 00:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kzbLbrBxTj3Os65r+VG8KyOSku+VVjAs9NkmdJFxbWQ=; b=s8sRIx/WRM3FFvesKkRG0VaWju
	ewkMn1MMJRvrq1QIpJ1cTXYa1joGUUu4NbFO0adhQmHpkNJma2gEV1hiRDM0auJRANSs+HMjmMqdL
	1kEY2eDE43bEwj8yqA0c8vmqxaPLLYqdLjGkmdxmWZC1H34mFulJfF8bBGGCgyLQRSIqfnu90TPkN
	ZJ4qStwgu6Osl6HHpQfKAeFtrkeATl9EUrSKDFxZA5HfZgckJeyVJ6zLRuEmx6qAlshs602wgismU
	Fv4+be09c6myyRTVQn1Ls12EoqKcfnN0lx4yRW8nfLMIUnyHi/qiPcngqW8qfZq8baFt7Ozg7Rsru
	t5Y2nReQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgYT-00000006vmM-1qtc;
	Fri, 15 May 2026 00:37:29 +0000
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgYR-00000006vlT-05D2
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 00:37:28 +0000
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso5914096d6.1
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 17:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778805446; x=1779410246; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzbLbrBxTj3Os65r+VG8KyOSku+VVjAs9NkmdJFxbWQ=;
        b=O8NFqJcrB58z4iX8mTsD1O55jLkqJLKhol2RvtwfTcwlq+ubeyocoOlOib0K0LjrbN
         z0P4PSjFvPZUIrt8iLO21M1Pb+OymZDKAjqSpnaVKd92l8Pg631Yei/wa+DlD7wF4RHz
         Qd13Z6OJKU5XOw3FueSYuWEwRh510bsH5z4txKUCPTW0BiLssAxlvKyadT7tS05Ix51l
         hGePZcGZgo5olbrFMrM1YmrM4wqH4ptFma6V2T3PT3BHUVdgcIld2fRNyB4oIzRQu41v
         vIgfAeQ+T3aonLesby8cBIvFkhbDsRAAdCCcCB6Tjhzv3JVJUFGrhe1uO0cYpHboPUFh
         CdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778805446; x=1779410246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kzbLbrBxTj3Os65r+VG8KyOSku+VVjAs9NkmdJFxbWQ=;
        b=HoeTCdbmwIWvNiav5+44YBBPjTqy2KXVWSiZZJtKT94xPCFHBEqZ6+6u8nN4fy21l5
         vliQ3LzVGOtFp4Q7Yg8JQeIyfVONE5Shu+mSlh+D4IHfIJEUQZ30YMtGDPO2Y8p8tf8G
         xcRyI3DOGyidhvARjvq4aYvxt6wrfUSuASR0feRg6sPqAl2ho32ZEzxCa5WWxohK1B+z
         RkICEcqBvcmfKXSKBmIOlAk7rt76uiPvXOGJpMvd/KiD7gZZB9qRlPMa1KwmA+X56PGq
         dMKNzQUoiaSgwKnP9Pybfk3pEacu8C4plF/mHhtu2B/WB8DFUMj4Mzb7prtLZR697auv
         dW5A==
X-Forwarded-Encrypted: i=1; AFNElJ+h+DwewSJLxfnCN3BpftwRN6hij2QH6MOtRo+PFEFur/9R/nLakd650T6mcNA3LAMArX27RQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyG8n9hG4RGQ936x2HxHAB7IkqVg8OzZ1/ZkN2SBvjCgPvZ82NY
	xaj9FcNK+yA6LAjYLeWzofeKB910jcXow3kSaxedJS1q+3UmH4C7ezdXG1fGsJ+iT0s=
X-Gm-Gg: Acq92OEABh9SEsaL5zAWSfnTxFxogMFTUl4yTR9Pz9lrBz10iY7Jz4iMS+6xFAW0TPG
	9HRYRJ43RCJgc7TaeM2qBtu9+WfdqHaNm9a+RJNAilJb01jb5zZ2ix8yeWiXlhO7nm8E7z9pubX
	jbQCwqAWYiESrs/6FMSkGC1/dxG/4g56TeNUlfBirwrK8ziGaenIxDVhy97SY8OCOOG0p4YCGlr
	CwugZgIYgjgCdceaFqJ6A4SvGDnNipXQYjigJMRoyQoXl8jBtLEpS1HY/qmNKUI7mJ7i75aWt2I
	7S845RvJ6zbzTraPao5G6XlnPlcuSMKcG0lC5jF3a4FNjGzzK8EXs7k70mY8/Teg6oR/QbM0tGX
	3IzjAG8KptEJHqppzY+vQST+pYMScqrD7iF6Z0QAckMCWT3qCaTQUPFhvJcp09nWUtkxRGtVwEu
	0/80n5htKIWiV5nAXwViXVyJ8EINfoFwQAbGcfwDElHvcsGHOfbr8=
X-Received: by 2002:a05:6214:5b88:b0:8ac:b3fe:68c4 with SMTP id 6a1803df08f44-8c8ff636dc2mr94109806d6.36.1778805445660;
        Thu, 14 May 2026 17:37:25 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c16366csm36918236d6.40.2026.05.14.17.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 17:37:25 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kees@kernel.org,
	rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v3 1/5] liveupdate: skip serialization for context-preserving kexec
Date: Fri, 15 May 2026 00:37:18 +0000
Message-ID: <20260515003722.938123-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515003722.938123-1-pasha.tatashin@soleen.com>
References: <20260515003722.938123-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_173727_057639_75C7AC6A 
X-CRM114-Status: UNSURE (   9.44  )
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

A preserve_context kexec returns to the current kernel, which is
unrelated to live update where the state is passed to the next kernel.
Skip liveupdate_reboot() in this case to avoid serialization and prevent
sessions from being left in a frozen state upon return.

Fixes: db8bed8082dc ("kexec: call liveupdate_reboot() before kexec")
Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a43d2da0fe3e..dc770b9a6d05 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1146,9 +1146,11 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
-	error = liveupdate_reboot();
-	if (error)
-		goto Unlock;
+	if (!kexec_image->preserve_context) {
+		error = liveupdate_reboot();
+		if (error)
+			goto Unlock;
+	}
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
-- 
2.53.0


