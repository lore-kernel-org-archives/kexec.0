Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B5ACD98E2
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 18:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MuHmxF3Q3Im7lyehrUggcluXuhikWRgzOx5fgePtduM=; b=noxFZqPZ+Nu+vedZRT/DqXlAIK
	aOKfQsy5F5XSwJVz3nEVqPVSaA1OUsZid/BpT1mBVRX3BWc+6mo8ZgeCGzELY/DGHQcSxN9+0u3X7
	4pj7oRY4FIP8VqPorRIVLxAin2NPNSY2A1P8QEhIUA9rOz4Khyqzv/jJKnGEQfEfuHOlJATUVgv57
	5kj35giLq3KbsojZOOr2idKukhukFsAP0IN5FWVMXqsKnoq/JPEzLel3H71egOK1QECpHklLeOuDU
	yuzEL7IKPKhFOenCQVTjrcpMDVZQ0VyZzMt5vmtSW00g2x4tLmWhou32WMb/zuO8sB+42NqdbvgBo
	GFu+nAHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvSI-00000000Dq0-3yFl;
	Wed, 17 Jun 2026 18:57:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvSH-00000000Dpg-1aV8
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 18:57:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BD4A460052;
	Wed, 17 Jun 2026 18:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7891F00A3A;
	Wed, 17 Jun 2026 18:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781722660;
	bh=MuHmxF3Q3Im7lyehrUggcluXuhikWRgzOx5fgePtduM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fXryMjMk/Xq0WcxFi0hr2UMx4uUqPl2Mf+U9u1XOSgK97gCt9F2Qm2zCSpchld2X1
	 vfC2fdVvpzjCo3Z9nE+pNnZI9XoAGHR5qfhtC4Q2v4OBXjWdQ8gaqUoL9eCDuxcXER
	 xedFJeKWCkOW7+5sRRdytlXq/QqYQhGgJqFmrYNyT0nllTv/ZUNuiDlzC2prcNqvb/
	 8dz/HpV3EQ9T90n+zh5IiZ8qKomMPZAeeA3UGDdcVlp+Ywim0K6W0R150Qcj3fGN1q
	 Ej1mYOlwedKVnNOTm2EjbjCH4U3hB27BjqzilFy1KDmqWYsrIOR9dZAuJzC25K8GFG
	 o3Ys2n/hyo46Q==
Date: Wed, 17 Jun 2026 21:57:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	David Matlack <dmatlack@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>,
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 0/3] kho: Add support for kunit mocking KHO restore API
Message-ID: <ajLuHq-FJxrIzr51@kernel.org>
References: <20260521193202.746810-1-skhawaja@google.com>
 <ah0t9Ss_S-5iOM59@kernel.org>
 <ajGOIOqBY1pazq5g@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajGOIOqBY1pazq5g@google.com>
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

Hi Sami,

On Tue, Jun 16, 2026 at 07:15:03PM +0000, Samiullah Khawaja wrote:
> On Mon, Jun 01, 2026 at 10:00:05AM +0300, Mike Rapoport wrote:
> > Hi Samiullah,
> > 
> > On Thu, May 21, 2026 at 07:31:59PM +0000, Samiullah Khawaja wrote:
> > > To write kunit tests for preservation and restoration of liveupdate
> > > state in various subsystems without triggering the actual kexec, the KHO
> > > restore API needs to be mocked by the test writer. The mocking is done
> > > to allow testing of the individual components or functions in isolation.
> > > 
> > > The patch series adds the following to support kunit testing when using the KHO
> > > API:
> > > 
> > > - Add static stub hooks to mock the KHO restore API so the restore path
> > >   can be tested without triggering kexec.
> > > - Add helper function that can be used by the test writer to check if
> > >   memory is preserved in KHO tree.
> > > 
> > > Finally, it adds a KUnit test for the KHO API that verifies the allocation of
> > > preserved memory, and the preservation/restoration of pages and folios.
> > 
> > I looked at the tests for preservation and apparently they don't add
> > coverage beyond the existing KHO selftest. How hard and/or intrusive would
> > be adding tests for example for error paths?
> > 
> > Do you have an example of a kunit test for another subsystem that would
> > benefit from mocking of KHO APIs?
> 
> I think intrusive tests to get more coverage for KHO would probably not
> use the stubs added in this series, as these are meant to mock the KHO
> restore API itself.
> 
> My motivation was to allow downstream users of KHO to test their own
> preservation logic (making sure their ABI doesn't have bugs). LUO or the
> recently added KHO linked-block can probably be a start?
> 
> The KHO kunit test added here is just a minimum example of how to use the
> stubs, which is why it doesn't provide much extra coverage.
> 
> I am perfectly happy to drop this patch for now. We can get this in
> later when we have kunit tests for KHO users. WDYT?

I wouldn't want to merge this upstream before the actual users appear, but
we can apply this to a branch in the liveupdate tree and keep it there so
that subsystems that plan to use these stubs could base their work on that
branch.

Let's revisit this after -rc1 is out.

> Thanks,
> Sami

-- 
Sincerely yours,
Mike.

