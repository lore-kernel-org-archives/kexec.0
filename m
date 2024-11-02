Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AE4E677FC
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/l37cuiX6l3yhVPHG576cySC0JlDZZNGEki0/2f4Fr8=; b=smG8OztJoLe6dd
	bdTSPV+laLECR3aqfzOqVhAbZbgCAF77oA07i6Kar3BKgaZJpXXYsZPOp90BScpReIvI4qo6xqDdC
	zbnTiQKF10iwxXvb91hT+tDkEWd84mE6rDZPZf1KsXvI88CLbd4hPiddW0QMQh/MrRn5KgsRh7jna
	BMDCAL8M+sTfVrF+Xr2LPJDdfV57dVaZ4Zc/lqXFoWrXbSTbx0SvYxd4ciEITsR4HPnYcktsXF5h5
	FDM7jRGktMnTYf1dLaLPCpfMpIzwN9eAcqeUfCP36eR8w8KDT3M70AU+K2FwnjtWYi6ULg4y1Yqjz
	b97cSfEMNchUJR/A8saQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7EmX-00000009pVO-1nC3;
	Sat, 02 Nov 2024 14:07:13 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7EmU-00000009pUS-35VU
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 14:07:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E5062A40280;
	Sat,  2 Nov 2024 14:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56207C4CEC3;
	Sat,  2 Nov 2024 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730556429;
	bh=Q821xsKXoJpJAxa6aZg5/VMu9xAoqVqBnQJhUqyV72k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=IOcQWZtRAPtxYRkzOQxHHSquppDz8lzAFNi0f/YvjS7tasWa59/bNiUZYoNhNkaX2
	 yiReHqnCuWv9KDvpJLznhKnSsAM/GWuiXTf6mS0qOY6QPIHUAoKFMBOSI4jV0K4Qjd
	 tHv7ujaIKeF+1aJbmQy7dIifP3mYPQtwAWb5Lo23Etmo8Xzwx8681roOg5DpJ2F05/
	 27dvBPeEX5Ez7GkT+sorULpAYaC2bfUN5oyUPyyrhbqCrxQCayb1kxPUiu7RScXEiw
	 YZ9L3gwbDqvznQ5inQSWLuVdcZoJwqQHEi48Do7mIljbZSCjNNRjtznzvIilf0QzQZ
	 6pbXxvUPnwrlA==
Mime-Version: 1.0
Date: Sat, 02 Nov 2024 16:07:04 +0200
Message-Id: <D5BR1YBPGPWG.28WTN4GE8V87N@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, <James.Bottomley@hansenpartnership.com>,
 <andrew.cooper3@citrix.com>, <baolu.lu@linux.intel.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <davem@davemloft.net>,
 <dpsmith@apertussolutions.com>, <dwmw2@infradead.org>,
 <ebiederm@xmission.com>, <herbert@gondor.apana.org.au>, <hpa@zytor.com>,
 <iommu@lists.linux-foundation.org>, <kanth.ghatraju@oracle.com>,
 <kexec@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-efi@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <luto@amacapital.net>, <mingo@redhat.com>, <mjg59@srcf.ucam.org>,
 <nivedita@alum.mit.edu>, <ross.philipson@oracle.com>, <tglx@linutronix.de>,
 <trenchboot-devel@googlegroups.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH v2 1/2] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ard Biesheuvel"
 <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
 <20241102062259.2521361-1-jarkko@kernel.org>
 <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org>
 <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>
 <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>
 <CAMj1kXExMWBAx7geuU8Uwp9CQLpJyTgYmWUw2CtKd3xT8mMFsg@mail.gmail.com>
 <D5BQGY5425TQ.3U6N698H2KYWO@kernel.org>
In-Reply-To: <D5BQGY5425TQ.3U6N698H2KYWO@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241102_070710_868813_7CC5C5EF 
X-CRM114-Status: UNSURE (   6.36  )
X-CRM114-Notice: Please train this message.
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

On Sat Nov 2, 2024 at 3:39 PM EET, Jarkko Sakkinen wrote:
> int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
> {
> 	int ret;
>
> 	if (locality >= TPM_MAX_LOCALITY)
> 		return false;
>
> 	ret = tpm_try_get_ops(chip);
> 	if (ret)
> 		return ret;
>
> 	chip->default_locality = locality;
>
> 	tpm_put_ops(chip);
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(tpm_chip_set_locality);

Other things to take from 1/2 of my RFC to this:

1. Must be one-shot.
2. Must be only for tpm_tis as this is made to work only with that
   driver. E.g. 15/20 is only for tpm_tis. I guess that is the
   main target anyway here. Future patch sets can extend this to
   other drivers.

TPM_CHIP_FLAG_SET_LOCALITY_ENABLED use in 1/2 can be referenced
for a solution.

Kernel command-line parameter: I agree not having it if no need
for ioctl, so that is addressed too.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
