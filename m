Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E0CC369B2
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rr20TjwMb+nGA9+gyTaPX7rvBwY2Vc0vBMvqfcTN+Ec=; b=ew5rxbC/LzQCwmdbq0iADPh0GS
	np0PdDPZxyZm1qO3LhaDXU6Oi257NMrxGBrxWxKaYW8+LHH+0TVnjJlyw9ONighyBIXK5GAVJEETE
	f3q+jh7WgCIB/+RzzVEnWLUW7Kbku6TkRQGWyTG8sOnSdULeUwLCMdfIoIiRqGAFTbnK4XQmer/0k
	hBjWuUmqlXSaTk1+xE3nIlyJXkAId6yLiRiKlIsfR9T0voED3EiT4o7m2pTVwxfv2fpuYfyLXTPcm
	0j1n0PneN7t7FvPHjQDbyWwW3RS8S9AOJ3k8FE5uHdr2ccqoEJFGdUTP3+sXAthsE9xBRsB6UVPyJ
	6liAXuKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJK-000000017LB-2hLn;
	Mon, 14 Apr 2025 08:36:58 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0hUB-0000000Btin-06BW;
	Fri, 04 Apr 2025 13:53:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7CB95A47547;
	Fri,  4 Apr 2025 13:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67702C4CEE9;
	Fri,  4 Apr 2025 13:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743774810;
	bh=2rzMRftKBbWXyLp7FGHjPk6gHfvfTiEV+d+apCFfS6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u86qq+WWOgfr/y8T3yYEfFibNlmCislNnrANwDMm0Ddd3FrjSwk5X/9lyM2ctT40p
	 fbIqF2t2bIDazWL1aQ+8uKlFQwozKkEDLtbquMfiQEfWaMUxIkbLXNa3+U20SS79tc
	 zsXuF9LVeo4pVn1onYujBO70qGEQvFTfGdJyt62/ft4rTl1i7VRVZueQsD5E0NMq3R
	 4XlixfG7j2DkiY5hGeOJg9CqNrunFEW/Vhp7IbJcQUzXFhrmZ9yj191xLraeS8y+0B
	 A5ZL0U88jgVbAMqN4TBDpuesEaWt5Mz+qG36eitZepGX00BCXMDM83p/0iTferff24
	 ylNRrHAYePorg==
Date: Fri, 4 Apr 2025 16:53:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
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
Message-ID: <Z-_kSXrHWU5Bf3sV@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <mafs05xjmqsqc.fsf@amazon.de>
 <20250403114209.GE342109@nvidia.com>
 <Z-6UA3C1TPeH_kGL@kernel.org>
 <20250403142438.GF342109@nvidia.com>
 <Z--sUYCvP3Q8nT8e@kernel.org>
 <20250404124729.GH342109@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404124729.GH342109@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_065331_189072_A13BC04F 
X-CRM114-Status: GOOD (  32.67  )
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

On Fri, Apr 04, 2025 at 09:47:29AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 04, 2025 at 12:54:25PM +0300, Mike Rapoport wrote:
> > > IMHO it should not call kho_preserve_phys() at all.
> > 
> > Do you mean that for preserving large physical ranges we need something
> > entirely different?
> 
> If they don't use the buddy allocator, then yes?
> 
> > Then we don't need the bitmaps at this point, as we don't have any users
> > for kho_preserve_folio() and we should not worry ourself with orders and
> > restoration of high order folios until then ;-)
> 
> Arguably yes :\
> 
> Maybe change the reserved regions code to put the region list in a
> folio and preserve the folio instead of using FDT as a "demo" for the
> functionality.

Folios are not available when we restore reserved regions, this just won't
work.

> > The xarrays + bitmaps do have the limitation that we cannot store any
> > information about the folio except its order and if we are anyway need
> > something else to preserve physical ranges, I suggest starting with
> > preserving ranges and then adding optimizations for the folio case.
> 
> Why? What is the use case for physical ranges that isn't handled
> entirely by reserved_mem_add()?
> 
> We know what the future use case is for the folio preservation, all
> the drivers and the iommu are going to rely on this.

We don't know how much of the preservation will be based on folios.
Most drivers do not use folios and for preserving memfd* and hugetlb we'd
need to have some dance around that memory anyway.  So I think
kho_preserve_folio() would be a part of the fdbox or whatever that
functionality will be called.

> > Here's something that implements preservation of ranges (compile tested
> > only) and adding folios with their orders and maybe other information would
> > be quite easy.
> 
> But folios and their orders is the *whole point*, again I don't see
> any use case for preserving ranges, beyond it being a way to optimize
> the memblock reserve path. But that path should be fixed up to just
> use the bitmap directly..

Are they? 
The purpose of basic KHO is to make sure the memory we want to preserve is
not trampled over. Preserving folios with their orders means we need to
make sure memory range of the folio is preserved and we carry additional
information to actually recreate the folio object, in case it is needed and
in case it is possible. Hughetlb, for instance has its own way initializing
folios and just keeping the order won't be enough for that.

As for the optimizations of memblock reserve path, currently it what hurts
the most in my and Pratyush experiments. They are not very representative,
but still, preserving lots of pages/folios spread all over would have it's
toll on the mm initialization. And I don't think invasive changes to how
buddy and memory map initialization are the best way to move forward and
optimize that. Quite possibly we'd want to be able to minimize amount of
*ranges* that we preserve.

So from the three alternatives we have now (xarrays + bitmaps, tables +
bitmaps and maple tree for ranges) maple tree seems to be the simplest and
efficient enough to start with.
 
Preserving folio orders with it is really straighforward and until we see
some real data of how the entire KHO machinery is used, I'd prefer simple
over anything else.

> Jason

-- 
Sincerely yours,
Mike.

