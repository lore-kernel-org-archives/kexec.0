Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB94CA0EEB
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 23:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S+gS8f64vE5JkLxSnB7ir6Lb0kF6iQE9gWFgqB32eCo=; b=Q89mNUB+TkFeKvW+Vk0utvz7wf
	/B0cA6mkKPUjgggBMXvLH1NiKXbv4Md7Ojb+DzBgUQeAK8P8ELKIDeTGtVXRlQUfY+0zmXMwg4FZH
	uwCovG1pR1L6wRdB/fJ/nMyadqIMoN2/ubvSi7jW29pbtqoj0e5BLC5Fs6MOgBsJOwWL1gtNL/U9I
	foWW6EkpF9fdru8d9G2vjrUqBraQNZac8jA7UOM/zwhuy5uuZ3zfFikjTr9BUgB18hl3yMgO6mU46
	4Ww9uiFpiQZ/Ndv5qxlAIkq0kopCoun0EgkT/sUgXJSsU0oU0tSQcVv5vw3smgPYhvracz9cEH2IA
	+qDqklYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upEWJ-00000000uhE-1DFK;
	Thu, 21 Aug 2025 23:16:35 +0000
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com ([44.246.77.92])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up9ZG-000000007vr-3A59
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 17:59:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1755799158; x=1787335158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S+gS8f64vE5JkLxSnB7ir6Lb0kF6iQE9gWFgqB32eCo=;
  b=SczNh8m5J44AKBrxdS13maQJdFwLv3knGxu6sLDXXeMowZASCA/TYBYn
   yqrenQiYV+bcbZ3GI64Z1ec3tVRsOBmPf0dfhnPNSrPGAq8jrSotVHjoQ
   tk8tv8j14V38sMdZaRY9aQyoUgfMlCRt8O9qtHo4aoQaUU01TjMSKScfC
   a1UrujdU32zDbT1j0pKr7DndiusotW+WQ46M6xPd3kS1nJtddIcnEakWq
   SFqqSX/yBfvbsY/V+wjFreDdMrrWejTL5sO93bwWw78HPovayXPLCxin/
   DNZ5y1HpDJvAyFfcGyBRNSDICOz2OiJCs0t0Yzwmg6mNk1pHGW+BYK7c8
   A==;
X-CSE-ConnectionGUID: K8Hohe32Qp+Vv4T80IzDyQ==
X-CSE-MsgGUID: xyRxENLgS6O/spnd+SQBkw==
X-IronPort-AV: E=Sophos;i="6.17,309,1747699200"; 
   d="scan'208";a="1570660"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 17:59:14 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:34303]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.64:2525] with esmtp (Farcaster)
 id ddd70eb3-6448-4aee-bf33-ff8d888990ad; Thu, 21 Aug 2025 17:59:14 +0000 (UTC)
X-Farcaster-Flow-ID: ddd70eb3-6448-4aee-bf33-ff8d888990ad
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Thu, 21 Aug 2025 17:59:13 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Thu, 21 Aug 2025
 17:59:11 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf
	<graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH v3 0/2] efi: Fix EFI boot with kexec handover (KHO)
Date: Thu, 21 Aug 2025 17:58:58 +0000
Message-ID: <cover.1755721529.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_105918_898361_B87E3B21 
X-CRM114-Status: GOOD (  11.32  )
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

This patch series fixes a kernel panic that occurs when booting with
both EFI and KHO (Kexec HandOver) enabled.

The issue arises because EFI's `reserve_regions()` clears all memory
regions with `memblock_remove(0, PHYS_ADDR_MAX)` before rebuilding them
from EFI data. This destroys KHO scratch regions that were set up early
during device tree scanning, causing a panic as the kernel has no valid
memory regions for early allocations.

The first patch introduces `is_kho_boot()` to allow early boot
components to reliably detect if the kernel was booted via KHO-enabled
kexec. The existing `kho_is_enabled()` only checks the command line and
doesn't verify if an actual KHO FDT was passed.

The second patch modifies EFI's `reserve_regions()` to selectively
remove only non-KHO memory regions when KHO is active, preserving the
critical scratch regions while still allowing EFI to rebuild its memory
map.

The patchset was developed/tested on arm64.

Main Changes in v3 (smaller changes can be found in individual patches):
    - Condition is_kho_boot only on the existence of a KHO FDT
    - Add Reviewed-by/Acked-by

Main Changes in v2:
    - Introduce is_kho_boot()
    - Replace manual loop with for_each_mem_region macro

Evangelos Petrongonas (2):
  kexec: introduce is_kho_boot()
  efi: Support booting with kexec handover (KHO)

 drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
 include/linux/kexec_handover.h  |  6 ++++++
 kernel/kexec_handover.c         | 20 ++++++++++++++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)

-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


