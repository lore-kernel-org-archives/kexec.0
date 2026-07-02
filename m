Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D14C43458
	for <kexec@archiver.kernel.org>; Thu,  2 Jul 2026 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YqgqhnLGnVEDfWjNjM0BXN2S8815yYGAUBSzi9h+WUg=; b=MEnIJzGzzA9iAXY/EH2/flAZNg
	AL/NzFTMhDJEq9K9B+A9U0GAFneczXuwcJqzsAdbMH+R0HsJeEJTI3l7210CX5dVVIPvXlSIrwag3
	KbVyJWszktFdnEfB02gXglFMbRV/qKKPik+RgzgedA31tFl9FuZb6G/Q/Yut6ycvkCBtwx2JC+OIp
	DD1BrerVRwGEesoMCSDNipC4EZOHscsJpOg/47L8scsgqrYki6Dv4mVMB6nGmNd8bdrNesdUUWGF/
	bcvvwG8KJtmYIaNriMoDcko0a24nvwfzdLG9B2xEOg3tuXUwvemO4I2sjh33oDG29QoZzSNgeQNvv
	3Arg4U3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfN86-00000005MlF-3PCz;
	Thu, 02 Jul 2026 19:31:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfN84-00000005Ml7-0AsX
	for kexec@lists.infradead.org;
	Thu, 02 Jul 2026 19:31:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E54E402ED;
	Thu,  2 Jul 2026 19:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0008D1F000E9;
	Thu,  2 Jul 2026 19:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783020678;
	bh=YqgqhnLGnVEDfWjNjM0BXN2S8815yYGAUBSzi9h+WUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ser2G7/gyDTtPclUiqGqOPKsh2tfck2pPmsUN1wlniesfdGw3/hRPW4tbqharLuV6
	 O8a0ACdZe5VW5cH1DG0i4s5q5wLoUgXxmWf/cWOR1zu6868nJYXXqt3b6c+UirCti3
	 nm/odCPm5+XUD0TekX/6Gze+G228ED+0hL4aXlC55YHfpZTYQHo4kjeMUVrxxuZOrV
	 W/2K/4FX3VUHhWskVe7e7eXAy8/WTtxKJWCIf/6HhsLm1BSxGi/ijigNB+6S/7FnNy
	 KRMSXxj1OQxd8FiZfCe+l+6gLgBL1+v9vGsIHJHSLXk7ISqbbozINRxBvBHg1I7lBf
	 xpcwEzEzHDGfw==
Date: Thu, 2 Jul 2026 22:31:11 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Pratyush Yadav <pratyush@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH] x86/setup: do not include kexec_handover.h from
 asm/setup.h
Message-ID: <aka8f1RNJH-zI7Kl@kernel.org>
References: <20260701151536.3068791-1-pratyush@kernel.org>
 <20260701165714.GAakVG6p191JTJ0nJS@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701165714.GAakVG6p191JTJ0nJS@fat_crate.local>
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

On Wed, Jul 01, 2026 at 09:57:14AM -0700, Borislav Petkov wrote:
> On Wed, Jul 01, 2026 at 05:15:33PM +0200, Pratyush Yadav wrote:
> > From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> > 
> > x86 asm/setup.h includes linux/kexec_handover.h. This is because it is
> > used by setup.c and kaslr.c. But this inclusion is problematic. The
> > header is included in many places, so it results in the KHO header being
> > propagated there. Also, the setup header is used by realmode code. If
> > KHO header includes things like mm.h, it causes a big dump of
> > compliation failures.
> 
> This is exactly why we are trying hard to block people from using more linux/
> namespace headers in the decompressor code. Please split it and put only the
> bits that are needed by the decompressor into a header in
> arch/x86/include/asm/shared/ and use that in the decompressor.
> 
> There are examples there.

The examples there are really x86 specific.
KHO needs decompressor to recognise 'struct kho_scratch' that's defined in
include/linux/kexec_handover.h

I see there's a duplicated 'struct efi_unaccepted_memory' for decompressor
needs, should KHO do the same for 'struct kho_scratch'?

-- 
Sincerely yours,
Mike.

