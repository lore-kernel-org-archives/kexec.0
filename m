Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCFBC4452D
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 23:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GAFJIXu/UVteHEvaICMncjgcIn69HtrYqtQZR1t34RY=; b=BZTR4++SfWIRcTuzZX/wOEOkVA
	UAqk/feR41gWXAoLiFoaCk3be83WM6hbj+8pqXQE7Z5ORtot4OhcEruZM/PQhZfcM5VynA+1EfcsX
	LXRjPxxSyK76Q5K/QrWPf+JZK0l1lWn6jUqySzgIM5hepSVIaWuFI+GPj0Va695xRtHxNovW7fwch
	XALVaflKhy2feANpGQ3cfnc8TQAsY6qpqyQBs8TCFzJPPxUbpIYbOnMVtyQpIKoGL/cRN1KjNHQKY
	Kd4sW9ppJIKJhsvPBfhCbBBIgnLgy/TP8Xng8DKrKInySM7q4eaBK5ULx8rBD04eosxmnLm1yJWM1
	/48T7Uuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmKAx-0000000Abwl-0fAx;
	Tue, 21 Jul 2026 23:47:03 +0000
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmKAu-0000000Abv0-0u1M
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 23:47:01 +0000
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-930f4e5eed1so21455585a.2
        for <kexec@lists.infradead.org>; Tue, 21 Jul 2026 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784677617; x=1785282417; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GAFJIXu/UVteHEvaICMncjgcIn69HtrYqtQZR1t34RY=;
        b=WLe/Zg9dM+UwASQNHtRQRg9+7y4g9lATP7ziOxVF09kD1nRMveOIKysW0nwRAn9zyu
         qrn5PXHUnf/bw3qkUg++pGrDe+ys8Nmawiyu0QFO6yQ4TPiXN5nFJ48aGwK9JDxmWpsQ
         pcWBcgautoYb/OdMaAPkiQ5BaeYYcKt7uh+QTFYk4+Cq1BBj9FPYVLSYkwGU21gentYp
         D6psFiwuqlPOSxB9L8gqAhjguyJ/ipumeieB01AE+KGMFL8NCFHygw5DLnVpkMajdoXU
         nNQhNkRu8vx+cU5N/S6uPIskMpXiUdfm5z16SZdcWegWjj1I2CgZ9RXxqD5m4HLi+Pz8
         6qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784677617; x=1785282417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GAFJIXu/UVteHEvaICMncjgcIn69HtrYqtQZR1t34RY=;
        b=jlT37taWBTio4DPn4kVp9QJUackyXt1n5zQT2fz+WplJMBur2oxPiUnB5BERBepmCl
         ywaW23Xg8sPs98OGpoDE0Cqx3uJwREC89xsqLLZI4Q0Dkxx9y5PnqDnT/GH4J6g8w+bm
         wpdK+CpuAeaU+qjyyeSRJuMAFjCB/P5qYpLTWqAAaHiK8z7bdz/tO1ztq8NXP0GtLi+x
         WAGKhKA6HFguMGdaZ+txMgtB8vy2fgHBL7SxmWque9QpAx+rBAxtRV4DjpEjgMv+GYy0
         um4+ANqxvFa3JWvWy8y7XGgyYsRVPMgtsjvWvjz+B23xGWHiNgCVITqVEN4QA/1eiCbm
         DAsw==
X-Forwarded-Encrypted: i=1; AHgh+RrfU0l98g34AhNgK5r+mJPFgsBMG2DLJdsY9j4aoZYjWRAL25K1xJ1v39ypJLmJo9TfiVwKAA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw60azlk2s2zCeRxBOu5vtdXOSWoQOsLwh/GScttkRvxW6heH2K
	utCg8VJAvHoa7AvnhB9vpE0gDwgg+hq/r7cXMtn9wLzWhiAw8Mj5GGHNZbRJoLV8EpXxLrye4Xx
	QiuWO
X-Gm-Gg: AR+sD13DvOWCAmSAxXdvde9ZAHc5+Hs+hy/uSxXHMDqokSI6VOTKzPBFnrDqorASnLw
	w0SpmS4Qm7ys//0gww+TYUqb5FWpVynQ7sraPl5m0nBwEtQa5o3jH/5n3wScwpW4aNT4//lM5iV
	pxwjLH8LC/TOY2TbuYe/YJ+AivF/Oltw05qXPyT6xiHW0iY+2zU5XtXAvVJPW7VTyXiNIR6WbuW
	TxwbmOaGGFK19YC7Dus+bDqsP5HljQ3W0U0n+wgFC2L12LzXLdS0cS+6SpJX50X5q/mDZR221rp
	QjrOyEhzoeucZ+RuFOvVNq4ggUt4FjlU5j2RTDc5pn1vCvpyv4BF03yZhOGPXC8bM616ThZcVSl
	KCdUqQaTW7i7FoYapaP8rmmpreugKoGizhaLNou4Kr0Bm66I4uSFJIKxclWLRBR0GMfTKqkNLjQ
	DTLRwbkOd/PrSVa8k/fxPzjhMWdxsv2w==
X-Received: by 2002:a05:620a:4546:b0:915:9fba:8795 with SMTP id af79cd13be357-930b3ec6bb6mr2023091185a.1.1784677616667;
        Tue, 21 Jul 2026 16:46:56 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a41180sm18815485a.34.2026.07.21.16.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:46:55 -0700 (PDT)
Date: Tue, 21 Jul 2026 23:46:53 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <amAExy1vqMbx31WU@plex>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4>
 <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <al_3nOssZoa6RoCq@google.com>
 <CALzav=dvc_bdmFtV1U2APfs1FM-6Zi5=VShcAYQjZ0wwNRfC-Q@mail.gmail.com>
 <CALzav=fYx7R7c6FTQ5bC4bbQ+_KNaC3gopcPihOtKmHGaB6s1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=fYx7R7c6FTQ5bC4bbQ+_KNaC3gopcPihOtKmHGaB6s1Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_164700_276716_2E0384F4 
X-CRM114-Status: GOOD (  39.43  )
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

On 07-21 16:18, David Matlack wrote:
> On Tue, Jul 21, 2026 at 4:16 PM David Matlack <dmatlack@google.com> wrote:
> >
> > On Tue, Jul 21, 2026 at 4:02 PM Samiullah Khawaja <skhawaja@google.com> wrote:
> > >
> > > On Mon, Jul 20, 2026 at 02:54:51PM -0700, David Matlack wrote:
> > > >On Fri, Jul 17, 2026 at 2:47 PM Pasha Tatashin
> > > ><pasha.tatashin@soleen.com> wrote:
> > > >>
> > > >> On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@google.com> wrote:
> > > >> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > > >> > index 03075ce06ac9..df6a02240aa4 100644
> > > >> > --- a/drivers/pci/liveupdate.c
> > > >> > +++ b/drivers/pci/liveupdate.c
> > > >> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
> > > >> > [ ... skip 76 lines ... ]
> > > >> > +     /*
> > > >> > +      * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
> > > >> > +      * that dev->liveupdate.incoming cannot get freed while the PCI core
> > > >> > +      * has a pointer to it. It's better to leak the incoming FLB than do a
> > > >> > +      * use-after-free if driver does not call pci_liveupdate_finish().
> > > >> > +      */
> > > >>
> > > >> I am confused by this. Each preserved PCI device must have an associated
> > > >> FD preserved with it via LUO. I.e., vfiofd would need to be preserved. If
> > > >> the vfiofd was not reclaimed, and finish is not possible, that vfiofd
> > > >> would still be owned by LUO, and therefore PCI FLB refcount would stay
> > > >> positive.
> > > >>
> > > >> However, if finish is possible, and this is the last vfiofd that is
> > > >> finished, FLB will be freed as soon as the reference count reaches zero,
> > > >> which I would think is the expected behavior.
> > > >>
> > > >> What is the point of holding a reference here, instead of only for the
> > > >> duration of FLB access, i.e. to make sure we are accessing a valid data?
> > > >
> > > >The duration of the access is from here until pci_liveupdate_finish()
> > > >because that it when the pointer (dev->liveupdate.incoming) is
> > > >cleared. So that is why the PCI core holds the reference from here
> > > >until pci_liveupdate_finish().
> > >
> > > I think LUO gives you guarantee that this pointer remains valid until
> > > the FLB finish(), because all the vfiofd that were preserved have not
> > > finished. And when all vfiofd have finished, LUO lets you know that the
> > > pointer is becoming invalid so you can unset these in the finish()
> > > callback from LUO?
> > >
> > > If I understand this correctly, I think by keeping long references until
> > > finish you are replicating the vfiofd bound lifecycle that LUO already
> > > gives you.
> >
> > Yes that's right. I am taking the approach of not trusting drivers
> > (i.e. VFIO) and having the PCI core maintain it's own references so
> > that FLB finish() is guaranteed to never be called while a device has
> > device->liveupdate.incoming set.
> >
> > Alternatively, the PCI core could avoid taking a reference and instead
> > check for driver bugs in FLB finish(). I previously explored that
> > approach and ran into a circular lock dependency between the FLB mutex
> > and pci_liveupdate.rwsem. But I can look into that again, or just do a
> > lockless walk of all PCI devices and panic if any still has
> > dev->liveupdate.incoming set. It will only happen if the driver is
> > completely broken so panicking seems fine.
> 
> Pasha what do you think of this approach?

I like it, let's do lockless sanity checking in flb finish callback, and 
avoid messing with references.

> 
> It avoids the PCI core taking a long reference (your conern) and also
> avoids the PCI core needing to take lots of short references to access
> dev->liveupdate.incoming (my concern). So seems like a good
> compromise.

