Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90032CD4F54
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 07:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ngk4gUL5eOt+YzcG2pEJx/fEU902BO0rDrmbW7CZbM=; b=cjFCSlGNSAgOQ3kdF6SFEpPv4E
	ZtIzQtuUVpnJvTc2PAW4tVng3yUAR9HLdygXb6HhIzX2TIEZ8O/2AeKsETgmte3srIuQDo/AR8iuH
	EtQHHwuW+/PMXHeyXVgq1xrbxyii/QiPTYvSZI1SV1FElPgk+clMULFQKV4wIv887wpIb4GO4Zv/x
	Omj+1E/s4xePWC0vFqgD9EVt7vOKcMvjcxEw846ki4TBsaBYouQ+3f7dNApOfl56G5O516cg1e0Om
	h0gvIllnLmuad28yMoxUCY5yUGmuqNqaNHZ7ZClLZ3MCRfpcnmd9jPtkkSHmbTifBRVQNr590wKMT
	yhorEQMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8fa-00000003Seg-3xj4;
	Wed, 27 May 2026 07:27:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8fZ-00000003SeH-1WQl
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 07:27:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3B8EF439F7;
	Wed, 27 May 2026 07:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301391F00A3A;
	Wed, 27 May 2026 07:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779866832;
	bh=/ngk4gUL5eOt+YzcG2pEJx/fEU902BO0rDrmbW7CZbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bDR1RSYUmx0vT2tYjybhmh8RbA3S+AQAakPr7zo6AkXKsFX91fdQuGdKGW6ndK1jx
	 bfnxYU8U4HSYwE1ZYTATUNlbMtvAjZ+005n1lUa0dD+6jfab/oRY5zWG5kL1cy1+RB
	 /f4fhLC9EC2/9MCnRPER+H3XaTd9bYoz/Mx+JD+cy0l3Hzbih+KoIiJeqbK1jkB4E3
	 BljznW8HdXa8vkH/mtWpJEdpunhoM6l+47e2z7exOFFcLVXmP+9nKO7FRj1rWOW/lo
	 pfxZlzyDX6DW4yLNBHp8VVILL2305SyqTmCOykVtOS0j5X2fZBWqB1zlSEp3yaUkB1
	 rRbg30n7komXg==
Date: Wed, 27 May 2026 08:27:09 +0100
From: Simon Horman <horms@kernel.org>
To: luo.haiyang@zte.com.cn
Cc: kexec@lists.infradead.org, zhang.run@zte.com.cn, cai.qu@zte.com.cn
Subject: Re: [PATCH v4 2/4] RISCV: Fix incorrect virtual address translation
 in? crashdump load
Message-ID: <20260527072709.GA51310@horms.kernel.org>
References: <20260521120643491yZJMsKq2fLbFcvtV5ukN1@zte.com.cn>
 <20260521120946097C8qpZkVC2mBT_ozYEHlhp@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521120946097C8qpZkVC2mBT_ozYEHlhp@zte.com.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_002713_423087_C0D22D00 
X-CRM114-Status: UNSURE (   9.60  )
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

On Thu, May 21, 2026 at 12:09:46PM +0800, luo.haiyang@zte.com.cn wrote:
> From: Luo Haiyang <luo.haiyang@zte.com.cn>
> 
> The kexec shows the following crashdump log:
> 
> Elf header: p_type = 1, p_offset = 0x80100000 p_paddr = 0x80100000 p_vaddr = 0xcff000 ...
> Elf header: p_type = 1, p_offset = 0x100000000 p_paddr = 0x100000000 p_vaddr = 0x80bff000 ...
> Elf header: p_type = 1, p_offset = 0x87ffff000 p_paddr = 0x87ffff000 p_vaddr = 0x800bfe000 ...
> 
> Obviously, phys_to_virt returns an incorrect virtual address (vaddr). On the RISC-V architecture,
> the linear address mapping is defined as:
> va = pa + kernel_map.va_pa_offset (kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base)
> Both PAGE_OFFSET and phys_ram_base can be read from /proc/kcore.
> 
> Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>

Hi,

Unfortunately this patch seems to be somewhat mangled
and does not apply. Could you look into that?



