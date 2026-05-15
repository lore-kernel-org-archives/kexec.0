Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F53CD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 08:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Message-Id:Date:From:Content-Type:In-Reply-To:Cc:To:References:Mime-Version:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YeS0QPnSv0aM0izN7SJxmYTtXB7tT4UpcetS6NXsMMA=; b=Ens/y1fm0IWzAtaw+NJDEgceSR
	m0VjVhc+kI/9XgrqzPbfPZUlKRMynYHPBebuHHoCw3aB5wOqezBA+B6b10A2RS7E2fbKL7Zfq4qiK
	AntCsYXUtsaxrDjskxtK7yXPO0H259FcH4vKiEPynIxTaEMnxefpjW8BcuObo8RwvYucqWk7U72TL
	H4cE6eSZNII1XZOWTOGhzcMS8jwkCLTNVomrAO9Sa0VFcVRE7WCthCxLffoc0CXN3mz5RfDm1xDZB
	06pVft540A6ot1dgSES120V5jL6gCa+StWLfj1rmho2o9AWweY0CiE7yD6IPkqq+8DNUrP3b8k/uk
	KNs1RivA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNnan-00000007hE4-2slE;
	Fri, 15 May 2026 08:08:21 +0000
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNnal-00000007hCx-0qC9
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 08:08:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778832493; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YeS0QPnSv0aM0izN7SJxmYTtXB7tT4UpcetS6NXsMMA=;
 b=HB7RCGCjLuZPEBBSs6cN6JLarGLGQtgMDjaeJQuFD/+vKAzyN3pVed2eumIS0kkjn/aRh9
 JADdTzl2TKiR6VEoY2aoA2dPVebczqxiMExefsMHqCYSH36vK6r82SatkntCc05zmsCTmo
 n71MjvZjh8b2FvguswGvg5AuzGZtWgVOU1khSWcSDo4UBHNY3epyh19Sg2qw7wQl7b7G3I
 XACL1MfjNtshFK31dR+St//Cj3IVTGBiNfvPuwEIDs25H8/rfIibOge7l2WA/zLLTXpu3k
 EQxFzVlz6SIjHNYG69hxkXu9AQivPo78P/ZYKFRbmQX12gCKAa93w0bbQ5Rqnw==
X-Lms-Return-Path: <lba+26a06d46a+575906+lists.infradead.org+qirui.001@bytedance.com>
Subject: [PATCH v2 1/2] riscv64: Fix vaddr_to_paddr for vmalloc and vmemmap regions
Mime-Version: 1.0
X-Original-From: Rui Qi <qirui.001@bytedance.com>
References: <20260515080745.70110-1-qirui.001@bytedance.com>
To: <kexec@lists.infradead.org>
Cc: <k-hagio-ab@nec.com>, "Rui Qi" <qirui.001@bytedance.com>, 
	"Shuan He" <heshuan@bytedance.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515080745.70110-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Fri, 15 May 2026 16:07:43 +0800
Message-Id: <20260515080745.70110-2-qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_010819_946170_005F5833 
X-CRM114-Status: UNSURE (   6.94  )
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

The current vaddr_to_paddr_riscv64() incorrectly uses VTOP() linear
mapping for vmalloc and vmemmap addresses, which are not linearly
mapped. Add checks to exclude these regions so they fall through to
page table walk via vtop_riscv64().

Co-developed-by: Rui Qi <qirui.001@bytedance.com>
Signed-off-by: Shuan He <heshuan@bytedance.com>
---
 arch/riscv64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv64.c b/arch/riscv64.c
index 1b43ec4f62a1..28365fa0cc5b 100644
--- a/arch/riscv64.c
+++ b/arch/riscv64.c
@@ -202,6 +202,8 @@ vaddr_to_paddr_riscv64(unsigned long vaddr)
 	unsigned long long swapper_phys;
 
 	if (vaddr >= PAGE_OFFSET &&
+	    !(vaddr >= NUMBER(vmalloc_start) && vaddr <= NUMBER(vmalloc_end)) &&
+	    !(vaddr >= NUMBER(vmemmap_start) && vaddr <= NUMBER(vmemmap_end)) &&
 	    !(vaddr >= NUMBER(modules_vaddr) && vaddr <= NUMBER(modules_end))){
 		return VTOP(vaddr);
 	}
-- 
2.20.1

