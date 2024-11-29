Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5F5D6EBFF
	for <kexec@archiver.kernel.org>; Fri, 29 Nov 2024 11:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XxQ3De7RUhc+RdOPHYM+OjqpU7dn3KwiW10hYXSFbC8=; b=m/MMs1E1Xprtj0xPA//WehLMRi
	C7k2RCmlkAjdW2YHunDJHR7amYckoUMwCyIcSDawIf/IrJ+POEKaV7wCaejVf1fatNSkjorWuUqSw
	DRqzKM31UEpgJVjVOP8yW3AaB1nOvWHCrxCqobNSbNUyV9YY6gdAvtCbYasxJ4qFn7GMFwRf2GRWX
	8ouTp3DJbh2Lg58FL5NftG8kLlglEEDrnxG1nNJVLE7k8WjeC3n/mjARX8HPz/SAQSoSQIJWVxO/p
	TB+Qei1VmgKOIQe3P4OtaNSv9khGRalm1OWunZTzljpe45aUHsZI7H69n9ZDrDmdSWBQiTSkjp0rc
	oVqhRpag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGzEd-0000000HYee-3ljm;
	Fri, 29 Nov 2024 11:32:31 +0000
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGzDg-0000000HYLb-1IrQ;
	Fri, 29 Nov 2024 11:31:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732879892; x=1764415892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XxQ3De7RUhc+RdOPHYM+OjqpU7dn3KwiW10hYXSFbC8=;
  b=SmXQC/h05OAEx8AbyIVAVy64MLxUVfd/XfMG/zj5VMh/yusAc0DUjtJL
   j7cawSctR16BiQ1+PfUtLGP3syksbsx5gDMf3eIweLY1e2zD1JkIVo1Vl
   r8t034E1uWO6FdsV+2moj9sBfA5c5qF2m0cJP6fYv5vKYkngF7tqJpTXk
   0=;
X-IronPort-AV: E=Sophos;i="6.12,195,1728950400"; 
   d="scan'208";a="441793923"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 11:31:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:47324]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.2:2525] with esmtp (Farcaster)
 id ecdc713d-df63-4dcd-9dd4-55bcc88c3341; Fri, 29 Nov 2024 11:31:24 +0000 (UTC)
X-Farcaster-Flow-ID: ecdc713d-df63-4dcd-9dd4-55bcc88c3341
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 11:31:20 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 11:31:19 +0000
Received: from email-imr-corp-prod-iad-all-1a-8c151b82.us-east-1.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 29 Nov 2024 11:31:19 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com [172.19.116.181])
	by email-imr-corp-prod-iad-all-1a-8c151b82.us-east-1.amazon.com (Postfix) with ESMTP id 78A5940640;
	Fri, 29 Nov 2024 11:31:19 +0000 (UTC)
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
	id 355A79E9A; Fri, 29 Nov 2024 11:31:19 +0000 (UTC)
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
Subject: [PATCH v4 0/2] Improve interrupt handling during machine kexec
Date: Fri, 29 Nov 2024 11:31:17 +0000
Message-ID: <20241129113119.26669-1-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_033132_666226_08221071 
X-CRM114-Status: UNSURE (   7.16  )
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
[PATCH v4 1/2] Move machine_kexec_mask_interrupts() to kexec_core.c,
               removing duplicate architecture-specific implementations.
[PATCH v4 2/2] Refine machine_kexec_mask_interrupts() to avoid re-masking
               already-masked interrupts, resolving specific warnings
               triggered in GPIO IRQ flows.

Changes between v3 and v4:
 - Add missing <linux/irqdesc.h> and <linux/irq.h> includes.

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
 kernel/kexec_core.c               | 30 ++++++++++++++++++++++++++++++
 9 files changed, 35 insertions(+), 101 deletions(-)

-- 
2.40.1


