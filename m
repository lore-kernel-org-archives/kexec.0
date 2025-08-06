Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443FEC87FD3
	for <kexec@archiver.kernel.org>; Wed,  6 Aug 2025 09:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PTXZ12hDGDcdzT4dTRf8gTd7m5ASw2z0AO9vV96Yq7Q=; b=ssSV1E1rqHDLtywtySBcjqDnnZ
	HdXBJzI3cajL28EiysAtGMiV42JMABTTt1WtJtK3KHz7yYZo17J20wEIqkF3h7GjXgMRZvhCLJGJJ
	7xGLrpAhlXOJvrLlAx/wWEnlyVkfuDixRuRn2mVj9oOESTH6eBj5AlCYdJqO+/8IelW6Z9oRT/A6e
	E1r8PuQrfN+6azORdiOorzdq25hzsRQOgohgDF5ZQEchrb6JnggstyF9KBO3YFMqFUeCGimzWLd1F
	XT+h0YR+gg88w2gWWqyvDcTAGMxsaiy2MHXFToB/VsT5+VPu/XH/ILyhTNQ/n0gZUsXoktgKuQHWE
	iVGl+WOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujaTA-0000000Em7v-0LFT;
	Wed, 06 Aug 2025 09:30:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujaEi-0000000EjzW-1gFj
	for kexec@lists.infradead.org;
	Wed, 06 Aug 2025 09:15:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 16F6341AAC;
	Wed,  6 Aug 2025 09:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CCAC4CEE7;
	Wed,  6 Aug 2025 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754471704;
	bh=d+HSvp78wIdEYoYgYEAgVxFykEJx5QIk0fRNJs0VDuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgQTiKoQyYEpSd3VK6sTRKnWGn+Ofp/7Yklj6IzdBy8gjp0HbNWDgPbrDsZKApPuT
	 RwCQ3hjkeJEToaZweUyahjhlVCFeked+lKhNi8qwmBhX49P+R8u+ItZVG10BDdoX4z
	 eCy1SMKB44S1AicRLMVpxBHLIuqxRHvE56AEbPw9n5wLqYyasmb9pTDuduPFHj57Xk
	 UniqALaSZlZfXXhtZQFP0wtFuI/FNSdG8fjUe97NocBk4mNAQsO9rZi7xAIbSbJ88s
	 NC2WaKglZ6j8EqzV18LG/QJDBcWq68PSuhE8LM1eFOlVrgQXx++kHJlbZmGSoZCclR
	 47O3G53gzy75A==
Date: Wed, 6 Aug 2025 10:15:00 +0100
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Askar Safin <safinaskar@zohomail.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	kexec <kexec@lists.infradead.org>
Subject: Re: [PATCH] fix printf string specifiers, otherwise kexec doesn't
 work on my laptop
Message-ID: <aJMdFFs8MVzTpYZ3@horms.kernel.org>
References: <20250805124722.11193-1-safinaskar@zohomail.com>
 <CAHp75VcUmOrfp21gij_-Ysrk5P=smTpfxmZHWgHU+z_VFZzc+w@mail.gmail.com>
 <1987a776a08.d9fe55e19764.4211219700074090609@zohomail.com>
 <CAHp75VfYP+QDzXGq5_8FQapUF26DZCyVHFPmr9+0ymRNQipyGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfYP+QDzXGq5_8FQapUF26DZCyVHFPmr9+0ymRNQipyGQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_021504_466744_AF9B4549 
X-CRM114-Status: GOOD (  18.15  )
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

On Tue, Aug 05, 2025 at 10:10:10PM +0200, Andy Shevchenko wrote:
> On Tue, Aug 5, 2025 at 3:41 PM Askar Safin <safinaskar@zohomail.com> wrote:
> >  ---- On Tue, 05 Aug 2025 17:00:45 +0400  Andy Shevchenko <andy.shevchenko@gmail.com> wrote ---
> >  > Thanks for your report and the fix! My comments below.
> > Andy, thank you for answer! I will write second version of my patch soon.
> 
> Just to be clear, if you want all changes you listed, it should be a
> patch series and not a single patch.
> 
> > Also, please look at another my report: https://lore.kernel.org/regressions/9eac81e6-b4ee-4210-84ac-cbf7bf811130@kernel.org/ .
> > Mario Limonciello said that we need you specially to proceed.
> 
> Thanks for heads up.
> 
> >  > > 3. uint64_t a; printf ("%w64x", a);
> >  >
> >  > Haven't heard about it. Which C/POSIX/etc standard is this?
> > Introduced in C23. https://www.c-language.org/ .
> > https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3220.pdf , 7.23.6.1
> 
> A-ha, then it's definitely no, even if it compiles with all used
> compilers. Too young a standard to follow.

It is a shame, as IMHO it's the nicest solution.
But I agree that we need to support somewhat older standards.

> 
> >  > > * Laptop Dell Precision 7780
> > Side note: I bought this laptop, because it seems to be the only laptop in the world,
> > which has ECC memory and in the same time doesn't have nvidia.
> 
> Hmm... okay.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

