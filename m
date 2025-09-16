Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D89CAC59B
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 01:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NX9CeCQ5BA7mSy9GMyixqOGIulSxpjlNCebCUvYZyvQ=; b=ZgK2yuT8Orf35+4dIp38XQWwbb
	MlDrcGnLGLQgeCvemHr5ySX2oPZj8dMdY1bVQEy+6inRoeOd8Wb/mfgH2h77D2E6SloGr3i8/PMtI
	o/yslHdlRCMGMC9C+wbMvyqoXBkjguOC61tMjM1+pTVNZXovCaPfdQ91g9t27AUzAE7x6QjGrLhCs
	e5KBufXnEpdgSgbrzVmpe3bs+1clbXYaqC7kA2vVpLqng6k/EBlEort5BYTCxxZV/80s4Zu26sKGS
	XhYODlkcGBBY40mNZSE9dqRgOVOiEBg2W2q67ZnbwAcrEjsK3vlxbYarkfMcbvvNczpNxEg/iafsM
	e4Y3+DOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxe-00000006D1S-0sXu;
	Tue, 16 Sep 2025 01:58:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxc-00000006D18-2TmU
	for kexec@bombadil.infradead.org;
	Tue, 16 Sep 2025 01:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=NX9CeCQ5BA7mSy9GMyixqOGIulSxpjlNCebCUvYZyvQ=; b=KWer6Kib0yTq9kfiVINln0ct54
	xwZiqvoe4vZJhBiNGU3IYr5+QagR5WuXEe2cr+1TBF9/3ChgBOvoREUD08fW3yKy6qRLbTk+a03nY
	oiMaM+k2tFMIwgdCJEQHvohhBXycht8MQ/cnMwNfx/pBU7gXJywo3IPnrk9D4DWk2XS/R41P70pW4
	ATvMlotz7662FbK32pPIOqMjcvkFaFmE77TreAqwKbDSzw0U67HN6TntwKulvgRjJ9zZUn9ZdJkrX
	+gxzf0biOhTYhct82qOc0WgYQ+MAw3tUU158AD4D+ajBGxIUard1f/g/IHGdD3MROvNAtcyIAnVGt
	+xAskyBw==;
Received: from out-182.mta0.migadu.com ([2001:41d0:1004:224b::b6])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKxV-000000077yM-02jS
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 01:58:20 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757987289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NX9CeCQ5BA7mSy9GMyixqOGIulSxpjlNCebCUvYZyvQ=;
	b=cG5LdOv5JtfJNJkSazHto4LIrafTAGUO0PCDJBY859w057hz8JHf0NRav3aEBoOuned/kd
	NnDs2ORDUQ866VERYJFvHJAzI3KmTbiDi1o3bT/dJ8qQlHq8vmQdclVDkcR5d50tzdB76P
	zs98/T5mfascWVOcp9RulgelCMMWqAE=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	kexec@lists.infradead.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 00/10] Fix and improve the LoongArch implementation
Date: Tue, 16 Sep 2025 09:46:45 +0800
Message-Id: <20250916014655.841632-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_025818_173563_B438F60E 
X-CRM114-Status: UNSURE (   6.42  )
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

- Add kexec_file support for LoongArch.
- Fix and improve the LoongArch implementation.
- Fixed the handling of crashkernel parameters when using --reuse-cmdline.

Kernel support for kexec_file was introduced by the patch detailed in Link [1].

Link[1]:
https://lore.kernel.org/loongarch/20250903030100.196744-1-youling.tang@linux.dev/T/#t

Changelog:
v2:
 - Add kexec_file support for LoongArch.
 - Correct email address and Signed-off-by.

Youling Tang (10):
  kexec: Handle removal of multiple 'crashkernel' parameters
  LoongArch: Fix comments
  LoongArch: Terminate the cmdline string using '\0'
  LoongArch: Enforce relocatable kernel check for crash dump
  LoongArch: Change initrd allocation to top-down
  LoongArch: Fix the use of loongarch_image_header in ELF format
  LoongArch: Add pe_hdr->machine check for pei format images
  LoongArch/pez: Fix kernel_fd handling when kexec_file is supported
  LoongArch: Add kexec_file_load syscall
  LoongArch: Remove 'kexec_file' cmdline parameters when using
    --reuse-cmdline option

 kexec/arch/loongarch/image-header.h        |  5 ++-
 kexec/arch/loongarch/kexec-elf-loongarch.c | 47 ++++++++++++++++++----
 kexec/arch/loongarch/kexec-loongarch.c     | 44 +++++++++++++++++++-
 kexec/arch/loongarch/kexec-loongarch.h     |  1 +
 kexec/arch/loongarch/kexec-pei-loongarch.c | 27 ++++++++++++-
 kexec/arch/loongarch/kexec-pez-loongarch.c | 14 ++++---
 kexec/kexec-syscall.h                      |  5 ++-
 kexec/kexec.c                              |  6 +++
 8 files changed, 130 insertions(+), 19 deletions(-)

-- 
2.34.1


