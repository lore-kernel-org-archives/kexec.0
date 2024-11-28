Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F48D70DEB
	for <kexec@archiver.kernel.org>; Thu, 28 Nov 2024 20:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Oqbo5Ux4OrhsJI4uowmEwMruoxJmsMCjMmy8LyWeTpM=; b=q05e5U6d7RvPEiIQmSLp5v3x4T
	r04A95Q14O6OwFpdMYeZ1/NuIZvg2gbdpkGAISkLx/At0lDNbFAjO5VlNSux9YUpRNmbPyAzb3kWP
	xXwLIzg+O2o4X0u6j4wt2ue2C6/2g1cuVUEBxFmhlpsYdQv3xSb5i4JqvK4VS11NgsbJCS0AdG/zA
	TjnL148cSoY4kkpssqUv+2VdYofJR52+Ns3YT84shgkmWJr1LXPHj9wHLgIzUJ0HoALKA9HZ3TpQC
	VrkagceQpi3KPLbtXK73NA+z4Kbo68qC7KNituoXmiOvqMGRw9ZFKHRGWRunWmAtNHb9H8P7ahY54
	1Ubayjcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGkrX-0000000GKiI-2q47;
	Thu, 28 Nov 2024 20:11:43 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGkqW-0000000GKTs-1r9e;
	Thu, 28 Nov 2024 20:10:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732824640; x=1764360640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oqbo5Ux4OrhsJI4uowmEwMruoxJmsMCjMmy8LyWeTpM=;
  b=Bt0/BXLjM9Z455hp0+L1VSjS1OQ/Jlae9+qaZHINid8VIplK0+IRahpN
   uX7T8JQB8ySN1pLJurzTLA9xLdmCTdkDLuyRjIfDfi+coGEHWgsqRzM+z
   F4EaQ7At0drJ2CPrdsvl4ZyyxSGFTQ+3Z3pcTqYFlA4oHioulfYm7dbxj
   g=;
X-IronPort-AV: E=Sophos;i="6.12,193,1728950400"; 
   d="scan'208";a="474023892"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 20:10:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:3078]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.230:2525] with esmtp (Farcaster)
 id e228fb57-fca2-4faa-a153-d79a23d0243c; Thu, 28 Nov 2024 20:10:31 +0000 (UTC)
X-Farcaster-Flow-ID: e228fb57-fca2-4faa-a153-d79a23d0243c
Received: from EX19D013UWB004.ant.amazon.com (10.13.138.62) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 28 Nov 2024 20:10:28 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D013UWB004.ant.amazon.com (10.13.138.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 28 Nov 2024 20:10:28 +0000
Received: from email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Thu, 28 Nov 2024 20:10:28 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com [172.19.116.181])
	by email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com (Postfix) with ESMTP id 82252A0279;
	Thu, 28 Nov 2024 20:10:27 +0000 (UTC)
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
	id 3FB005ED0; Thu, 28 Nov 2024 20:10:27 +0000 (UTC)
From: Eliav Farber <farbere@amazon.com>
To: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<naveen@kernel.org>, <maddy@linux.ibm.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <tglx@linutronix.de>,
	<ebiederm@xmission.com>, <akpm@linux-foundation.org>, <bhe@redhat.com>,
	<farbere@amazon.com>, <hbathini@linux.ibm.com>, <sourabhjain@linux.ibm.com>,
	<adityag@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<takakura@valinux.co.jp>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
CC: <jonnyc@amazon.com>
Subject: [PATCH v3 0/2] Improve interrupt handling during machine kexec
Date: Thu, 28 Nov 2024 20:10:25 +0000
Message-ID: <20241128201027.10396-1-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_121040_521423_77312EAE 
X-CRM114-Status: UNSURE (   6.67  )
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

This patch series focuses on improving the machine_kexec_mask_interrupts()
function by consolidating its implementation and optimizing its behavior to
avoid redundant interrupt masking.

Patch Summary:
[PATCH v3 1/2] Move machine_kexec_mask_interrupts() to kexec_core.c,
               removing duplicate architecture-specific implementations.
[PATCH v3 2/2] Refine machine_kexec_mask_interrupts() to avoid re-masking
               already-masked interrupts, resolving specific warnings
               triggered in GPIO IRQ flows.

Eliav Farber (2):
  kexec: Consolidate machine_kexec_mask_interrupts() implementation
  kexec: Prevent redundant IRQ masking by checking state before shutdown

 arch/arm/kernel/machine_kexec.c   | 23 -----------------------
 arch/arm64/kernel/machine_kexec.c | 31 -------------------------------
 arch/powerpc/include/asm/kexec.h  |  1 -
 arch/powerpc/kexec/core.c         | 22 ----------------------
 arch/riscv/kernel/machine_kexec.c | 23 -----------------------
 include/linux/irq.h               |  3 +++
 include/linux/kexec.h             |  2 ++
 kernel/irq/internals.h            |  1 -
 kernel/kexec_core.c               | 28 ++++++++++++++++++++++++++++
 9 files changed, 33 insertions(+), 101 deletions(-)

-- 
2.40.1


