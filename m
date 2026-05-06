Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16162CD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 11:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Mime-Version:Subject:From:To
	:Content-Transfer-Encoding:Date:Cc:Content-Type:Message-Id:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZV/JuzK9yrFngNj+Zqv1hLOWZznmFT1n+c05mCoXvtI=; b=3jUCgbVOnoteWOaqZXaWUMG8BC
	DgWT+GcwTG/nyIunAA/7brsgpFEQlvns0L6MjWCIkCePTrL8PLzqFeYlOGs1IhubdghMJ078jrLw9
	q01MRI9U/RuK1ffZmSKuBxmxGLtrgd9BnjPNjo9mXaVQgPJVXQNK0ivl8An1m6OtZlD8ZLBMQ1+Wm
	mcVOKXQN3K1cLA0pqrv1m6J1zvSKcOnXM9wL6cVrYu7odfFkXyWdF5rdMZaxCxwizBJK3WcqXLxoR
	w13XXuXj4CDJ6bpwiH3lZ0S/FtHpnV71vFPxVLXk3GqvYgCbmyWN3vQUNYhFdrR8NTiv/4Rq3GR3Y
	wwsRtoBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKatU-00000000hW2-1J60;
	Wed, 06 May 2026 11:58:24 +0000
Received: from va-2-115.ptr.blmpb.com ([209.127.231.115])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKatP-00000000hUe-3xSV
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 11:58:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778068690; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ZV/JuzK9yrFngNj+Zqv1hLOWZznmFT1n+c05mCoXvtI=;
 b=CkrHH7USQ83nnUbxnp7zIgvpVCcY389vJnjPudbL4OIMOtGrLZLK4MVvJW6cLFR9gwkSB1
 hj0D5dGea2u9VkcSz7+EIhBIQ9cvrAf2gL2WBLqMIwiw5Xjw5DR98mU9n0Zu5Dq5IbQWSM
 +6+urh5Ce3mf6lx/1cI2dphYbr6CR2DcWf94DpcrEiiFC1KAQ68jcy78Aio9PSLUknYoYW
 svMkuQpDf4dbSkA+LpXrVhxrjZ6NVvJJrRNBZJQ4/5FrSUk1EZxITmoGnDCVClXKiwsOff
 GDa9PlAlzSmR6mWjMR1ozwdMwNdxnlDSrnVTEIetyWBvYuBrywmzlNdn9MOlPg==
Message-Id: <20260506115758.2497610-1-qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+269fb2cd0+16c1ab+lists.infradead.org+qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: "Rui Qi" <qirui.001@bytedance.com>
Date: Wed,  6 May 2026 19:57:56 +0800
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.20.1
To: <kexec@lists.infradead.org>
From: "Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH][makedumpfile] Fix riscv64 virtual-to-physical address translation
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_045820_399769_E5A66A28 
X-CRM114-Status: UNSURE (   5.35  )
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

This patchset fixes two bugs in the riscv64 architecture support of
makedumpfile related to virtual-to-physical address translation.

Patch 1 fixes vaddr_to_paddr_riscv64() to exclude vmalloc and vmemmap
regions from the VTOP() fast path. These regions are not linearly mapped
and must go through page table walk.

Patch 2 fixes vtop_riscv64() to correctly handle huge pages when
_PAGE_LEAF is set at PGD/P4D/PUD/PMD level. The original code incorrectly
fell through to the next level, causing wrong physical address computation.

Shuan He (2):
  riscv64: Fix vaddr_to_paddr for vmalloc and vmemmap regions
  riscv64: Fix huge page translation in vtop_riscv64()

 arch/riscv64.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

-- 
2.20.1

