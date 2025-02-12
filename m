Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F76C021A0
	for <kexec@archiver.kernel.org>; Wed, 12 Feb 2025 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o9EcgwaoNH9P8S3TSPAC5aJNBCxAKdO1YHsWC1zruTc=; b=OdQ4jMy+fWKLSmBqwBSOxb1BeU
	CyIOHWw8tqsrlmaahbfhNhSQnshxKIFGJGJqdzomwicWMCUVZuxlZv6/xnUCe0Oga06OnbsPgW0Vl
	/vLZbFqyjOKpzgTnojX8S+DaaiRM9SCWtxGiR0ahsaOxRknqhtvs/UlObVoFx/fH3pjzlt9/SMtIr
	c510vJO+Pk7L0DlHqLQWDOgQBaNs07SAm9GJDqB7n8GZB+tx4F+OX84wSUkIAYmKIwwLHCMftRE7H
	NOPrR4RiEm7tX55Cu1d4XrtEDG4auQ8+JRpcyIZkyoQrNXnSbfLthD3ewiBWEmdKNML2HMnpM94aU
	Outo5PBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiGGV-00000008F0O-0XMh;
	Wed, 12 Feb 2025 17:11:11 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiFlm-000000087y2-3jVa;
	Wed, 12 Feb 2025 16:39:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B22D2A40C19;
	Wed, 12 Feb 2025 16:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45E0C4CEDF;
	Wed, 12 Feb 2025 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739378365;
	bh=zfEIpiTrcj/R2Ru79c+QdETWalY9N06YUbZ/uIkxoRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwS+nkzE62iYAWY6oMvTiOE2hZdqZW4je7lUt/Tn8svDT0aqJyRSG1Te50dWeoSK6
	 yZO90wTxRzWvs64nxtq+JimjJqslPOcN7j/gDEv42ILOhCNdmCR6wWLQcePUqYZ0Yz
	 uadqjYhtm/BeUJnOKtwxaC2USAWhcuMi9AeP4KLnjL50JLMhS7jyRHMJsejxavbVDh
	 sV1QU2dtmz9BzlPJHJQTzkrOQXYWw8C3AzJ/mP1FzbO60nnOuds/LnOuA/bs/jEEl1
	 +GgoenuPWq9nhK1ojBt2vq5J0TI5Wg9+EvPg0Lk5i7f20zfeNS5Qm+VHUuZdt6qoTp
	 WjzuuOLLR6qTQ==
Date: Wed, 12 Feb 2025 18:39:06 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 05/14] kexec: Add Kexec HandOver (KHO) generation
 helpers
Message-ID: <Z6zOqtaLQwnIWl2E@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-6-rppt@kernel.org>
 <20250210202220.GC3765641@nvidia.com>
 <CA+CK2bBBX+HgD0HLj-AyTScM59F2wXq11BEPgejPMHoEwqj+_Q@mail.gmail.com>
 <20250211124943.GC3754072@nvidia.com>
 <CA+CK2bAEnaPUJmd3LxFwCRa9xWrSJ478c4xisvD4pwvNMiTCgA@mail.gmail.com>
 <20250211163720.GH3754072@nvidia.com>
 <20250212152336.GA3848889@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212152336.GA3848889@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_083927_068040_C751FF21 
X-CRM114-Status: GOOD (  24.44  )
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

Hi Jason,

On Wed, Feb 12, 2025 at 11:23:36AM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 11, 2025 at 12:37:20PM -0400, Jason Gunthorpe wrote:
> 
> > To do that you need to preserve folios as the basic primitive.
> 
> I made a small sketch of what I suggest.
> 
> I imagine the FDT schema for this would look something like this:
> 
> /dts-v1/;
> / {
>   compatible = "linux-kho,v1";
>   phys-addr-size = 64;
>   void-p-size = 64;
>   preserved-folio-map = <phys_addr>;
> 
>   // The per "driver" storage
>   instance@1 {..};
>   instance@2 {..};
> };
> 
> I think this is alot better than what is in this series. It uses much
> less memory when there are alot of allocation, it supports any order
> folios, it is efficient for 1G guestmemfd folios, and it only needs a
> few bytes in the FDT. It could preserve and restore the high order
> folio struct page folding (HVO).
> 
> The use cases I'm imagining for drivers would be pushing gigabytes of
> memory into this preservation mechanism. It needs to be scalable!
> 
> This also illustrates my point that I don't think FDT is a good
> representation to use exclusively. This in-memory structure is much
> better and faster than trying to represent the same information
> embedded directly into the FDT. I imagine this to be the general
> pattern that drivers will want to use. A few bytes in the FDT pointing
> at a scalable in-memory structure for the bulk of the data.

As I've mentioned off-list earlier, KHO in its current form is the lowest
level of abstraction for state preservation and it is by no means is
intended to provide complex drivers with all the tools necessary.

It's sole purpose is to allow preserving simple properties and ensure that
memory ranges KHO clients need to preserve won't be overwritten.

What you propose is a great optimization for memory preservation mechanism,
and additional and very useful abstraction layer on top of "basic KHO"!

But I think it will be easier to start with something *very simple* and
probably suboptimal and then extend it rather than to try to build complex
comprehensive solution from day one.

-- 
Sincerely yours,
Mike.

