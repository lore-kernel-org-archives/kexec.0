Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA548C4453C
	for <kexec@archiver.kernel.org>; Wed, 22 Jul 2026 17:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b6BLtSCxCp7M8WEIqu/WUMj2zfCCYaejhLZ7J9DExtM=; b=vEu1YZv5gtjhBINicAS+Lme6qy
	lriSXvHLKeA+C40l3RuUvyTikBClds1gcpj9FKHWvgXHFuwJ6sozlssMzZ4SVSk0r9lRVF6DvVK5+
	HWSPwN97MrSlx3q3amxkHAfksgVnktQ3xqPUrORiC08hVZzf6yfjxBuOKOOS1OfJ56FND73g/f1Qu
	2WSuXd8/9UEMiwvAnF/gJ07ZFBBV/+/rlD6tXpThvtAaFxnTNfNSRgSP4YmV3pIMWj+8D6JifwNJy
	CKDOENl7izTr3xCZNm16T0ARlfzaRw9STDc+TteLwAEBsaeklx5L3zSMRRivRSnhhDMm58IZ+FrG7
	W2nHuJLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmaJF-0000000CPJr-2lzX;
	Wed, 22 Jul 2026 17:00:41 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmaJC-0000000CPHn-3Shw
	for kexec@lists.infradead.org;
	Wed, 22 Jul 2026 17:00:40 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so7469440a91.0
        for <kexec@lists.infradead.org>; Wed, 22 Jul 2026 10:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784739638; cv=none;
        d=google.com; s=arc-20260327;
        b=MygflHybBWWasS8RbKDE0p7hSeXvuezlWEb/qkBB7hvWzt/VA8vBoO/DLkq5T8IHgS
         8udw56Bx0WpRqjDNWsmb2oWwIgHMhecrRfRNNXq+se2NV47O4ROg+IdcWrp27e77yLKD
         dkQWlYJ/ru/s8bpMVG3qv5BAE33roxPbeZnLxnWfjOyU0Lr7opQv3FhvojP1dIc01hl8
         2Zg+lKLAwQaEOGFmensyhdaNnqkdibI6MBa2JphH8TLtZyX2BOaik1BG5mY9EQTjKQJ3
         dQ3O+qsOS/v0RV0yRMf531DkQKNcpq0YdUweWhyFwTa1OHvmXLyuNaw18WcB5QxWpkct
         N5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b6BLtSCxCp7M8WEIqu/WUMj2zfCCYaejhLZ7J9DExtM=;
        fh=QvYiZNwjaBIdHeiDlgNcBm81YfG/r1Q7AKJdIeWPPJU=;
        b=lnfyHncQfca8WBk9IDYndFhcQVFo9mKfJTQIoT9qonYfNj+0Y3d+t9jCu1ymFb/FN8
         yMKOegAPK/P1ApiWveuZbDSPRn3Sf7qdsMaBQ8ZO3RfrZz+0cZyufanY4lz0gAnXsCL5
         Q1qLA9eLChZCD09fFCqyUpx72/vDxHUV6VEO5PvP6mnVQ0rXIZf1rx/nSZeQPZFqm97M
         kCJSvbFgNQ5fxHKurUPO1eOVgNmqtH1jY3ofdW4T89bV5CSfLJHxttA6isjE4HDsf+fV
         14Qj9qhTW+fSNWWIEz35ZHRASvcdrBxf7/4/NsOoD4tuUu8zxP1A5Cs2gjug8JztwunV
         MX+Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784739638; x=1785344438; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b6BLtSCxCp7M8WEIqu/WUMj2zfCCYaejhLZ7J9DExtM=;
        b=qF9Vt6gpS0KFZPpr2Ob0Dqfs81GlegWbUTLAS07LnktYhW4yJPHSAjKNbGwKr+f7/s
         yv35ueaqltmACwq53pfuAPXMfuUe0uJN8/B8VhJcuyGmsnN65D4nxCvgOd6U+rkaRLCk
         tPwP5z/vFFW+uKZBq0ODwijMgcoey/gwtkAdnVIAIqHrhyqMmJ/ItDzh8Oa2KciaIQQ3
         wpeQ9E4brsZ4hCOzztW6fjvlsvT7o4Y9bVZmn89T1eoPAK4BHxqxU8tqHboHbERBtdOh
         hkZwFzaDCD9RQAKtszzfFl2V+D+W+nvo+/qpl8O7CF4Z6A1bZ6fX6YJRk8z1QiCoF3vT
         moeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784739638; x=1785344438;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6BLtSCxCp7M8WEIqu/WUMj2zfCCYaejhLZ7J9DExtM=;
        b=VNSaCia/STVruHmikjqy9FKc4u3ZdVFNRf0gL1mJTGRV+qkIHKDycKCf9L0Pi9iDsr
         ikOyifT74/CQGVlf3PAQQdLWes2NwnQFOz8v9zgZyku4Ju4MLiaiyz+l9sNAVKacfIKd
         wAJdxdVmHQqVCjjypXv7kYhXC/gRZoSSIqMVTtYdTwN7Q86bbMn6AMj+Skl8/UKn1fmp
         gV5vNLv8+/kh6YL+op1qInwxeKkfz5rAC7r1CYdCM8cyXZTZu5utNs/PamJ1f4l7sK3F
         TTVnZWqiVPksiNInmIMHEXOVUEATtuCOPmJbegOfsEnks7JiqhCKprbJ3sUKTqY1ocCc
         rKIA==
X-Forwarded-Encrypted: i=1; AHgh+RoIx1TMUDRuMtmPZp34OVgAgO206uDoWPhyU0FhRvQU1kJFUkBz0z4CDsuPRFPKzJNsUxycfw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzWrWCC2BFXLaYB0HmNGuwXqXMvnzeMcb8sOHpihedKBOsVh00d
	lOkcI5ZOvwlSZnp18xb3dz8CvAOUC7aWtAvyKTIt8dBOXbjHpJWhL1PXEcpFhGVCoryIZuLnv1N
	g2ae2GvtjoWw3SRToUzllyPQpzzm1YzpXgQsUwLzd
X-Gm-Gg: AR+sD13t1w+VITLs+pN7/1qdsaFHYeaYRc55eXntPBOzi7GLyH0m1Tt9y/FCF5IghY+
	B264N9Yz5YTpPgihtmZGZpH17zzNxkyKLrFerR/6gCES80WoJ4ZGBIYiWsQF151Cs6sASCVZflX
	YSipAeRmycJUfuMWNOqGBG5CW2sRN9QWk2UlIrF4OAD+4Vs5xr4F8l7gU+qAw/WiCHmRXBdhSe0
	23rWws0G71KUC9TBU8j/dXEwlZRbrsQ7oOv/ur+XeaOm72BzITU3DWTztmqH1AkcJ/vJFUVRisV
	ZAo7hiPDZNSpflY=
X-Received: by 2002:a17:90b:1f88:b0:38d:f1a4:1116 with SMTP id
 98e67ed59e1d1-38e4b537bedmr20414674a91.33.1784739634476; Wed, 22 Jul 2026
 10:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4> <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <al_3nOssZoa6RoCq@google.com> <CALzav=dvc_bdmFtV1U2APfs1FM-6Zi5=VShcAYQjZ0wwNRfC-Q@mail.gmail.com>
 <CALzav=fYx7R7c6FTQ5bC4bbQ+_KNaC3gopcPihOtKmHGaB6s1Q@mail.gmail.com> <amAExy1vqMbx31WU@plex>
In-Reply-To: <amAExy1vqMbx31WU@plex>
From: David Matlack <dmatlack@google.com>
Date: Wed, 22 Jul 2026 10:00:07 -0700
X-Gm-Features: AUfX_mw9U43t-da8vfCp9-yZYFJuwnLedP2gk2wgS7EP9CWA2swr-hVEqcna6rY
Message-ID: <CALzav=dHJ6g9FZmoWC5hFRCwCtf=BTHOmEFqbFFaDZiYDbRBvw@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_100038_890808_14B3B480 
X-CRM114-Status: GOOD (  39.38  )
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

On Tue, Jul 21, 2026 at 4:46=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 07-21 16:18, David Matlack wrote:
> > On Tue, Jul 21, 2026 at 4:16=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On Tue, Jul 21, 2026 at 4:02=E2=80=AFPM Samiullah Khawaja <skhawaja@g=
oogle.com> wrote:
> > > >
> > > > On Mon, Jul 20, 2026 at 02:54:51PM -0700, David Matlack wrote:
> > > > >On Fri, Jul 17, 2026 at 2:47=E2=80=AFPM Pasha Tatashin
> > > > ><pasha.tatashin@soleen.com> wrote:
> > > > >>
> > > > >> On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@goog=
le.com> wrote:
> > > > >> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate=
.c
> > > > >> > index 03075ce06ac9..df6a02240aa4 100644
> > > > >> > --- a/drivers/pci/liveupdate.c
> > > > >> > +++ b/drivers/pci/liveupdate.c
> > > > >> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci=
_dev *dev)
> > > > >> > [ ... skip 76 lines ... ]
> > > > >> > +     /*
> > > > >> > +      * Hold the ref on the incoming FLB until pci_liveupdate=
_finish() so
> > > > >> > +      * that dev->liveupdate.incoming cannot get freed while =
the PCI core
> > > > >> > +      * has a pointer to it. It's better to leak the incoming=
 FLB than do a
> > > > >> > +      * use-after-free if driver does not call pci_liveupdate=
_finish().
> > > > >> > +      */
> > > > >>
> > > > >> I am confused by this. Each preserved PCI device must have an as=
sociated
> > > > >> FD preserved with it via LUO. I.e., vfiofd would need to be pres=
erved. If
> > > > >> the vfiofd was not reclaimed, and finish is not possible, that v=
fiofd
> > > > >> would still be owned by LUO, and therefore PCI FLB refcount woul=
d stay
> > > > >> positive.
> > > > >>
> > > > >> However, if finish is possible, and this is the last vfiofd that=
 is
> > > > >> finished, FLB will be freed as soon as the reference count reach=
es zero,
> > > > >> which I would think is the expected behavior.
> > > > >>
> > > > >> What is the point of holding a reference here, instead of only f=
or the
> > > > >> duration of FLB access, i.e. to make sure we are accessing a val=
id data?
> > > > >
> > > > >The duration of the access is from here until pci_liveupdate_finis=
h()
> > > > >because that it when the pointer (dev->liveupdate.incoming) is
> > > > >cleared. So that is why the PCI core holds the reference from here
> > > > >until pci_liveupdate_finish().
> > > >
> > > > I think LUO gives you guarantee that this pointer remains valid unt=
il
> > > > the FLB finish(), because all the vfiofd that were preserved have n=
ot
> > > > finished. And when all vfiofd have finished, LUO lets you know that=
 the
> > > > pointer is becoming invalid so you can unset these in the finish()
> > > > callback from LUO?
> > > >
> > > > If I understand this correctly, I think by keeping long references =
until
> > > > finish you are replicating the vfiofd bound lifecycle that LUO alre=
ady
> > > > gives you.
> > >
> > > Yes that's right. I am taking the approach of not trusting drivers
> > > (i.e. VFIO) and having the PCI core maintain it's own references so
> > > that FLB finish() is guaranteed to never be called while a device has
> > > device->liveupdate.incoming set.
> > >
> > > Alternatively, the PCI core could avoid taking a reference and instea=
d
> > > check for driver bugs in FLB finish(). I previously explored that
> > > approach and ran into a circular lock dependency between the FLB mute=
x
> > > and pci_liveupdate.rwsem. But I can look into that again, or just do =
a
> > > lockless walk of all PCI devices and panic if any still has
> > > dev->liveupdate.incoming set. It will only happen if the driver is
> > > completely broken so panicking seems fine.
> >
> > Pasha what do you think of this approach?
>
> I like it, let's do lockless sanity checking in flb finish callback, and
> avoid messing with references.

Great! I'll take this approach in v8.

> >
> > It avoids the PCI core taking a long reference (your conern) and also
> > avoids the PCI core needing to take lots of short references to access
> > dev->liveupdate.incoming (my concern). So seems like a good
> > compromise.

