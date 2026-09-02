Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE52AC61DFD
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nb5Q2Se78rLq0fXFEmBN2MgTVK3UgvxyIXmhlVfKh+w=; b=MDD4q1lOGEEFr+/3yIorwl54le
	QWoqMUDqeqlPX9j41O1aU9zc5aNaFwHSyevHah9BmcNjTCvZJ95JQcAazbgGB7yzASh3cqsyqzD0F
	fyWowLW/us+Q9qfOlBCjJcJI5x60RyWNotU4sPr+xuSwGF7qtmagwsxgsjGD+K0pU9QDVHZNPP4B1
	2lnjOLPtKUPa2PIvX5aahRlSQp6M80wnQE/jX2QpItshA5sLo6mxRFfYj/i0QJFMWFJXn93QVd6ak
	GAVt9fgUHyzQ+ZSrhnsyYEF3eN6CIHLuJkgkjILBsNVwsPORAlKTj0FUNlLOjieIGqPPZWGdBTEaJ
	zWa9WE4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fUq-0000000DxPL-3jGL;
	Wed, 02 Sep 2026 07:35:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fTh-0000000Dx8r-43pE
	for kexec@bombadil.infradead.org;
	Wed, 02 Sep 2026 07:33:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Nb5Q2Se78rLq0fXFEmBN2MgTVK3UgvxyIXmhlVfKh+w=; b=CqHuMltFEWzlY6tUajIRmKyXyB
	kgtifvqkPLs10Ce0ec9fVpPR4suVY3Ga+hmMXPlMy5HifXLzJ+mlaFbSluu4IJsthLUnOFx37cIjr
	lasXQ7D1u3xwYDmSPay352xiRUqXgb7+rEhdgDjvFp4cuMw8PDjPLg7fs1QgcjYlm2Q9boqNHBmpm
	GU6r1+qDx9GOT3bX2ZZB1oBuVrk3B7h4eslvrGgK82M+kA4WWInzEkf0NDVo/GKJfTUlAL8hbUYJz
	9OwkwCDI+GhnW9qa0fTkVdxaPgroZKGr+U3bhqAskEw8WGPw9k1LpYHVIZeBcVHu+BSufk/D0+hDu
	fYU+eCUw==;
Received: from mail-pz2-x0a.google.com ([2607:f8b0:4864:3b::a])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x1fTd-0000000BhC0-2pEv
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 07:33:47 +0000
Received: by mail-pz2-x0a.google.com with SMTP id 41be03b00d2f7-cc2085ecd44so201091a12.1
        for <kexec@lists.infradead.org>; Wed, 02 Sep 2026 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334423; x=1788939223; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nb5Q2Se78rLq0fXFEmBN2MgTVK3UgvxyIXmhlVfKh+w=;
        b=F7MXSFNQC7lN7mWAImdv78D2wRBdtBQwMR2uldOxjj6ia1+HqbiETEtq3JdDyTM/v0
         lcuQNxWzjgmkWEpF/lG0MURaQyN91w4pl71OrunzIgV1OSOzSDzkITmriOsW+STQ+wsf
         A0vGwgg5W2Pc4ovLiKX0EnTmQjQk1UzwL1i7m1+BKAothuVKfyfwBta61VA2GBdMhlWe
         44HGpakdWFGan5XKvXWoAD9cMOhHWiCw6s2G8Lo+iy89bSp879oePLdt3cEk/gExs0C/
         DUiwcuk5sIdjLNJzMtBYj2IuyKhrXx8cB4cmrdMAjsfsWRka6pKYOZpLphOD0+pbS3zh
         MB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334423; x=1788939223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nb5Q2Se78rLq0fXFEmBN2MgTVK3UgvxyIXmhlVfKh+w=;
        b=IHMRhiKUcu9fmWUkeSZDq6GowvGbZ9OQ46wVm0wll8nxow47AxCaVIEiCTO2W05NXK
         v9dC9L5qiDBsZ4z2YVSfaz+6l5CVo08Ph4tVCkAVROrMuCKf01vIQzb1A629RoG0E9RK
         +D93K1ph1igrMevX0FYypsuHnVrFimvvIw1kyv8QvlLXtUhDyPeMOIiZPA3aK7j8Knep
         3ULOSc9tkhpFnV+RHv2tMKZvA3XoFOe8WM0E+BYtqeZm+6f91bAI3KcccituiD3cgLRT
         Tp0kkwDnUCMKxkcHr6lPr9nUEjxtp8wD/8UXYMc4jTqw60i5PCivdeU+mkjSndiXNf7Y
         0YpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzU+XxcyQrUPbfn1wyXHT7FBMMS8aT8uvYyiHcyeZE1o2MUexyzi1Q/5EkNCy3gdTOitjl3kw==@lists.infradead.org
X-Gm-Message-State: AFuF++kiBqlwmzOn42xMvKHYqGb1mBFHtdma6yat5K52jhml1WFX/xXh
	qHUnXmPU8c3mOut1Am4sOQEa0MoPmh1Hgkqyn9e0/bhyeRLx6CvrsORL
X-Gm-Gg: AYBFou1wu+NXW6SGBEUoH2cwUdrr15N4x5KTR35uqC72O74dGQ3uZBpW8hnR9Um+lMP
	By9/HwdVyLQbope9mo70YGTqMEh2oGadcGcrTAxyTclHhbJUYF6QhdblLit+7AuaLRt+tHt/TZw
	x3H023UtVlXCHGzulSnCuwnAsERvYEe1Tk84EhMn64P1D2H2Ymz+wRbVM7NY+zUx1qzh41z64io
	auQfqWu4Ov/YvwvnBVT5fBJz4HSlHK7B5RCdvAD+oEgCdAwQrR79biaVqeqCuyJw5PPTyY8dUWE
	ILO645zA49um4IK93MYXuaDyDCTYi++oi7IdyWS6C6rz6ubFPr0BO562tMRIcFiyOwwrJZo+U9S
	70d+xpCtQ8QwOaNllnx+5xZFLwQm1+PQOpmhxjfDNJCZrAq8i02Iq4XKxUekGoKe4N6/MS3PID9
	WmBhrOJ4Dtvlu8zu7As2EzupFfSgw+lfUEQ5a9K2Y8jl6oXdZahp1/L4UjR+mXgzuLrENj4I1K
X-Received: by 2002:a05:6a00:6ca9:b0:84f:77cc:63cd with SMTP id d2e1a72fcca58-85ed4449927mr5116039b3a.17.1788334423379;
        Wed, 02 Sep 2026 00:33:43 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:33:41 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com
Cc: mark.rutland@arm.com,
	kernel@xen0n.name,
	alex@ghiti.fr,
	hpa@zytor.com,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v6 10/10] crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF header
Date: Wed,  2 Sep 2026 15:31:16 +0800
Message-ID: <20260902073116.802752-11-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_083346_158697_0E27228E 
X-CRM114-Status: GOOD (  10.45  )
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

Reserve regions (for GPU, DSP, ...) carry no data useful for crash
analysis. Exclude MEMBLOCK_NODUMP regions from the vmcore ELF header to
reduce vmcore size and capture time. crash_should_skip_region() now also
returns true for MEMBLOCK_NODUMP.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index bd64cf585795..b0e618e13588 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -270,10 +270,10 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	return 0;
 }
 
-/* Exclude NOMAP regions from the vmcore. */
+/* Exclude NOMAP and NODUMP regions from the vmcore. */
 static bool crash_should_skip_region(struct memblock_region *reg)
 {
-	return memblock_is_nomap(reg);
+	return memblock_is_nomap(reg) || memblock_is_nodump(reg);
 }
 
 static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
-- 
2.43.0


