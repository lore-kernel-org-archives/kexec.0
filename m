Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B650ECA101F
	for <kexec@archiver.kernel.org>; Wed, 10 Sep 2025 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KrTGWU5jgNL2Yex8GuGQCQTTzsuf4kgKWTk1ruEDz8Q=; b=r/fUFbHklfw5ess3we7jp7jdnD
	LtXj3+X4+T2O5HITXUWjDiMapJ58TJq0bY2faOdevL/BsBCvDP1+aHjDEgQuPVt4r2ky+KNHM/sFX
	Z9MEiZMYTqbKhSiukkVEia2RaGQIQwRwVhTMNPopxA8aslkHBOHzO6xzQQeAA4mOxyUZtDGMCH+GH
	1OKpSyS0WKOfip39gcuYbQCbPsi8cYFsLmiciMt2VhubsUnok3rwz4lkGyG3U3RFOWgExzJqD+sf7
	Kz6nr7ogop1X+F8BTzK7TQVsilEgwM3YHX30+sS5uKcQQpt5CdaPmc0wadd+MPPFRt5eoTqX75AAd
	jnJzYhVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNjG-0000000FVP9-0SJJ;
	Wed, 10 Sep 2025 16:31:30 +0000
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.12.53.23])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNjE-0000000FVNK-0EXM
	for kexec@lists.infradead.org;
	Wed, 10 Sep 2025 16:31:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757521888; x=1789057888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KrTGWU5jgNL2Yex8GuGQCQTTzsuf4kgKWTk1ruEDz8Q=;
  b=VUh/jlCH8CWrKMPifSA6MQuh88EsQ+vshAaeuIQzfBboaQCQEkRLCyXE
   X4eqFsz6WoQE+ximmxHPDuMaug5tgSReutYQcLJ4CJraCGgFvWXg7/3qZ
   ivGL1XAvqcVePX1dyB3N8b2djtAT/V1iVK+15mbN/TmeybzH+2Q57lfYe
   Ngacsra9ajLUapMMy0bVIeLKUOpe39zWF8GCYOlqHLsjgK8SeQ+rDkCf3
   dnIT0aeX3RVuFYV23jlvhBhrZX9VIIfSVPET67g0ionR2KCdd+skhvXt3
   MpntFtVywavDFZlbTMb6s358NXUZoALzm5oJhnURzA5n7Oys1Ldmv3l+h
   Q==;
X-CSE-ConnectionGUID: h9F3vohiSnSI31kY0ffszA==
X-CSE-MsgGUID: BLs8tLXxSh+45GlVNn7aoA==
X-IronPort-AV: E=Sophos;i="6.18,254,1751241600"; 
   d="scan'208";a="2659304"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 16:31:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:32617]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.248:2525] with esmtp (Farcaster)
 id 03010344-ed65-4286-b33c-177a1cba4abf; Wed, 10 Sep 2025 16:31:24 +0000 (UTC)
X-Farcaster-Flow-ID: 03010344-ed65-4286-b33c-177a1cba4abf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 16:31:23 +0000
Received: from 80a9970eed1e.amazon.com (10.106.101.45) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 16:31:23 +0000
From: Justinien Bouron <jbouron@amazon.com>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek
	<pmladek@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, "Marcos
 Paulo de Souza" <mpdesouza@suse.com>, Alexander Graf <graf@amazon.com>,
	Justinien Bouron <jbouron@amazon.com>, Steven Chen
	<chenste@linux.microsoft.com>, Yan Zhao <yan.y.zhao@intel.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: [PATCH] kexec_core: Remove superfluous page offset handling in segment loading
Date: Wed, 10 Sep 2025 09:31:16 -0700
Message-ID: <20250910163116.49148-1-jbouron@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.45]
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_093128_156228_7143DF35 
X-CRM114-Status: UNSURE (   9.89  )
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

Kexec does not accept segments for which the destination address is not
page aligned. Therefore there is no need for page offset handling when
loading segments.

Signed-off-by: Justinien Bouron <jbouron@amazon.com>
Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
---
 kernel/kexec_core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31203f0bacaf..7d4c9eebea79 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -761,9 +761,7 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 	while (mbytes) {
 		size_t uchunk, mchunk;
 
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 
 		if (uchunk) {
@@ -815,6 +813,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
 	mbytes = segment->memsz;
 	maddr = segment->mem;
 
+
 	if (image->segment_cma[idx])
 		return kimage_load_cma_segment(image, idx);
 
@@ -840,9 +839,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
 		ptr = kmap_local_page(page);
 		/* Start with a clear page */
 		clear_page(ptr);
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 
 		if (uchunk) {
@@ -905,9 +902,7 @@ static int kimage_load_crash_segment(struct kimage *image, int idx)
 		}
 		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
 		ptr = kmap_local_page(page);
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 		if (mchunk > uchunk) {
 			/* Zero the trailing part of the page */
-- 
2.43.0


