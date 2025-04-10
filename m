Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BA8C369B8
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EjNA9E6fQoObQrEF9x/xR2bwcpg2cboOt/4jyue8tog=; b=GaI3nVSYbwg2F072glpKBCeeSr
	F9gX0YKx09L8ePD6uouH+aHhb9HInje1ZToM7CwLwoIucdIHxK7gdz7Mwy5tPmJWepFMCE+qLVzFA
	KkvQM4OOL3i8RYTV4KUBl9etbx06pPOINPs+2rTxhaDUwfiIEmhIJqYlk8tTlpMlsz86I2xs4skyT
	8BczFjC0OWSwmzEKkI0T/d+sj+eEqInY97b+lSoXD7CKHDSSevyyCqTrUPXmFShPsfZFVXiaBeS3F
	fyXcxfyLTPYV7WOlx5Xr9VPLhZqOCgvw+N8RQqla+DFq/M7etPkJaS2+dZXEoyH/qVgsrHIOvohdr
	EzYvGEzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJb-000000017lD-45te;
	Mon, 14 Apr 2025 08:37:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2v8C-0000000BGpV-35bh;
	Thu, 10 Apr 2025 16:52:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EjNA9E6fQoObQrEF9x/xR2bwcpg2cboOt/4jyue8tog=; b=RAnFP+sa8REHwREQhuJs2YHIWN
	OrZAs12oMxeWbpncHVB29giNb8cyVPFV3+HdAb/cmklF4kTJD8BRqCv4exsJXSKaiW7dMlbUE2hHr
	6rgi9NFwGz8ahECnVaFqrUK7nZu6YDFwiK+BHj3w1GQ+CEtykNrITzBxkTj4pqJiUfipuZUkHryYk
	FcoRDUUy751+rhrtNHwqavdxk62n4fXInDOnrKxh3cYuCP8m6EB01JqmoKvbOfJc3bUcP58GoemOM
	1W4ZmB951GNXPtbhO0Bcpxn93wdKB00fjmkCjI9efyEMQ5M5eQvjPtqEsh9cRwdCtzr+Y2WqmmMYv
	c2UMaN8A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2v83-000000039mo-2MIy;
	Thu, 10 Apr 2025 16:51:51 +0000
Date: Thu, 10 Apr 2025 17:51:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <ptyadav@amazon.de>,
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
Message-ID: <Z_f3Jyac_o308ws-@casper.infradead.org>
References: <Z_KnovvW7F2ZyzhX@kernel.org>
 <20250407141626.GB1557073@nvidia.com>
 <Z_P92UCbNCV0TbiA@kernel.org>
 <20250407170305.GI1557073@nvidia.com>
 <Z_Y4k4rDO-BbMjqs@kernel.org>
 <20250409125630.GI1778492@nvidia.com>
 <Z_Z8-BLWMkiWpaDY@kernel.org>
 <20250409153714.GK1778492@nvidia.com>
 <Z_aeEn7hKqGOG3Cf@kernel.org>
 <20250409162837.GN1778492@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409162837.GN1778492@nvidia.com>
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

On Wed, Apr 09, 2025 at 01:28:37PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 09, 2025 at 07:19:30PM +0300, Mike Rapoport wrote:
> > But we have memdesc today, it's struct page.
> 
> No, I don't think it is. struct page seems to be turning into
> something legacy that indicates the code has not been converted to the
> new stuff yet.

No, struct page will be with us for a while.  Possibly forever.  I have
started reluctantly talking about a future in which there aren't struct
pages, but it's really premature at this point.  That's a 2030 kind
of future.

For 2025-2029, we will still have alloc_page(s)().  It's just that
the size of struct page will be gradually shrinking over that time.

> > And when the data structure that memdesc points to will be allocated
> > separately folios won't make sense for order-0 allocations.
> 
> At that point the lowest level allocator function will be allocating
> the memdesc along with the struct page. Then folio will become
> restricted to only actual folio memdescs and alot of the type punning
> should go away. We are not there yet.

We'll have a few allocator functions.  There'll be a slab_alloc(),
folio_alloc(), pt_alloc() and so on.  I sketched out how these might
work last year:

https://kernelnewbies.org/MatthewWilcox/FolioAlloc

> > > The lowest allocator primitive returns folios, which can represent any
> > > order, and the caller casts to their own memdesc.
> > 
> > The lowest allocation primitive returns pages. 
> 
> Yes, but as I understand things, we should not be calling that
> interface in new code because we are trying to make 'struct page' go
> away.
> 
> Instead you should use the folio interfaces and cast to your own
> memdesc, or use an allocator interface that returns void * (ie slab)
> and never touch the struct page area.
> 
> AFAICT, and I just wrote one of these..

Casting is the best you can do today because I haven't provided a better
interface yet.

> > And I don't think folio will be a lowest primitive buddy returns anytime
> > soon if ever.
> 
> Maybe not internally, but driver facing, I think it should be true.
> 
> Like I just completely purged all struct page from the iommu code:
> 
> https://lore.kernel.org/linux-iommu/0-v4-c8663abbb606+3f7-iommu_pages_jgg@nvidia.com/
> 
> I don't want some weird KHO interface that doesn't align with using
> __folio_alloc_node() and folio_put() as the lowest level allocator
> interface.

I think it's fine to say "the KHO interface doesn't support bare pages;
you must have a memdesc".  But I'm not sure that's the right approach.

