Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24850C4332F
	for <kexec@archiver.kernel.org>; Fri, 14 Oct 2022 13:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FfYH22/fGc+VqJ7orE3vNT28w651nnkcMDw0gESxNns=; b=a5Njt8fRPzEwOy
	qVgGoEWpSGk4hFbZMDOt/BC1F6x6ziDB6aPuVeai4cFIEhdnNFPuiu39/sl3cNb8BzoqB99g7gAiW
	dLUnPH6UyTYPKhJiuEao5mLr3aM/0PskBwshN0AzDTtIfo4GKQs/1wSZ5WGDXgoBph7OC0ZQwKDSW
	uuZJa1iulxNI2xlzL1KB4j/V8z2phFIutwBkXa/+o/5e4OiNT0KaGJVbtpjolQ8MVVc9qcoTMXfA2
	/+d+YcbcH1BOht6pBaO4ewp1JMyHBNzSz3n8ODnYJ52RjfTXlopfzdylAhTL4voV7UuXylPMnRbT1
	02SJtWbYphOidkmu9ZoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojKSM-00EjJu-Rw; Fri, 14 Oct 2022 13:10:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojKSJ-00EjJD-Ls; Fri, 14 Oct 2022 13:10:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B92FF61AB3;
	Fri, 14 Oct 2022 13:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE029C433D6;
	Fri, 14 Oct 2022 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665753026;
	bh=0UWfEXADH79SUIFSFUOzUN9Z7O8mN3bA71DoAjm0o+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAnusdpMXtsxh0cy7ysADo6KpporNRqVtaAUVHwP4HKdj1SWp7d7KsG0eSoRBmbie
	 bxyeKQUzukN8nWu8Ng6T26lghfSZ/EnF+6wHyYA6M0gpbmUVIrv6sQ0pWTCQErzL4L
	 XXqyBLNhoX0TSWIvR+Y66zKf4UKT3XlR/zbBpwcKtNoT5TBLkY3jqxm+LIRyYRrWYj
	 DaYQp0k6NWcDDTsx2Vfu5iq0GvU9PzFPwCPzQf6U2g0sT48FujD+jzrFUPQm6gMVSf
	 rofOMGrFDoT+eBM4miIpcoZ2QLHPz/m3lzPyVbhVpydjG5B7YlF1ds3Nl7bIF3cqLJ
	 TuOMEMPfmzngA==
Date: Fri, 14 Oct 2022 14:10:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Xianting Tian <xianting.tian@linux.alibaba.com>,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	anup@brainfault.org, heiko@sntech.de, guoren@kernel.org,
	mick@ics.forth.gr, alexandre.ghiti@canonical.com, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
	Conor.Dooley@microchip.com, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, crash-utility@redhat.com,
	heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
	hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH 2/2] Documentation: kdump: describe VMCOREINFO export for
 RISCV64
Message-ID: <Y0lfuixXue4k4poY@spud>
References: <20221014074810.4471-1-xianting.tian@linux.alibaba.com>
 <20221014074810.4471-3-xianting.tian@linux.alibaba.com>
 <Y0ldrJ91ac0um3++@debian.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y0ldrJ91ac0um3++@debian.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221014_061027_817083_FD4D5FBE 
X-CRM114-Status: GOOD (  15.55  )
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

Hey Bagas,

On Fri, Oct 14, 2022 at 08:01:32PM +0700, Bagas Sanjaya wrote:
> On Fri, Oct 14, 2022 at 03:48:10PM +0800, Xianting Tian wrote:
> > The following interrelated definitions and ranges are needed by the kdump
> > crash tool, they are exported by "arch/riscv/kernel/crash_core.c":
> >     VA_BITS,
> >     PAGE_OFFSET,
> >     phys_ram_base,
> >     MODULES_VADDR ~ MODULES_END,
> >     VMALLOC_START ~ VMALLOC_END,
> >     VMEMMAP_START ~ VMEMMAP_END,
> >     KASAN_SHADOW_START ~ KASAN_SHADOW_END,
> >     KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END
> > 
> > Document these RISCV64 exports above.
> > 
> 
> The patch description LGTM, thanks.
> 
> > +----------------------------------------------------------------------------------------------------------------------------------------------------
> > +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
> > +----------------------------------------------------------------------------------------------------------------------------------------------------
> 
> The overline above header text is unnecessary, so I have to strip it:
> 
> ---- >8 ----
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 6c7a1728de220e..8e2e164cf3db49 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -615,7 +615,6 @@ phys_ram_base
>  
>  Indicates the start physical RAM address.
>  
> -----------------------------------------------------------------------------------------------------------------------------------------------------
>  MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
>  ----------------------------------------------------------------------------------------------------------------------------------------------------

Without whitespace highlighting, your change threw me for a sec.. But
yeah, having the overline is inconsistent with other headings in the
doc.

What I wanted to ask about was the linelength as I don't know anything
about rst. Is it possible to avoid having the ~150 character line or is
that a necessary evil?

Thanks,
Conor.

>  
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
