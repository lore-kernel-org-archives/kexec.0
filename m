Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52344E6529E
	for <kexec@archiver.kernel.org>; Sun,  1 Feb 2026 22:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gTQ2x8UFffFN8oMJq+k7riVCHd3Bz/9h/U4e2EOF/w0=; b=AlQsDaf9AgkuNUpXhWR5PKQ1kk
	T/uK8m66pYcgb1yj1hcB4+8sEls8VtwoiO8POnRquFBdtg3qqSktiExwNicQgWdkZxLtUgXRKsgnQ
	Y83bFDy//yqBNT1D1G5K/EeuK8ozcqImAV7Jjp7EDsdZ3wZm2o35ZbDIwMWjfgqnij8s8FaVwzw1C
	lzYX+odFPPVtNusY72pkXRPjlEOKWaXsS86Uh5ToaSxy0tyLabCAEkA5WL9+FrqO5TjPVfTT5O5c1
	gBY7ABahG1ZGsGLjDnj3popb4Wj3U0ssHFE/nKpex9prAtG3wg3H+8UWyE4b9zzgKW5RkVCObtI0T
	XYz/hXew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmgDP-00000004D0i-1f2b;
	Sun, 01 Feb 2026 22:46:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmgDM-00000004D0L-3raM
	for kexec@lists.infradead.org;
	Sun, 01 Feb 2026 22:46:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4748B43869;
	Sun,  1 Feb 2026 22:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9944FC4CEF7;
	Sun,  1 Feb 2026 22:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769986003;
	bh=FCYpJl8EOX8GMWf4gm75QpFvBDwzIFIO8cA6R9Ty+Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=demddUI3kI/QRadXK8U7OSeKMbsdkhKJqfLguBHAca+Trk4VXSu0sJZCszhFvMfeF
	 QBhh4DkygaGFZjcREzGN+Gg3DGSZf4C9/aCNsy9ixHnDgHtnTp34sz+GtxNQ7YEfMx
	 uTogeujSiWcnvxxf/yJJ3NRK0/IJ2TBa4ES8Gre9M/GYhHOloTrh686VAzyxHSNW9+
	 azvzULdZsop3ti7N1x4mnbaRHfu4ahXro61ihGNaHMZVmrkqeHLxo6kSE7TEkw4xJq
	 G1VieqSHaz92qAYAL2qzNdThPFf0+IsKjI1kqbXL6ENmRTt0F3PXmIR+kMkQaJw9Wm
	 e2I9O5NDkD9Ww==
Date: Mon, 2 Feb 2026 00:46:39 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux.dev,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 01/28] tpm: Initial step to reorganize TPM public
 headers
Message-ID: <aX_Xz3ERMEb7GwK8@kernel.org>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-2-ross.philipson@oracle.com>
 <aW7A-4xJSzln1HtH@kernel.org>
 <b94815dc-fc4d-4073-bfd6-31ab99a6b85b@apertussolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b94815dc-fc4d-4073-bfd6-31ab99a6b85b@apertussolutions.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260201_144645_003924_80A721CA 
X-CRM114-Status: GOOD (  22.22  )
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

On Sun, Feb 01, 2026 at 11:20:20AM -0500, Daniel P. Smith wrote:
> On 1/19/26 18:40, Jarkko Sakkinen wrote:
> > On Mon, Dec 15, 2025 at 03:32:49PM -0800, Ross Philipson wrote:
> > > Replace the existing public header tpm_command.h with the first two
> > > new public headers tpm1.h and tpm_common.h. In addition, related
> > > definitions in tpm1_cmd.c were moved to the new tpm1.h.
> > > 
> > > Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> > > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > > ---
> > >   drivers/char/tpm/tpm-buf.c                |  3 +-
> > >   drivers/char/tpm/tpm1-cmd.c               | 13 +-----
> > >   include/keys/trusted_tpm.h                |  1 -
> > >   include/linux/tpm.h                       |  3 ++
> > >   include/linux/tpm1.h                      | 55 +++++++++++++++++++++++
> > >   include/linux/tpm_command.h               | 30 -------------
> > 
> > Removing tpm_command.h causes unnecessary noise.
> > 
> > It would be better to retain tpm_command.h, and simply supplement
> > it with TPM2 constants.
> > 
> > Also, what is the reason to not have both TPM1 and TPM2 in tpm.h?
> > 
> > To put the question in other words: is there something in tpm.h that
> > would be incompatible with early boot code?
> > 
> > I'd rather tweak that than have more files...
> 
> Every #include in tpm.h will break in the early boot code. I don't see any
> way to avoid having one header that is the device driver header that
> integrates with mainline features and at least one header that holds the
> general TPM definitions.
> 
> We will move everything that was broken out into tpm_command.h, making it
> the header with the general definitions. I would raise the question of
> whether tpm_command.h would be the best name of the file after definition
> reloactions

tpm_command.h conforms with lowest common denominator in the sense that
it in its current state it is compatible with early boot code.

I'd consolidate TPM1 and TPM2 definitions that can be shared to that
header. I guess rename is fine as long as protocol definitions are
not scattered to two headers.

BR, Jarkko

