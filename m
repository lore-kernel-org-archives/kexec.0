Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C42104891D
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QNS9W6SZfyDIUc8hBvcmHVCCa8aXdEVnnS9qGJqvemc=; b=Scn81nvtAlQOnstzpdjEmYf7i/
	/wjW945PJDlDMho6we8Zjnq4fDGcWga6/8UL2YHhmUp0bAqRrv4aMn2imdh2uUkVLzSKqbD/1EI/P
	4WVeArkwo5UQp0qXuPUR9xQP5dPl0GsFfLI807lGatnaspXWuZLdehrFNjYg+z8f0840Ob0mgCgae
	LrUZ8+Q+l1hZj49/TMWQC2nZZN3sGgIgHzKvvPTn5vHL6gxmbcOAIVrYWDf75xfD5aTY0rX6kGo7+
	p2zMuohtGqirX8eAwyybz+j2PoFolCpEGRxU4BaIKAeGvHjHqfrA5WUqGhasdpj9HPsxYtW99hDp2
	WxOTe8EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6Rf-00000009EFr-1N7S;
	Fri, 27 Feb 2026 22:36:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6Rb-00000009EEr-0itm
	for kexec@bombadil.infradead.org;
	Fri, 27 Feb 2026 22:36:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=QNS9W6SZfyDIUc8hBvcmHVCCa8aXdEVnnS9qGJqvemc=; b=jCWkW2hvA5spZqOkPfmkPciKOc
	XABrNZvpG/5K8r3GI9qXUWwV3ZjFKl+1lV3ATV7OvP9/09hbwd+JoNcMVOPaUwvfCSXeqq86wZ/t0
	MMpFnLd0X+lZfBdRTEI9I3W7ryEYGmyEmi7PnpJ/vwCR2yuJq2PLjcDRdbBgL4WAFLZaU6tEa+3YU
	9JnXwTMq5GzSLfoJbcpDOf24rfWBllgF/GHr/Gx0vPYNAOhp2wcS9pX72hr9lt9NtQ2HKil06xB2H
	mchOz2dVRNJJ/HcdaxczRw9iETQpQfNAkp8SC+CQ2jvHxzQVd/BROW9BW1Ebc46OnqJUDuTJx3stj
	wO7xahsA==;
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6RV-0000000E0pr-0gJ3
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 22:36:21 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-389ff3f41f8so6388591fa.3
        for <kexec@lists.infradead.org>; Fri, 27 Feb 2026 14:36:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772231774; cv=none;
        d=google.com; s=arc-20240605;
        b=VbbqFqIFl8lAFTJM9fesy2CJT9QYLBybFLJClDnGz2SnNyUWNI0gyY3RvRhrC7HpJF
         XGmBpI+utD26REin0P7tpySCHEN+e/qWQsP3Mo3kZNh1obJkBIAq+nrcPRtXJ5Xwthmq
         /qj5qDHOwyd9H5ecuKXD9KblV7AsjlHEaElgCn9wNqXmNPSGToSKRGyX+aFOGP+5U+AW
         /WyD7FwlHCkWGBMzxkO5rUDmbHzT6EiRuiBYcoG9Cfxdcuw6PI4jcJjZf+TSNfmF9Ijp
         EfX3RJIsyrv05Nisi0s9KBd0NNSVulB6eJn2r463lC0KEpcBsPLZWCD+kydND8ZkW4a5
         /cTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNS9W6SZfyDIUc8hBvcmHVCCa8aXdEVnnS9qGJqvemc=;
        fh=Wk5ua8FgUn1oE3TqSh+igywiQJA2SLvFf+f5S78Cr0g=;
        b=d2M+mkPZfvqoWwekMs/c4smArOdxkZWHS27blXGP12ElnqaV7SgVFyLRbiE31QNzup
         noXP+rDDCHIHav3KlVhhFufBPuPkF0L5S+mZ7OK559SY9Z4bXXe3unmbmk8r/P2fnpXD
         glnj4GgGMRqezdTi2s8KHC214G/5mT2fcbEbNSQ52PYBJLDJHlxU9ekhhOOxr2pxfxUA
         ziNlTdzlR2yejydC2nuuCtq6UdainIJOTi9tIZvnFnBrsQsqB/4DYI1xMNp0Q3luu1Iz
         RuOnEOuuGiRoBmAxmSZyYSmt47f95WOGtqn8QqsYk/DOOXZ7acGEaxVBztd3Kg7g8biR
         v+2A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772231774; x=1772836574; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNS9W6SZfyDIUc8hBvcmHVCCa8aXdEVnnS9qGJqvemc=;
        b=PI8oYY11UHjLCmdnm+aC3ulrd0OntieHBo3MXdkionPo5595EAQeSfvfsUXFImWVZK
         FxFYom2YNwvKLqgLNlnbJaZ7GbJNDZYSW+th6/mLZiVXoXgX9yvijHtXCdZSwRF/g1h1
         o10YubuiUTIMgsS7gB6KBXujGvI5WLvPxZbGmhppLU+JN6Hm9hEQQm7Ghzo1K5z0JxMh
         gRwqvgeJ+UIFsk67fZrIcrR2Go+n9YdOc7bFS9l5g8iKscBMtDOdHdPAcaGDsIBKjDze
         1t4nQlcI65SdQRDOtjTlL20M1H+DmdUrdPZ2pJ5WKcLmeiI62S4+D2xLl4mDzshiiLA2
         T6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231774; x=1772836574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNS9W6SZfyDIUc8hBvcmHVCCa8aXdEVnnS9qGJqvemc=;
        b=Xq+oEyp5g3yD+H2jXVbRKVpSiB74bEWaOeAxoQCa84OEWbSX9V3pggFVtrpfx3JwMA
         PhSm4+kcFOsWlb5l+Ef5j0A0p9+Xm12jncJ10gTG5pZCZ94d5/OIbw5j/xf8F2LyEjkE
         v1E9t9UPcLRvdL/8c2IPT/ItwhUJsuuXfZf865Mg8i+6n+Y/VhMHypvuo9+4a0v07zvZ
         h0JPAtaaQZLEOnjM7OMUImfyMZWPzVs5H9e4eHK9DX11sYjSIdKR+MMxTBSk+O1DhYAm
         7vzKn96eSyOj1Tzzg9//O8jQEPBBORpycpQ0TG3CZgeiWYV7sV4k9cR4W8OXuOFCrKL8
         qx/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXT0HcXtUSNhx4porsP/WFXMqQw3U1dD1bpcNqhX6Bz+YWe+yUGGbtyZyoQNnmeg/TPF+ePQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyXiQVqdihfku03c7AAdvmt2WIsJTikuOn0HRLS/DIHE2ULvHT8
	5SlMMSPPesHwzoTD3aiVpxYXVYlVuMTYv6ElBSih8PqB8fttEvTx7LgDUUVaOf2EmaEBeA1cEZQ
	yaFWtcRxcnWmsxiJJbmW9U2yvPW2Zm2+yNt0T1yQN
X-Gm-Gg: ATEYQzzWGtUR2C7zOt6BEx9u+UPSa2wPbk0Fk5pjDu+7paaGpQwSuobaPnNCZiitidY
	XPcAQCURIV53d4qY7A6czz1NeNMSTcU9jP67w0ZX3BdsoyCoJPzYIYKv/hVyH/IeR0oTFBnipc1
	sgeG6WfBbYZM8OMArdZrx4os0ooCFlmEqnX9WXQJxz9sdYwyAMyf8RKRrLbzD0i/E/i5Z4UN2UT
	7azpc/1v8gBq/wlrw6wcgC2D+eE3O+WpSB79+7MHQEq0NndsvQoN76i3bUyz2VGcjY3Qy83A0iU
	DN+W8nc=
X-Received: by 2002:a05:651c:150e:b0:384:9355:6a7e with SMTP id
 38308e7fff4ca-389ff144dcdmr32194241fa.17.1772231773691; Fri, 27 Feb 2026
 14:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-3-dmatlack@google.com> <20260225224651.GA3711085@bhelgaas>
 <aZ-TrC8P0tLYhxXO@google.com> <20260227093233.45891424@shazbot.org>
 <CALzav=dxthSXYo13rOjY710uNbu=6UjzD-OJKm-Xt=wR7oc0mg@mail.gmail.com>
 <20260227112501.465e2a86@shazbot.org> <CALzav=egQgG-eHjrjpznGnyf-gpdErSUU_L8y82rbp5u=rQ83A@mail.gmail.com>
 <20260227152330.1b2b0ebb@shazbot.org>
In-Reply-To: <20260227152330.1b2b0ebb@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 27 Feb 2026 14:35:42 -0800
X-Gm-Features: AaiRm50D90uQBM2OzGa-RA7PnZi6CheC4aDHB2jS6rwjE4obcECpnTV5MTFBKgA
Message-ID: <CALzav=fq-3J4WFD-uNd5zJ_Fx2sHGv0vL+EtpV7WvGO8ddG5mw@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_223617_607333_01383CAB 
X-CRM114-Status: GOOD (  47.03  )
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

On Fri, Feb 27, 2026 at 2:23=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Fri, 27 Feb 2026 14:19:45 -0800
> David Matlack <dmatlack@google.com> wrote:
>
> > On Fri, Feb 27, 2026 at 10:25=E2=80=AFAM Alex Williamson <alex@shazbot.=
org> wrote:
> > >
> > > On Fri, 27 Feb 2026 09:19:28 -0800
> > > David Matlack <dmatlack@google.com> wrote:
> > >
> > > > On Fri, Feb 27, 2026 at 8:32=E2=80=AFAM Alex Williamson <alex@shazb=
ot.org> wrote:
> > > > >
> > > > > On Thu, 26 Feb 2026 00:28:28 +0000
> > > > > David Matlack <dmatlack@google.com> wrote:
> > > > > > > > +static int pci_flb_preserve(struct liveupdate_flb_op_args =
*args)
> > > > > > > > +{
> > > > > > > > + struct pci_dev *dev =3D NULL;
> > > > > > > > + int max_nr_devices =3D 0;
> > > > > > > > + struct pci_ser *ser;
> > > > > > > > + unsigned long size;
> > > > > > > > +
> > > > > > > > + for_each_pci_dev(dev)
> > > > > > > > +         max_nr_devices++;
> > > > > > >
> > > > > > > How is this protected against hotplug?
> > > > > >
> > > > > > Pranjal raised this as well. Here was my reply:
> > > > > >
> > > > > > .  Yes, it's possible to run out space to preserve devices if d=
evices are
> > > > > > .  hot-plugged and then preserved. But I think it's better to d=
efer
> > > > > > .  handling such a use-case exists (unless you see an obvious s=
imple
> > > > > > .  solution). So far I am not seeing preserving hot-plugged dev=
ices
> > > > > > .  across Live Update as a high priority use-case to support.
> > > > > >
> > > > > > I am going to add a comment here in the next revision to clarif=
y that.
> > > > > > I will also add a comment clarifying why this code doesn't both=
er to
> > > > > > account for VFs created after this call (preserving VFs are exp=
licitly
> > > > > > disallowed to be preserved in this patch since they require add=
itional
> > > > > > support).
> > > > >
> > > > > TBH, without SR-IOV support and some examples of in-kernel PF
> > > > > preservation in support of vfio-pci VFs, it seems like this only
> > > > > supports a very niche use case.
> > > >
> > > > The intent is to start by supporting a simple use-case and expand t=
o
> > > > more complex scenarios over time, including preserving VFs. Full GP=
U
> > > > passthrough is common at cloud providers so even non-VF preservatio=
n
> > > > support is valuable.
> > > >
> > > > > I expect the majority of vfio-pci
> > > > > devices are VFs and I don't think we want to present a solution w=
here
> > > > > the requirement is to move the PF driver to userspace.
> > > >
> > > > JasonG recommended the upstream support for VF preservation be limi=
ted
> > > > to cases where the PF is also bound to VFIO:
> > > >
> > > >   https://lore.kernel.org/lkml/20251003120358.GL3195829@ziepe.ca/
> > > >
> > > > Within Google we have a way to support in-kernel PF drivers but we =
are
> > > > trying to focus on simpler use-cases first upstream.
> > > >
> > > > > It's not clear,
> > > > > for example, how we can have vfio-pci variant drivers relying on
> > > > > in-kernel channels to PF drivers to support migration in this mod=
el.
> > > >
> > > > Agree this still needs to be fleshed out and designed. I think the
> > > > roadmap will be something like:
> > > >
> > > >  1. Get non-VF preservation working end-to-end (device fully preser=
ved
> > > > and doing DMA continuously during Live Update).
> > > >  2. Extend to support VF preservation where the PF is also bound to=
 vfio-pci.
> > > >  3. (Maybe) Extend to support in-kernel PF drivers.
> > > >
> > > > This series is the first step of #1. I have line of sight to how #2
> > > > could work since it's all VFIO.
> > >
> > > Without 3, does this become a mainstream feature?
> >
> > I do think there will be enough demand for (3) that it will be worth
> > doing. But I also think ordering the steps this way makes sense from
> > an iterative development point of view.
> >
> > > There's obviously a knee jerk reaction that moving PF drivers into
> > > userspace is a means to circumvent the GPL that was evident at LPC,
> > > even if the real reason is "in-kernel is hard".
> > >
> > > Related to that, there's also not much difference between a userspace
> > > driver and an out-of-tree driver when it comes to adding in-kernel co=
de
> > > for their specific support requirements.  Therefore, unless migration=
 is
> > > entirely accomplished via a shared dmabuf between PF and VF,
> > > orchestrated through userspace, I'm not sure how we get to migration,
> > > making KHO vs migration a binary choice.  I have trouble seeing how
> > > that's a viable intermediate step.  Thanks,
> >
> > What do you mean by "migration" in this context?
>
> Live migration support, it's the primary use case currently where we
> have vfio-pci variant drivers on VFs communicating with in-kernel PF
> drivers.  Thanks,

I see so you're saying if those users wanted Live Update support and
we didn't do (3), they would have to give up their Live Migration
support. So that would be additional motivation to do (3).

Jason, does this change your mind about whether (3) is worth doing, or
whether it should be prioritized over (2)?

I think I still lean toward doing (2) before (3) since Live Update is
most useful in setups that cannot support Live Migration. If you can
support Live Migration, you have a reasonable way to update host
software with minimal impact to the VM. Live Update really shines in
scenarios where Live Migraiton is untenable, since host upgrades
require VM terminations. In the limit, Live Update can have lower
impact on the VM than Live Migration, since there is no state transfer
across hosts. But Live Migration can enable more maintenance scenarios
than Live Update (like HW maintenance, and firmware upgrades). So I
think both are valuable to support.

