Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028A9D5E14E
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vSY7wQKntypHc5vZ+H2tOs9E59MY74VNKOCe0oScgtI=; b=OWrVpNkNvjEMPVq4NnkblysX/k
	GASjnKcktSIPPDMhgqfLv08RVKmsnCrWsbUZUvMRHdgqIrHnb7ylKYYGMLrEn/UewNsIgBkNiqZrm
	/ejsHYCig9xrIxAHIYkryVDOLGuVpKQ+Pgzys8q4ILZPD70yJ1QW8ZYGJzVyKl5t2vj7YZpiWbnGz
	NYcIkYllOz9N1P5UwE636cTwFv9rwITe3egUwZIAanUVS8WKc2NmD1H26JWDzFVifDpYE2eyzeQif
	MPvlHcUvwdkZ0EcoMrSlbcya2bWY0KuBmffKwkUPmSpvkJFTHkf2payH2nc1DXrENbFs4c3TfdjO4
	p810Tw2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVV6I-00000005FfB-04Xl;
	Tue, 16 Dec 2025 13:28:26 +0000
Received: from esa4.hc555-34.eu.iphmx.com ([207.54.77.171])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVV6A-00000005Fb1-2igc
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 13:28:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1765891698; x=1797427698;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gi4khvtwgbMqqNuNGAAzKa3KN3NP/O6F46myC8nPl94=;
  b=WjqAoEW9+uQqJKPd3bc2Q98m7kow4mXJAQOKuf7BWHAdfswu7B85AxFE
   IJ2SavfAFRC+xFQr3z9qfE7+bSyyq7aji4ZrNEcv67e/oKrUHZmgrzpW6
   r40dsueXzAx/fOJjUsH7xyBp9Bh29VUA2Rg/gancUTt30gmmRo1eBNtUt
   cojnGA4IDMdEDiMbS21VXH2jxtQwjkg44nWlRwX+8wTmpYiF8lLpb6dLu
   dEPqeip3sTvgYe8XxDxYjWwMYVeXlg3aQvQ8dVOHgtYtYB/EYk2qZkr2n
   ci9VIUN2f1ksrrl0mOrjkI6hHAgETxXGBZjqjp/A2WnBs98HLid9ZNkDX
   w==;
X-CSE-ConnectionGUID: KabgYPC0QN26nMkiJh7SEg==
X-CSE-MsgGUID: Gc44OxbVR62XIEIN6hPiMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 15:28:14 +0200
X-CSE-ConnectionGUID: A/1ufcHVSFuB9DQOz2R8JA==
X-CSE-MsgGUID: NeFqLJ+vQbqDHa0Fo1ziCg==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 16 Dec 2025 15:29:22 +0200
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Tue, 16 Dec 2025 15:28:12 +0200
From: Pnina Feder <pnina.feder@mobileye.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 0/2] vmcoreinfo: support VMCOREINFO_BYTES larger than PAGE_SIZE
Date: Tue, 16 Dec 2025 15:27:59 +0200
Message-ID: <20251216132801.807260-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_052819_122148_085E39A4 
X-CRM114-Status: UNSURE (   8.42  )
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

VMCOREINFO_BYTES is defined as a configurable size, but multiple
code paths implicitly assume it always fits into a single page.

This series removes that assumption by allocating and mapping
vmcoreinfo based on its actual size.

Patch 1 updates vmcoreinfo allocation to use get_order(VMCOREINFO_BYTES).
Patch 2 updates crash kernel handling to correctly allocate and map
multiple pages when copying vmcoreinfo.

This makes vmcoreinfo size consistent across the kernel and avoids
future breakage if VMCOREINFO_BYTES grows.

Tested on riscv64.

(No functional change when VMCOREINFO_BYTES == PAGE_SIZE.)

Pnina Feder (2):
  kernel: vmcoreinfo: allocate vmcoreinfo_data based on VMCOREINFO_BYTES
  kernel/crash: handle multi-page vmcoreinfo in crash kernel copy

 kernel/crash_core.c  | 17 +++++++++++++----
 kernel/vmcore_info.c |  6 ++++--
 2 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.43.0


