Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80E8CD98D2
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 08:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=que3sP/ffeF4LlJToSGURdqIREPWzcMga9glwfB2Yns=; b=EbHbgCkLVaCrB4KEIcNg1ZTxfq
	V4iQMFFaowSIVJ+JnhWB2bDMfGyc3X5CbsYFswYC4iICYPb265P3iIOIYsl4lBgJ+9IZE/hzPfn95
	YHkzzW1oq9Gvylb5YTL/ItAwS2uvmSy79+zbAiQqzr6cljLWPydLJXWdcgnMW7XwtYfn/DGzvLCI+
	9L6uP/pS/+8DYIyf1dJ9G42J9rpW2reFc1mHNtcewBUn7SzJtEtCS6gwoMuKSKeEmsyyiMh2zked1
	Z7Sfn7H76eTGG5Yx/mLvd+w0Ba6t8HDs0/2MLEXqQkt7Zjkv5pd09wB9fkZsN3HGJaWln7j43kJZp
	XOC0ELuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYgHu-0000000CpB9-3gaI;
	Sun, 14 Jun 2026 08:33:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYgHq-0000000CpB3-1LRD
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 08:33:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8473740AC4;
	Sun, 14 Jun 2026 08:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D2E1F000E9;
	Sun, 14 Jun 2026 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781426025;
	bh=que3sP/ffeF4LlJToSGURdqIREPWzcMga9glwfB2Yns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nREEMt4Ib5eW4hGLFtr1gAraUJGIK0UZ0C9Qr9FzmNuLq1kPIAE3Ac+3n3quuV0he
	 wBLzSaEUbRSNCiqYzNae661Q+lju6jVJmDJROXI8kGPhYLwXq2SP8k+SQA8N67s0sn
	 BOIeaputX6CfJr9ANR3wK6VUQFnL65+OHrgZ1nHn4qy8t04rkbA4+yYHpjTiT9jxHi
	 +FCnu4JFhKzoULBbmb/aJhuwK5v02AbQIcqKq2rH5CugOmi3rRyPnzpowzmBVn3KeW
	 gBwuBDM17mxpcDvID1dcUPy4JD91lZeeW5bRw5c7+Z0RLsPtFQmwEkKxehK+PnVeBv
	 5Q+qmTnF0x3gg==
Date: Sun, 14 Jun 2026 11:33:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org, loongarch@lists.linux.dev,
	George Guo <guodongtai@kylinos.cn>, Kexin Liu <liukexin@kylinos.cn>
Subject: Re: [PATCH v2] liveupdate: luo_session: include linux/mm.h for
 virt/phys translation
Message-ID: <ai5nYlbERQBXRHSp@kernel.org>
References: <20260604091913.306603-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604091913.306603-1-dongtai.guo@linux.dev>
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

On Thu, Jun 04, 2026 at 05:19:13PM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> luo_session.c calls virt_to_phys() and phys_to_virt(). On LoongArch with
> CONFIG_KFENCE=y, these macros (in arch/loongarch/include/asm/io.h) expand
> to offset_in_page() and page_address(), both declared in <linux/mm.h>.
> 
> Since luo_session.c only includes <linux/io.h>, the translation unit fails
> to build with CONFIG_KFENCE=y:
> 
>   asm/io.h: error: implicit declaration of function 'offset_in_page'
>   asm/io.h: error: implicit declaration of function 'page_address'
> 
> Add the missing include to fix these build errors.
> 
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Please send this patch along with the series that enable KHO on LoongArch.

> ---
> v2: Move the include from arch/loongarch/include/asm/io.h to the consumer
>     luo_session.c, instead of pulling the heavy <linux/mm.h> into the
>     low-level asm/io.h header (per review feedback). The 0-day report
>     confirmed the v1 approach introduces a circular include
>     (slab.h -> kasan.h -> asm/kasan.h -> asm/io.h -> mm.h, where mm.h
>     needs kfree() before slab.h declares it).
> Link: https://lore.kernel.org/r/20260521063310.52926-1-dongtai.guo@linux.dev/ # v1
> 
>  kernel/liveupdate/luo_session.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index 7a42385dabe2..4ce7128a4ae9 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -62,6 +62,7 @@
>  #include <linux/libfdt.h>
>  #include <linux/list.h>
>  #include <linux/liveupdate.h>
> +#include <linux/mm.h>
>  #include <linux/mutex.h>
>  #include <linux/rwsem.h>
>  #include <linux/slab.h>
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.

