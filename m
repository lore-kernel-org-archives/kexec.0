Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276AFCD5BD1
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 03:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hKDMR5TAGwiz4Z0dhIjLc6hZgq3gL98geqqMieh10P4=; b=OhUV2gbTLPmaTBFkP1SFbohOcM
	dJKrMsupytiSXunirmxPp1YIHxCvufVdirK7AXYIdkb4r8kc2FujPTehD/2XMVchMsD2ffreC5meK
	E8MfCOK+qSSoJny+AcyUVBwrxna3pLbIEnBHO8VWDskI8yKEF/71vpSv3tQY8XGGyfjpGWxtEc/Nx
	MxYF3xd0wqUU5jAgB67Cnnb1scRNQ/RIQFGlUyfQMkkz2HKbx3dFWWkmky2EKkHFTZc0NQ5vzzsHl
	QdbMD+AsgNfKP+zuZeZr4lCXWfs7nRqHP3E76Dqq2ZNS0uSdyNGwdy/fuP5N/Z1q2gaiSgoHwGQm2
	RVkeQJeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4yg-00000003FLG-1mGk;
	Wed, 27 May 2026 03:30:42 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4yd-00000003FIV-05Kj
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 03:30:40 +0000
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-841882f8f4bso1399522b3a.0
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 20:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852638; x=1780457438; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKDMR5TAGwiz4Z0dhIjLc6hZgq3gL98geqqMieh10P4=;
        b=pozrrvGzOPZuO3lWdsinLPtBiAXzRM2WRhuj98N3QKlDsiW6A34NrE0js5hSAzckm7
         YilZnzzrOuZarkjBK7Xm6BFw7AshHtd2HUKSeIUrnNj/y3TTToUOiG8GQ3tROxthUTSM
         StpGZgL7GMKfixaROwc0TyW3ZSqpVjOK5EhohgLFTJkRL9U0s3reQRxTr0Re6Hpj6UtB
         w8J+gYaNxunVFFX43J8BUSsptlSTsoDVb/iTnUmLd/KXPppeaUJx06FHWf1+eqJRsMrT
         8YMdUd3m6ci5HcycF9aZe5xkJCe/YI6hifPibp8Ir9U4EFMdflch8j/fO3a1hFypzjDB
         YV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852638; x=1780457438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hKDMR5TAGwiz4Z0dhIjLc6hZgq3gL98geqqMieh10P4=;
        b=ddoCdCeHknKkyk/r2dYg5nb6Ja9kl7JZt40+v20woEgExGe7fitvedVf22vgb31bLG
         B6QJv5mRpVAjZyATyezNwQihqMs//04/wT775KmTKQ6ZzQJYNH3N3g6XZFg2qivz9PJp
         XW904aiIG8WClBvBewRBGJ2a8S1APQc2rzBWEVzdeXm+6MwIphEj51wJuAw+Jr3oATMD
         uA6kHdZA6Mnr/FaeXCmYxRojtWHh2ghPS4H1N+o1cHNe8T6NWt0G999EpUz2MWnNS6rh
         1Bymn0YN5AE7U5wft29UXLTLc/JKsLE6lDn70E8+RLZx922GKGzuYr3kvDAIFdx03RRw
         8JEw==
X-Forwarded-Encrypted: i=1; AFNElJ9by5+jPEDxGLRcddXnXg2Kr9Ts3BtTAVBgmDfzyEvaEcyADdzgwgeRImAk6MMCx857JmnIqw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzZeCyhGQ+sKkl30nAPohqsBmZ5yVlCWPzB6Tz1ggmCq9yQQQOl
	HKzQQJyrfkZIgOJw1iX6rVXsgn9M1GaB9DwRmumw8cRhx4p2gOtmuPN3
X-Gm-Gg: Acq92OGcwW0mEFnGtLnOuafLSMe7UVGHyU7Z6qLigczw6+ctEtH0Z30npVB26HNQ7uP
	0VEpC3seQDC3fFUK5mMMrwNO3jIlK/NLaUrQJwrmUbswTJQLWltsOvgAuS9O6owvtkpIoFWYMVz
	Sqy6LZFbVEKOOnOuvXK0wZLRR7GCkYhtMgrhZttlDOY26lyakMWmtLFJOoeazffbpt/0PtPijfo
	oaXflKFADdl1RmbMFcAwwy4Xe/tMIHeRWBGiPtmUmOvzyi+noGJDKja00ui+VPUqtyiZ/lXTqI5
	vvpBPk7Ir5DZCONrIHFVKr3M+KfXBcB9FZwjGz8yTr0gDTVjZUN+bMGQ47mJv7hkkyRMP9iAZlW
	AcwkEhPsOaQakqPldOA86llzzNX7WrOJtKdkX8ltTlGJs9rQsScH/oIt4grRS0BFv3YX5nIBGBw
	MuVJS1EPd57+0uhVX3Dg0bO20jQZSdeyysD7QV
X-Received: by 2002:a05:6a00:1d9e:b0:835:38db:82f6 with SMTP id d2e1a72fcca58-8415f69ea9cmr20057592b3a.36.1779852638276;
        Tue, 26 May 2026 20:30:38 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:30:37 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 06/11] of: reserved_mem: add dumpable flag to opt-in vmcore
Date: Wed, 27 May 2026 11:29:12 +0800
Message-ID: <20260527032917.3385849-7-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_203039_085646_3CB184B7 
X-CRM114-Status: GOOD (  13.13  )
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

From: Wandun Chen <chenwandun@lixiang.com>

Add a 'dumpable' flag to struct reserved_mem so the kernel can decide
whether a reserved area should be included in the kdump vmcore. Most
reserved regions are owned by devices and do not contain data useful
for kernel crash analysis, so excluding them by default is the right
behaviour.

Reusable CMA regions are different: pages in a CMA region are handed
back to the buddy allocator and may contain key data for crash
analysis, so set dumpable to true in rmem_cma_setup().

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/all/20260506144542.GA2072596-robh@kernel.org/
---
 include/linux/of_reserved_mem.h | 1 +
 kernel/dma/contiguous.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index e8b20b29fa68..55a67cee41ea 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -15,6 +15,7 @@ struct reserved_mem {
 	phys_addr_t			base;
 	phys_addr_t			size;
 	void				*priv;
+	bool				dumpable;
 };
 
 struct reserved_mem_ops {
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 03f52bd17120..eddec89eb414 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -579,6 +579,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 		dma_contiguous_default_area = cma;
 
 	rmem->priv = cma;
+	rmem->dumpable = true;
 
 	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
-- 
2.43.0


