Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552FCD59D69
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 20:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MnDmNH6zIsn82b33mMwCY2LXLvCw3+6N+7WIBIewVSk=; b=Kcg9rgLKEZyq3Pg9jKo6RG2nLw
	+kG5sSwemqXW9pt2YH1z5CGa2U6qx92rU/AMuAyviMXJpdK9RiM+h56aXG9mzAnv3fQlhC9HS/9eM
	0LdQsBssB/N+HnJgWybK4iQg2SqmvcSTGFWgcpRKCu/CUidFZ13U4rRk/uk1NQieBFd8sfzneO9cm
	tDJTXhEM4QbrVaPNusIDQ7Oym3PtekjnZaBCfoIvX4Qn4Qs7lfNZFxadZ5sYcFHYoVZwUhHbVKTk8
	meGoNINBeH6eLo8ZLyEcXiClUlGAj2XZLWvfrj6/9Xs71co9hKtzt9c2Qp2JiyephAbH6LPceV6Fx
	ryosY8sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFfnV-000000093JG-0zPK;
	Mon, 25 Nov 2024 20:35:05 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFfnR-000000093Hw-3svj
	for kexec@lists.infradead.org;
	Mon, 25 Nov 2024 20:35:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2A1F2A418D7;
	Mon, 25 Nov 2024 20:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D85C4CED2;
	Mon, 25 Nov 2024 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732566900;
	bh=0xJmV6Fv8F7uZ3U35bZV4ncl1VQmEU7hso9MskULO/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xn8m4EDoPqdYRheWzAvmNaWcws2w9cdBCps4+YXKKpWXF1KTrG1RIfyNybZMZhp9H
	 K3kMNgntTQnJNbtASxmGP6IuSWPmcy2uoIRVd3BmOxLlFl2XqUsItbFpIiiQoY1aWg
	 f2yuD1p2dfTj5MeuK3XypG5E7Dvpz1kOffEB8WOmP/m2XjuSAqSA3FGBpYrYNg8KSd
	 t02Mi0uqREOvt01bgYkM8Nkwd4Tggmd6lEhw0KnvXBP63CJLBQjHMlV62VYR74IrLY
	 78Szxonz86bABrxUh3tzQ4GH/HyRKFRXFy847d1/C/LelcmAIRdTJ+0LVulikL7lFb
	 WmeIHV7vGgHDw==
Date: Mon, 25 Nov 2024 21:34:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 16/16] [DO NOT MERGE] x86/kexec: enable DEBUG
Message-ID: <Z0TfblQeVRnDc-S1@gmail.com>
References: <20241122224715.171751-1-dwmw2@infradead.org>
 <20241122224715.171751-17-dwmw2@infradead.org>
 <Z0RBl6pzNf5irop9@gmail.com>
 <334ae44077315e2b69529b6fef8d85ec55f80ecf.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <334ae44077315e2b69529b6fef8d85ec55f80ecf.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_123502_094010_A1D342E4 
X-CRM114-Status: GOOD (  23.59  )
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


* David Woodhouse <dwmw2@infradead.org> wrote:

> > Just curious: did you write this code to debug the series, or was 
> > there some original hair-tearing regression that motivated you? Is 
> > there's an upstream fix to marvel at and be horrified about in 
> > equal measure?
> 
> https://lore.kernel.org/all/2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com/t/#u
> is the upstream fix.

Which ended up being the following upstream commit:

  88a921aa3c6b ("x86/sev: Ensure that RMP table fixups are reserved")

Might make sense to add this commit reference to one of the central 
patches of the GDT/IDT code, to document how this feature is able to 
pin down very hard to debug regressions. (Even if the upstream fix was 
done independently in probably luckier circumstances.)

> [...] It's all the more horrifying because it was already *fixed* 
> upstream before I lost weeks of my life to chasing it. And the 
> trigger which actually made it *happen*, and made our production 
> systems allocate memory within that dangerous 1MiB region adjacent to 
> the RMP table, was a tweak to the NMI watchdog period... leading to 
> an assumption that we were getting stray perf NMIs during the kexec, 
> and a *long* wild goose chase based on that false assumption...

:-/

> Once I'd written the debug code, I just wanted to clean it up a bit 
> and push it out for the benefit of others; that *was* the main point 
> of this series. All the rest of the cleanups are just yak shaving.
> 
> The realisation that we never even explicitly mapped the control code 
> page and always just got lucky because it happened to be in the same 
> 2MiB or 1GiB superpage as something else that we did map... was just 
> a bonus :)

I'm amazed and horrified in equal measure ;-)

> (That one is fixed in v3 which I'll post shortly, and is already in 
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/kexec-debug
> )
> 
> > I'd argue that this debugging code probably needs a default-off Kconfig 
> > option, even with the obvious hard-coded environmental limitations & 
> > assumptions it has. Could be useful to very early debugging & would 
> > preserve your effort without it bitrotting too obviously.
> 
> Yeah. In v3 I've made it a config option, and made it use the 
> early_printk serial console (as long as that's an I/O based 8250; we 
> can add others too later).

That's lovely!

Thanks,

	Ingo

