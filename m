Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C61C5CFEB
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zt5aG8T70pAVsz38Vf/LQqt7yVTDjwmbD2OUxXE/YKw=; b=WEdXXqQNo+10uwh0LZ15sUsAxI
	hbVIaV8qsasK6XRV0er+o4lACVpWkcHVcKuaZsMIphZGc7XpIdM2l2D4Cgh3OYHavEnKhGNmjBRvD
	p0Bww5Vo/wfUKnYNtYdfEVksp8wT2JukW071zs8mZTr5JxEshY63HD3gs5OZ7/2cHAxYziOocQHZA
	58t+mFUb59FeB5JMGTMNONTGT20E/j/ZNnRVmgvJxd6pA8/Wh1twlPvoc/C+dWoiLMbj8LeQQRVtW
	wK7xVZ6s1HvdyuAMXNVaBTOF1WKuRVMI9+itPnRCXQZZMree+bJZHAkkHtIbkWhrtEHE4l/PaCPfq
	AZkK/RoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7Ge-0000000G76Y-299e;
	Wed, 12 Aug 2026 11:37:08 +0000
Received: from devianza.investici.org ([2c0f:f930:0:4::108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7Ga-0000000G75p-0t7D
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 11:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786534620;
	bh=zt5aG8T70pAVsz38Vf/LQqt7yVTDjwmbD2OUxXE/YKw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jmUgl7iLgfoUTZ1W8XhpUyUvliTn62FHeVsiCG0Z/UIJ61ojEssIleUCeHJiV0KQU
	 4oryrUMBdJkrk/FWrelE64YPMAu7FQKIr+CYhS2RtF7SRQ6xUrQ+6QcLU+j6mlA8X+
	 Do8TfjkyyO/aXIfS606LkNQrwlIw0nbvgzmTmueQ=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hKmg01XsJz6vGx;
	Wed, 12 Aug 2026 11:37:00 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hKmfz5Q9xz4y6W;
	Wed, 12 Aug 2026 11:36:59 +0000 (UTC)
Date: Wed, 12 Aug 2026 12:36:59 +0100
From: Bradley Morgan <include@grrlz.net>
To: Breno Leitao <leitao@debian.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 rmikey@meta.com, riel@surriel.com, kernel-team@meta.com,
 Kiryl Shutsemau <kas@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_0/2=5D_kexec=3A_keep_the_ne?=
 =?US-ASCII?Q?xt_kernel_off_hardware-poisoned_pages?=
In-Reply-To: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org>
References: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org>
Message-ID: <6D17A62B-3124-492F-9593-63F857DD475F@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_043704_668945_DA9DDD4C 
X-CRM114-Status: GOOD (  16.39  )
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

On 12 August 2026 12:31:50 BST, Breno Leitao <leitao@debian.org> wrote:
>Memory failures are common enough on large fleets that kexec regularly
>lands the next kernel on a frame the memory failure subsystem has already
>marked bad. Patch 2 teaches the segment placement to avoid those frames.
>
>Patch 1 is a prerequisite. locate_mem_hole_top_down() walks candidates
>downwards without ever checking that the subtraction stays above zero, so
>the walk can wrap and report success with a destination outside of RAM.
>Patch 2 adds one more downward step to that loop, so the bug is fixed
>first and both patches rely on the same bail-out.
>
>Signed-off-by: Breno Leitao <leitao@debian.org>
>---
>Changes in v6:
>- Split the pre-existing top-down underflow out into its own patch, and
>  drop the "if (poison < kbuf->memsz)" guard from the hwpoison hunk now
>  that the loop bail-out covers it. (Mike Rapoport, Sashiko)
>- Reword the changelog: the MCE comes from reading the poison back, not
>  from the relocation copy writing it, and the placement paragraphs read
>  better split up. (Mike Rapoport)
>- Move cond_resched() after the struct page dereference, so the scan does
>  not yield between pfn_to_online_page() and is_page_hwpoison().
>  (Pratyush Yadav, Sashiko)
>- Keep cond_resched() per pfn rather than batching it. (Kiryl Shutsemau,
>  Rik van Riel)
>- Link to v5: https://patch.msgid.link/20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org

This is a two patch series with one patch, why?


>
>Changes in v5:
>- Return -EHWPOISON instead of -EADDRNOTAVAIL
>- Leverage is_page_hwpoison() instead of per-page check
>- Link to v4: https://patch.msgid.link/20260807-kexec_posioned-v4-1-70d57f14625d@debian.org
>
>Changes in v4:
>- Anchor the top-down hole finder on the first poisoned page in the
>  window and the bottom-up one on the last, so each jumps clear of the
>  poison in one step. New range_first_hwpoison(). (Kiryl Shutsemau)
>- Count a poisoned hugetlb folio in full: the flag lives on the folio,
>  not on the subpages, so the per-pfn scan missed poisoned tail pages.
>  (Kiryl Shutsemau)
>- Link to v3: https://patch.msgid.link/20260803-kexec_posioned-v3-1-83aa6ede0351@debian.org
>
>Changes in v3:
>- Return the address of the last poisoned page in the range, or
>  PHYS_ADDR_MAX when it is clean, instead of a bool plus an output
>  parameter. Renamed to range_last_hwpoison(). (Pratyush Yadav)
>- Add cond_resched() to the scan loop, as a segment can span half of
>  memory. (Sashiko)
>- Link to v2: https://patch.msgid.link/20260730-kexec_posioned-v2-1-f92d18551f64@debian.org
>
>Changes in v2:
>- Change from pfn_to_page() to pfn_to_online_page(). (Miaohe Lin)
>- Return the poisoned address once we find a hit, to avoid the O(n^2)
>  rescan. (Sashiko)
>- Link to v1: https://patch.msgid.link/20260728-kexec_posioned-v1-1-160c81d180fe@debian.org
>
>To: Andrew Morton <akpm@linux-foundation.org>
>To: David Hildenbrand <david@kernel.org>
>To: Lorenzo Stoakes <ljs@kernel.org>
>To: "Liam R. Howlett" <liam@infradead.org>
>To: Vlastimil Babka <vbabka@kernel.org>
>To: Mike Rapoport <rppt@kernel.org>
>To: Suren Baghdasaryan <surenb@google.com>
>To: Michal Hocko <mhocko@suse.com>
>To: Baoquan He <baoquan.he@linux.dev>
>To: Pasha Tatashin <pasha.tatashin@soleen.com>
>To: Pratyush Yadav <pratyush@kernel.org>
>To: Miaohe Lin <linmiaohe@huawei.com>
>To: Naoya Horiguchi <nao.horiguchi@gmail.com>
>Cc: linux-mm@kvack.org
>Cc: linux-kernel@vger.kernel.org
>Cc: kexec@lists.infradead.org
>Cc: rmikey@meta.com
>Cc: riel@surriel.com
>
>---
>Breno Leitao (2):
>      kexec_file: stop the top-down search before it underflows
>      kexec: keep the next kernel off hardware-poisoned pages
>
> include/linux/mm.h  | 14 ++++++++++++++
> kernel/kexec_core.c | 10 ++++++++++
> kernel/kexec_file.c | 20 +++++++++++++++++++-
> mm/memory-failure.c | 40 ++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 83 insertions(+), 1 deletion(-)
>---
>base-commit: c5e32e86ca02b003f86e095d379b38148999293d
>change-id: 20260727-kexec_posioned-72bb0a4143a0
>
>Best regards,
>--  
>Breno Leitao <leitao@debian.org>
>
>

Thanks!

