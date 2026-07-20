Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E802BC44524
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 23:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mSz2hdMIpgZEgySIqZijvekD49+PJVVZ/pNOTGmHIyg=; b=Ko0N6CE8c6l8bf/c5jmhF/nP5B
	aVD2QReVTd1lncL9Zn/kwIOAhCzRKfhAo0EUavyMyJ01sgTjLaTZ5xLO/XTSvNV7839LBvg8EQ1vM
	CiQXnJiVR5WTPpThuufoDwZO/PArUJXDQMfJeJoJEx/qDL6m/l2RO/FkWpdQJnXnL5rQ2kTKHWiIq
	JVVOow10uyAbMiITMVbybG9VabeP1fVDzJxRVr3PE6AtKUzsN9CLZUjvn6byOGmvbMsfyWLLYWrSM
	Lgln2kCEaiC55P6lWmR+ts++xvmeZrOLNzUx/bN2hslXix1xwUYg688BsPzp/zSG6snuiYVWO/AeJ
	WMBIUbOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlx5u-000000084Q8-2whS;
	Mon, 20 Jul 2026 23:08:18 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlx5s-000000084P0-0ZDH
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 23:08:17 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-38dcbade417so8833010a91.1
        for <kexec@lists.infradead.org>; Mon, 20 Jul 2026 16:08:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784588895; cv=none;
        d=google.com; s=arc-20260327;
        b=Ymk221Kvip+Ij7vMZXBMqkhB4p/aiaBDSmeruLd5skGdqEQ8Z5gD/rso6isV7Ciw+3
         sSpAyqaYeV4tPEOYrYQtWn85dtIeI4e5mqCYT+54yrNbqivs6v77+3lkllTQv5i3Ne0g
         E2mX9wperbpp879dQGmmPWQQTGt4mdFUyn2q/Kh7wr7yuMx3mPcBvCJ4jWgVM6oU5kjx
         QA5lhGaMTitt3RMnxyk+Vh0b1xy+5dWAJVQMq3r7NQeSe9P5P8zaKW1MFCZXDq1XAvKu
         i1WlK60SnEf5L+kUhwEEW/fKGGtCKhrh525l7yszgRm9k/y9YRHGM8Fr5hf+pzpotG65
         s6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mSz2hdMIpgZEgySIqZijvekD49+PJVVZ/pNOTGmHIyg=;
        fh=NmzZBCo2v6h/OOnChjJyHO5DmoEC8vLdB+rxb6oUc0I=;
        b=haUNvxPAKS9U7D7UYBafvOBTIORe3aCQA18B4Cna+sImlosQfM3PoF14RUtCIjMZQ2
         D4n9DhLn4xgbdu2TqC6tJxyz5JxHzliM/PTCH5uq+b1jFHu6SiNK1KqOxZAg8Rax/e5A
         /eTFgYxOB+WptxeOD74CYoPKaTfjDrSeQflu8YROd/coc0lLYosI9AqoYfEW0xhrMXgd
         hWZSV5neOWQHV/N/1JmfsT4mIqHcypiLT6E7V7UosgaqzfyU+e8sn7wHhgn6GsqVkrj0
         1LBbkjjbgXqNvkWcsTHN9OzTFv9ZZ44TAvTq/5Z/cVoQxhBfG/M2HjSlcA3ljUM2U743
         YVYw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784588895; x=1785193695; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mSz2hdMIpgZEgySIqZijvekD49+PJVVZ/pNOTGmHIyg=;
        b=awd6hjjEWxe5tq7cMRZiIRnqd0O8UFOMkdDuuHqa3trcVtka7A8EPl5tXOKlXVbEn2
         JyAIFPhNcCIsYCKV+q3L0YbjneLZaetnyBoswWLqRqdRGu8s9oaUxN4hrFlVZpsj247X
         nCSHNh02kUp4QYg3RgtzZmhauS6EJjqPf2IIrwQQOQOFtHfiQbtW9aENubbEUhv3/mcn
         YrxqdOkDVG8xV/CvviCH3I/K2uhV87PCscVwzgL1IyykTyIPi6CTXDFrU49V1aCRK+h3
         FO2aCcK/r8NF1DiFGqMfrCYQ8HilF15gfhCkQHBUGJw/13T3BR3e7jdfRcKvkdaqaIs2
         QVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784588895; x=1785193695;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSz2hdMIpgZEgySIqZijvekD49+PJVVZ/pNOTGmHIyg=;
        b=EsKl8SOBHhODNuRBIvLla/9dV0zZPS1F+CpKhSAroyGpHa27vyo+GkGcElR5qkFkZ0
         m2LxMG2Jg4AtluM38snTKHHkcErurAYvxJ7o4K3DluB29h63Z8nGtPP5EI/sGY8ckUjJ
         QtqubEncmFJP/5YXuXIpTIa4BbxpMT3y/9Xwmz25lcSTzRV9t14gCQYjUXWN8WSBd///
         4QXomQoqDP4gk877/2DZFjdxTe0l825c12/B8vE1zjZmt/wnTEmgOt6ydwtlfTfrSIeW
         08xe3bb5D198O1lBJTRhuy1Y9lEcWr79bQcqbZLD9HlU3D9ct10Zb2lOvWPfHpH2EtVC
         +ymg==
X-Gm-Message-State: AOJu0YxujCypKWMIMF5ameUvdERLqPdSCf5w8LE+wuNxA+xVoMoY72Fg
	571rgxIRB6+reU1AuIOy62XZlj9iqxf5SaFCQO0tRSCwhUtbx4sEnAECI1137cNRdbdsqMsB53t
	NYwm+XFVnd4+2ci6Kx6WJWT05l/4MDZAh6ryCbAqP
X-Gm-Gg: AR+sD10LcoZ7nkrEpzlzsHDGrIBO9/kZ5BFBLkydKfTtDths/zinJ2PLukHFZsGNVYz
	9w7PTJQfDWpTV3zg/KJ/RVzeqYKcm7AwP1eBXsVSzIUrK56Y9QTlq/+bJzXXOn8+z60W58rExlr
	Lfqf6CTTizH9So8h42HzOC7C3oTnBovALXK1WU2dfYtWGsKIJ8RfU4juGmfekVmAHlQD6wCz8oS
	Vwe6YMIsoVxzJ3ZuCycMRdWlHxkkm69tGEKeI1Ag4l/OA0Z2BjPgum6iG1Xqw==
X-Received: by 2002:a17:90b:2703:b0:37f:9cdf:f0ab with SMTP id
 98e67ed59e1d1-38e4b53898fmr16254011a91.26.1784588894581; Mon, 20 Jul 2026
 16:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4> <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <178458744511.332171.13770778781241262180.b4-reply@b4>
In-Reply-To: <178458744511.332171.13770778781241262180.b4-reply@b4>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Jul 2026 16:07:47 -0700
X-Gm-Features: AUfX_mw2b0MAZqdoOYi7muREPJHZr01uIkETTrQ-nKl4vTsYC1YtP48BRUt3g1Y
Message-ID: <CALzav=fjTOnyg2++GFFe5B17rHqNCWW=afjsD0A=EEjycPW7Sg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260720_160816_184130_D8CF3E1D 
X-CRM114-Status: GOOD (  34.77  )
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

On Mon, Jul 20, 2026 at 3:44=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 2026-07-20 14:54:51-07:00, David Matlack wrote:
> > On Fri, Jul 17, 2026 at 2:47=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> >
> > > On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@google.co=
m> wrote:
> > >
> > > I am confused by this. Each preserved PCI device must have an associa=
ted
> > > FD preserved with it via LUO. I.e., vfiofd would need to be preserved=
. If
> > > the vfiofd was not reclaimed, and finish is not possible, that vfiofd
> > > would still be owned by LUO, and therefore PCI FLB refcount would sta=
y
> > > positive.
> > >
> > > However, if finish is possible, and this is the last vfiofd that is
> > > finished, FLB will be freed as soon as the reference count reaches ze=
ro,
> > > which I would think is the expected behavior.
> > >
> > > What is the point of holding a reference here, instead of only for th=
e
> > > duration of FLB access, i.e. to make sure we are accessing a valid da=
ta?
> >
> > The duration of the access is from here until pci_liveupdate_finish()
> > because that it when the pointer (dev->liveupdate.incoming) is
> > cleared. So that is why the PCI core holds the reference from here
> > until pci_liveupdate_finish().
> >
> > We could avoid this by deleteing dev->liveupdate.incoming and,
> > instead, fetching the incoming FLB and doing the xarray lookup every
> > atime the PCI core needs to access the device's incoming ser struct,
> > but that would be inefficient.
>
> Thanks for the explanation. As I understand, the most straightforward
> way to avoid holding the permanent reference is indeed to delete
> dev->liveupdate.incoming entirely and perform an xarray lookup on every
> access, like this:
>
> bool pci_liveupdate_is_incoming(struct pci_dev *dev)
> {
>         ...
>         incoming =3D pci_liveupdate_flb_get_incoming();
>         ...
>         dev_ser =3D xa_load(&incoming->xa, key);
>         ...
>         pci_liveupdate_flb_put_incoming();
>         return dev_ser && dev_ser->refcount > 0;
> }
>
> However, as you note, this is inefficient because it affects every
> single device and adds lookup overhead to every access (not sure about
> the actual cost though, xarray access is pretty fast!).
>
> We can, however, still avoid tinkering with the lifecycle of the FLB,
> and instead treat dev->liveupdate.incoming as a "hint" that we validate
> on access with a fast, liveness check:

Can you tell me more about your concern about FLB lifetime?

The lifetime of the FLB will not be affected by this reference unless
there is a bug in the driver where it fails to call
pci_liveupdate_finish() during it's file handler finish callback.

>
> 1. At Setup: In pci_liveupdate_setup_device(), we do the xarray lookup
> once, cache the pointer in dev->liveupdate.incoming, and immediately
> call pci_liveupdate_flb_put_incoming(). We do not hold a permanent
> reference.
>
> 2. On Access: When an accessor runs, instead of doing a full xarray
> lookup, it just validates the cached pointer's liveness by temporarily
> securing the FLB:
>
> static struct pci_flb_incoming *pci_liveupdate_get_incoming(struct pci_de=
v *dev)
> {
>         struct pci_flb_incoming *incoming;
>
>         incoming =3D pci_liveupdate_flb_get_incoming();
>         if (!incoming)
>                 return NULL;
>
>         if (dev->liveupdate.incoming)
>                 return incoming;
>
>         pci_liveupdate_flb_put_incoming();
>         return NULL;
> }
>
> * If get_incoming() returns NULL (the FLB has already finished/freed),
>   the hint is invalid and the device is no longer incoming.

This avoids the xarray lookup but still requires taking the incoming
FLB mutex twice (once for get and once for put) on every access. And
if there's no incoming PCI FLB, the LUO will iterate over all incoming
FLBs under the mutex to find it.

>
> * If it returns a valid pointer, the FLB is guaranteed to be alive, so
>   we can immediately use the cached dev->liveupdate.incoming pointer
>   without xarray lookups. The accessor then puts the transient
>   reference when done.
>
> 3. In Finish/Cleanup: We can simply clear dev->liveupdate.incoming,
> and decrement ser->nr_devices.
>

