Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12746ECE57A
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 10:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=77tcV93hOsmRVfWUJRdNueLl1A/ikjdxY5oeoQXGCy8=; b=tNYBvAN71/8J39
	JgCov5NJa2bV/+bdMHu/Ut7/WDAu8kkSDQPxt4NLote03TyazjeGc0b9KuGSal7PpJYG5yklUbmHA
	P9xl4zZk/Hx07Y5e3YXtbmXnrMjZsJZ7lvySjeN/LavRqeo7uUyMhbY+hOIpqvNF1vQE09IBZ05sm
	Lvy1oXf3P7XluSRk74el2GeZlOrAINFsXNwZ2XxdpnhtCxl2ax6/DChDk9scJYfo15tMKUl2JNp+O
	O9AT5vHZNz8vK1uWFBJMnUiwNqw/UqbSYcvHARpBBV1f19WjlA9pJ1ickX18bq0CR7f0SgWQRl9gO
	7VporOrI71dMWpvy3/oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snbtQ-00000001YAm-21wr;
	Mon, 09 Sep 2024 10:45:12 +0000
Received: from fhigh1-smtp.messagingengine.com ([103.168.172.152])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snbr9-00000001Xio-4AdF
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 10:42:53 +0000
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40CC91140206;
	Mon,  9 Sep 2024 06:42:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Sep 2024 06:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1725878569; x=1725964969; bh=ZFTA+pO0V1
	16RhPMfAQzVCkGKQSIt4l0h5shzFuOeNk=; b=ro+MYWG+JmT2YEB/62iuK8yM9O
	3exbN72n/Ol15M23lBZ2inyBUN+ZR/NpTqFeaxX1dns071cyW6QuGVWfdp7yrgIK
	r4QasFH4QQxmDGAKMid6/K4zFubqMZyxmKItJDX1/jUKYnVOY1noWmIkbjMNNDrD
	5FPIuteECmGKG8DLQlMqZuR8n5ofokP2FiTQpJoHJ0Lk13VHUUVMME4GHbumaUKa
	CgdVzHqEF8srQ9JsmJ5K8iOwUd6ibacSl1BsEa0H8c85vbnfDhNTG0Y5Tiee6i9C
	oDdDqeEJyrdXm0MTr0R4c9nioUaS84Fv1ay6106zHq9lPH+ZzkWkIxgpwT5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725878569; x=1725964969; bh=ZFTA+pO0V116RhPMfAQzVCkGKQSI
	t4l0h5shzFuOeNk=; b=l011lgwrlWJ0pDW7aJCNH/DMfXqPMe/pxYc3knKROLOF
	hiithLggMKjYVkQuYjZ4HoRXQCw/3SZr4+aiElmc57GycZVuws+sMFQwh/fAUd+T
	CFEYa9Xusf/s2P9dvcFd2hraW7xhtYpwg7OXDr3WPrlFAn4rRuKFoRIQLeE2aXYZ
	9ovU8mCvgue8GnbmHlu5j2DpQ9h2mZZf3O/DgPQaGWNe/laiS4vUHSFakXi4VLi4
	DnAPNXw1YZzJajTxr/tQDSnKZlyVEYKBea4CiWgB9Fh5Q+e5RYWPdz93Qqg7TBUH
	GJQMB/TzCR0AuW8XfL3cApzkXIGJzye+7nnVeOKrhA==
X-ME-Sender: <xms:KNHeZr3wBH6Jopv0Q3WJM1mr6LZ6MPHep4kKOSizOqvR3CzWK5QFSg>
    <xme:KNHeZqFqljSXp3Sdnb8bp5OuQ1XkxH2kE7B9R9LOgn_JaTJ3ZPZdL3F9otWQILt-N
    ztKzJtkfIvvOoxlXug>
X-ME-Received: <xmr:KNHeZr5kpGmddeHQGeobGRqYj1b3aXRGNx7CeUj-vCtqfB0fX4BPG9NYtw9CC4jAxGu5dc1UMeKUwvaxiBq878RheAQp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrghrrh
    cuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpedukeegffdt
    feeihfehteevvdeiueetteelgfefvdfhleeufeegieduieduhfekieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhfrghr
    rhdrtggtpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhiigihrvggrrhihsedtphhoihhnthgvrhdruggvpdhrtghpthhtohepphhruhgu
    ohesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpihhlihhusehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrghr
    khhkoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihgvuggvrhhmseigmhhish
    hsihhonhdrtghomhdprhgtphhtthhopegshhgvsehrvgguhhgrthdrtghomhdprhgtphht
    thhopeguhihouhhnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrrhhkrdhruh
    htlhgrnhgusegrrhhmrdgtohhm
X-ME-Proxy: <xmx:KNHeZg0FjZU7uScSbgbh3obke5N0LOltSv6hXggI3crxdagqrBzwsA>
    <xmx:KNHeZuGY1IkWebm7_BxT6C3PlBBCxpFFFoMbFj-ouBCuarvFAXy4GQ>
    <xmx:KNHeZh_aMT-9F9SYnt1-mmeGuoWBrGpIxUVn2J3mwvwDFntn25MPFQ>
    <xmx:KNHeZrlKYxvrEmbTpDWI3Anq021tpG4tKvxGtuktKSsBYfleGAXjaw>
    <xmx:KdHeZrdQJNBx9W6KzlOZ1Ky6jBnbcqsbNM-uf-XhwHmXDDXASLcsnz0v>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 06:42:46 -0400 (EDT)
Date: Mon, 9 Sep 2024 12:42:45 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Philipp Rudo <prudo@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Pingfan Liu <piliu@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zt7RJepoCiCMRZSu@archlinux>
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
 <Zt7EbvWjF9WPCYfn@gardel-login>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zt7EbvWjF9WPCYfn@gardel-login>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_034252_197278_5098C824 
X-CRM114-Status: GOOD (  36.36  )
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

On 09 11:48:30, Lennart Poettering wrote:
> On Fr, 06.09.24 12:54, Philipp Rudo (prudo@redhat.com) wrote:
> 
> > I mostly agree on what you have wrote. But I see a big problem in
> > running the EFI emulator in user space when it comes to secure boot.
> > The chain of trust ends in the kernel. So it's the kernel that needs to
> > verify that the image to be loaded can be trusted. But when the EFI
> > runtime is in user space the kernel simply cannot do that. Which means,
> > if we want to go this way, we would need to extend the chain of trust
> > to user space. Which will be a whole bucket of worms, not just a
> > can.
> 
> May it would be nice to have a way to "zap" userspace away, i.e. allow
> the kernel to get rid of all processes in some way, reliable. And then
> simply start a new userspace, from a trusted definition. Or in other
> words: if you don't want to trust the usual userspace, then let's
> maybe just terminate it, and create it anew, with a clean, pristine
> definition the old userspace cannot get access to.

Well, this is an interesting idea!

However, I'm sceptical if this could be done in a secure way. How do we
ensure that nothing the old userspace did with the various interfaces to
the kernel has no impact on the new userspace? Maybe others can chime in
on this? Does kernel_lockdown give more guarantees related to this?

Even if this is possible in a secure way, there is a problem with doing
this for kernels that are to be kexec'd on kernel panic. In this
approach we can't pre-run them until EBS(), so we would rely on the old
kernel to still be intact when we want to kexec reboot.



You could do a system where you kexec into an intermediate kernel. That
kernel get's kexec'd with a signed initrd that can use the normal
kexec_load syscall to load do any kind of preparation in userspace.
Problem: For that intermediate enviroment we already need a format
that combines kernel image, initrd, cmdline all signed in one package
aka UKI. Was it the chicken or the egg?

But this shows that if we implemented UKIs the easy way (kernel simply
checks signature, extracts the pieces, and kexecs them like normal),
this approach could always be used to support kexec for other future
formats. They could use the kernels UKI support to boot into an
intermediate kernel with UEFI implemented in userspace in the initrd.

So basically support UKIs the easy way and use them to be able to
securely zap away userspace and start with a fresh kernel and signed
userspace as a way to support other UEFI formats that are not UKI.

> 
> > Let me throw an other wild idea in the ring. Instead of implementing
> > a EFI runtime we could also include a eBPF version of the stub into the
> > images. kexec could then extract the eBPF program and let it run just
> > like any other eBPF program with all the pros (and cons) that come with
> > it. That won't be as generic as the EFI runtime, e.g. you couldn't
> > simply kexec any OS installer. On the other hand it would make it
> > easier to port UKIs et al. to non-EFI systems. What do you think?
> 
> ebpf is not turing complete, I am not sure how far you will make it
> with this, in the various implementations of EFI payloads there are
> plenty of loops, sometimes IO loops, sometimes hash loops of huge data
> (for measurements). As I understand ebpf is not really compatible such
> code.
> 
> Lennart
> 
> --
> Lennart Poettering, Berlin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
