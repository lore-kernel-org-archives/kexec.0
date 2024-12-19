Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99EAE77188
	for <kexec@archiver.kernel.org>; Thu, 19 Dec 2024 00:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=63MVVXDd3R6liypXO6eDyojsMfTmAWd2B+CBvyksBnI=; b=ji/vsTYYFdFqmTZcih8FSGiuvy
	iBNZXDdy/GpvyD3fcrP5RBgawsnI0zvnOwQ7DQp6+9Pf3qTLn9ZbpdWW0kT384+eQXXHkgLPgjVvn
	9xkgObhJpgRsNuMbKHEkOC078Hcv0m1Yh4H09rlIihZgJlwtzbARae5cSZ9N6DFFtu8TQ/vfkOyjZ
	RuKUyeE9rWjkeuwj2N7WOn94GQBU2/DkiCdYtU2CHoIosAVwClYCCTwCUy8TJzRRlH06AuHnOW3LJ
	enYtrnOe24n1KviMaCqtp7Z1LUOgDyGIHrVv7Syqwt1vLDE+swpYEUuTc7fo3kA2G95mZknuGyjd+
	4nNfHSMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tO4H8-00000000PmG-0R3g;
	Thu, 19 Dec 2024 00:20:22 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tO4H5-00000000Pkt-0PHT
	for kexec@lists.infradead.org;
	Thu, 19 Dec 2024 00:20:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AA3A5A4180A;
	Thu, 19 Dec 2024 00:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D5EC4CECD;
	Thu, 19 Dec 2024 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734567617;
	bh=IdAEVyqkwKASzgLMKMaj4XPwzGy2bn7iJa8EH06pkNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNPsYDMML0jdz/FtOG/rbjxUk5l7SHxx3/p0SttSrzBXE3sWmVhOglVQL5ZpXw5Bl
	 izSB0qB93U5C96kS9FBvI+qGkEIJdXZF5VE67DoQCgtOH1isJ3IsnJIqjogqaGX9lk
	 vCW4GLbPB/nYPyX6h3Cl6NEh46srZlMwz5f3FMiIZig7mXUytbeaGDvTHUhDoAukP4
	 15pKHJl84m8UPL7TAiB9SDpGSceD9Wfx5kkt7hK0iSyEgt6yxpAbS6uETryr88M5Ll
	 3kDgeARTgCnQndeS9B5MZ+ImHsZnkmMhr+ZghTOLLSUD4sv5cL0OxolLs37ya6wOtC
	 N68YVOcSiIHoQ==
Date: Wed, 18 Dec 2024 16:20:15 -0800
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
Message-ID: <20241219002015.7y5ohlfofc6c3njr@jpoimboe>
References: <20241205153343.3275139-8-dwmw2@infradead.org>
 <20241214230818.GA677337@ax162>
 <24d843d2ceb09acdae494ee9a17ec94bf8bb4e4f.camel@infradead.org>
 <20241216054942.GA25019@ax162>
 <79ea9c10ae4f1dae16be8c05bb7b7e6b72512f10.camel@infradead.org>
 <9ee61d2b89b4cecd10ece64002bf2c06648e1de7.camel@infradead.org>
 <20241218090305.y4o62pmdwq32732h@jpoimboe>
 <5857ef047402c3ded29d4c024f8fdc32608f1696.camel@infradead.org>
 <20241218212326.44qff3i5n6cxuu5d@jpoimboe>
 <dc059a127d59ccc77be0c92b686f72616c2d1c0f.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc059a127d59ccc77be0c92b686f72616c2d1c0f.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_162019_208506_C2BF9FF2 
X-CRM114-Status: GOOD (  21.09  )
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

On Wed, Dec 18, 2024 at 11:27:27PM +0100, David Woodhouse wrote:
> On Wed, 2024-12-18 at 13:23 -0800, Josh Poimboeuf wrote:
> > 
> > The linker script does place it in .data, but objtool runs on the object
> > file before linking, where it's still in an executable section
> > (.text..relocate_kernel).
> > 
> > How about something like below?
> > 
> >   - move text to .data..relocate_kernel
> >   - remove objtool annotations
> >   - replace the alternative with a runtime check
> 
> That leaves me unable to use 'objdump -S
> arch/x86/kernel/relocate_kernel_64.o' so I hate it :)

Well, it's already written in assembly, there's not much benefit in
disassembling it ;-)  But you can still force gdb to do so with
something like "x/50i <addr>".

Isn't that easier than putting in all these hacks to make objtool happy
(and continue to keep it happy over the coming years), when it doesn't
need to care about this code in the first place?

Anyway, what I think you're looking for is UNWIND_HINT_UNDEFINED.  In
fact all the unwind annotations in that file should be UNDEFINED since
the hints are all referring to the wrong addresses (because copied code)
and the ORC unwinder isn't reachable for most of that code anyway.

Also, it's fine to make relocate_kernel() a proper function with
SYM_FUNC_END, you'd just need to add the following line afterwards:

  STACK_FRAME_NON_STANDARD relocate_kernel

-- 
Josh

