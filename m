Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6539DE7718A
	for <kexec@archiver.kernel.org>; Thu, 19 Dec 2024 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3/QwrzJsiwP+XrKwjXSVNe4saEEyevlgRCTrrfhZb+E=; b=K5HH54//VHFRd/5ZOOhSSlEth8
	rb5CFxfc0DS+Ut+pu45wkijN1lz0DRlXAex3vmFwVbnNStnBIGFnl4Tvs+i/fLfMbUiF01fqWvIae
	T4C0z/srfttEt2xgRrqUisner4tbfBIhtj5u7ROUbKfm6KRHuidROBnGPFbwIiZXomBYHtQY0akBL
	46VsK37y8eaJ8oKJ+AMOBSRdKcODNelXHEi3wEHNb2JRxwPBzV5fDSKgrTrN7jtHELFhFFQ4MoYE0
	N5vfCML510c0jQ9jM3wd6R7tCFGwRBCUeL/J6ad6q5F0cHRx1Z1z2Tsu3XmbtR90KuoxGP6VSrRmc
	DWRZKaog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOP0Q-00000003GWm-1imZ;
	Thu, 19 Dec 2024 22:28:30 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOP0L-00000003GVp-3eHP
	for kexec@lists.infradead.org;
	Thu, 19 Dec 2024 22:28:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DAEB2A42A2B;
	Thu, 19 Dec 2024 22:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A583FC4CED0;
	Thu, 19 Dec 2024 22:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734647304;
	bh=79H2dkuKzWYOcCVtdE3fcGrUAnwuaGNK/vpt2JprKBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgM93Nt4ID+MkG/UCIiE9fEhFrjZGJxqpq6lDw6rHGhLS5hhOMjBxzFHQ/AMMGpdO
	 Rm2FsD6TRpxuMH0tYp99HXT4SrsqdfJeYFq14RChd7E/9pWubXsSFNuxSkBUTa5oj6
	 QeASkzstE2EvvMYJicWawVNSJiLLzBWndYXoQAXm4yeqKRrIRiLLNPCPTI8pQuUU3C
	 9lhLqG951HnX57VCO29r0D4eTDg1FBsKUJ7zmoR+uuAaV1KLrgZbqs3krx9+SxEX8J
	 xTrw1iDRb/jGPYOSIIcjz/PTnrFfaUQwLNyOguH4nad9jUW7o6sMbCRXIUp55a9Ovu
	 zioXsPjqUvgDg==
Date: Thu, 19 Dec 2024 14:28:21 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Nathan Chancellor <nathan@kernel.org>, kexec@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de
Subject: Re: [PATCH v5 07/20] x86/kexec: Invoke copy of relocate_kernel()
 instead of the original
Message-ID: <20241219222821.c6o3peznyzoxaslj@jpoimboe>
References: <24d843d2ceb09acdae494ee9a17ec94bf8bb4e4f.camel@infradead.org>
 <20241216054942.GA25019@ax162>
 <79ea9c10ae4f1dae16be8c05bb7b7e6b72512f10.camel@infradead.org>
 <9ee61d2b89b4cecd10ece64002bf2c06648e1de7.camel@infradead.org>
 <20241218090305.y4o62pmdwq32732h@jpoimboe>
 <5857ef047402c3ded29d4c024f8fdc32608f1696.camel@infradead.org>
 <20241218212326.44qff3i5n6cxuu5d@jpoimboe>
 <dc059a127d59ccc77be0c92b686f72616c2d1c0f.camel@infradead.org>
 <20241219002015.7y5ohlfofc6c3njr@jpoimboe>
 <7e7eda28bf697752435dc730d689cd3edf9bf013.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e7eda28bf697752435dc730d689cd3edf9bf013.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_142825_968192_D032D699 
X-CRM114-Status: GOOD (  18.56  )
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

On Thu, Dec 19, 2024 at 11:02:55AM +0100, David Woodhouse wrote:
> On Wed, 2024-12-18 at 16:20 -0800, Josh Poimboeuf wrote:
> > Anyway, what I think you're looking for is UNWIND_HINT_UNDEFINED.  In
> > fact all the unwind annotations in that file should be UNDEFINED since
> > the hints are all referring to the wrong addresses (because copied code)
> > and the ORC unwinder isn't reachable for most of that code anyway.
> > 
> > Also, it's fine to make relocate_kernel() a proper function with
> > SYM_FUNC_END, you'd just need to add the following line afterwards:
> > 
> >   STACK_FRAME_NON_STANDARD relocate_kernel
> > 
> 
> Thanks, I'll take a look. The next thing objtool is actually
> complaining about is that relocate_kernel() itself is not reachable
> (since it's never invoked in its original location):
> 
> vmlinux.o: warning: objtool: relocate_kernel+0x0: unreachable instruction

Right, I think UNWIND_HINT_UNDEFINED should fix that.

-- 
Josh

