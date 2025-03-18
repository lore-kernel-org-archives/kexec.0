Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F614C282EC
	for <kexec@archiver.kernel.org>; Tue, 18 Mar 2025 22:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HVXLQex27aDQ6kR57/FDTXFg+FA4zcNeY0ZgHInK9F8=; b=iPGr/PWn4vmKR2eu+MZFvyhREY
	MtcOgGhqo964qOmipPPPg0oCcKutvinnBopjcrdBbn1OyRqtkr8K5WIuurKOXWKYQFAHZGTaykibD
	RkYKnP7Gnl7CcIkZRIBC617kt+GLo4A2T4NcoveP+TAtBayxoqGZ7dw8mN0ei5yGgOocHWf6iOL/i
	iiO0GBHX4kfsDFTtQCb46qzvoGP5rvD0pXHHS+Z/x96Mkp1YKCipDhHqIRCXb8uNLMCQuuF4N+6ms
	o953leXYtYyyXGPqCayHA+Lw1M886kXdgxyhic122MF+JhEyeWBNZQwSPunvyKqbCrtDIlZBtrNqg
	yJev8icg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tufd5-00000007H68-2AhL;
	Tue, 18 Mar 2025 22:41:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tufd4-00000007H5w-2qui
	for kexec@lists.infradead.org;
	Tue, 18 Mar 2025 22:41:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2AC1C615A6;
	Tue, 18 Mar 2025 22:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E15C4CEDD;
	Tue, 18 Mar 2025 22:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742337705;
	bh=MlZnSdtmYtlbROC1AkQXerbxO3/nmB10SHRGM5Kp1PM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzvPDZdSElDHFT8DaTJnJBTNqxnpm+MLnvx5+Txq0bJJMl/h5RzXnBm22UmnhBIdx
	 uIWXaWW//yYr7VzrSI3PDG8EJ906Q5FK7H76VquFBscNkbHa4DREWOj9luxXI9Mm77
	 /pae93lcO4FHRjlq5jlMvjF6/4Bz0Un38y4OjnqfVFu3y4/hIDbIV6GCxnebGdxTqN
	 rEnJYVNYrgMutoNWQJpoEJbhgEzImHOC2qiz0agZPLz1ytXdtICCbMqA25ZnjicvtD
	 mamEVXWjBnbU3u+Qb0uQDeee6dVWg3WKsg1JdLinmVGxgpAYrEC093LkGQZNh4YBq9
	 rbwbskpeXgXxg==
Date: Tue, 18 Mar 2025 15:41:43 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de
Subject: Re: [PATCH v7 8/8] [DO NOT MERGE] x86/kexec: Add CFI type
 information to relocate_kernel()
Message-ID: <orpk67p2yolcb4gi462wqwphaaio6ivny2gcfcw4jna3uyaak5@oty7arlxxykl>
References: <20250312144257.2348250-9-dwmw2@infradead.org>
 <ra6zlx2iz7eks3y4ymoi6mn7o6rvnjc3lnjoaadf3szaocbkae@yg2lyjzlnqdn>
 <c2471b0a81ebd183d32e76f995a70b7912c1d4a1.camel@infradead.org>
 <7tq4tti5pv7fjboiapuglkcsodl4nsk53rj36skg4xb2bkysei@ncoz2ztiddm7>
 <970a4932cb95bc8934dc2ad15e8e84a2a51d2232.camel@infradead.org>
 <wzc2owczflbhfho6xcgnl3mnrutdvmqz46xgo54g2ahorhpo5l@rykdsdkjw4fd>
 <6swzz4732x5kfeg3qsif2r5s5ado3nbweznm6alsxvniy4xq6a@z6foorhlhelj>
 <9c41ab61efc573e3ab5a75b6e4031f81db84a846.camel@infradead.org>
 <awucsfjn475mvwg7xhihexln2hfbtvrie2uv333u7awtkz4mrf@t57pi7jibytc>
 <e48391c54a4ba27795919099f8ea25c29d868000.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e48391c54a4ba27795919099f8ea25c29d868000.camel@infradead.org>
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

On Tue, Mar 18, 2025 at 09:06:58PM +0000, David Woodhouse wrote:
> On Tue, 2025-03-18 at 10:14 -0700, Josh Poimboeuf wrote:
> > On Tue, Mar 18, 2025 at 03:56:36PM +0000, David Woodhouse wrote:
> > > For the relocate_kernel() case I don't think we care much about the
> > > first. Without a CFI prologue, no *other* code can be tricked into
> > > calling relocate_kernel()
> > 
> > But for FineIBT the hash is checked on the callee side.  So it loses
> > FineIBT protection.
> 
> Right now the relocate_kernel() code doesn't even have an endbr, does
> it? So it isn't a useful gadget?

In that case wouldn't IBT explode when you indirect call it?  Or is IBT
getting disabled beforehand?

> > > — and besides, it's in the kernel's data
> > > section and isn't executable anyway until the kexec code copies it to a
> > > page that *is*.
> > 
> > Does the code get copied immediately before getting called, or can it be
> > initialized earlier during boot when kdump does its initial setup?
> 
> It's initialized earlier, in machine_kexec_prepare(), and then the page
> is set ROX.

If that happens during boot (like for kdump init) then it'll be in text
the whole time after boot, right?

-- 
Josh

