Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ACAFF5104
	for <kexec@archiver.kernel.org>; Tue,  7 Apr 2026 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fwF/+V8vSUXyDGHI+Ez5ilMcTLluahXcPGLTKcZ4SJQ=; b=DlCBWXeCrzOYoRIYzRWWGGqlrg
	dz2DZVvd+jI4/oqfKy1RHSkDNjE1Y/+BDt17sLxRmfKq7qyQUfIolWegQpGxB4CTNx3cGqdgnv/4t
	GGAMXPbKypuR91XCODo6E8QmzSO15iL6uE9lonjPsWbw/siFgO5EVPpMLLTwxf4yR4ZVbd8lH7HJc
	2g7+n5whL/u6pkkamqp1s6Nh1pTsQ4Pvz8UNh1A2fgp8Esf/J6phXYqbwtAMqeW8sjjNG3N6PddzS
	p1LFJMwKldCN5luPmhxsZ5TbRwxOB11VGuLFM29yTZu/dmIGGU9xlR1CxlVB3qKPqBGu3tfp96vvY
	EPict5Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA81X-00000006fqP-1NvU;
	Tue, 07 Apr 2026 15:07:27 +0000
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.35.192.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA81U-00000006fpY-1DvZ
	for kexec@lists.infradead.org;
	Tue, 07 Apr 2026 15:07:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1775574444; x=1807110444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fwF/+V8vSUXyDGHI+Ez5ilMcTLluahXcPGLTKcZ4SJQ=;
  b=AxBaZFqgcZoymDHuNyloKxJf/uXVln0GPpcXR1us4Sa09AnQ42N6CW/4
   SWGzD2sqYhK4RxUy72dOfhtxTpBuLF1e+7pPTxxK+VrCk3YPJ1kUP0x1+
   i56FmvYdInDIUg634q+gQve09CQc7AW1YSyxS79T8/aDmEloFys+ziCUZ
   bI1yZoGJyZWvgTUMrYGAx72OtLi77toC38sb8e+ctesAJJkeYkw9+tVq6
   +6HjB3Yh9LQuss17aTTtwHFBfhhTMDKA7WKYN3eGD0bmKceoaDat0bo49
   15VJSSFcdAuME4YRmb49noCi1P2up8k2A5jXvF438czfyg+NcgaxT3L5a
   A==;
X-CSE-ConnectionGUID: No09qL5zSY+r3KzHCgll3Q==
X-CSE-MsgGUID: rDHiqfZOR+6EXwRVTo2XtQ==
X-IronPort-AV: E=Sophos;i="6.23,165,1770595200"; 
   d="scan'208";a="16535437"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 15:07:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:19288]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.23:2525] with esmtp (Farcaster)
 id 4bfd4df0-b04f-448b-b697-624a06f2ef88; Tue, 7 Apr 2026 15:07:18 +0000 (UTC)
X-Farcaster-Flow-ID: 4bfd4df0-b04f-448b-b697-624a06f2ef88
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 7 Apr 2026 15:07:18 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 7 Apr 2026
 15:07:15 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, "Mike Rapoport (Microsoft)"
	<rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>, Alexander Graf
	<graf@amazon.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav
	<pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [PATCH] of: fdt: skip KHO when booting as crash kernel
Date: Tue, 7 Apr 2026 15:06:33 +0000
Message-ID: <20260407150639.69923-1-epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_080724_421629_FB4124ED 
X-CRM114-Status: GOOD (  17.31  )
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

KHO preserves state across kexec by passing a KHO-specific FDT pointer
and scratch memory region to the incoming kernel. These point to
physical addresses in the outgoing kernel's memory that the incoming
kernel is expected to access and restore from. This falls apart when
the incoming kernel is a crash kernel as the crash kernel can run in a
small reserved memory region. The scratch regions can sit outside this
reservation, so the end result is quite unpleasant.

kho_add_chosen() unconditionally propagates KHO properties into
the device tree for all kexec image types, including crash images. The
crash kernel then discovers these properties during
early_init_dt_check_kho(), records the stale physical addresses via
kho_populate(), and later faults in kho_memory_init() when it tries
phys_to_virt() on the KHO FDT address:

Unable to handle kernel paging request at virtual address xxxxxxxx
...
  fdt_offset_ptr+...
  fdt_check_node_offset_+...
  fdt_first_property_offset+...
  fdt_get_property_namelen_+...
  fdt_getprop+...
  kho_memory_init+...
  mm_core_init+...
  start_kernel+...

kho_locate_mem_hole() already skips KHO logic for KEXEC_TYPE_CRASH
images, but the DT property propagation and the consumer side were both
missing the same guard.

Fix this at both ends. Have kho_add_chosen() skip writing KHO properties
for crash images so the stale pointers never reach the crash kernel's
device tree. Also have early_init_dt_check_kho() bail out when
is_kdump_kernel() is true. This way even if KHO properties end up in
the DT through some other path, the crash kernel will not act on them.

Fixes: 274cdcb1c004 ("arm64: add KHO support")
Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---

I think we should backport the fix on KHO compatible versions (6.16+),
hence the "Fixes:" tag. Tested on an arm64 system.

 drivers/of/fdt.c   | 3 +++
 drivers/of/kexec.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 43a0944ca462..77018ec99fc8 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -926,6 +926,9 @@ static void __init early_init_dt_check_kho(void)
 	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER) || (long)node < 0)
 		return;
 
+	if (is_kdump_kernel())
+		return;
+
 	if (!of_flat_dt_get_addr_size(node, "linux,kho-fdt",
 				      &fdt_start, &fdt_size))
 		return;
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index c4cf3552c018..b95f0b386684 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -271,7 +271,8 @@ static int kho_add_chosen(const struct kimage *image, void *fdt, int chosen_node
 	if (ret && ret != -FDT_ERR_NOTFOUND)
 		return ret;
 
-	if (!image->kho.fdt || !image->kho.scratch)
+	if (!image->kho.fdt || !image->kho.scratch ||
+	    image->type == KEXEC_TYPE_CRASH)
 		return 0;
 
 	fdt_mem = image->kho.fdt;
-- 
2.43.0




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


