Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A757AC44500
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 12:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SXWW54h4kaUiEYhDhi0tKdenERduKH4QQYXp8ttP4zc=; b=G00A8J/KsiXA3OAydonKoB0cBi
	aXpyhGjYMbhn17TQqtYC71yXBnSO2Mc4CKV/qMxXXAOBpOE2GtA2WZ+k/yw9yBJ+7XG0xLogsUE3Z
	NFuvis9hyvFwgrEe1e1gYn7NvB0Yqg71CitUxoTJ+Qn7Mzv0of7Qkh8/46W0pmj3aD5UO7x5ddIE+
	FFdSAV2yTIUdU8twv75dZmieF5hWkDL7yPVaxGEwTCvZNh7WlxLHHHGLmP9RYd+wwsEb4rgd7Gz4g
	Q7/aqjLFFpo+Ob6xozW31z3sCFrargXX8J0+kAKROAR5YKOeBsSY6/G7V7mVF95qsPNv9VNOn3bOW
	aLfvmo2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vitRH-000000071nN-2WDL;
	Thu, 22 Jan 2026 12:05:27 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vitRF-000000071mV-12x6
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 12:05:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SXWW54h4kaUiEYhDhi0tKdenERduKH4QQYXp8ttP4zc=; b=QTR5bMdKKQIdvaXl1F+VY653N5
	deoCWEBrVYM5kYB1ioI4txfqaRfnP3/o5wmJR2oU2T/VoDoj7W90huPy6y6/sdm2NEY9ITRF43+6H
	BeeHRXsBFRICDbM7413O2Nk4PFNOlU+PltnqN1zn7BdK8bsjLCiIwBZDP5UgtdcLdZ9gyGFXPsdNM
	LFlO8lwU6Bu22ZUYi65aKqLaxdQ0jLgryx5uGf6Gz7fQD/yINQjoqNHFB1SwVURunmeLGEAu0DPWT
	2JpJ9B9zf/hnKHZwWQ+jxU6KqB48S7sq2G8Edw4/CNsvZD+pF/go4hXkmlLs+/PP92bSZG0F5tsW+
	sHvLYNBQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vitQq-00D0EE-OM; Thu, 22 Jan 2026 12:05:01 +0000
Date: Thu, 22 Jan 2026 04:04:55 -0800
From: Breno Leitao <leitao@debian.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, riel@surriel.com, 
	kernel-team@meta.com, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4] kho: kexec-metadata: track previous kernel chain
Message-ID: <aXILzST3NxyYXW1m@gmail.com>
References: <20260121-kho-v4-1-5c8fe77b6804@debian.org>
 <aXICriRKbYB5f3li@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXICriRKbYB5f3li@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_040525_294316_7D7BFE1F 
X-CRM114-Status: GOOD (  26.72  )
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

Hello Mike,

On Thu, Jan 22, 2026 at 12:57:50PM +0200, Mike Rapoport wrote:
> > +/**
> > + * DOC: Kexec Metadata ABI
> > + *
> 
> It would be nice to link it from Documentation/ as well ;-)

Ack! I am planning something as:

	commit 90e098ca0d611b44594f08e50ba1cff3c932dd2b
	Author: Breno Leitao <leitao@debian.org>
	Date:   Thu Jan 22 03:47:23 2026 -0800

	kho: document kexec-metadata tracking feature
	
	Add documentation for the kexec-metadata feature that tracks the
	previous kernel version and kexec boot count across kexec reboots.
	This helps diagnose bugs that only reproduce when kexecing from
	specific kernel versions.
	
	Suggested-by: Mike Rapoport <rppt@kernel.org>
	Signed-off-by: Breno Leitao <leitao@debian.org>

	diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
	index 6dc18ed4b8861..1faf2c3ba4620 100644
	--- a/Documentation/admin-guide/mm/kho.rst
	+++ b/Documentation/admin-guide/mm/kho.rst
	@@ -113,3 +113,42 @@ stabilized.
	``/sys/kernel/debug/kho/in/sub_fdts/``
	Similar to ``kho/out/sub_fdts/``, but contains sub FDT blobs
	of KHO producers passed from the old kernel.
	+
	+Kexec Metadata
	+==============
	+
	+KHO automatically tracks metadata about the kexec chain, passing information
	+about the previous kernel to the next kernel. This feature helps diagnose
	+bugs that only reproduce when kexecing from specific kernel versions.
	+
	+On each KHO kexec, the kernel logs the previous kernel's version and the
	+number of kexec reboots since the last cold boot::
	+
	+    [    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107 (count 1)
	+
	+The metadata includes:
	+
	+``previous_release``
	+    The kernel version string (from ``uname -r``) of the kernel that
	+    initiated the kexec.
	+
	+``kexec_count``
	+    The number of kexec boots since the last cold boot. On cold boot,
	+    this counter starts at 0 and increments with each kexec. This helps
	+    identify issues that only manifest after multiple consecutive kexec
	+    reboots.
	+
	+Use Cases
	+---------
	+
	+This metadata is particularly useful for debugging kexec transition bugs,
	+where a buggy kernel kexecs into a new kernel and the bug manifests only
	+in the second kernel. Examples of such bugs include:
	+
	+- Memory corruption from the previous kernel affecting the new kernel
	+- Incorrect hardware state left by the previous kernel
	+- Firmware/ACPI state issues that only appear in kexec scenarios
	+
	+At scale, correlating crashes to the previous kernel version enables
	+faster root cause analysis when issues only occur in specific kernel
	+transition scenarios.


> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> 
> ...
> 
> >  static __init int kho_init(void)
> >  {
> >  	const void *fdt = kho_get_fdt();
> > @@ -1357,6 +1413,15 @@ static __init int kho_init(void)
> >  	if (err)
> >  		goto err_free_fdt;
> >  
> > +	if (fdt)
> > +		kho_process_kexec_metadata();
> 
> Can't we move it into the existing if (fdt) below?

Unfortunately, that won't work due to a data dependency between the two
functions.

kho_process_kexec_metadata() reads from the FDT subtree and populates kho_in:

Basically:

	kho_in.kexec_count = metadata->kexec_count;

While kho_populate_kexec_metadata() increments metadata->kexec_count:

          /* kho_in.kexec_count is set to 0 on cold boot */
          metadata->kexec_count = kho_in.kexec_count + 1;

If kho_process_kexec_metadata() is moved after kho_populate_kexec_metadata(),
the count would always increment from 0 to 1, ignoring whatever was passed in
the FDT.

Restructuring to call kho_in_debugfs_init() earlier also doesn't work:


	if (fdt) {
		kho_in_debugfs_init(&kho_in.dbg, fdt);
		kho_process_kexec_metadata();
		return 0;
	}

	/* Populate kexec metadata for the possible next kexec */
	err = kho_populate_kexec_metadata();
	if (err)
                  pr_warn("failed to initialize kexec-metadata subtree: %d\n",
                          err);

This would return early without populating the kexec metadata for the next
kexec, breaking the chain on KHO boots.

Please let me know if I am missing any other option.

> > +
> > +	/* Populate kexec metadata for the possible next kexec */
> > +	err = kho_populate_kexec_metadata();
> > +	if (err)
> > +		pr_warn("failed to initialize kexec-metadata subtree: %d\n",
> > +			err);
> 
> Please follow if (err) goto err_ pattern.
> 
> kho_populate_kexec_metadata() failure essentially means that we failed to
> allocate memory. This shouldn't happen that early in boot, but if it did,
> then something is utterly wrong.

Ack!

Thanks for the review,
--breno

