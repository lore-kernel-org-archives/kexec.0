Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8285D26284
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 18:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ytTCX43YaWLKtzXMqmoIG0r0Wwfc5JFXaC5vs4GyATw=; b=glQckaeXwzV8UPiU988RK1PcJb
	jAq7CTFRgPC/GEIIKn5HAA2HVLCOqeq3B6fK6IeMC2c+HjJiQepTfdBhRcVshkDTko27UrudbrziR
	P6nHQeQgEivCZJqTfrbNd96h6BZX9+F0h77fDP16gXg6kEdKtOTt9nooKbNjjTFCIGNL2V3RCErGy
	VmJzemXOsz7o+0OO7kRkXIfiPVgs+jaaBEiM2SdV4dRtz76RHxWqETG62n2oX9kr+qqwUHFPoa8gn
	l/REGZyqcMuvekOridJrLWOibyauA7u3MAHXGtDmzkflWjqqCfJD61OQh6p+yokDoYQPNEdthBL3q
	mXooQNUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGvc-00000004Ka6-0pDM;
	Tue, 20 Jan 2026 18:58:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGvb-00000004Ka0-0w6L
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 18:58:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 46E7A6001A;
	Tue, 20 Jan 2026 18:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEA8C16AAE;
	Tue, 20 Jan 2026 18:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768935490;
	bh=I5q0oGB+BoA/gz8qsotA61iskY7SDlYKob9LdnVdGNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhB7IVkwG/XveGj1F09VZwJYfZ6BTg7yXMg4IEJIePaigtf7knr23e4MQvTMxS+XR
	 3XGbUKDlpl5+VcPlQFcjc3V9gDkHfwLhvQtn1622KVxhrL30oJc5/p1DDSVoy5b+oK
	 gBhlEsuMf2+/UQWGOlx0kq6hZGbVeB28j90YZPDymuuRHHHrT0mJOWLA4U3nnby16v
	 xCMZ/fk+eOp/cSZbaK58BPKykl50BWitcslIvDcc3KdijKzNQ8tUR6m4ERC7oTDGHh
	 8D5Dnc+dFsby36GI2D0phtpjip1EDcbHqJ8Lu/KtkMuKJMuTGQxieNcRvQdi2kptia
	 B2purnqkBT7Ig==
Date: Tue, 20 Jan 2026 20:58:02 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com,
	clm@fb.com, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] kho: history: track previous kernel version
Message-ID: <aW_QOpA1ocySNLAF@kernel.org>
References: <20260108-kho-v3-0-b1d6b7a89342@debian.org>
 <20260108-kho-v3-1-b1d6b7a89342@debian.org>
 <2vxzy0m0gfyo.fsf@kernel.org>
 <v7g7nmd3jif6vftvnmucvpluevufcdxmefcgqq3yfpnzyb7mql@ojpotuu4hgxm>
 <2vxzms28e1ib.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzms28e1ib.fsf@kernel.org>
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

Hi,

On Tue, Jan 20, 2026 at 03:40:12PM +0000, Pratyush Yadav wrote:
> On Fri, Jan 16 2026, Breno Leitao wrote:
> >     
> >     On cold boot, kexec-count starts at 0 and increments with each kexec.
> >     The count helps identify issues that only manifest after multiple
> >     consecutive kexec reboots.
> 
> Very well written changelog!

@Breno, the submission would be perfect if you'd start a new thread rather
than reply to v1 ;-)
 
> > +/*
> > + * The "history" subtree stores optional metadata about the kexec chain.
> > + * It is registered as a separate FDT via kho_add_subtree(), keeping it
> > + * independent from the core KHO ABI. This allows the history format to
> > + * evolve without affecting other KHO consumers.
> > + *
> > + * The history FDT structure:
> 
> I don't have a strong preference here, but you don't _have_ to use FDT.
> For example, with memfd, we moved from FDT to plain C structs during the
> evolution of the patchset. Main reason is that FDT programming is a bit
> annoying. C structs make many things much easier. For example, you can
> always assume a certain property always exists and is of a given size,
> and you don't have to validate every single property you read.
> 
> Anyway, I don't mind either way.

Yeah, I agree that a plain C structure with an array of chars and u64 will
make things simpler.

> > + *
> > + *   / {
> > + *       compatible = "kho-history-v1";
> > + *       previous-release = "6.x.y-...";
> > + *       kexec-count = <N>;
> > + *   };
> > + */
> > +#define KHO_HISTORY_NODE_NAME "history"
> 
> Do we want to call it history? Perhaps "kexec-metadata" instead? So we
> could use it for other misc information if needed later.
> 
> Mike/Pasha, any thoughts?

I like kexec-metadata.

-- 
Sincerely yours,
Mike.

