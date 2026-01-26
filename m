Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EB4CF65DB
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 10:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JOwl1LOtoKU5/PoRXFyQSq1478e5eRvje0/beAymu74=; b=h5wdxUkxXBxrXggM/4z3Aa9iYw
	UUzki/yFuR4iQ6b9qLK7eyzR/ABGBQSK4EMO2KhX5AtDmyp3ZjXB+jz3Xg0vNSqtcd4srQK0b8Jb3
	UsaExyF4M2hro/wYg2VAac3GOeImugQK18KYSR6nXn0vL2WVVo8quROWLkQymt4c2lB4RnzqexT9s
	7KXT/xFZh5C46YCRJj+Z6r6T84lilk0bX1unSrHD3eMEFebFUpMQqHYYLED1FDXtDlp2OLnrz4j+D
	NRc5BofJrVMcUPOLr2tiRfUwYzKgFGug7tHb4Ajyvtksk1w7hdvcccYnDkNzIX0JKs3/WhKkH/miH
	xwQUhX9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkKCm-0000000CMXI-3zyv;
	Mon, 26 Jan 2026 10:52:24 +0000
Received: from [2001:41b8:202:deb::311:108] (helo=stravinsky.debian.org)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkKCh-0000000CMWs-0HdD
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 10:52:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JOwl1LOtoKU5/PoRXFyQSq1478e5eRvje0/beAymu74=; b=FoeaBPY0sUru0rq2ib8j3XoHP0
	jLisWlOIFORxUfmSwSfaBPksTO0/3iVT4cjfhskdL07owgh01DLsc9Vxkf8bEnYpffwyo7XjcMyfV
	LoXFCdyb2d/U03jgFLE6O/Pdnffd91i9BOd3NM0vnV7E1EoHsFeMFyqUDX5kAx5xC6ncJWcd6Cq7b
	wY38oXTrfyD0C1tJujuVRBPeOgbCDNdeONtJ8frbYHDDRQLthI38YiqGTcN4K457qBhgb1Cv8qy4K
	D9R84n7FKPlZZH813+eIw70MV1hqEOcLPZ92rcv4OZF2x/FE5lWDAQpQ3Dp/vi+7Y4hew5+/pCG5r
	M2foYQNQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkKCR-00G7ie-Sd; Mon, 26 Jan 2026 10:52:04 +0000
Date: Mon, 26 Jan 2026 02:51:58 -0800
From: Breno Leitao <leitao@debian.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, riel@surriel.com, 
	kernel-team@meta.com, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4] kho: kexec-metadata: track previous kernel chain
Message-ID: <aXdGyXNUO0mPwJsp@gmail.com>
References: <20260121-kho-v4-1-5c8fe77b6804@debian.org>
 <aXICriRKbYB5f3li@kernel.org>
 <aXILzST3NxyYXW1m@gmail.com>
 <aXX_SxpI8Tuh6Q3V@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXX_SxpI8Tuh6Q3V@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_025219_186081_E0139D03 
X-CRM114-Status: GOOD (  20.91  )
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

On Sun, Jan 25, 2026 at 01:32:27PM +0200, Mike Rapoport wrote:
> On Thu, Jan 22, 2026 at 04:04:55AM -0800, Breno Leitao wrote:
> > Ack! I am planning something as:
> > 
> > 	commit 90e098ca0d611b44594f08e50ba1cff3c932dd2b
> > 	Author: Breno Leitao <leitao@debian.org>
> > 	Date:   Thu Jan 22 03:47:23 2026 -0800
> > 
> > 	kho: document kexec-metadata tracking feature

...

> I'd move this section before "debugfs Interfaces", other than that LGTM.

Ack!

> > > Can't we move it into the existing if (fdt) below?
> > 
> > Unfortunately, that won't work due to a data dependency between the two
> > functions.
> > 
> > kho_process_kexec_metadata() reads from the FDT subtree and populates kho_in:
> > 
> > Basically:
> > 
> > 	kho_in.kexec_count = metadata->kexec_count;
> > 
> > While kho_populate_kexec_metadata() increments metadata->kexec_count:
> > 
> >           /* kho_in.kexec_count is set to 0 on cold boot */
> >           metadata->kexec_count = kho_in.kexec_count + 1;
> > 
> > If kho_process_kexec_metadata() is moved after kho_populate_kexec_metadata(),
> > the count would always increment from 0 to 1, ignoring whatever was passed in
> > the FDT.
> > 
> > Restructuring to call kho_in_debugfs_init() earlier also doesn't work:
> > 
> > 
> > 	if (fdt) {
> > 		kho_in_debugfs_init(&kho_in.dbg, fdt);
> > 		kho_process_kexec_metadata();
> > 		return 0;
> > 	}
> > 
> > 	/* Populate kexec metadata for the possible next kexec */
> > 	err = kho_populate_kexec_metadata();
> > 	if (err)
> >                   pr_warn("failed to initialize kexec-metadata subtree: %d\n",
> >                           err);
> > 
> > This would return early without populating the kexec metadata for the next
> > kexec, breaking the chain on KHO boots.
> 
> How about we rename kho_process_kexec_metadata() to
> kho_retreive_kexec_metadata() and add kho_process_kexec_metadata() that
> will first call _retrieve and then _populate? Something like
> 
> static int __init kho_process_kexec_metadata(const void *fdt)
> {
> 	int err;
> 
> 	if (fdt)
> 		kho_retrieve_kexec_metadata();
> 
> 	/* Populate kexec metadata for the possible next kexec */
> 	err = kho_populate_kexec_metadata();
> 	if (err)
> 		pr_warn("failed to initialize kexec-metadata subtree: %d\n",
> 			err);
> 
> 	return err;
> }

That would work, I will probably rename it to kho_kexec_metadata_init()
or kho_kexec_metadata_setup() to follow the same pattern already there.

Thanks for the review, I will send an updated version soon,
--breno

