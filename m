Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C03EE63CA0
	for <kexec@archiver.kernel.org>; Sun, 25 Jan 2026 11:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PMowTRC9OtnPDS2ZtFYbgFHKwlbH5JZ3LWx5m6VSM5Y=; b=lvowZ52m2wjYgK5FXmDDdGSCVP
	KsEQLscBmHl3DeS+UUvRbXjM5mpIfPe10k9wce6jULM9NvI9O6Zi7c+175T7DUXGI04RDyMWQjgEM
	DCB5d7MF3Z4mpWgiEqx9AEeRwJnz4exRV5oFBPdYhgV2a5gLzROaEOpcWJPN2rezbMPEK0esaNtfa
	dhZrJQv77eWa8vsGEjc+nNGOhJ5dilkGnCPMPoQgZr0C3jwXj7gp0bIArbV8TS7avpiZIes8sWlW+
	r1xc89S+3qMV1F1dirpJQg6hNGGBb2jquxJw6MiSjv/9JAPC7jpseq0gCct0Cg98xQjcpHaaac+OY
	i/gEyoPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjyMB-0000000B7kP-44Q1;
	Sun, 25 Jan 2026 11:32:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjyM9-0000000B7k1-1OGC
	for kexec@lists.infradead.org;
	Sun, 25 Jan 2026 11:32:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 60DD743BF9;
	Sun, 25 Jan 2026 11:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4098C4CEF1;
	Sun, 25 Jan 2026 11:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769340756;
	bh=DALCkrQPWtk9H7+d/aGiJ42oNVLwpdqVy+SfoWTK9Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msLpPpb3AN7Nz6lgCEhTvDNv/wrAShMlG+UIDVdsOhpcdvF74+u6CfBG4Alz7jxOq
	 6GGi/65QVo6nZ3ItWks6RPBBrbPZinQD/2QRGVN2uq+BqQrSv0c7kOb7USX3EgsH3q
	 RNxLYVhwS5hoEL8qsYz1fQVil40SPdL01h1+hNbXAV3IvYhZkGJee5UcMfnM4bZy39
	 amJJc4dbvXNA5DK/U/HzvdBdwP0mjN/GIo+rmApMtxOQjixkFXgQxXFLmtcrAydotc
	 kLX9L21y29tNDLCT5b4FyGT7UyEleZzk0XFK09d635WSoVe56bXmhRXAam5GhWkqGL
	 YIfzVqZMI9LYA==
Date: Sun, 25 Jan 2026 13:32:27 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com,
	riel@surriel.com, kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4] kho: kexec-metadata: track previous kernel chain
Message-ID: <aXX_SxpI8Tuh6Q3V@kernel.org>
References: <20260121-kho-v4-1-5c8fe77b6804@debian.org>
 <aXICriRKbYB5f3li@kernel.org>
 <aXILzST3NxyYXW1m@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXILzST3NxyYXW1m@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260125_033237_411205_6B89C0B7 
X-CRM114-Status: GOOD (  28.59  )
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

On Thu, Jan 22, 2026 at 04:04:55AM -0800, Breno Leitao wrote:
> Hello Mike,
> 
> On Thu, Jan 22, 2026 at 12:57:50PM +0200, Mike Rapoport wrote:
> > > +/**
> > > + * DOC: Kexec Metadata ABI
> > > + *
> > 
> > It would be nice to link it from Documentation/ as well ;-)
> 
> Ack! I am planning something as:
> 
> 	commit 90e098ca0d611b44594f08e50ba1cff3c932dd2b
> 	Author: Breno Leitao <leitao@debian.org>
> 	Date:   Thu Jan 22 03:47:23 2026 -0800
> 
> 	kho: document kexec-metadata tracking feature
> 	
> 	Add documentation for the kexec-metadata feature that tracks the
> 	previous kernel version and kexec boot count across kexec reboots.
> 	This helps diagnose bugs that only reproduce when kexecing from
> 	specific kernel versions.
> 	
> 	Suggested-by: Mike Rapoport <rppt@kernel.org>
> 	Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> 	diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
> 	index 6dc18ed4b8861..1faf2c3ba4620 100644
> 	--- a/Documentation/admin-guide/mm/kho.rst
> 	+++ b/Documentation/admin-guide/mm/kho.rst
> 	@@ -113,3 +113,42 @@ stabilized.
> 	``/sys/kernel/debug/kho/in/sub_fdts/``
> 	Similar to ``kho/out/sub_fdts/``, but contains sub FDT blobs
> 	of KHO producers passed from the old kernel.
> 	+
> 	+Kexec Metadata
> 	+==============

I'd move this section before "debugfs Interfaces", other than that LGTM.

> 	+
> 	+KHO automatically tracks metadata about the kexec chain, passing information
> 	+about the previous kernel to the next kernel. This feature helps diagnose
> 	+bugs that only reproduce when kexecing from specific kernel versions.

...

> > >  static __init int kho_init(void)
> > >  {
> > >  	const void *fdt = kho_get_fdt();
> > > @@ -1357,6 +1413,15 @@ static __init int kho_init(void)
> > >  	if (err)
> > >  		goto err_free_fdt;
> > >  
> > > +	if (fdt)
> > > +		kho_process_kexec_metadata();
> > 
> > Can't we move it into the existing if (fdt) below?
> 
> Unfortunately, that won't work due to a data dependency between the two
> functions.
> 
> kho_process_kexec_metadata() reads from the FDT subtree and populates kho_in:
> 
> Basically:
> 
> 	kho_in.kexec_count = metadata->kexec_count;
> 
> While kho_populate_kexec_metadata() increments metadata->kexec_count:
> 
>           /* kho_in.kexec_count is set to 0 on cold boot */
>           metadata->kexec_count = kho_in.kexec_count + 1;
> 
> If kho_process_kexec_metadata() is moved after kho_populate_kexec_metadata(),
> the count would always increment from 0 to 1, ignoring whatever was passed in
> the FDT.
> 
> Restructuring to call kho_in_debugfs_init() earlier also doesn't work:
> 
> 
> 	if (fdt) {
> 		kho_in_debugfs_init(&kho_in.dbg, fdt);
> 		kho_process_kexec_metadata();
> 		return 0;
> 	}
> 
> 	/* Populate kexec metadata for the possible next kexec */
> 	err = kho_populate_kexec_metadata();
> 	if (err)
>                   pr_warn("failed to initialize kexec-metadata subtree: %d\n",
>                           err);
> 
> This would return early without populating the kexec metadata for the next
> kexec, breaking the chain on KHO boots.

How about we rename kho_process_kexec_metadata() to
kho_retreive_kexec_metadata() and add kho_process_kexec_metadata() that
will first call _retrieve and then _populate? Something like

static int __init kho_process_kexec_metadata(const void *fdt)
{
	int err;

	if (fdt)
		kho_retrieve_kexec_metadata();

	/* Populate kexec metadata for the possible next kexec */
	err = kho_populate_kexec_metadata();
	if (err)
		pr_warn("failed to initialize kexec-metadata subtree: %d\n",
			err);

	return err;
}

> --breno

-- 
Sincerely yours,
Mike.

