Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506D0C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 18:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dDGxMQkLzM5VDpPT4TA20nmgaFOaZys3hJhEKh9UkZ4=; b=zyyZn4JKEScS4I
	gjivPDlO4+KLJi5jxs4mj/jVT46Oc38Z4EHTqwFTYc0JdFWOtfjBkfQTqVGSJtIxPyJbUGU8vm28b
	wpaxCKW8S9q8vfir8NSEzTlKKb+16EAvrtcWkRF9poUPMO7AFrJlFYRpVACFgER6KsxSB/Qx04wrN
	CoHEIT41wZnJN2hz/SkbjRQaUXg4NNRuBPhEFcBkKnVLLHYzplUvsjr9thyg9NC5MKg9ZE98EWhJc
	ZmyDwMNWmq8FaXd6jXYOQoRPQ7GmpOW+H+dzKpbg8l0EaSBj0gkt8PW5DSUoDbu3HMKoQreFWy9ra
	ajQm08Dma71eEOmT4Agg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEYkK-00000003R3v-3SSm;
	Tue, 04 Jun 2024 18:18:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEYkH-00000003R2x-3Pg7
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 18:18:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E66E061306;
	Tue,  4 Jun 2024 18:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B45C2BBFC;
	Tue,  4 Jun 2024 18:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717525132;
	bh=tLjjYFY5sCNOwFACQ2wDYtXISD6b1TLmfsdB964Sstc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=n7dcQ/XJbYOrNgCq5ESQZ59Xa+8dYD9+SB2DAU+OfLA8+DJ598KJLqQiqzrIkhh0g
	 UKXoqmVVDSu94Mt+rn6Kt5IiGUIlnhjkHcBKGhkcGrtM0QGZQCWFjn9oN0jIncG0fp
	 0QlSaaAm4hwabRgHQVI9d18LWhK5wr2VVpmu2KdVihNlW73A86ZY77EafzsRt2QQ3r
	 B5ZE8GI052OZDh6CpZHFKpgpvDaWVst//+JGORQKi6AkRNZ1/NhSToLX/ckeeFOkdO
	 Q/yaIOC0UjL6j/KnhlbnzaO6guYALvwQyNR8Mk8553jwwkWCwCeyZlOfimTruQ5bse
	 XlUy3IHVbRpvA==
Mime-Version: 1.0
Date: Tue, 04 Jun 2024 21:18:44 +0300
Message-Id: <D1RFUDSAJJKJ.2MF9OSQAJGBRW@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 01/19] x86/boot: Place kernel_info at a fixed offset
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-2-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-2-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_111853_967323_DA0E2A14 
X-CRM114-Status: GOOD (  19.42  )
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

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> From: Arvind Sankar <nivedita@alum.mit.edu>
>
> There are use cases for storing the offset of a symbol in kernel_info.
> For example, the trenchboot series [0] needs to store the offset of the
> Measured Launch Environment header in kernel_info.

So either there are other use cases that you should enumerate, or just
be straight and state that this is done for Trenchboot.

I believe latter is the case, and there is no reason to project further.
If it does not interfere kernel otherwise, it should be fine just by
that.

Also I believe that it is written as Trenchboot, without "series" ;-)
Think when writing commit message that it will some day be part of the
commit log, not a series flying in the air.

Sorry for the nitpicks but better to be punctual and that way also
transparent as possible, right?

>
> Since commit (note: commit ID from tip/master)
>
> commit 527afc212231 ("x86/boot: Check that there are no run-time relocations")
>
> run-time relocations are not allowed in the compressed kernel, so simply
> using the symbol in kernel_info, as
>
> 	.long	symbol
>
> will cause a linker error because this is not position-independent.
>
> With kernel_info being a separate object file and in a different section
> from startup_32, there is no way to calculate the offset of a symbol
> from the start of the image in a position-independent way.
>
> To enable such use cases, put kernel_info into its own section which is

"To allow Trenchboot to access the fields of kernel_info..."

Much more understandable.

> placed at a predetermined offset (KERNEL_INFO_OFFSET) via the linker
> script. This will allow calculating the symbol offset in a
> position-independent way, by adding the offset from the start of
> kernel_info to KERNEL_INFO_OFFSET.
>
> Ensure that kernel_info is aligned, and use the SYM_DATA.* macros
> instead of bare labels. This stores the size of the kernel_info
> structure in the ELF symbol table.

Aligned to which boundary and short explanation why to that boundary,
i.e. state the obvious if you bring it up anyway here.

Just seems to be progressing pretty well so taking my eye glass and
looking into nitty gritty details...

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
