Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74C5CF8861
	for <kexec@archiver.kernel.org>; Thu, 20 Nov 2025 14:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VzGv03IYbkXuhrbno5kD8tYczSIVbSX/Gu02hzXe/jo=; b=OFtaroqgL9e4Q+WhF4nE7ik3lZ
	pr9sxbIABtCYrkAwuy173WjLwye4AqV8DHQx+NJonwwIIby+1bv0q0YtmOb+xExpbaAf9h8+hS1KD
	bagT5JYbEp0AbxQsBwImeVWtJjS6FqZ6X9Wr24LT/l1to9lBpBguIvjEOAJX+GQlrhQgmGgqDJD41
	EfSHk973p0Oxz49rsFyx5UeVCCNpeIJH9ntXrMDqMT9AzsNepX/BncZ1uPN8sSS1+hfjn0XpZde5M
	zEkZBea/P50EtN7RC+1La+xiykDF92y5b6llnQ2mplHmIS4d77uQLePovJtZ39eKBaexBy+LW/57o
	OwQ8jVxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM5sA-00000006rcr-0ZnJ;
	Thu, 20 Nov 2025 14:42:58 +0000
Received: from m16.mail.163.com ([117.135.210.2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM5s5-00000006rbG-1sJT
	for kexec@lists.infradead.org;
	Thu, 20 Nov 2025 14:42:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Vz
	Gv03IYbkXuhrbno5kD8tYczSIVbSX/Gu02hzXe/jo=; b=TbRkCcmSf4nblu/8gP
	A+0RSQtSnda2MSlbfIJ3KV8GTzmlSCTkSNmRxtB2/7BUSupFgEIWHcOxBbBypd9q
	VIyaGSxakci3yrFW68ev6/b7x4j15RepqGAw17oVexLk8UUll6ahvX1Bx/3mvD4m
	/nb+WzcHfYRzFQtqZk2oDrft8=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wA3yJmuKB9pTEQrBQ--.727S2;
	Thu, 20 Nov 2025 22:41:51 +0800 (CST)
From: ranxiaokai627@163.com
To: catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	changyuanl@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH 0/2] liveupdate: Fix boot failure due to kmemleak access to unmapped pages
Date: Thu, 20 Nov 2025 14:41:45 +0000
Message-ID: <20251120144147.90508-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3yJmuKB9pTEQrBQ--.727S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr48CF43Jw4kJF4fJw1UWrg_yoW8Zr1xpr
	yDCr4jkrsrJa4Y9Fsavay0kryIyws3KFWUAFy7Xw15Z3s8WrWIyws5A34YyFyUGw48Gr4f
	XF4UKay7ur1jqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pin2-UUUUUU=
X-Originating-IP: [117.176.242.6]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbBEAkMTGkfJUZRaAAAs1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_064253_824019_9B5CD28C 
X-CRM114-Status: UNSURE (   6.12  )
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

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

When booting with debug_pagealloc=on while having:
CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y  
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=n  
the system fails to boot due to page faults during kmemleak scanning.

Crash logs:
BUG: unable to handle page fault for address: ffff8880cd400000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11de00067 P4D 11de00067 PUD 11af2b067 PMD 11aec1067 PTE 800fffff32bff020
Oops: Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
RIP: 0010:scan_block+0x43/0xb0
Call Trace:
 <TASK>
 scan_gray_list+0x2b5/0x2f0
 kmemleak_scan+0x3b1/0xcf0
 kmemleak_scan_thread+0x7d/0xc0
 kthread+0x11c/0x240
 ret_from_fork+0x2d3/0x370
 ret_from_fork_asm+0x11/0x20
 </TASK>

This occurs because:
With debug_pagealloc enabled, __free_pages() invokes
debug_pagealloc_unmap_pages(), clearing the _PAGE_PRESENT bit for
freed pages in the direct mapping.
Commit 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
releases the KHO scratch region via init_cma_reserved_pageblock(),
unmapping its physical pages. Subsequent kmemleak scanning accesses
these unmapped pages, triggering fatal page faults.

This patch introduces kmemleak_no_scan_phys(phys_addr_t),
a physical-address variant of kmemleak_no_scan(), which marks
memblock regions as OBJECT_NO_SCAN.

We invoke this from kho_reserve_scratch() to exclude the reserved
region from scanning before it is released to the buddy allocator.

This is based linux next-20251119.

Ran Xiaokai (2):
  mm: kmemleak: introduce kmemleak_no_scan_phys() helper
  liveupdate: Fix boot failure due to kmemleak access to unmapped pages

 include/linux/kmemleak.h           |  4 ++++
 kernel/liveupdate/kexec_handover.c |  4 ++++
 mm/kmemleak.c                      | 15 ++++++++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.25.1



