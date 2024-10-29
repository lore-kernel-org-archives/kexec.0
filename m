Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF32D3A67B
	for <kexec@archiver.kernel.org>; Tue, 29 Oct 2024 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cX774osWxdkYZ6WGEjb8Lb3ReCtSI6W8nFCRT0QUpAY=; b=fi51mfMR9mimB1
	71hYHNKRmNOqT2Q6sbK6D8221B3FbClTzRMsGIRzcW5m6zmWtd6dRvWauingveCiYs7vJiqfhGEr/
	iQ7iUqQsmn7ymwGgnj0zSaWZH24OMEFU76Z0X/de7oYFJ52pwjPZvlOadL+3aG4KXSqiya4oRwVDV
	/9hXvdoCyf6LtMN/iX2utBYPaFapZo20e7YQkk06gqO4CgzqFxA6Vl6AqBU4YV3z1kvIVG7quFbpY
	2MvsruOK1XBevBzPzhT/4qP405K3QH47nkgpI9/Y902Eoyq3++9SlXuwy1Oy2YkrY3KepMgpSHC0H
	xivIiTrj2hSp8pSgzuMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5rFJ-0000000FY5l-3nwx;
	Tue, 29 Oct 2024 18:47:13 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pFi-0000000F9On-2SQj
	for kexec@lists.infradead.org;
	Tue, 29 Oct 2024 16:39:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 857A2A42BAE;
	Tue, 29 Oct 2024 16:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4A9C4CECD;
	Tue, 29 Oct 2024 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730219969;
	bh=CvGZshwjj/Jzn5BjBR9puizjZSCPPPEqIfbTu3B8uME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H49B90HSTsjTYtBoUnW/LU4uL0T1hght3SqZoXNwwASlW55bQNW1CinjwhB/prcmu
	 iUoxWppmLaa5HNplX4vWLbPVkAG6YuzUv4H6BG/3/HxAKWJ3DWieR4Mz+tcKIBF0ir
	 NQVLIl7RSw4sDuGvQsRj0rCqRGAXZ/g283OZKWIiYR8ecmEAoPRGpPidbnDOkdFGB8
	 TeW7p5S3BktQ3dneRvFiYg43r1Fnj+DAgk9v+5LCHzStBuN4DbHRIum3ms39Cckv9g
	 aWohmQHz6h3UAMFJzdhnOZ0KvM+87mJQ2NFc4QKpRpimGJymmCS44YVNbGkyc5H6Fu
	 g9jRKgCFBGhxw==
Date: Tue, 29 Oct 2024 18:35:30 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: James Gowans <jgowans@amazon.com>, Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <mike.rapoport@gmail.com>,
	Pasha Tatashin <tatashin@google.com>, Peter Xu <peterx@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frank van der Linden <fvdl@google.com>,
	Vipin Sharma <vipinsh@google.com>,
	David Matlack <dmatlack@google.com>,
	Steve Rutherford <srutherford@google.com>,
	Erdem Aktas <erdemaktas@google.com>,
	Alper Gun <alpergun@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Sagi Shahar <sagis@google.com>, linux-mm@kvack.org,
	kexec@lists.infradead.org
Subject: Re: Pmemfs/guestmemfs discussion recap and open questions
Message-ID: <ZyEO0rFGTGAs-d_N@kernel.org>
References: <f44f317a-2dcb-cfe2-013c-7508907ce3df@google.com>
 <5b6613bc-beef-79e6-62ed-23de4dfafe51@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5b6613bc-beef-79e6-62ed-23de4dfafe51@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_093930_776930_1ED6ED1B 
X-CRM114-Status: GOOD (  34.47  )
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

Hi David,

On Fri, Oct 25, 2024 at 11:07:27PM -0700, David Rientjes wrote:
> On Wed, 16 Oct 2024, David Rientjes wrote:
> 
> > ----->o-----
> > My takeaway: based on the feedback that was provided in the discussion:
> > 
> >  - we need an allocator abstraction for persistent memory that can return
> >    memory with various characteristics: 1GB or not, kernel direct map or
> >    not, HVO or not, etc.
> > 
> >  - built on top of that, we need the ability to carve out very large
> >    ranges of memory (cloud provider use case) with NUMA awareness on the
> >    kernel command line
> > 
> 
> Following up on this, I think this physical memory allocator would also be 
> possible to use as a backend for hugetlb.  Hopefully this would be an 
> allocator that would be generally useful for multiple purposes, something 
> like a mm/phys_alloc.c.

Can you elaborate on this? mm/page_alloc.c already allocates physical
memory :)

Or you mean an allocator that will deal with memory carved out from what page
allocator manages?
 
> Frank van der Linden may also have thoughts on the above?
> 
> >  - we also need the ability to be able to dynamically resize this or
> >    provide hints at allocation time that memory must be persisted across
> >    kexec to support the non-cloud provider use case
> > 
> >  - we need a filesystem abstraction that map memory of the type that is
> >    requested, including guest_memfd and then deal with all the fun of
> >    multitenancy since it would be drawing from a finite per-NUMA node
> >    pool of persistent memory
> > 
> >  - absolutely critical to this discussion is defining what is the core
> >    infrastructure that is required for a generally acceptable solution
> >    and then what builds off of that to be more special cased (like the
> >    cloud provider use case or persistent tmpfs use case)
> > 
> > We're looking to continue that discussion here and then come together 
> > again in a few weeks.
> > 
> 
> We'll be looking to schedule some more time to talk about this topic in 
> the Wednesday, November 13 instance of the Linux MM Alignment Session.
> 
> After that, I think it would be quite useful to break out the set of 
> people that are interested in persisting guest memory across kexec and KHO 
> into a separate series to accelerate discussion and next stpes.  Getting 
> the requirements and design locked down are critical, so happy to 
> facilitate that to any extent possible and welcome everybody interested in 
> discussing it.
> 
> James, for the guestmemfs discussions, would this work for you?
> 
> Alexander, same question for you regarding the KHO work?
> 
> It's a global community, so the timing won't work for eveyrbody.  We'd 
> plan on sending out summaries of these discussions, such as in this email, 
> to solicit feedback and ideas from everybody.
> 
> If you're not on the To: or Cc: list already, please email me separatel if 
> you're interested in participating and then we can find a regular time.
> 
> This is exciting!
> 

-- 
Sincerely yours,
Mike.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
