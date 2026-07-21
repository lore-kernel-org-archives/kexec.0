Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64094C4452B
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 20:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vbz1iYT6k9l+H6Z3FTtCF6cLZIfTcAcJKlDT5dYK2AI=; b=eYG/bpW+s9tmfmh7iuQPe08cfM
	DyHiH6YK+3prWjbrtjWwXuBQn77hu960YUqIls9vDIJ9yG9yg2CFS3grnyjg6ickWUGeeNnrbff3O
	vC6bDHf0vDoMYHNlAKBpDoMbWHIVZHHXLUZ3tPfgFB40pxehku3AQZC1NrPijYBLzbRwcHuDNo8gg
	ynch6EL2iGb6b17rsh3GOhwqU+X0pCHDHiFr5lYmus26+s+zDASa37I/10jvj+n7CqbSdAwaKUwgv
	8FFTeS//yh6WXIuip2xNUdqUzuo8bBENlaormXIAwDkpyz0KPBYgZLkAwW0VlJtXaqvbmYeJ+jggO
	x9PqJvGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmH1r-0000000ANHm-19HS;
	Tue, 21 Jul 2026 20:25:27 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmH1o-0000000ANHM-3NW0
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 20:25:26 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2caf228a910so93423695ad.2
        for <kexec@lists.infradead.org>; Tue, 21 Jul 2026 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784665523; x=1785270323; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vbz1iYT6k9l+H6Z3FTtCF6cLZIfTcAcJKlDT5dYK2AI=;
        b=A0R5UhfbMg6827JHJZj1w0D+E8Plf5CFLaEQGkPaJcvVr9MyFXEV60+gxxNHuIuEQD
         dFhboQyU7BE8r9rbJJlHvprlYCyCSlKWQEmGiFCiYvFpxoO7Be/DHRBJDDHk1Erf7wvF
         ACWQHQ7z1+VNg6d47clMobB9X5r5THfmsHMRqD7j9TXkeVlBsmBu7w2UWln851xu6o+u
         JMdmlGEb2LMJMy8cEq5jCPCksHA73dyUlP8OyNt2yFU4aFbuaOYUhC7mBA7JdGWLqd7S
         6esgr0C7chpROEL7zJJ3q9RozbsCQc7t+m4wyQjCy6Jh/hhU0BzbkDRQpWrXIbP6vD95
         pqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784665523; x=1785270323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vbz1iYT6k9l+H6Z3FTtCF6cLZIfTcAcJKlDT5dYK2AI=;
        b=QI0Wm0nm7i4AIk7G81SbboMqB0qMLbvOH4NfB6KTr+33Pd3CxlPP5XPL+/Dt9QMNum
         Odrh+pHCramE1KWOEC3jR/ku7Jqiy2/Og6iPKFh5RT/1cMqDMxunf37atERt2H/9m3Bi
         YRb2uSofgSvFq1oUt4Hz/AGDHhds9FYMPryH80mIfHQjg61xJAK0OUX5YpphnSN7G//a
         j3Fc6UOIdcx10vlsIOoMgrB9XbLeGB0A4B6NJ+o2etqT9mlKpWnqwY2N7mrA8W5CtyAU
         mrpHWyposEcelmYKvgPoFvvZyui5OEafT1ev8JfxBNwGFZ96kcmVtfeaFMPH2kuYZ8Jz
         8i4A==
X-Gm-Message-State: AOJu0Ywe+63RYsh3kakml7Po2P6WxubZV02zIlvqH/oz9hWu4F9rwOj4
	BpLksjseOGez3EiTeSKw+ieVJDzYEcOCzO2/oll71Y28uSXbTiETMhju3JehwXPI0Q==
X-Gm-Gg: AR+sD134KSi22LbaZFWmm5hVkTbAWF8aVz3F82JB18cHeQCVRXGC2mJWuoq1E/F1Bhm
	djQ7wvqdCKQ8w0Jf37/xmCxxaL3LAUSU9XFs7VnBaSY6Obk+DHExWCGZJaOcRmd7Ml1pyTo94/I
	WZmbf7E/0qtacQdK9bg42o3dRpqVlG0Sx5XjXe+WLiGjzciSPat1vtKdZCPLz/Y9ueivqbMG7II
	u0QklPdBa97jJ/5HhCA8cluYaPNf3L0uwncb/7ND28pIU7RTZWyhMbZBZ1OKPXIYgddNZRFcf2r
	nqwe4DeulyFYK537zF/hQP7whMrJCw5TCqae4ZhJssXQTjcmzawyKHQ5WpqT86o3usapEmmyxcK
	iehaRKc6sHrEVQ2jQu8Lg5S3IJY2TgYxtiYWK2Ve2Ew8R0r5CNdSZXtVQ46KqiNH5oBg/pFhVaV
	bIM8tr980ghmJK7iq/FbgaB/k6nEZjtx8x86bUUKZ5
X-Received: by 2002:a17:903:b08:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2cf34835859mr235453285ad.8.1784665522497;
        Tue, 21 Jul 2026 13:25:22 -0700 (PDT)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f3b7c9dsm2391865ad.83.2026.07.21.13.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:25:21 -0700 (PDT)
Date: Tue, 21 Jul 2026 20:25:18 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <al_VrpvPE-RLCF5X@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4>
 <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <178458744511.332171.13770778781241262180.b4-reply@b4>
 <CALzav=fjTOnyg2++GFFe5B17rHqNCWW=afjsD0A=EEjycPW7Sg@mail.gmail.com>
 <178465652971.412167.17838319728990505256.b4-reply@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178465652971.412167.17838319728990505256.b4-reply@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_132524_852313_578B70BE 
X-CRM114-Status: GOOD (  38.32  )
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

On 2026-07-21 05:55 PM, Pasha Tatashin wrote:
> On 2026-07-20 16:07:47-07:00, David Matlack wrote:
> > On Mon, Jul 20, 2026 at 3:44 PM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > 
> > > On 2026-07-20 14:54:51-07:00, David Matlack wrote:
> > >
> > > Thanks for the explanation. As I understand, the most straightforward
> > > way to avoid holding the permanent reference is indeed to delete
> > > dev->liveupdate.incoming entirely and perform an xarray lookup on every
> > > access, like this:
> > >
> > > bool pci_liveupdate_is_incoming(struct pci_dev *dev)
> > > {
> > >         ...
> > >         incoming = pci_liveupdate_flb_get_incoming();
> > >         ...
> > >         dev_ser = xa_load(&incoming->xa, key);
> > >         ...
> > >         pci_liveupdate_flb_put_incoming();
> > >         return dev_ser && dev_ser->refcount > 0;
> > > }
> > >
> > > However, as you note, this is inefficient because it affects every
> > > single device and adds lookup overhead to every access (not sure about
> > > the actual cost though, xarray access is pretty fast!).
> > >
> > > We can, however, still avoid tinkering with the lifecycle of the FLB,
> > > and instead treat dev->liveupdate.incoming as a "hint" that we validate
> > > on access with a fast, liveness check:
> > 
> > Can you tell me more about your concern about FLB lifetime?
> > 
> > The lifetime of the FLB will not be affected by this reference unless
> > there is a bug in the driver where it fails to call
> > pci_liveupdate_finish() during it's file handler finish callback.
> 
> From a design perspective, liveupdate_flb_get/put_incoming() is a 
> logical read-lock/unlock pair on the FLB data. We use a refcount for 
> optimization and sharing, but holding a get over a long asynchronous gap 
> (from boot-time device setup to driver probe) is essentially holding an 
> unbound lock.
> 
> Unbound locks make it difficult to trace refcount leaks or debug 
> lifecycle issues.

It's very standard for refcounts to be held for a long time, e.g. file
refcounts and device refcounts. LUO FLBs themselves already have
long-lived refcounts taken by each file that depends on themm, which
aren't released until that file handler's finish callback runs. The PCI
core is just doing the same thing.

> 
> > 
> > > 1. At Setup: In pci_liveupdate_setup_device(), we do the xarray lookup
> > > once, cache the pointer in dev->liveupdate.incoming, and immediately
> > > call pci_liveupdate_flb_put_incoming(). We do not hold a permanent
> > > reference.
> > >
> > > 2. On Access: When an accessor runs, instead of doing a full xarray
> > > lookup, it just validates the cached pointer's liveness by temporarily
> > > securing the FLB:
> > >
> > > static struct pci_flb_incoming *pci_liveupdate_get_incoming(struct pci_dev *dev)
> > > {
> > >         struct pci_flb_incoming *incoming;
> > >
> > >         incoming = pci_liveupdate_flb_get_incoming();
> > >         if (!incoming)
> > >                 return NULL;
> > >
> > >         if (dev->liveupdate.incoming)
> > >                 return incoming;
> > >
> > >         pci_liveupdate_flb_put_incoming();
> > >         return NULL;
> > > }
> > >
> > > * If get_incoming() returns NULL (the FLB has already finished/freed),
> > >   the hint is invalid and the device is no longer incoming.
> > 
> > This avoids the xarray lookup but still requires taking the incoming
> > FLB mutex twice (once for get and once for put) on every access. And
> > if there's no incoming PCI FLB, the LUO will iterate over all incoming
> > FLBs under the mutex to find it.
> 
> Can we do a fast-path check first?
> 
> static struct pci_flb_incoming *pci_liveupdate_get_incoming(struct pci_dev *dev)
> {
> 	struct pci_flb_incoming *incoming;
> 
> 	/* Fast-path to avoid unnecessary FLB querying */
> 	if (!dev->liveupdate.incoming)
> 		return NULL;
> 
> 	incoming = pci_liveupdate_flb_get_incoming();
> 	if (!incoming)
> 		return NULL;
> 
> 	/* Check again, now that FLB is acquired */
> 	if (dev->liveupdate.incoming)
> 		return incoming;
> 
> 	pci_liveupdate_flb_put_incoming();
> 	return NULL;
> }
> 
> This seems to gives us the best of both worlds: robust refcount hygiene 
> and a sane fast path.
> 
> What do you think?

It still seems like an overall worse approach to me.

 * From a performance perspective, the PCI core would still have to
   acquire the FLB mutex twice every time it needs to use the device's
   serialized state (once to acquire a new reference and once to release
   it).

 * From a locking perspective, the refcount doesn't actually protect
   against the device itself going through finish. So we still need the
   pci_liveupdate.rwsem.

 * From a hygiene perspective, each reference is held for less time yes,
   but there will more places in the code that need to acquire and
   release a refcount.  That is more room for bugs to leak a refcount.
   So I'm not sure taking more small refcounts is an improvement.

With the current approach there is just one refcount with a very clear
lifetime (that aligns with the device file's refcount) and no extra LUO
mutexes required to use the device's serialized state during device
enumeration & setup.

