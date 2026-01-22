Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E67EC44536
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 04:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yiJmlg5WsTB2rZ1C0+qojdvr50gKuolKVQyUrO3LUno=; b=2Is6VGeul+uzapygRL89R+WWS/
	1gN9ejig7waPz9T8WVpiqC36LzrB6o71bpI91PBuYDc98c4vXoz9EpChvRuU51t/rGjAIZ0+t1Lfu
	QEE688DLXXCMr7f6GAFH9rQFl3fbGGpOOovq31UZfbu9SkvG8djvb5JlY7V1oVa33NBdr6EYrZXXo
	2P837rcmT1EofRnloRR7SA3ZyjGwNO/4YeH1HR96ZCFr7KYD2tT0FLqA3bHOcq11OCREJnOAwi8eY
	/JfsVnFy6ajKo531H+anvFeDv9ZhDfGEAgMz1TChYaJQjVolPKi8RZoX2G+WnVWpq2JmK3xWuQwVp
	6zlwQ4tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vimGn-00000006QyA-2clV;
	Thu, 22 Jan 2026 04:26:09 +0000
Received: from m16.mail.163.com ([220.197.31.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vimGk-00000006QxQ-45iS
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 04:26:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yi
	Jmlg5WsTB2rZ1C0+qojdvr50gKuolKVQyUrO3LUno=; b=UTOGQQ9o1dCcjCh+IN
	R9TGhZrdDk4+UGiHFIVNnSDOyauUnfxnTiwUUy3TeFsmPZWzCTMLdsUB2tK63oda
	VuTD0iU3YTDY2NvYng23H2/XTajEce33uvftPhK3HbaDOgBXXqRhnmG+qA/rnErt
	sjJXDZp9BG5H6OBEiX4SuO6wE=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHL2uipnFpPMcLHw--.543S2;
	Thu, 22 Jan 2026 12:25:08 +0800 (CST)
From: ranxiaokai627@163.com
To: akpm@linux-foundation.org
Cc: graf@amazon.com,
	kent.overstreet@linux.dev,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	rppt@kernel.org,
	surenb@google.com
Subject: Re: [PATCH v3] kho: init alloc tags when restoring pages from reserved memory
Date: Thu, 22 Jan 2026 04:25:06 +0000
Message-ID: <20260122042506.175897-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121120804.d1334ea0cc66b4a6de691cbf@linux-foundation.org>
References: <20260121120804.d1334ea0cc66b4a6de691cbf@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHL2uipnFpPMcLHw--.543S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury3Ar45GF4DuFy8tr17trb_yoW8tr1fpr
	WUXw42yw4DGF1UArW2ga40934FqaykGry5J34j9rWfu3ZxGrn2q3s2ya1j9FyUurs5JF42
	gw4q9340ywn0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUFjg7UUUUU=
X-Originating-IP: [2409:8a62:11:dad0:5054:ff:fe87:d41]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxgSJ1WlxpqTjDgAA3p
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_202607_378928_5618BFA8 
X-CRM114-Status: GOOD (  12.16  )
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

>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> 
>> Memblock pages (including reserved memory) should have their allocation
>> tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
>> released to the page allocator. When kho restores pages through
>> kho_restore_page(), missing this call causes mismatched
>> allocation/deallocation tracking and below warning message:
>> 
>> alloc_tag was not set
>> WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1: swapper/0/1
>> RIP: 0010:___free_pages+0xb8/0x260
>>  kho_restore_vmalloc+0x187/0x2e0
>>  kho_test_init+0x3c4/0xa30
>>  do_one_initcall+0x62/0x2b0
>>  kernel_init_freeable+0x25b/0x480
>>  kernel_init+0x1a/0x1c0
>>  ret_from_fork+0x2d1/0x360
>> 
>> Add missing clear_page_tag_ref() annotation in kho_restore_page() to
>> fix this.
>> 
>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> ---
>> It is based on linux-next 20260120. I dont konw whether this base is ok ?
>
>It's awkward.
>
>Your v2 patch was based on Linus mainline.  This is appropriate, as the
>patch should be sent to Linus soon and it has cc:stable, so -stable
>maintainers will try to backport it into earlier kernels.
>
>However your v3 patch is dependent upon other material ("kho: simplify
>page initialization in kho_restore_page()") which is scheduled for
>6.20(?)-rc1.

I think i misunderstood Pratyush's last reply:
"I suggested a re-roll of this patch based on top of my cleanup patches
[1], since I think with those the end result is a bit nicer."

>For a prompt, backportable merge it's best to base the fix on latest
>Linus mainline, please.
>
>You didn't actually describe why v3 is different from v2.  If the
>v2->v3 changes are just nice-to-have then let's redo those and base
>them on linux-next in the usual fashion.

>Unless I'm missing something, your well-reviewed, decently-tested v2
>patch remains suitable for upstreaming during 6.18-rcX

v2 version just fixed the folio case(compound page), but didn't fix the
contiguous order 0 pages case. So i think it is better to send a v3 version
base on lastest Linus tree and drop the v2 version.


