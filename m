Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF702C54798
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 19:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nmiOz4G3ZhPf0idEdHF0fIZdztmdHMQUL7R+lNM6RMs=; b=VuekBizDIzHAtO
	DmJ1fYDw6XB5x5kHKEdr3ClxvV/luDGcWd0oiTQzrrEQvxO2uY/e1PPRsDUhQdakrbQI35OlzTG1W
	bvBBYzYb48kZPxA0i/XJGreK7D00CBuwmq1oHEvzKDY+BPq5CBndHfQXRxZhsjHy5f0XRTH7fpxE1
	zp64cV0i1p45WDnqDQemDadVPND9jd1E5u8QhYz8zJpou98O/bxVcc/bCkfY7OhlLEqfKdbEiuJ8G
	tVARi7DixQrIUt10FLuccb9aVH3lpgLLnuzcpZj0aLcm6BG10WcQLiLyXJXqTp9DR06wvdh5nNnXK
	Ohxw22Z6pHDetQseZ66Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdatO-0000000AxTD-1DHI;
	Fri, 23 Feb 2024 19:07:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdZlK-0000000Af30-2khu
	for kexec@bombadil.infradead.org;
	Fri, 23 Feb 2024 17:55:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2RHelr+Ph97AiMQ6PESS8TFDHLVaDkzRx9AB7ctN5iY=; b=eVstQu6lQILKu+k89wd7zB5H1S
	K2g/eDloypi4cEOwKXvuvSuYUVW0ep7GLd5WhdHMvHrYuQagJEoUFNDtNaG/e5i8Bj7GthSvPPwP3
	YwSYLm01fEfYuKtmMMOMLfCY4s3ZuehZt5mUZylOLZOANWlO4fScqbEU0JGxH4KdryROnQNidIwLP
	HUGaFBZeOOSyPfPcvj44N8CswdDevLvJuMzFD0xR49lbXslc9fPAmN1F3rhSKvuweDytR57NGQuJt
	OcZ5ZTA8AWXU27iMPi6WYDlHnQU9nl8nyY4TwkQsRrcgOwspOlg0IJlz59EHVvN21dkl2UtULu5YG
	7rNvHawQ==;
Received: from sin.source.kernel.org ([145.40.73.55])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdZlG-0000000049E-1Y4m
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 17:55:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 37D0ECE2E3A;
	Fri, 23 Feb 2024 17:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C556C43399;
	Fri, 23 Feb 2024 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708710891;
	bh=QDQLjwhGjrv6J0gGJFn9+fBtaCu989tCcvRM0N4xN5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLDmk0vYspblgOXAoC1hDGtndhtEX5ClQrqv4HwBrmPOeqoDPmCoH9QecDEkw4k+b
	 le+AJCfHgTBFu7ME44ZsdGBgrPxx1XDntVzq7JqVKDEOoFe7olbmg8/Mlx14w0aKX4
	 3u2OB28AFlNz0RHygrPBtUvDPALSu+g3uUh4LE/RJbkhBQEe4R9IHYfaoPygrWlBkr
	 x0UQuR43gmgaTidqfHdUjdCr9FiQFhBf9jBVPN6Dhm7K/Wnvc11ns7eAbOUh04bbb/
	 GIMVyqki0yi5QhPsaSZUOq/tLrKFAzL4NndRsVCcGlq6gjsrZFsKE8F/it6IfkWKaw
	 4h/c916YgvLHg==
Date: Fri, 23 Feb 2024 09:54:49 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20240223175449.GA1112@sol.localdomain>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-7-ross.philipson@oracle.com>
 <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
 <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
 <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com>
 <CAMj1kXEvmGy9RJo4s8tECsFj2dufZ8jBPoJOEtkcGUoj+x2qsw@mail.gmail.com>
 <431a0b3a-47e5-4e61-a7fc-31cdf56f4e4c@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <431a0b3a-47e5-4e61-a7fc-31cdf56f4e4c@citrix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_175503_865585_D2503FB8 
X-CRM114-Status: UNSURE (   8.84  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Feb 23, 2024 at 04:42:11PM +0000, Andrew Cooper wrote:
> =

> Yes, and I agree.=A0 We're not looking to try and force this in with
> underhand tactics.
> =

> But a blind "nack to any SHA-1" is similarly damaging in the opposite
> direction.
> =


Well, reviewers have said they'd prefer that SHA-1 not be included and given
some thoughtful reasons for that.  But also they've given suggestions on ho=
w to
make the SHA-1 support more palatable, such as splitting it into a separate
patch and giving it a proper justification.

All suggestions have been ignored.

- Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
