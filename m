Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D8ACD4851
	for <kexec@archiver.kernel.org>; Wed, 13 May 2026 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U5FgpYdWutcIouGicjgojW9gOVO0tiNobAoLydLLHpI=; b=WqR3WKv910FNUaoKqfTpOZY0e3
	kiKA8SFek3orEwol+ugaC6UZN5vhPGc/UCc6/p2PWoZ/UMjJNsWF93nchDu8tO10X1q6sdA+dO6Ko
	NyzZAUbBTrA5mgoR2LKy43teTBN/M/7axFQWIGCrDZh7WFRBLKn5CxYQqNr/XQS+6q6P/SUFk9Rex
	9Q06YvBcelp8biR3XVoAcMe5xZLXqfKxi2tEiESORvpFpzd4upPuJelqYiob1a5DCKWALndinl71l
	HiP37NjYgbBwOWrzAFq4rB0+m4MQOOrdRJgY4yXfZ3Tb+POFL2ui0TyG6dKepUwTtJ15h76JwmSlU
	S1PFonBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNBCg-000000031ph-3tJW;
	Wed, 13 May 2026 15:08:54 +0000
Received: from mta1.migadu.com ([2001:41d0:203:375::] helo=out-172.mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNBCd-000000031gM-2ks7
	for kexec@lists.infradead.org;
	Wed, 13 May 2026 15:08:53 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778684848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5FgpYdWutcIouGicjgojW9gOVO0tiNobAoLydLLHpI=;
	b=NE/mD9WC9zOAcd3zhlSYl0Cqj9YZsIOlgArz6a2uSxTzDzgPNbdatWQb46xgsRMfDyQyuO
	FbhokL+ZCFFbeOjECotujV7IQL/rnfpmKH9ArHa+ck4pceT+KZILLm/yK/zSjPk4buHBk5
	/v8g66veXLhfQVWNf+k3kxmXnoKJajI=
From: George Guo <dongtai.guo@linux.dev>
To: pratyush@kernel.org
Cc: akpm@linux-foundation.org,
	dongtai.guo@linux.dev,
	graf@amazon.com,
	guodongtai@kylinos.cn,
	jasonmiu@google.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liukexin@kylinos.cn,
	pasha.tatashin@soleen.com,
	ran.xiaokai@zte.com.cn,
	rppt@kernel.org
Subject: Re: [PATCH 1/1] kho: fix KHO_TREE_MAX_DEPTH for non-4KB page sizes
Date: Wed, 13 May 2026 23:07:18 +0800
Message-Id: <20260513150718.182224-1-dongtai.guo@linux.dev>
In-Reply-To: <2vxzcxz2dybi.fsf@kernel.org>
References: <2vxzcxz2dybi.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_080851_835610_0E37834A 
X-CRM114-Status: GOOD (  11.06  )
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

Sorry for the late reply.

On Mon, May 11 2026, Pratyush Yadav wrote:

> As of now, we only support KHO on x86 and arm64. Are you working on
> supporting it for LoongArch? What is your use case?

Yes, we are adding KHO support for LoongArch (16KB page size). The
LoongArch patches are being prepared separately. This fix is a
prerequisite.

> Maybe I don't understand the math so well, but I can't see the problem.
> ...
> level = 4, s = 50, idx = 1
> What am I missing?

The issue is that all three operations start the traversal at
KHO_TREE_MAX_DEPTH - 1, not KHO_TREE_MAX_DEPTH:

  kho_radix_add_page()  line 180: for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--)
  kho_radix_del_page()  line 255: for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--)
  kho_radix_walk_tree() line 356: __kho_radix_walk_tree(..., KHO_TREE_MAX_DEPTH - 1, ...)

So with depth=4 the effective top level is 3, not 4.

phys_to_page() of that address faults in kho_preserved_memory_reserve().

This is confirmed by a kernel panic on 7.1-rc3 LoongArch (16KB pages)
without the fix. With depth=5 the top level is 4 (shift=50):

  (key >> 50) % 2048 = 1   /* order bit correctly captured */

Signed-off-by: George Guo <guodongtai@kylinos.cn>

Panic log on 7.1-rc3 LoongArch (16KB pages) without the fix:

[    0.000000] CPU 0 Unable to handle kernel paging request at virtual address 00003d3ffe000028, era == 90000000c162f10c, ra == 90000000c162f0f8
[    0.000000] Oops[#1]:
...
[    0.000000] Call Trace:
[    0.000000] [<90000000c162f10c>] kho_preserved_memory_reserve+0xc4/0xe8
[    0.000000] [<90000000c0129f88>] __kho_radix_walk_tree+0xf0/0x138
[    0.000000] [<90000000c0129f10>] __kho_radix_walk_tree+0x78/0x138
[    0.000000] [<90000000c012b730>] kho_radix_walk_tree+0x88/0xe8
[    0.000000] [<90000000c162f874>] kho_memory_init+0x220/0x4e4
[    0.000000] [<90000000c1639b38>] mm_core_init+0x168/0x1a0
[    0.000000] [<90000000c1620d50>] start_kernel+0x5c4/0x778
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!

