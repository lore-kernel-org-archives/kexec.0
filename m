Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C8ACA1002
	for <kexec@archiver.kernel.org>; Fri, 29 Aug 2025 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LR9IaYVdyYrO+KHT5MCiEIqQH5svD3ta6RQw+Qw6/7w=; b=qSooZltyoLvprX0XWz/iFV0McM
	hFbj8gffjPaNEMqatDX/DL+qhQTu5k4oVv++GS6L1mMBDU7E8mfndyEcr4fh/7PRbIG9D+Pqn16tl
	Snn1MWB1uQPHzP4r1bLaXmxYibn7aEn01jjVF4a0pzJslYwlMBb4fLCZ35FO3rxNNG2Bm0mecNSnx
	TsUtgGAy0nMj8NNHA47A06bc+OAO+ulYPMLlxEmELidimYGcWfyZIBjOSx2dHxjeHutulEqyS5YU1
	JLHHjOCGiM4kR1riHki3iyH0kPCMGTZ4kkkwhpm3IFCalLetxOqtnzbhK4FZwa3wL4ePiUTBW/8Np
	8xoLEmDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urwDE-00000005IiK-3q3a;
	Fri, 29 Aug 2025 10:20:04 +0000
Received: from out-187.mta1.migadu.com ([2001:41d0:203:375::bb])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urv9M-0000000561j-39NZ
	for kexec@lists.infradead.org;
	Fri, 29 Aug 2025 09:12:02 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756458705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LR9IaYVdyYrO+KHT5MCiEIqQH5svD3ta6RQw+Qw6/7w=;
	b=FI4Bev1hZTqvoaJXd6GrrLgm1PTgYK5isSfmBlVlb0psPmF3FYMIp2W/nV/BN35lOymCfo
	9j70VXwUPG79+wmVk6kb00N/jI8yXOEPibrAnAU/GtPxIm+EZBOhlDXEpxyAslQCnWi2iZ
	ucuF5WucOPzsjV3DzDJVxVujPh571o4=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 0/7] Fix and improve the LoongArch implementation
Date: Fri, 29 Aug 2025 17:10:33 +0800
Message-Id: <20250829091040.35827-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_021200_931149_28AF4EFB 
X-CRM114-Status: UNSURE (   5.28  )
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

From: Youling Tang <tangyouling@kylinos.cn>

- Fix and improve the LoongArch implementation.
- Fixed the handling of crashkernel parameters when using --reuse-cmdline.

Youling Tang (7):
  kexec: Handle removal of multiple 'crashkernel' parameters
  LoongArch: Fix comments
  LoongArch: Terminate the cmdline string using '\0'
  LoongArch: Enforce relocatable kernel check for crash dump
  LoongArch: Change initrd allocation to top-down
  LoongArch: Fix the use of loongarch_image_header in ELF format
  LoongArch: Add pe_hdr->machine check for pei format images

 kexec/arch/loongarch/image-header.h        |  5 ++-
 kexec/arch/loongarch/kexec-elf-loongarch.c | 44 ++++++++++++++++++----
 kexec/arch/loongarch/kexec-loongarch.c     |  4 +-
 kexec/arch/loongarch/kexec-pei-loongarch.c | 24 +++++++++++-
 kexec/kexec.c                              |  6 +++
 5 files changed, 70 insertions(+), 13 deletions(-)

-- 
2.34.1


