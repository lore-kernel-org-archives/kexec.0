Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5915CAC59A
	for <kexec@archiver.kernel.org>; Sun, 21 Sep 2025 22:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Goc4fu4E5QtA9qLOcM+4h+EpWxYEBSIjsqPof2KABk=; b=chaFqhuvYu0JVpOfYCIoo77Pne
	bAe/se7PhGh5ouJsHzF36Ngk+ZEL5lYadlcQfjZIHWvP2UfIH3HVEDHI2radGqXCfz0ETp1WTfDpO
	7EgW6fXTElUH3UQ/ZMPOq4wPPMW6CYLJn5vFh2jAuGs/XxSj1Kd/MIPSiTKqZcm8y2I3RjJAt1cQp
	x0oiO3BrwGLdPlq2zGHDuYq1WdfsPZJfgVbKiyjIEyDnByrhOngx3dt/gsWum+RIzdh4bni62kC57
	+8maGExg1pM9q43ZLkd35jJOoOsOOrWBd1IOerOHP5D0VgHrodtCQdrlRh2D58OfOU2YpcHe3eH+r
	L9RriV1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0SVZ-00000008Kye-0xF5;
	Sun, 21 Sep 2025 22:26:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0SVV-00000008KyY-2aUn
	for kexec@bombadil.infradead.org;
	Sun, 21 Sep 2025 22:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0Goc4fu4E5QtA9qLOcM+4h+EpWxYEBSIjsqPof2KABk=; b=eXHuVgdZPnG4LY9fvzsP9Thzot
	7SaWdtBpIJZJ+ZMtycjRH8f62jRq439I7bIDyx/lEVq+2Y10XLWKT4YXi7uMdnYZoofhXR7UdOOOB
	RSmpSUJ7igwnEk+/VRLt6W6jicEw9dEBpykWNOAi5hSq+cGm/noOLpvNUmbGliqToIXvQ5yXENXp2
	RhvcPu7pLZ1vqzz82SGYd/zFFjc43f6hYFhbKRjCSKqROT1b0A30axHs3tfmYRwL7WZZCmarTEiKL
	JkJqPsmNJcpyljqdklBvphzT8J935OBZoPhSuDwqpF7dZ38OGrRXbJC50KHrwCVSBrEm3TWxEt6d5
	dCR4URDA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0SVR-0000000COjD-2G10;
	Sun, 21 Sep 2025 22:26:05 +0000
Date: Sun, 21 Sep 2025 23:26:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Petr Mladek <pmladek@suse.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 0/4] Make KHO Stateless
Message-ID: <aNB7fTesaVCXHB0E@casper.infradead.org>
References: <20250917025019.1585041-1-jasonmiu@google.com>
 <20250917113609.GB1086830@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917113609.GB1086830@nvidia.com>
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

On Wed, Sep 17, 2025 at 08:36:09AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 16, 2025 at 07:50:15PM -0700, Jason Miu wrote:
> > This series transitions KHO from an xarray-based metadata tracking
> > system with serialization to using page table like data structures
> > that can be passed directly to the next kernel.
> > 
> > The key motivations for this change are to:
> > - Eliminate the need for data serialization before kexec.
> > - Remove the former KHO state machine by deprecating the finalize
> >   and abort states.
> > - Pass preservation metadata more directly to the next kernel via the FDT.
> > 
> > The new approach uses a per-order page table structure (kho_order_table,
> > kho_page_table, kho_bitmap_table) to mark preserved pages. The physical
> > address of the root `kho_order_table` is passed in the FDT, allowing the
> > next kernel to reconstruct the preserved memory map.
> 
> It is not a "page table" structure, it is just a radix tree with bits
> as the leaf.

Sounds like the IDA data structure.  Maybe that API needs to be enhanced
for this use case, but surely using the same data structure would be a
good thing?

