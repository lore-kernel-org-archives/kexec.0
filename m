Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5443DC44515
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 21:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9mE0sfVA6cta9/M5CvPkkpA0kKt/DbFANSsjRo5aapo=; b=oax/xDGls9aUvIA6t7ozFO7MYd
	eGAP5UR4D7/zlrB3GWjRcnM0bdVsN6R1psbm16W8z7HMOrB4oFBYQelIwimxWQvL94ATUr6DdGrF9
	z8gJAydPEg0/ZI7kPuqIadMaMLcCS51/HG9HxwV0LgYuoxuFoxmAaWPEffpAgCGchyln7fs1SW0o4
	cXhm728miKqp4gkKOlK5BS+r5tE9DBGeboGRBGbrUnYbcarv3BQ5M5JQWbhhB+lLg4jBRoD8665cz
	fic6pqe1PI6h4jjQS0h/Ny7Bnv5/qUa952fu7G47BxoF8YWfeEhPpcei4X7RmRj0gFgjKPmQkJGNE
	yGyq/P+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlvxK-00000007zCM-3M8M;
	Mon, 20 Jul 2026 21:55:22 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlvxH-00000007zBV-1yJU
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 21:55:21 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-38175907a56so3237641a91.0
        for <kexec@lists.infradead.org>; Mon, 20 Jul 2026 14:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584518; cv=none;
        d=google.com; s=arc-20260327;
        b=DPsmYTgGs3NckSfyPO9q0sLt2dMJI8OGaFszEE0qCxRIas+zzrDWccnIxMqGg0+X+B
         IcBpGDGegt7ya2rksIuZpvjp//7NBaA8AoLVVvT1fQc1gAAfOpIvMv8aGUBl4fDSuipA
         XBqtlRU98SPSkeNiKyHkHnOr27mfOxuVjWs2ThQBrgXhaHBFTpVH6M96CtoVGIsR74ip
         gFNdA2kgt9+ryo295+SYncJMrtwjdcuiRqT4rBaFDi6b1uPqUm9dUcTAZ1H+e4HT2VG+
         BOqaH0Doid7Hpyfl73YHqea0xwnLrzQksxnj58tqkM2QNdNS0PS5KNv/1VbT7AW+Bqzb
         ovQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9mE0sfVA6cta9/M5CvPkkpA0kKt/DbFANSsjRo5aapo=;
        fh=NmzZBCo2v6h/OOnChjJyHO5DmoEC8vLdB+rxb6oUc0I=;
        b=BBkZ6PhqH15ZwdmJgx8QrenBjb1nyBHy28HxOjkvEv2gQTvkcVN8nSJKexXnX7FFxU
         Xp+klmVqTVu/mkiX2dp+JTe7/3jWRg2zRrmRRB883C/7QYThp7qJpo4jPREC5fco8dyw
         nD42LgmM5Aak4T2Bcvlyi1iFrDYJ5iUlA4f7qVT7ssxpoG8Yl7VvbwzAjjT20DNrIrPH
         K8qmd4HGx4GqDDjPcCr4xcWXm1drjSFO3bD1ae4qh/MI8QHaWXC9LOV2eof6RkmoUCGS
         AIgdC2L8nE8BhWqK1yD+my0MbZD8rAI1G7XjJuWvCztZHJs1CSk0wSERE9LBGOdk13JD
         KWow==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784584518; x=1785189318; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9mE0sfVA6cta9/M5CvPkkpA0kKt/DbFANSsjRo5aapo=;
        b=qaZniUJFYSSwkqGswUxSzsBYdCL7MlSF78WLP2PkIM2xJWwVQV/eOA46/aIYGZBUrl
         KOJAmVBMWW7SEHj0Nkn9N8u5VfN9MSxoSQxFqC+W3SApR9e8XqQKAi4OMGbdEvilkuKZ
         R+UCv1/J71XZ8f1bX4+od3s9JTFGj4KAdxm+/vt9spVBkf6x0kIGpqV4aQ3u9IddVx8e
         sZJLtEpJqr5SQQRoX7EonenwR5J8w5DJii13ZBPOJWVdlDiFexqS0a08hOm9Z3p5LtX7
         iZe1GRSV+dQT+gq0/YzQE9ooPh04aklM8ZUypUIeM2yVCIV8B0VboCKS2LAkJv0NAf7N
         +f+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584518; x=1785189318;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9mE0sfVA6cta9/M5CvPkkpA0kKt/DbFANSsjRo5aapo=;
        b=KchdkSHRejqLXBV8Ocr5ipHzZF5lcnc5+q2XdNlFDFfkWhxng4a/aT9tvspxdhS+Hj
         BurJquE/RVW4FnB+B51xDt1L+6/Mo+dddYW1fi9bWxCGnHbY6kYU038psLZYEhXEMf1q
         dWTsLvT12nfGNdFCfIHQsWCcIyfi3trLsjBD1+eVtxlc5xKkfQR91IB91sKeV+b4L95Y
         hTNsU5K2j9G6q9GBdSjuIlim/Eo0M6x5foe/SsFisHW91J4rpr6wbD9pG5cXlrN7bcH2
         O1ViX1TmtC9r/KNlzB06/N6ULeZBfu/A5kcIJvBeZFcXZXkwgDyFJFvOF9yBh29RJ9iB
         tg4w==
X-Gm-Message-State: AOJu0YzlRhJHdDN6mrgAk7IvIrmpD8hTpbHyh1cU7HVTKHMe6S6hFbvj
	urQJAeP6SCUoYfD5y1fmh6BdUMSPKOJQ892ymb4LKUmoS9rGdN7J5wnft+5J9pJ8bu/7r3rYUJZ
	+HGosrQy1lwSpkgT4cOkBcE+fBkS0ZpH6pELe0XzySzaqFwWb11Z5iI8Y
X-Gm-Gg: AR+sD12cYX9o0MDmDzvkkXkKN8BIdAUfm8IhD/NvavOnXuoqDRObChryip3lBi3uhLq
	zPHpA5EP4qs6eZEoJYnh7wiAacNLGLgR/8ffWjJmCed5rr94CTPEHVk5LOb/X3k6+sHXd7FmG/K
	93txRPkMdAjg1O7/QCZNHHWVjcJ7XQayirE8c5XujK9gkhiYwMePRQ37ZpiPYoEkvCY+pos5sXF
	242qWLYhOsO9enMr2zdK4ldq0GZpoQQNS2LilT4jfehvZtMZZOXSLEg4sJyJaVCAETWmHy6
X-Received: by 2002:a17:90b:1d01:b0:380:8bb9:aba9 with SMTP id
 98e67ed59e1d1-38e3d13426cmr20701271a91.3.1784584518042; Mon, 20 Jul 2026
 14:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4>
In-Reply-To: <178432481253.189683.3297727348836286619.b4-review@b4>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Jul 2026 14:54:51 -0700
X-Gm-Features: AUfX_mzVY7YuVDoFqhrPV6EULV5udJxArm79VLoT9W377bOVTdCDKuzAWRnUCOk
Message-ID: <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_145519_511355_565BF585 
X-CRM114-Status: GOOD (  21.44  )
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

On Fri, Jul 17, 2026 at 2:47=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@google.com> w=
rote:
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 03075ce06ac9..df6a02240aa4 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev=
)
> > [ ... skip 76 lines ... ]
> > +     /*
> > +      * Hold the ref on the incoming FLB until pci_liveupdate_finish()=
 so
> > +      * that dev->liveupdate.incoming cannot get freed while the PCI c=
ore
> > +      * has a pointer to it. It's better to leak the incoming FLB than=
 do a
> > +      * use-after-free if driver does not call pci_liveupdate_finish()=
.
> > +      */
>
> I am confused by this. Each preserved PCI device must have an associated
> FD preserved with it via LUO. I.e., vfiofd would need to be preserved. If
> the vfiofd was not reclaimed, and finish is not possible, that vfiofd
> would still be owned by LUO, and therefore PCI FLB refcount would stay
> positive.
>
> However, if finish is possible, and this is the last vfiofd that is
> finished, FLB will be freed as soon as the reference count reaches zero,
> which I would think is the expected behavior.
>
> What is the point of holding a reference here, instead of only for the
> duration of FLB access, i.e. to make sure we are accessing a valid data?

The duration of the access is from here until pci_liveupdate_finish()
because that it when the pointer (dev->liveupdate.incoming) is
cleared. So that is why the PCI core holds the reference from here
until pci_liveupdate_finish().

We could avoid this by deleteing dev->liveupdate.incoming and,
instead, fetching the incoming FLB and doing the xarray lookup every
atime the PCI core needs to access the device's incoming ser struct,
but that would be inefficient.

