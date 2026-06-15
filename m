Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04A7CD98DA
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 19:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hFOp9Mnlyd+4upqc3Wy51fIoKW/HpZIdfJ39eZ9j+VY=; b=yl/e3WuICXA/Rg0SBcVZ+jeszW
	abVjFJzAbOerwQJcYcvl4HfQ4jRLLBoLOKdpiqphQBN6LX0h2slFOdfRhW+wjNWn3OzpQJGgXCfRi
	PffRnqHHE7PqSrAvjq9IhvUYgPHEiTF+LF3nqZpr9lRGkoBcNVMnhIXwaUgULmUs1iov767jKVKM9
	R5jW2XSMGpQGQJSJ+pqo0RqXpUuabwj3fte2MzLQ9B+vQ1lEFTxOadxWH0uGa6jVIDuNuXt/7hKQE
	lx80OtnIEsGXJ81aUUQgm4MlNWEQaUEkokgmup6XPNPSQZev4/G3hVC9QiPxavllU1lbejVKYxSnh
	vp7F6lbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZD7z-0000000EmgD-1TyA;
	Mon, 15 Jun 2026 19:37:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZD7y-0000000Emg6-1rzH
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 19:37:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7C2EF601E5;
	Mon, 15 Jun 2026 19:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2741F000E9;
	Mon, 15 Jun 2026 19:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552265;
	bh=hFOp9Mnlyd+4upqc3Wy51fIoKW/HpZIdfJ39eZ9j+VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b1Bs2BrC22gb7aJjDlwlKGl27EOTCJpSbtDjlfGJ+IWNFvciHyzMIxhbXF0FDetVK
	 9iaUTPPSYdTNtlbI64bUtd5VRGoeGL7Py4s6z5xiNURCkdxF0gNQcQtCgdeaL/FA69
	 Av0aZZjWOQoGrbCPjAAAgR1SBMSwThJjKJMFQHy+CSee228Tze1GnPxCcOSaXq4vRJ
	 fyX5Lrq0iZKLofhtPib1TD5bM1nhN8qcJj5iWy9NJ9bhqdESlJFkzfNyWV8bUSHAzD
	 TC2Q7jlWtEmPGsi0kWVYBq4L8xo+enYpCPGWU3f7QLQeFU1aYM6Mm4RZyOYIZVFvCt
	 bMPmBrYImjJOQ==
Date: Mon, 15 Jun 2026 22:37:36 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 15/18] kho: extend scratch
Message-ID: <ajBUgB8uG509JJ0A@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
 <20260605183501.3884950-16-pratyush@kernel.org>
 <178143855117.2123877.6330314807920146675.b4-review@b4>
 <2vxztsr4orvg.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxztsr4orvg.fsf@kernel.org>
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

On Mon, Jun 15, 2026 at 03:28:03PM +0200, Pratyush Yadav wrote:
> On Sun, Jun 14 2026, Mike Rapoport wrote:
> > On Fri, 05 Jun 2026 20:34:48 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
> >
> >> +{
> >> +	struct kho_radix_tree *tree = data;
> >
> > Would be nice to say which tree in the variable name ;)
> 
> How about preserved_mem_map?

But this is the new tree, isn't it?
Maybe keep the variable name and add a comment? 

> >> +/**
> >
> > I don't think we expose statics as kernel-doc somewhere, so this
> > probably shouldn't be a kernel-doc comment
> 
> This is a leftover from the previous version, where this was external.
> 
> I think the documentation is still worthwhile though, so I suppose I'll
> turn it into a normal comment by removing the /**.

Yeah, I meant it should not be a kernel-doc, just a plain comment. 

> >> +static void __init kho_extend_scratch(void)
> >> +{
> >> +	const struct kho_radix_walk_cb kho_cb = {
> >> +		.leaf = kho_ext_walk_key,
> >> +		.node = kho_ext_walk_node,
> >> +	};
> >> +	const struct kho_radix_walk_cb ext_cb = {
> >> +		.leaf = kho_ext_mark_scratch,
> >> +	};
> >> +	struct kho_radix_tree radix;
> >
> > sashiko says:
> >
> >   Is it possible for the radix variable to contain uninitialized stack memory
> >   here?
> >   If radix is uninitialized, tree->root might contain garbage data when passed
> >   to kho_radix_init_tree()
> >
> > and I agree :)
> >
> > This should be
> >
> > 	struct kho_radix_tree radix = { 0 };
> 
> Ugh, right. But at the same time, it is odd for an initialization
> function to expect an initialized object. Perhaps I should move the
> kho_radix_init_tree() from kho_mem_retrieve() to
> kho_memory_init_early(). Then kho_extend_scratch() won't have to do the
> init at all and I can remove the if (tree->root) check from
> kho_radix_init_tree().

Sounds about right :)
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

