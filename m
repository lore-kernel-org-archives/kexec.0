Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3308BC982FF
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ic/h6nB8JUlBM8zaXvVjgvTf0SPmAf0fMbuRRf6h1OU=; b=kEm4q931anXT3Q571tLaoiGlVD
	8mHKNTdfZGmoUztihPEJdiQfqtUAx26ICGuQ5ISHCZSpm8Y6GzpPp7AFh0zro5hijaKry67fD1KS9
	7s9Q4qF1V1UB0k5cRWnn/+kh4KG36DNnpXLwKy3UNb4F2E2Wmq1Zwrb6Bg4CqKmBif+qPC1bPvNU1
	7nLh/P1rSmiIpRkL4u46Jp2XOdZIm3d1t9qJL+BFeW5A/yjJrzZJuVbxGT0fEjfWmRQUIR4o0ZzMz
	PjsvjwnaDe8D4Q2XnwtAeQmwfSrqqxZLs5EiZ9RFpgsvq/aRABjVlFjA9ZqrAO43/UyzLKZq1diml
	ejcluBCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ze5-00000005JLn-2aeZ;
	Tue, 22 Sep 2026 12:30:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ze4-00000005JLg-15Vm
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 12:30:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AAF2B43E20;
	Tue, 22 Sep 2026 12:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E541F000FF;
	Tue, 22 Sep 2026 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080247;
	bh=Ic/h6nB8JUlBM8zaXvVjgvTf0SPmAf0fMbuRRf6h1OU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=O4TcHUGvDUaiZAcbWB6yDzYBqy/coJnW/7scfWIrPA9JZxubQUqIJf+7nKN83DAvz
	 U3rD2gr4++NFyoHbWT7OGBHQAnistbtAfT9opp3pPyes8L3+xOT//5ld67ttl0foKz
	 nXPLSXKR+pImSUOXClFkHmJBrLLIrFeQMPqtNcb9BryKjXCfhBjEnN9oi8UW7pkOYA
	 Hq+AfNeeC/W59e3rt+G6pf9lVI8MhGhbKvOoZk761TLTZJ9xR5xBsZNMSg2dNWGc8+
	 FIGiRNf6VjsnCN/LNVHx/rSj4nVE7vE+zwGwcigogdyg+GL6/GP2A9eRl5QX8kga0z
	 ZSCN83j72ugfQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: rppt@kernel.org,  pasha.tatashin@soleen.com,  pratyush@kernel.org,
  chenhuacai@kernel.org,  ardb@kernel.org,  shuah@kernel.org,
  ilias.apalodimas@linaro.org,  akpm@linux-foundation.org,
  baoquan.he@linux.dev,  ruirui.yang@linux.dev,  guodongtai@kylinos.cn,
  kernel@xen0n.name,  graf@amazon.com,  liukexin@kylinos.cn,
  loongarch@lists.linux.dev,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kselftest@vger.kernel.org,  linux-efi@vger.kernel.org
Subject: Re: [PATCH v5 3/5] liveupdate: kho_block: include linux/mm.h for
 virt/phys translation
In-Reply-To: <20260904100852.26006-4-dongtai.guo@linux.dev> (George Guo's
	message of "Fri, 4 Sep 2026 18:08:50 +0800")
References: <20260904100852.26006-1-dongtai.guo@linux.dev>
	<20260904100852.26006-4-dongtai.guo@linux.dev>
Date: Tue, 22 Sep 2026 14:30:43 +0200
Message-ID: <2vxz5wzx5uz0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Sep 04 2026, George Guo wrote:

> From: George Guo <guodongtai@kylinos.cn>
>
> kho_block.c calls virt_to_phys() and phys_to_virt(). On LoongArch with
> CONFIG_KFENCE=y, these macros (in arch/loongarch/include/asm/io.h) expand
> to offset_in_page() and page_address(), both declared in <linux/mm.h>.
>
> Since kho_block.c does not include <linux/mm.h>, the translation unit
> fails to build with CONFIG_KFENCE=y:
>
>   asm/io.h: error: implicit declaration of function 'offset_in_page'
>   asm/io.h: error: implicit declaration of function 'page_address'
>
> Add the missing include to fix these build errors.
>
> This is the same root cause as the luo_session.c build fix previously
> acked by Mike Rapoport [1]; the virt_to_phys()/phys_to_virt() calls have
> since been refactored from luo_session.c into kho_block.c, so the fix
> moves with it.
>
> [1] https://lore.kernel.org/r/ai5nYlbERQBXRHSp@kernel.org/

Drop this paragraph please. History of previous patch postings doesn't
belong in the commit message. You should write this kind of things below
the "---".

>
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  kernel/liveupdate/kho_block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
> index 0d2a342ef422..0d56891b2f4c 100644
> --- a/kernel/liveupdate/kho_block.c
> +++ b/kernel/liveupdate/kho_block.c
> @@ -25,6 +25,7 @@
>  #include <linux/kho/abi/block.h>
>  #include <linux/kho_block.h>
>  #include <linux/slab.h>
> +#include <linux/mm.h>
>  
>  /*
>   * Safeguard limit for the number of serialization blocks. This is used to

-- 
Regards,
Pratyush Yadav

