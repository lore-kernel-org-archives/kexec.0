Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF480C4332F
	for <kexec@archiver.kernel.org>; Mon, 17 Oct 2022 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k4J7zqYLXuBzKu2SEDEJJcPi2FzIwMFAj/oRpT1ioWw=; b=EVyLPaelxqrgHD
	kKgplmzTHXjUThTusdp+VotDokZg3xOx+SOi54nkO05kPIcGJkuDqkz0Ou0ankKOXh/aASF252nDn
	3WcjGi7/LJBuYzqUGXX2DfMIUhjo8VJVo8e1KOj9Wv7rAkpl9q1nQnyu9DQ5d7Qo48zPcE+o73h5v
	4PPSTqvjJlQW92Md0UaPs2NO5pdIjIVVlGs5fyJ6yRynUFRiZJXNMoYWLZJIOZbsAIKuJ0IsHVscq
	PR3DJbaWJi83vyC2IxVaL8N6bz5esZTnLlQDtgjcrerUR+1Q1dTbMGqZGbkgoH47ENFfVzD+e3vW8
	KplJaSc0UtIb6awv2tIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okVyK-00EZTK-17; Mon, 17 Oct 2022 19:40:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okVyH-00EZS6-5c; Mon, 17 Oct 2022 19:40:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EC18C611FE;
	Mon, 17 Oct 2022 19:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA86C433D7;
	Mon, 17 Oct 2022 19:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666035619;
	bh=PoXBeSReIgM+CQoQFfALFgw1SR3n3qlfZ7NKvcrE5EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLbdx3qp4igqZeYdoIqsPx9OipZNjUoAH5jTM6hMaf60PyURO4ukHV+fiCMlCstS6
	 InK/ibE8Wt4PT1Usl94deknM1j9AjVmCyqP9OuwOq2hH007N5KvOVAfbLuhX1ojWhU
	 /hJ2yc8kHTbw2pViQF+1oOE5xW1kiSHft+Cq/Gf2kJN3F6PTRwY00D7mgseDw6oX2b
	 UAgHHWDyHVIBYRKgGUqmbugxXX7qidWPpKcNGf+uaAsCO3fEZAlE93oazPcjUQQz+c
	 pfZ973IIquhBinsUzB5soRIdDqcWZdTMPBLNeXHJ5S4s2Nbef0C91W6qhWRRfR7i1e
	 xm66VcLLXdhvg==
Date: Mon, 17 Oct 2022 20:40:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	anup@brainfault.org, heiko@sntech.de, guoren@kernel.org,
	mick@ics.forth.gr, alexandre.ghiti@canonical.com, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
	Conor.Dooley@microchip.com, bagasdotme@gmail.com,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
	k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V2 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
Message-ID: <Y02vm7FrhdEoSXZ+@spud>
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_124021_330162_C94C76FC 
X-CRM114-Status: GOOD (  18.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Oct 14, 2022 at 09:41:39PM +0800, Xianting Tian wrote:
> The following interrelated definitions and ranges are needed by the kdump
> crash tool, they are exported by "arch/riscv/kernel/crash_core.c":
>     VA_BITS,
>     PAGE_OFFSET,
>     phys_ram_base,
>     MODULES_VADDR ~ MODULES_END,
>     VMALLOC_START ~ VMALLOC_END,
>     VMEMMAP_START ~ VMEMMAP_END,
>     KASAN_SHADOW_START ~ KASAN_SHADOW_END,
>     KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END
> 
> Document these RISCV64 exports above.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  .../admin-guide/kdump/vmcoreinfo.rst          | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 6726f439958c..8e2e164cf3db 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -595,3 +595,33 @@ X2TLB
>  -----
>  
>  Indicates whether the crashed kernel enabled SH extended mode.
> +
> +RISCV64
> +=======
> +
> +VA_BITS
> +-------
> +
> +The maximum number of bits for virtual addresses. Used to compute the
> +virtual memory ranges.
> +
> +PAGE_OFFSET
> +-----------
> +
> +Indicates the virtual kernel start address of direct-mapped RAM region.

Apologies for not seeing this sooner, but should there not be a "the"
prior to "direct-mapped"?

> +
> +phys_ram_base
> +-------------
> +
> +Indicates the start physical RAM address.
> +
> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
> +----------------------------------------------------------------------------------------------------------------------------------------------------
> +
> +Used to get the correct ranges:
> +
> +  * MODULES_VADDR ~ MODULES_END : Kernel module space.
> +  * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
> +  * VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.

Since I'm in pedant mode, it does look a little odd that you're using
region for vmemmap but space for the others but idc that much.

Thanks,
Conor.

> +  * KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
> +  * KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
> -- 
> 2.17.1
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
