Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33E7C36014
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NlDL/hv6YqzvYilR5+0osMhw7ZHcXbgXJsoE+sm0vik=; b=F0Gt14QQdHRR21aLahA64DT/bu
	HN13drdj4hgrLFsBhf9sQm9cKRWJTVzp9AcT5TeY7MUX3pdkywqa+zqFr5u5b1svUGkK4r1EFFz3f
	f1ELVenwK4j/nRmNwgsAQyrreFXOIbUuWTJRRRG/ZHQAvvsFPhyrH4cZ+2DAEFseibL43uGmM+Suz
	MRBsj23kr562LIj/sAEilbnjBmtX/dz3yEfq7HSHR9PI+4ujOXEt1EG0oZuGFtgRPgZtny31+XLy7
	6G1a3TI6ur1srq2GIEB2v7C6TgFUBmfKEO4n94wiHh2BlLOLKRGOP2fFkMlDFgJXo+cLWsTp6qvWM
	URT9RtGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTr-0000000B602-2BQf;
	Thu, 27 Mar 2025 13:41:11 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twmNl-00000003vla-1CS9;
	Mon, 24 Mar 2025 18:18:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C6113A4A41E;
	Mon, 24 Mar 2025 18:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1986DC4CEDD;
	Mon, 24 Mar 2025 18:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742840319;
	bh=CvPtVrvhXjNToxQtztbHoatPZJDWgp/53NY9ElBqIcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m9Ur08k8fMZRkAAhCI2CxUvgZeupcT7GIrwX+p9fSpvfV3Ajb3FbMQVykY2lKtAQe
	 rcSRUeEGnf3/NMWyPQ0qugpcciD3AvqI+F+GniZhsF5a2Ryvk/XXb2nshNIIN+x5cR
	 JYlU5fpj2U7s/S3WdPrOsq+Y0apgFmjxkWh8sXtE1wxekMHk5W9Gzb05gDZS+Vgjfn
	 oho/ytmj/aLCNS2l7wFW8/VHiNHcb8DPqS3CMWOxTVqp1CjPVVhuNpZCOYebRtk4tZ
	 ZLlxV+n2Jb/jAlskHje+GtPWM7FPyNyourFaqabkHce71qm183YbuQjYPsdqdZX51N
	 JlOQHRHBYPBPw==
Date: Mon, 24 Mar 2025 14:18:34 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
	tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z-Gh-t9xB21UNGU2@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <20250321134629.GA252045@nvidia.com>
 <Z98Lmo50h5RboFXq@kernel.org>
 <Z+BZOKSpyPA1Pyu+@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+BZOKSpyPA1Pyu+@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_111841_387214_8D9AE535 
X-CRM114-Status: GOOD (  18.30  )
X-Mailman-Approved-At: Thu, 27 Mar 2025 06:41:08 -0700
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

On Sun, Mar 23, 2025 at 03:55:52PM -0300, Jason Gunthorpe wrote:
> On Sat, Mar 22, 2025 at 03:12:26PM -0400, Mike Rapoport wrote:
>  
> > > > +		page->private = order;
> > > 
> > > Can't just set the page order directly? Why use private?
> > 
> > Setting the order means recreating the folio the way prep_compound_page()
> > does. I think it's better to postpone it until the folio is requested. This
> > way it might run after SMP is enabled. 
> 
> I see, that makes sense, but also it could stil use page->order..

But there's no page->order :)
 
> > Besides, when we start allocating
> > folios separately from struct page, initializing it here would be a real
> > issue.
> 
> Yes, but also we wouldn't have page->private to make it work.. Somehow
> anything we want to carry over would have to become encoded in the
> memdesc directly.

This is a problem to solve in 2026 :)

The January update for State of Page [1] talks about 

	reasonable goal to shrink struct page to (approximately): 

	struct page {
	    unsigned long flags;
	    union {
	        struct list_head buddy_list;
	        struct list_head pcp_list;
	        struct {
	            unsigned long memdesc;
	            int _refcount;
	        };
	    };
	    union {
	        unsigned long private;
	        struct {
	            int _folio_mapcount;
	        };
	    };
	};
 
[1] https://lore.kernel.org/linux-mm/Z37pxbkHPbLYnDKn@casper.infradead.org/
 
> Jason

-- 
Sincerely yours,
Mike.

