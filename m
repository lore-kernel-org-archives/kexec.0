Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484F7CA0EF8
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 00:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JrfIpk3vI2iEZnlCjBatj++PBwaKwr0n+7Op9hx7NqM=; b=iP7CyewrQR0C77UMWuEeFWjiI6
	sGYEHa6HCiC87L/GcSZqhENthIWwxcHwDHAgMnh5SR+9pG3g/h7ZoR9F7gtXIemGond7+dya9BRaw
	135mOiHSRtauqMiJmahtq+Zhr1QdKFxPkoCpN1NsbZOhbaYomf/bc2ADjBQ7IpWZ/SsbSnuhSCEXc
	GXBrOrSr2bpOi3a4esUxv56t42shbG66s9VZWFg2O2wSjs/BApYE/x3bWdR/MxQjxbBCRmI0mDiGE
	HDF4gWhb9p1UXbIHzVF8fIVssFiv/2HgLvIcQ2NR8fCwpAleg2rW8+fkC/VeSSA6/xdQR2dK4xaky
	WDqKAi8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoX4R-0000000BzyU-1Vd9;
	Wed, 20 Aug 2025 00:52:55 +0000
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com ([44.246.1.125])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoVgB-0000000BqZ3-2A9P
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 23:23:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1755645827; x=1787181827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JrfIpk3vI2iEZnlCjBatj++PBwaKwr0n+7Op9hx7NqM=;
  b=ZFCz0wVGn5YtrmB95/mMFSiQ13thGw4mcmFRNOdtztLgTSucv9g77thc
   Xk3I8GH9y//1ZZpBPB/Bbvre7r3mPjgKI0U+2MK10v4oMuADNB7gWcF3F
   nYJdcYUTQwcSEgmLO1ZhuNbfR86giprqs12wDe70dNGXCCk26xEDtFAg3
   RP6PPwD6eBVLm3ykTeFqnXsdx0mYaRvGdIX8nBPS9ND6gsb4rOEDwKnNA
   vJ+Gu7Q8D64MNDjZFTyKni5gCfPE2BYXBNKN4paokAeQawfEk8KQ8TUeV
   IdBZwpvEB9sCar3SbUeJhwU8x5gV2+J0Oj23JMxRFzYp39D80Jx44J35X
   w==;
X-CSE-ConnectionGUID: A3CnChY0S4G6zO7ySKE+3w==
X-CSE-MsgGUID: rIVmzT6GRpyTTXD+abL8SA==
X-IronPort-AV: E=Sophos;i="6.16,202,1744070400"; 
   d="scan'208";a="1404456"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 23:23:42 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:23645]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.67:2525] with esmtp (Farcaster)
 id 28c909b1-13a1-425e-9469-766521fc37e4; Tue, 19 Aug 2025 23:23:42 +0000 (UTC)
X-Farcaster-Flow-ID: 28c909b1-13a1-425e-9469-766521fc37e4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 19 Aug 2025 23:23:42 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Tue, 19 Aug 2025
 23:23:40 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf
	<graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH v2 0/2] efi: Fix EFI boot with kexec handover (KHO)
Date: Tue, 19 Aug 2025 23:22:44 +0000
Message-ID: <cover.1755643201.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_162347_652635_9C717BED 
X-CRM114-Status: GOOD (  13.40  )
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

On a side note, I have noticed that `kho_populate()` calls
`memblock_set_kho_scratch_only()`, but the `kho` cmdline option is
not checked until much later. Therefore, memblock will use only the
scratch regions that were passed from the outgoing kernel, even if the
incoming kernel doesn't explicitly want that. I am not sure if this is
done on purpose, but in any case we can discuss this in another patch,
as it is orthogonal to this one.

Main Changes in v2 (smaller changes can be found in individual patches):
    - Introduce is_kho_boot()
    - Replaced manual loop with for_each_mem_region macro

Evangelos Petrongonas (2):
  kexec: introduce is_kho_boot()
  efi: Support booting with kexec handover (KHO)

 drivers/firmware/efi/efi-init.c | 28 ++++++++++++++++++++++++----
 include/linux/kexec_handover.h  |  6 ++++++
 kernel/kexec_handover.c         | 20 ++++++++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

-- 
2.47.3



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


