Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76596C369B5
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IFKKm7Ern/16b5YntZX6gbHyvUt9H3U/nSXxdIz5XvQ=; b=WBTLfWY9ab5QkcoKWoGJYbDVTd
	DltCCFY7hx0wQ7/OAbpymxQH4oLBQRyLkTVz8pCPZfncpkAs+VUDdTEbPlprj2VUxvO/V38lyB4Zl
	YuDHYBeFZUgtW6QvNB0z81XmnoWx+D58C4xFFJnie7p89glttSzQilr6K3RpiOjYBU00eud/TH6o8
	UqDJ/E3bBP1yE3FVjmgJpdeDW+5tBxj4HfSPdCmVfJ+oNyvJIQRQLPT4aVhB1qcqE3R0YbG/eSTGX
	+Dj9qasoZQ2//oRFcgxlc7mc3hsRcuLhJk2dWSy4ryut7KHlUfzreMNBMi9dTRjVmbUJIKK3WfRs+
	pbuXcpZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJP-000000017Pi-0d0i;
	Mon, 14 Apr 2025 08:37:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1SxL-0000000FYCc-2QlU;
	Sun, 06 Apr 2025 16:34:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 35E1061138;
	Sun,  6 Apr 2025 16:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE96C4CEE3;
	Sun,  6 Apr 2025 16:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743957286;
	bh=VXmaK1KEQ4OdnNW6qkbtDrEkJuNzVNaxsi9xvoHemA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHYEa8E+WecBvlODItuw2b7YX/6tTcKkPkVY5c8hgfkEY8qrvZS4g0a3Ps36mtTc7
	 C1ll8nDNb2+K9tEtN6sZSs+7NVh3o6k6Kg/4wianbIJby8nQu2r7eDW3P4ypSyCXGB
	 +PTm6pWbv464BBckQVvKgFmhVS12NRwvpw2dOxLPxKRX/NeHfTRBeqj47VFsu/qaTq
	 kDdF/2+c/Pr6gHEjMytyRvKIWHvox2DCJh1vPUVQTXmvT+5ihdqD2WA5RflpUqRy7u
	 XiEBaOkZARTvBBRMrCpj6S6HvzxefWgH6WKx/07uPfbphejPBi1964kPEwB7U3GezU
	 UycEnTm5Y3e0A==
Date: Sun, 6 Apr 2025 19:34:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Changyuan Lyu <changyuanl@google.com>,
	linux-kernel@vger.kernel.org, graf@amazon.com,
	akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z_KtFnmExftpotmR@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <mafs05xjmqsqc.fsf@amazon.de>
 <20250403114209.GE342109@nvidia.com>
 <Z-6UA3C1TPeH_kGL@kernel.org>
 <20250403142438.GF342109@nvidia.com>
 <Z--sUYCvP3Q8nT8e@kernel.org>
 <20250404124729.GH342109@nvidia.com>
 <Z-_kSXrHWU5Bf3sV@kernel.org>
 <mafs0cydrq4wv.fsf@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0cydrq4wv.fsf@amazon.de>
X-Mailman-Approved-At: Mon, 14 Apr 2025 01:36:58 -0700
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

On Fri, Apr 04, 2025 at 04:15:28PM +0000, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Fri, Apr 04 2025, Mike Rapoport wrote:
> 
> [...]
> > As for the optimizations of memblock reserve path, currently it what hurts
> > the most in my and Pratyush experiments. They are not very representative,
> > but still, preserving lots of pages/folios spread all over would have it's
> > toll on the mm initialization. And I don't think invasive changes to how
> > buddy and memory map initialization are the best way to move forward and
> > optimize that. Quite possibly we'd want to be able to minimize amount of
> > *ranges* that we preserve.
> >
> > So from the three alternatives we have now (xarrays + bitmaps, tables +
> > bitmaps and maple tree for ranges) maple tree seems to be the simplest and
> > efficient enough to start with.
> 
> But you'd need to somehow serialize the maple tree ranges into some
> format. So you would either end up going back to the kho_mem ranges we
> had, or have to invent something more complex. The sample code you wrote
> is pretty much going back to having kho_mem ranges.

It's a bit better and it's not a part of FDT which Jason was so much
against :)
 
> And if you say that we should minimize the amount of ranges, the table +
> bitmaps is still a fairly good data structure. You can very well have a
> higher order table where your entire range is a handful of bits. This
> lets you track a small number of ranges fairly efficiently -- both in
> terms of memory and in terms of CPU. I think the only place where it
> doesn't work as well as a maple tree is if you want to merge or split a
> lot ranges quickly. But if you say that you only want to have a handful
> of ranges, does that really matter?

Until we all agree that we are bypassing memblock_reserve() and
reimplementing memory map and free lists initialization for KHO we must
minimize the amount of memblock_reserve() calls. And maple tree allows
easily merge ranges where appropriate resulting in much smaller amount of
ranges that kho_mem had.
 
> Also, I think the allocation pattern depends on which use case you have
> in mind. For hypervisor live update, you might very well only have a
> handful of ranges. The use case I have in mind is for taking a userspace
> process, quickly checkpointing it by dumping its memory contents to a
> memfd, and restoring it after KHO. For that, the ability to do random
> sparse allocations quickly helps a lot.
> 
> So IMO the table works well for both sparse and dense allocations. So
> why have a data structure that only solves one problem when we can have
> one that solves both? And honestly, I don't think the table is that much
> more complex either -- both in terms of understanding the idea and in
> terms of code -- the whole thing is like 200 lines.

It's more than 200 line longer than maple tree if we count the lines.
My point is both table and xarrays are trying to optimize for an unknown
goal. kho_mem with all it's drawbacks was an obvious baseline. Maple tree
improves that baseline and it is more straightforward than the
alternatives.
 
> Also, I think changes to buddy initialization _is_ the way to optimize
> boot times. Having maple tree ranges and moving them around into
> memblock ranges does not really scale very well for anything other than
> a handful of ranges, and we shouldn't limit ourselves to that without
> good reason.

As I said, this means an alternative implementation of the memory map and
free lists, which has been and remains quite fragile.
So we'd better start with something that does not require that in the
roadmap.
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

