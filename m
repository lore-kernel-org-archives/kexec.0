Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B237C44506
	for <kexec@archiver.kernel.org>; Wed, 21 Jan 2026 20:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kxc8fbJ+YY/2mA4Y0hAPpk62i8tV5kY4KJhCC1TX1jI=; b=QHVMkXubzZY188rHEeFA4APaI3
	DNnue3DZdRPSkevhUWM5feJ0mtE6D+nhlz3zKvczxftcjtYuXCQqB/CPyytsa8zVesRxkp3O0WsVb
	cKNlMRvzK1KHjSguOUwlwvTcOP0DhMfDkYnu2svLiVibDAYsnFYCIaAEyA1e55XekVpk3nAFwneGJ
	8/EeBgt+qgC4KmzLd4vutSSCOhH2o7lgiZZdv5A3RYmynzv/KobO0pFSYKUpQv/Y8G2CtwypHEwDO
	aug+ZK0HF+Ii6u9PW+++XsaaU1exxogBu9fYJvvWs4HMbmEwGpMdjOSt9YkWyeYsony7JKSIrgTcy
	flEuQecQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vieUr-000000060up-1PP6;
	Wed, 21 Jan 2026 20:08:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vieUo-000000060uU-2qjV
	for kexec@lists.infradead.org;
	Wed, 21 Jan 2026 20:08:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D8874409E;
	Wed, 21 Jan 2026 20:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE712C16AAE;
	Wed, 21 Jan 2026 20:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769026085;
	bh=yqttsfp1H+CLzQVJq0KmeD/aQFf9NmqtJ1yLdINQEtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e4uPDbwGhe7WwGvbYMTyV0bUrH75qbZWQcxDllCsYJ3ZkNm/b4OHV9tHT2+IDNwoD
	 b0nb18sh7q+FJR9OgdJzD4TarzbY27ukhztPDZOvSKu/hHD+YluhAk5Rm6AKHXs+yu
	 R3JGxuBJgjd7278oNPiMQk2w7xbICOJVhyHvtMZA=
Date: Wed, 21 Jan 2026 12:08:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: ranxiaokai627@163.com
Cc: pratyush@kernel.org, surenb@google.com, pasha.tatashin@soleen.com,
 kent.overstreet@linux.dev, rppt@kernel.org, graf@amazon.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, ran.xiaokai@zte.com.cn
Subject: Re: [PATCH v3] kho: init alloc tags when restoring pages from
 reserved memory
Message-Id: <20260121120804.d1334ea0cc66b4a6de691cbf@linux-foundation.org>
In-Reply-To: <20260121143430.175294-1-ranxiaokai627@163.com>
References: <20260121143430.175294-1-ranxiaokai627@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_120806_898660_9C877AAF 
X-CRM114-Status: GOOD (  15.51  )
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

On Wed, 21 Jan 2026 14:34:30 +0000 ranxiaokai627@163.com wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> Memblock pages (including reserved memory) should have their allocation
> tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> released to the page allocator. When kho restores pages through
> kho_restore_page(), missing this call causes mismatched
> allocation/deallocation tracking and below warning message:
> 
> alloc_tag was not set
> WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1: swapper/0/1
> RIP: 0010:___free_pages+0xb8/0x260
>  kho_restore_vmalloc+0x187/0x2e0
>  kho_test_init+0x3c4/0xa30
>  do_one_initcall+0x62/0x2b0
>  kernel_init_freeable+0x25b/0x480
>  kernel_init+0x1a/0x1c0
>  ret_from_fork+0x2d1/0x360
> 
> Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> fix this.
> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
> It is based on linux-next 20260120. I dont konw whether this base is ok ?

It's awkward.

Your v2 patch was based on Linus mainline.  This is appropriate, as the
patch should be sent to Linus soon and it has cc:stable, so -stable
maintainers will try to backport it into earlier kernels.

However your v3 patch is dependent upon other material ("kho: simplify
page initialization in kho_restore_page()") which is scheduled for
6.20(?)-rc1.

For a prompt, backportable merge it's best to base the fix on latest
Linus mainline, please.

You didn't actually describe why v3 is different from v2.  If the
v2->v3 changes are just nice-to-have then let's redo those and base
them on linux-next in the usual fashion.

Unless I'm missing something, your well-reviewed, decently-tested v2
patch remains suitable for upstreaming during 6.18-rcX?

