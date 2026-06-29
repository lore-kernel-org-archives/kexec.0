Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6346DC43602
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VpmUvFbjkT4TIDiuBxTmd8SHESx8y5cMZtvBxkjxfFU=; b=yufT5jUwtNSfcvm1F608617n68
	/qVVQ7rOoJYeDJP9xSMEmPuwlM2KA8mwX1THnCnxgLfQazSplFBF141UnRzq2VHHhQ6jY/djtDq6S
	XXH/KliY69sXoCXrVAJ2c/dbxe60Al6rj8gvaSNs5SgBJCqpBG8/CKJQcp53mIL7hGm7ZL6kivVur
	FSCp2G7pquZVR2wHvSnh0VXtWXTEuSnUdw3HicXY+WDWq/CNzQ1xzPnxr0ABkDoLXYQ7l4pu3M1NP
	L0l0Rc4bLEB++dQVoBvm57c546kCWE/RLjhsw90r5zOe+EV89QKs2wz9PgqKdhrEl3Q7JrqZ7MAeK
	qiviaH7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weH2t-0000000FMob-2aU0;
	Mon, 29 Jun 2026 18:49:27 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weH2r-0000000FMoF-1M4R
	for kexec@lists.infradead.org;
	Mon, 29 Jun 2026 18:49:26 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-139a5f4ca15so4427272c88.1
        for <kexec@lists.infradead.org>; Mon, 29 Jun 2026 11:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782758963; cv=none;
        d=google.com; s=arc-20260327;
        b=JEia7Utigv1JAF0ZfcGYM3uARFnPEQZBXFzToGBFI397cUc1bqmPDf70Du3k3X7n+h
         diLYjx5WVwzLI6xwt+WTA29K15KvC/xzWy1ye3+WTZLS+sJaoPidRBRJuk+KT5Rf3T5T
         8es2guy87EM6DhV8gObocOZAmqQQVnkGTnfdQo7YCFgXMSsp81aQN5w2Pys2XLUZW/tE
         hGwWm5/vGY/kMRg3rZ2MUItSz+A77Zu7FKySDReyxsLeAcdYm626Vjjxw3qqvm9q/Eqf
         32z62Jy74LBjLAPkHwq9EpPm4h4neLIOslECGNwUfUhJNK/5JiOh29qGZ2QC/M3h8n+w
         i9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VpmUvFbjkT4TIDiuBxTmd8SHESx8y5cMZtvBxkjxfFU=;
        fh=759/ZOvVq4Aay+v3dRCjwH0CpDtFRx4BcFdX8gtUU2Q=;
        b=M6PlNDiYRtgdAUVi2kPO4TDkrrrMpLeYNwjO8ol7JHC3kR3kbMxmjj3y8sXPFkv8pu
         6A/G6SJscpADXluofCPHAdVMiPmarNhztZculA4BFNQ0OyAQ+4fXEw5F+wgT4lqohR7P
         hJ5NFupsD9xntybNv6sNIpS5I1dyl6NIqKPPrfAKnYWBxPo682j0eNoRxnDXAbqApX+4
         IXw/c7MnLGKoC9HlWMs5Vim0t+ZiLIS/zU4+SoBTg31oxZwh4wW3Ra9MM1OWQEdif0pv
         0oeAMQeIcbyp0uTsoAVd+as32tSFBmraJ9s+TAeHYSzlI/GrT7D6fgMBNmR0CaYt0aZc
         bp9g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782758963; x=1783363763; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpmUvFbjkT4TIDiuBxTmd8SHESx8y5cMZtvBxkjxfFU=;
        b=MkD2cmp1s9KjiMI9CkgvDtoZHSYh5yNNOtSMhjDFvNgkhGJK7neWODjKuwmVBbXuq8
         5kkEIkCPRJ529fPOi731kTeRyFPHFqnwHTpJ68FeVvf22kybMejk9+8S1ZMKFp4eii5D
         dfoTnEM1V2fuHjV1kRtU4LtzKZvIvBqSeOtgDzddeJq6+zQFMO2iinUm31l0rnjG60de
         1py76JL+xmfSyhM6AW0toL+rPiQ4tr/5lqephN+4OGoYla8IP0KQlHaPkMVFLnrJ8bNU
         VHS4aIZtXJ9bn3jEpzVZHw4zDNaZaLZtZ3FncIgDv2XeBv589uvAt0XeTfVXJXMlvhiw
         Vplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782758963; x=1783363763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VpmUvFbjkT4TIDiuBxTmd8SHESx8y5cMZtvBxkjxfFU=;
        b=reDnNuOodtgal+Qe0GUsjfrxs0SwSDgO/V7sHnIOx6HWloYjxkNBiwvZ7jqqR9dRRc
         KIpv/pAWltvWWXMGH+F9u9Jv3I/U8uo4sq13E5UYS88elBnOSYeQ5Y9DC8idWVaMuHQY
         oUMpJX2X5jD4Ib0Sc+SGbWZDLhAeSNZ8QuwJYXDid7heHyIM2q+8PHLRlAvKXfmm+89Z
         1P1vcOYjFzdrYRjcA1mETNQJkHp0RDbH1rKqpK7UEXGbdCoNycTGIli9YJMGLNam0aoo
         MXDV6LUbnI7lKJx3Zti84H/urpFISxjhTHLH16HxY3orU3gc7+U4rKM3ixDjP/RkMveg
         Y9JQ==
X-Forwarded-Encrypted: i=1; AFNElJ+97+wiFDSLwK7DoHFPWmAteshVLezzgZRy9Tc5Mg/L3PR/iT2zJPUzRRFj9uVc1W/SjxmabA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzGH/m0qkVPW36eVkaxl6bDQKEb/IWvX9WhykzNi3J2Xw2yt5Ob
	iA9G5SDphGPZrwgLy1FtKQZGwqsbneUcsp6w94+fMJz8hTY7eSW3EHdFQ98r7XwiVZDvWvAyM/o
	Uy5DXYVz3/LJ5cKRZB/L29+aAm+/aMvtaC5pppzVr
X-Gm-Gg: AfdE7ckXHZzQF99lhSvRcDOW9lQ8N5dWabXDMup7azLVoAKVEQ0n4ks4r5J9A2a6KMM
	OZKtFSrHork0mWYSf4lwc/a2r1O0aKJORvSgjaDjYmFApCqDJ0yQ+xgsLW/kZkLwYfB0awjB+z+
	6wK3eRRzJu0XcLzgjXZYGzhtTtwnQWB3Jd5lyt+z/4C9qacil3DxG/eTpzjpHuG7TIEtKEcOpZU
	5zwys55Q1ihzmNWUSVgR/RHBq+RZfhdETxOyuFFmITaGABqakLCqawAh3Gx72B2OEbsDzRCuGhO
	MgKxQsg=
X-Received: by 2002:a05:7022:6620:b0:136:c443:80e5 with SMTP id
 a92af1059eb24-13b2a13e510mr391503c88.6.1782758962590; Mon, 29 Jun 2026
 11:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com> <20260522202410.3104264-4-dmatlack@google.com>
 <178144432039.1257322.9644414453415904478.b4-review@b4> <ajBgj_aSuzMZG47e@google.com>
 <2vxzechulmcp.fsf@kernel.org>
In-Reply-To: <2vxzechulmcp.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Mon, 29 Jun 2026 11:48:55 -0700
X-Gm-Features: AVVi8CddGN9A_Ob4R4wlMhPsXSn8oI36PZ00eW8upPHQmIA_C2z2tuBHbPtHPrY
Message-ID: <CALzav=fN8m9+rso7RSLR35bozZpNKv6McOR3jv1-ngxApM1BCg@mail.gmail.com>
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_114925_372752_0D2CB663 
X-CRM114-Status: GOOD (  56.38  )
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

On Thu, Jun 25, 2026 at 7:35=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Hi David,
>
> On Mon, Jun 15 2026, David Matlack wrote:
>
> > On 2026-06-14 01:38 PM, Pasha Tatashin wrote:
> >> On Fri, 22 May 2026 20:24:01 +0000, David Matlack <dmatlack@google.com=
> wrote:
> [...]
> >> > +  }
> >> > +
> >> > +  pci_info(dev, "Device was preserved by previous kernel across Liv=
e Update\n");
> >> > +  dev->liveupdate.incoming =3D dev_ser;
> >> > +
> >> > +  /*
> >> > +   * Hold the ref on the incoming FLB until pci_liveupdate_finish()=
 so
> >> > +   * that dev->liveupdate.incoming does not get freed while it is i=
n use.
> >> > +   */
> >>
> >> How would that work? If finish is not called FLB stays around until th=
e
> >> next reboot.
> >
> > True... I think if the PCI core trusts drivers to call
> > pci_liveupdate_finish() then we don't need to hold onto the incoming
> > reference here.
>
> That was my point when I was arguing against refcounts on outgoing FLBs.
> This is very easy to abuse, especially when we are talking about device
> drivers. And this refcounting mechanism makes the FLB no longer
> file-lifecycle-bound, since now it is entirely up to drivers to decide
> the lifecycle of this data.

The PCI core holds a reference to the incoming FLB for as long as it
maintains a pointer to that FLB in struct pci_dev
(dev->liveupdate.incoming). The lifetime of that pointer is aligned
with the lifetime of the file as long as the driver calls
pci_liveupdate_finish() in its file finish() callback.

If there is a bug in the driver that causes it to not call
pci_liveupdate_finish() then the FLB will leak past the file yes. But
the alternative would be to leak a pointer to freed memory in
dev->liveupdate.incoming, which could lead to UAF.

Leaking the FLB seems safer than UAF, which is why I went for the
refcounting approach.

Another approach entirely would be to drop the
dev->liveupdate.incoming and do the xarray lookup everytime instead.

>
> I have been thinking about this a bit more in the last couple days, and
> I wonder if we are doing this right. Here's an idea I have been thinking
> of.
>
> We should make live update a first class citizen in PCI. Instead of
> patching in liveupdate via the liveupdate.incoming field, and letting
> drivers figure out when to use it, we should separate out probe and
> retrieve paths entirely.
>
> Probe and retrieve are fundamentally different operations. While they
> may share some common initialization logic for the _software_ state, how
> they interface with the hardware is completely different. I think mixing
> the two will result in driver code being more spaghetti by having
> liveupdate checks sprayed out all over.

We are only planning on supporting Live Update for VFIO drivers for
the forseeable future. The VFIO work during probe is almost entirely
software state setup. The only hardware logic we need to "if" out in
the vfio-pci driver's probe() is putting the device into a low-power
mode via the runtime power manager. So I don't think we will get any
benefit from this approach, and it would be a lot more intrusive to
both the PCI core driver framework, and VFIO itself, to support this.

> This series doesn't add support for any drivers, but looking at some of
> the code we have downstream, I see this problem. The liveupdate code is
> all over the place in the driver and it is very hard to wrap one's head
> around how the device is actually retrieved.

You can find the vfio-pci driver changes here:

  https://lore.kernel.org/kvm/20260511234802.2280368-1-vipinsh@google.com/

Let's keep the discussion focused on upstream VFIO drivers since that
is all we are planning to support right now due to LUO's requirement
of file-based preservation. The downstream driver changes we are
carrying is not reflective of what we want to support upstream.

> So I think PCI core should track preserved devices, and if the device is
> preserved, it should skip the probe and wait for retrieve. Retrieve does
> the full initialization of the device. This fits in with the LUO model
> as well. You can make retrieve a callback of struct pci_driver and do
> some wrappers to talk with LUO, so device drivers don't directly
> interface with LUO at all.
>
> We should do similar things on the shutdown path. Shutdown is a
> fundamentally different operation from freeze, and so we should separate
> them out as well.

This is speculative. In practice, we haven't needed to change VFIO's
shutdown() or probe() functions so far. The only change I anticipate
needing is skipping runtime power management "put" during probe() I
mentioned above.

If we actually made retrieve() a first-class callback and used that
instead of probe(), VFIO would internally just call its probe()
function because that would be the cleanest way to set up all the
software state it needs to manage the device.

> This solves the lifetime problem as well. When PCI core is initializing,
> it knows for sure that no retrievals are going to happen. That's because
> none of the drivers have registered yet. So it can safely access the FLB
> and initialize its state. After that, drivers can register themselves
> and start accepting retrieve() calls. Once the last driver goes away,
> the FLB is freed automatically.

It's not so simple. The PCI core does not really initialize itself.
Scanning devices gets triggered externally, e.g. by ACPI, device
trees, runtime hotplug events, etc., and that is when the PCI core
gets notified about a device. None of this is synchronized with "when
drivers have registered", which I assume you are referring to
registering with LUO.

>
> I am sorry for suggesting a big refactor at v6, but the early versions
> looked good to me at the time, and I only thought more deeply about this
> when trying to figure out how we can make the lifetimes cleaner.
>
> What do you think? Does this make sense?
>
> --
> Regards,
> Pratyush Yadav

