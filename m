Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67E7E77187
	for <kexec@archiver.kernel.org>; Wed, 18 Dec 2024 09:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T9Rs3IEK9pDqV5LasBttLTxNXk/whqp+IzoicogzPqY=; b=iIH3bKOx1YZkzIrp1m7AozLJ5O
	3TyBNQtX7jwl2VDXeLsmBUjsSsfSbR3r62Ztuw4C5OQ3mgsLwyQ+c+N9YbNMCLFOuS5Fc+BDyguEk
	+AHPoGGxBIMKiii8UBINIh0AbNH4BAoVN4uboxpRP/+MRevWE/kmeJQE/3/XybPGFR8QX9cqF7Peb
	gHUcSIjW9Uv8pzkBOdDFvfynW3tCxoWf9mDBe/z3ZUFi/3ZD8jUCbGOnjGkrBGRPnaqm2Y3U27GTT
	yRMAWZHbe576yMyPkKqF0sPV39FLZL259KHYHpTNo1gzuzk00sUIOIWVJ0ylePMP/Damp18lXxn0+
	1+w6XqJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNpxY-0000000G0FY-2jkL;
	Wed, 18 Dec 2024 09:03:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNpxV-0000000G0ER-1kW9
	for kexec@lists.infradead.org;
	Wed, 18 Dec 2024 09:03:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A3FDA5C60EB;
	Wed, 18 Dec 2024 09:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9D5C4CECE;
	Wed, 18 Dec 2024 09:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734512588;
	bh=KAQ6/fswCYk6W29OO7hglKDSzu2pEyGIa9lofMh0cl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LF2+t3OhMJYhN/GUx8iKE3Dm2iqifbcjZZaM/zCJD1ccSg4q84IzNZwsxwxCrh/Yv
	 0Dn9tdrp3tVR26v8UU9RRaH6u7LD8h5OPtzErU/drSCq9DHtJSLcNAtC4F4QjhCaBu
	 lNf77sPhub/NFQXlrBHh2hz2iAatsebBEvbfMZmI1eYaiNn0DzshYzAhw3tZ9Aiu8U
	 58/hBxARJPcipRH1jMVgY/M11Jl4cq3S/WYtJeMdTfvogaX0heg3h64DlFpULXXU0u
	 R1Qt6yCv5rMjHFub64fh6mNQsVhX/yQMUgT8qQ0QVZpk3qjw1MjO/ASQCHhL/mcnfS
	 9KOWuympYOaRg==
Date: Wed, 18 Dec 2024 01:03:05 -0800
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
Message-ID: <20241218090305.y4o62pmdwq32732h@jpoimboe>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-8-dwmw2@infradead.org>
 <20241214230818.GA677337@ax162>
 <24d843d2ceb09acdae494ee9a17ec94bf8bb4e4f.camel@infradead.org>
 <20241216054942.GA25019@ax162>
 <79ea9c10ae4f1dae16be8c05bb7b7e6b72512f10.camel@infradead.org>
 <9ee61d2b89b4cecd10ece64002bf2c06648e1de7.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ee61d2b89b4cecd10ece64002bf2c06648e1de7.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_010309_498667_C99F746B 
X-CRM114-Status: GOOD (  12.70  )
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

On Tue, Dec 17, 2024 at 01:03:07PM +0100, David Woodhouse wrote:
> I've dropped this for now and just posted the __nocfi thing as the
> regression fix. I think we *should* provide the CFI information in
> relocate_kernel_64.S though, so I've left these commits in my tree at
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/kexec-debug
> 
> I'd really appreciate some help in getting objtool to stop whining
> about them, for *both* Clang and GCC builds at the same time :)

Hm, I can't fetch for some reason:

  $ git fetch https://git.infradead.org/users/dwmw2/linux.git kexec-debug
  fatal: https://git.infradead.org/users/dwmw2/linux.git/info/refs not valid: could not determine hash algorithm; is this a git repository?

At some point we had discussed placing the code in .rodata, was it the
alternative preventing that?

-- 
Josh

