Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D480CCD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 08:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:From:
	Content-Transfer-Encoding:Message-Id:Mime-Version:Cc:To:Content-Type:Subject:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/hxc1vX8X4GE0Ao60BjBpK+FRAblTuGkhsKBimUdVSM=; b=hBHPyItvz8qhZWUgD+v8DzfYE4
	/NQzPVG7GS83BaplkK1iHNSl+AXaCFH5cqqipMzfA+z4xwpvwY8hWThwvDs3RGsotfpL3wnP+eg2C
	OJhadqDq8qmoTM1Gvn5LJD/gFbdgXpdP9lclOt2t36E2Vx4BV/jTjYgSL3cWnt34IPaBOrduFf5gM
	1JGql54SjTs1QOWQ+wa4Xb6IDqUpWhzIRCNz8afRLl/4SFQcvf9/09K8iIcvfPqjOYoxuFZOD8m+o
	dvbTUQIumrpFq5SUN8KAcjwVHTbjhiOaAVqhoACKMukiNrLu0U5uOntOSK95g1eYtlfQ6JG73Ubhc
	tWEhpwRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNnaf-00000007hBV-2bs7;
	Fri, 15 May 2026 08:08:13 +0000
Received: from va-1-115.ptr.blmpb.com ([209.127.230.115])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNnac-00000007hAM-47Ds
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 08:08:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778832483; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/hxc1vX8X4GE0Ao60BjBpK+FRAblTuGkhsKBimUdVSM=;
 b=IeVsPriLlGOfdbj7392jsr/TI3mQgmi5610R+0x7EFGBiXgQZPDyNsLkSajYbJ/HsWDI66
 yAZ8J7Iu3SDOkCzRL/Jr/EXVIo1pmduKuQQLFGD3HjasPSirD3VmLKlzH4+3g/aOyZTmsD
 UboX6cGnEBdYvHzPLb75SRrF5FtEM1sHE82tM5BeQ9trltDA6izvYjF+HHlagaHoqRC1le
 Us+9jyLqLdONxS4OLWkAm60sLs5P1OoWvCIwopJopSLRDwqKmmPzTLkN02NUPt4yl3J4qo
 +7gCaJ0fFHR42W2dScPJkUzCjNqyyY2JqkFC5ojIMzga44gURYGo+UzRnbq4jw==
X-Lms-Return-Path: <lba+26a06d461+c9e41f+lists.infradead.org+qirui.001@bytedance.com>
Subject: [PATCH v2 0/2] Fix riscv64 virtual-to-physical address translation
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset=UTF-8
To: <kexec@lists.infradead.org>
Cc: <k-hagio-ab@nec.com>, "Rui Qi" <qirui.001@bytedance.com>
Mime-Version: 1.0
Message-Id: <20260515080745.70110-1-qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Fri, 15 May 2026 16:07:42 +0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_010811_375103_6F5CFC27 
X-CRM114-Status: UNSURE (   5.72  )
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


Changes in v2:
- Patch 2: Changed `goto invalid;` to `return paddr;` when huge page
  (_PAGE_LEAF) hits, as the calculated physical address is valid.
- Patch 2: Removed the unused `out:` label to fix a compiler warning.

Rui Qi (2):
  riscv64: Fix vaddr_to_paddr for vmalloc and vmemmap regions
  riscv64: Fix huge page translation in vtop_riscv64()

 arch/riscv64.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

-- 
2.20.1

