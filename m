Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888B2CDE019
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 07:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jETUsrNOtIYAIHLU5+yC9wox6nnk6e6+1rYc5xFt4DE=; b=xZV59vbDN9pC/bhlra4qaPOyol
	rlA6fv3Nh2ExEnspFj+PIqEmdHbHzK2lymWBBhLjEycsProGLgI63/lfJL1ZSMPm1juuRlK/o3JzC
	YhMZe5vkFZEYUGvOP1BCdqiuyHODaPMeku69QX4saG+IElaKB6pHkuyboCv23YO+6KdSu6e9Q/dsU
	BcAgPRXoPEievrw1WEZpo3DXpB/ei3ZX2FOyU6lB2l4YkhtosdytBVnDKEdhj+IlehqxZwxkvbZ8T
	FM2i3FoCa3T5u/10l5x9K7bjqUFHz/KJiiTXSv+EZyC+KCdE7ZQ/5M3NBa3oGYEPsm+q2IUq16vca
	if1NANtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJoGE-0000000BkvX-3dZt;
	Fri, 14 Nov 2025 07:30:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJoGB-0000000Bkuy-2VIr
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 07:30:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6BFE341B1D;
	Fri, 14 Nov 2025 07:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD36C4CEF8;
	Fri, 14 Nov 2025 07:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763105418;
	bh=ofHq5p9Z3RmRzcDHoqIGOqiKwshUcCL3Eo8rh8N1eow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dall0xEicEsJMWwgN246NGUG4Wt2t1VsFM3lAbgskABkVYqL1yPKR9ohMLRjTEbgl
	 tOnE84T+jml7UGQaiA6+qdmCUCBW9t5lNIranNvkvTLuIH65oNGHt51yDu0lqkJVS6
	 kN34kkvGuzaxDIws+ZwdwOBVQuvj55/E/6rDCUx+nKohXQi2+qcJhgLpcbfho1Ep8r
	 cPQC7bj+ktc8Kt5wWtbCy2LZiKLVapRNbbTcZBxCyTmocKbHflDyxR/OTFgHkqadeo
	 NkwzniLBj861/jzwgronYdq5Eh6kVGynd+ps9lYO3/EpVYIg13iY8xZbYtIeR+pNXA
	 z78J7/QWR2USg==
Date: Fri, 14 Nov 2025 09:30:11 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, graf@amazon.com, pratyush@kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] liveupdate: kho: Enable KHO by default
Message-ID: <aRbag7qR9OVNAQXN@kernel.org>
References: <20251110180715.602807-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110180715.602807-1-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_233019_662703_70708EEA 
X-CRM114-Status: GOOD (  14.04  )
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

On Mon, Nov 10, 2025 at 01:07:15PM -0500, Pasha Tatashin wrote:
> Upcoming LUO requires KHO for its operations, the requirement to place
> both KHO=on and liveupdate=on becomes redundant. Set KHO to be enabled
> by default.

I though more about this and it seems too much of a change. kho=1 enables
scratch areas and that significantly changes how free pages are distributed
in the free lists.

Let's go with a Kconfig option we discussed of-list:
(this is on top of the current mmotm/mm-nonmm-unstable)

From 823299d80aa4f7c16ef6cfd798a19e1dfe1a91ab Mon Sep 17 00:00:00 2001
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 09:27:47 +0200
Subject: [PATCH] kho: Allow KHO to be enabled by default

Upcoming LUO requires KHO for its operations, the requirement to place
both KHO=on and liveupdate=on becomes reduntant. Let's allow KHO to be
enabled by default, and CONFIG_LIVEUPDATE can select this CONFIG.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/Kconfig          | 8 ++++++++
 kernel/liveupdate/kexec_handover.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index d7344d347f69..25c9a4d7781f 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -63,4 +63,12 @@ config KEXEC_HANDOVER_DEBUGFS
 	  Also, enables inspecting the KHO fdt trees with the debugfs binary
 	  blobs.
 
+config KEXEC_HANDOVER_ENABLE_DEFAULT
+	bool "Enable kexec handover by default"
+	depends on KEXEC_HANDOVER
+	help
+	  Enable the kexec handover by default. It is equivalent of passing
+	  kho=on via kernel parameter, and can be overwritten to off via
+	  kho=off.
+
 endmenu
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 568cd9fe9aca..23a3df297bb3 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -51,7 +51,7 @@ union kho_page_info {
 
 static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
 
-static bool kho_enable __ro_after_init = true;
+static bool kho_enable __ro_after_init = IS_ENABLED(CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT);
 
 bool kho_is_enabled(void)
 {
-- 
2.50.1

 

-- 
Sincerely yours,
Mike.

