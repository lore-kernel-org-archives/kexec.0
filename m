Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FA1C5DF81
	for <kexec@archiver.kernel.org>; Wed, 19 Aug 2026 14:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PmK3ncwTQiQXAZMeh3sTvHkCfE4LURycHONVQJ7SAYw=; b=3T34d1oVxlUZUfk40HsLftoo87
	m0fZ5XFI3SmZZ3UUuktGnolDMLnjbklYNcGph+Yk9MM+GhDvmed5HD4F416qRVqdXx9ZhzGSrmdj9
	HiHbQwETeq1tATuYhq0Bu2JNqmbv5p/Fi/PqWX9Avk8LYdicPs2kJ/w1gJv5xb9UefrhcJzn0keHT
	xBFOLeXFWo5FrPEj71cA8aLrs1DAT+kp9L7+0mykr2/BH9cAqi1f0/X2iYZZtFG7tinf8X342xS6t
	4ibbhJb9Y0yXKUXjmLb0a+5kx96Uc3LQLan3StOt4q0OLuJMPD3Iw4a+ChP/VfLeqQnsgAq+aU3bs
	mpFTW7pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwhCG-00000009yA6-3NmS;
	Wed, 19 Aug 2026 14:23:16 +0000
Received: from devianza.investici.org ([2c0f:f930:0:4::108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwhCC-00000009y99-2zY4
	for kexec@lists.infradead.org;
	Wed, 19 Aug 2026 14:23:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787149386;
	bh=PmK3ncwTQiQXAZMeh3sTvHkCfE4LURycHONVQJ7SAYw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bjMOTD+wRqyP/D3W90OS7+jo0JAp5OhVkZrmeVelKAVcKsiJd2+teYZRsESxY9JKa
	 OQNV7YAcxpxWPQaWqCZ/gizjuxMEvDu0pCgWARsX/fXxK+Dyd2mziIUO0euXOq+FuW
	 52BTW25ZMib3ug0Kh8aQmvTsTA+sGouce6Wk/1BI=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hQ81Q001sz6vBx;
	Wed, 19 Aug 2026 14:23:05 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hQ81P31wdz4y6W;
	Wed, 19 Aug 2026 14:23:05 +0000 (UTC)
Date: Wed, 19 Aug 2026 15:23:04 +0100
From: Bradley Morgan <include@grrlz.net>
To: Mike Rapoport <rppt@kernel.org>, Breno Leitao <leitao@debian.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, rmikey@meta.com,
 riel@surriel.com, kernel-team@meta.com, Kiryl Shutsemau <kas@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_0/2=5D_kexec=3A_keep_the_ne?=
 =?US-ASCII?Q?xt_kernel_off_hardware-poisoned_pages?=
In-Reply-To: <aoV5EfBtlWcyf51E@kernel.org>
References: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org> <aoV5EfBtlWcyf51E@kernel.org>
Message-ID: <6CB4696E-03E3-42A0-9E3B-6BD1E143D5ED@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_072313_184431_09DB9420 
X-CRM114-Status: GOOD (  19.44  )
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

On 19 August 2026 10:36:17 BST, Mike Rapoport <rppt@kernel.org> wrote:
>On Wed, Aug 12, 2026 at 04:31:50AM -0700, Breno Leitao wrote:
>> Memory failures are common enough on large fleets that kexec regularly
>> lands the next kernel on a frame the memory failure subsystem has
>already
>> marked bad. Patch 2 teaches the segment placement to avoid those frames.
>> 
>> Patch 1 is a prerequisite. locate_mem_hole_top_down() walks candidates
>> downwards without ever checking that the subtraction stays above zero,
>so
>> the walk can wrap and report success with a destination outside of RAM.
>> Patch 2 adds one more downward step to that loop, so the bug is fixed
>> first and both patches rely on the same bail-out.
>
>I queued this for v7.4, the patches will appear in the liveupdate tree
>after the merge window.
> 

Ah, so it'll appear in a maintainers tree after MW?

>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>> Changes in v6:
>> - Split the pre-existing top-down underflow out into its own patch, and
>>   drop the "if (poison < kbuf->memsz)" guard from the hwpoison hunk now
>>   that the loop bail-out covers it. (Mike Rapoport, Sashiko)
>> - Reword the changelog: the MCE comes from reading the poison back, not
>>   from the relocation copy writing it, and the placement paragraphs read
>>   better split up. (Mike Rapoport)
>> - Move cond_resched() after the struct page dereference, so the scan
>does
>>   not yield between pfn_to_online_page() and is_page_hwpoison().
>>   (Pratyush Yadav, Sashiko)
>> - Keep cond_resched() per pfn rather than batching it. (Kiryl Shutsemau,
>>   Rik van Riel)
>> - Link to v5:
>https://patch.msgid.link/20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org
>> 
>> Changes in v5:
>> - Return -EHWPOISON instead of -EADDRNOTAVAIL
>> - Leverage is_page_hwpoison() instead of per-page check
>> - Link to v4:
>https://patch.msgid.link/20260807-kexec_posioned-v4-1-70d57f14625d@debian.org
>> 
>> Changes in v4:
>> - Anchor the top-down hole finder on the first poisoned page in the
>>   window and the bottom-up one on the last, so each jumps clear of the
>>   poison in one step. New range_first_hwpoison(). (Kiryl Shutsemau)
>> - Count a poisoned hugetlb folio in full: the flag lives on the folio,
>>   not on the subpages, so the per-pfn scan missed poisoned tail pages.
>>   (Kiryl Shutsemau)
>> - Link to v3:
>https://patch.msgid.link/20260803-kexec_posioned-v3-1-83aa6ede0351@debian.org
>> 
>> Changes in v3:
>> - Return the address of the last poisoned page in the range, or
>>   PHYS_ADDR_MAX when it is clean, instead of a bool plus an output
>>   parameter. Renamed to range_last_hwpoison(). (Pratyush Yadav)
>> - Add cond_resched() to the scan loop, as a segment can span half of
>>   memory. (Sashiko)
>> - Link to v2:
>https://patch.msgid.link/20260730-kexec_posioned-v2-1-f92d18551f64@debian.org
>> 
>> Changes in v2:
>> - Change from pfn_to_page() to pfn_to_online_page(). (Miaohe Lin)
>> - Return the poisoned address once we find a hit, to avoid the O(n^2)
>>   rescan. (Sashiko)
>> - Link to v1:
>https://patch.msgid.link/20260728-kexec_posioned-v1-1-160c81d180fe@debian.org
>> 
>> To: Andrew Morton <akpm@linux-foundation.org>
>> To: David Hildenbrand <david@kernel.org>
>> To: Lorenzo Stoakes <ljs@kernel.org>
>> To: "Liam R. Howlett" <liam@infradead.org>
>> To: Vlastimil Babka <vbabka@kernel.org>
>> To: Mike Rapoport <rppt@kernel.org>
>> To: Suren Baghdasaryan <surenb@google.com>
>> To: Michal Hocko <mhocko@suse.com>
>> To: Baoquan He <baoquan.he@linux.dev>
>> To: Pasha Tatashin <pasha.tatashin@soleen.com>
>> To: Pratyush Yadav <pratyush@kernel.org>
>> To: Miaohe Lin <linmiaohe@huawei.com>
>> To: Naoya Horiguchi <nao.horiguchi@gmail.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: kexec@lists.infradead.org
>> Cc: rmikey@meta.com
>> Cc: riel@surriel.com
>> 
>> ---
>> Breno Leitao (2):
>>       kexec_file: stop the top-down search before it underflows
>>       kexec: keep the next kernel off hardware-poisoned pages
>> 
>>  include/linux/mm.h  | 14 ++++++++++++++
>>  kernel/kexec_core.c | 10 ++++++++++
>>  kernel/kexec_file.c | 20 +++++++++++++++++++-
>>  mm/memory-failure.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 83 insertions(+), 1 deletion(-)
>> ---
>> base-commit: c5e32e86ca02b003f86e095d379b38148999293d
>> change-id: 20260727-kexec_posioned-72bb0a4143a0
>> 
>> Best regards,
>> --  
>> Breno Leitao <leitao@debian.org>
>> 
>
>

Thanks!

