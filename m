Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D16EC53209
	for <kexec@archiver.kernel.org>; Mon, 27 Jul 2026 17:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=goSDZrkoP4CAKwXn9vTqQBBWqi12AJrVoF+aHToitxQ=; b=4skhKBnhd81aKOBsVkxjhtTmq8
	7t1I+M0IlxMlG9oufawm4L26FEPh7spHwTE1AgMiYB4v1rW+nfneK/Dzx/rL85yRkLNcia18jv9aL
	2NeWKRUL6AAwvSd9gBMOVJjB+ppi5d4N5CIg+mOYqrJuMmAzAsuR47poWnyKdys9tCy0LAgxR3Tyb
	LjvW9hMyi+ffXlM4PUbd42njNegm4vswgXPqUSPHiW0E5ToXXfzr/jR7seY5Slu8WJ41pqnd/MuNs
	H71JIH7IUp5EKEn3vJUIql957BE1wkiuP2mEss2vQgx7rEkZXkp8a4h/1pVnWSzRvtus+uKZ7CGCn
	pQDmI7rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woPKO-00000003Xpz-19E8;
	Mon, 27 Jul 2026 17:41:24 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woPKM-00000003XpL-1rlj
	for kexec@lists.infradead.org;
	Mon, 27 Jul 2026 17:41:23 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2188147a91.2
        for <kexec@lists.infradead.org>; Mon, 27 Jul 2026 10:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785174080; cv=none;
        d=google.com; s=arc-20260327;
        b=DzTpYLRhLG+kLn1I1t7yj87oNeUSRsyj5kC3eqp504LWxIAZbHTkj9ogAWLMCnS9D4
         kN2znqW8+TwgsCCmqofEUAhiRbIhK0GO9NZ2GhYUGiZF3XJU2zberZ/r4Y3M5AvdkzAf
         xTYYZ7Bx7SOI2FzLO4Sk9Qpa4sO/6UDojYWvGOMX5Ie7OPI+22/TNikqPwrZX5TCvALJ
         a1OQR4vEGIyJPVG6idIXdgIcO7tNyEIg8s/KGMxOsKpV/NY2ZVU2Jy5yijbBtLCn2cce
         nlQk6YU1MEBC/G6HIgaX0IKzxPyNVjriNiNptihzxC+r4yO6BYsgjtCuDSA94uKEdhhr
         7R5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=goSDZrkoP4CAKwXn9vTqQBBWqi12AJrVoF+aHToitxQ=;
        fh=Vqc4ln53D4bxOegRoXRnAZ9HbLniKRCPC/zyIqSj7Z4=;
        b=lSrxsFr6gAKpHyiuJ7/3YOIYjMWk2p60D6sdcEojWQvr0JzJsejaw6+723olSpQWr8
         elTMko0p4QJ65vlreqy8+6JtZoktZq9GJoGqSgPw2OMaEqnOmfoUcdG6rEmKLJvXPOtT
         xjToMHIrVjBLHsF0axywfDWt6jkXN9EL0E7cT52QZ3nLWXXCuT/5v9Aa11hS8Gt3pN9i
         9WPSXKLR+/hKNqe152cYEJEeY7cZv6kS855WAnoStS02U8OX6qP5z3RvjhPtnqbho8HW
         r/zrKFFdLfvrugxfMNl9jlAfs0TeghCShGl66MNV+Nh/XFjNJD52eLxpbN6l5zVM5FDY
         oFFg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785174080; x=1785778880; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=goSDZrkoP4CAKwXn9vTqQBBWqi12AJrVoF+aHToitxQ=;
        b=SBm5rnK8qWBo+uGDKN3ESdDGsuJmNbDLt0Qu9diqISc02V+15c7bGW6KUxHesdMs+V
         HeYkxM7KRo88jALdawX1vO9auOLXxe6/xKDCEMDb3n5ATzoIt03GA09GEG+LAe8Zf1eB
         1x9QfBT6hapwrAkjCC09o18/jkHutMZV7TcIe/CZbu0iJd9ldOc5jyoR6qWIZa21aBCn
         nZJwqMxJjIRe81qRBibta8F3lHXfNx/iSno5jEF+IDEPOKd114Lh1GWf1zV24OntrLr1
         bE8M5K98ZCI1uyJ5jqVIcxkszotPiqgn/dsENd1kJIs4j3eIt8v3MpC2l9nATGdUNZY1
         uVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785174080; x=1785778880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=goSDZrkoP4CAKwXn9vTqQBBWqi12AJrVoF+aHToitxQ=;
        b=V9h7BkaTHk+M9VYVa8OzpdxAVpAaAYyyl4Ug95+FaRuWXIW0WRDMeoc4J2FzxmfGPd
         RIXMTX9TQxtICyUOKAR3BgtB5UPztHMAIgvywXX32m8X5RS/CpxbwfQ2rH4zeDvAL0ju
         9BESXoAhzN75eArZRxjLmPvE6HVSfAMkkqfQjlfSeimWUUpdCbiZ++tJWl6zLhs4oRrh
         dmFNVWiLtKMD5PqhrHydt1IZX3+8OOc4lx2zAQRwvZbY+rS+AvhvSq86lXNh70rBTs6B
         G8zi+KJw0uLAGNLLe4XSByClQ4gpMf2l3/8CiDJzCoITGzaqkMTVZWvw+8ArxCHDqb4h
         9SMg==
X-Gm-Message-State: AOJu0YxadNSobOZ1P9ht+nmO608f3oPaVsiCCdxDAxhDlpQdNgnjl6r+
	aXWQ8F3/s48JOSB7XCJtYS2aL2KKA7pt/2uD5olVtpmnUdKfeHZWv5t20cCVpp0+RFNc4wlzdH/
	yoqTdBz7PGIYR97SBZ/ZxBgknt/aypNpEh398UUFd
X-Gm-Gg: AR+sD11GAC1aKGSziQxJu76DNU7vyZ1e6Tjj2mgdTtjckIII/8ciaRasciu780hy4gY
	AumMx6/I3GpStqRS0zoEtFJ+JEoeSvUl0GYIyh35HUdgVPYICpGjeiPqW9hBa/1/4V0XmOImbIi
	bzlgLuDF7U+NIUTQIDTtNCKStJka3/OwgaVLFZVePz5N5LEW6pcCHGFtyx9j3w0DgGcjqf9Tnyb
	BagjWsHj29ZQLj6HHtihz3H57J10vhyTP1qy25iE1T/PQVgza6VmZy6/3vkW602hhp4yiWc9plY
	SWSwbIeo8BJFSMADbDQ5Ph+UPIJISDQM++U3B7wevr9K
X-Received: by 2002:a17:90b:3c8e:b0:38e:69ae:7148 with SMTP id
 98e67ed59e1d1-38f2960cb21mr8640703a91.24.1785174079933; Mon, 27 Jul 2026
 10:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260710212616.1351130-2-dmatlack@google.com> <20260723222106.GA867236@bhelgaas>
In-Reply-To: <20260723222106.GA867236@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Jul 2026 10:40:52 -0700
X-Gm-Features: AUfX_myC2ShwJmehW74tz8H5rliP_ZZpqbkoGqNrvu-bKZjNzGADgRSnjM8EYT8
Message-ID: <CALzav=cRhFW+zNX6xCnhjJXXDHgyhOxuoX26FG2Ve8+wMccypg@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the PCI core
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_104122_483905_25AC4D10 
X-CRM114-Status: GOOD (  18.82  )
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

On Thu, Jul 23, 2026 at 3:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jul 10, 2026 at 09:26:04PM +0000, David Matlack wrote:
> > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> > it to participate in the preservation of PCI devices across Live Update=
.
> > Essentially, this commit enables the PCI core to allocate a struct
> > (struct pci_ser) and preserve it across a Live Update whenever at least
> > one device is preserved.
> > ...
>
> > +#define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
>
> Is KBUILD_BASENAME buying us something important here?  Just from
> code-reading perspective, it's more work because without some digging
> I don't know what it will end up looking like in a dmesg log.
>
> > +static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> > +{
> > +     struct pci_flb_outgoing *outgoing =3D args->obj;
> > +
> > +     WARN_ON(outgoing->ser->nr_devices);
> > +     kho_block_set_destroy(&outgoing->block_set);
> > +     kho_unpreserve_free(outgoing->ser);
> > +     kfree(outgoing);
> > +     pr_debug("Unpreserved struct pci_ser\n");
>
> If this pr_debug() is useful, maybe it should include an address and
> there should be a corresponding pr_debug() on the preserve side so we
> could find things in a crashdump?
>
> > +int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
> > +{
> > +     pr_debug("Registering file handler \"%s\"\n", fh->compatible);
>
> Is fh->compatible enough to identify a driver?

Not necessarily. VFIO could theoretically have one file handler that
handles all the vfio-pci variant drivers. But I suspect we'll end up
with 1 fh per driver in practice.

Are you thinking about how we can ensure devices are bound to
compatible drivers after Live Update?

BTW, thank you for feedback on the rest of the series. I am addressing
all your comments in v8.

