Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFB4106FD62
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 00:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pnJL3Iw0wwI9nfGsL4UNGadpWjx4M7Li4XWaHu9e8Ms=; b=g0p6CTaGlutOqEbQ9xGGpwc610
	OqzPJjQFMUmcV6wXHhVPNZKc4vl5blTj/TDn/eSn/OgVHHGNGXs4lPhVtfRdq/BoDvEFYN+DuGNGq
	xcptiOt28Em8/Mo6nWc9I0CLNvd3qhfVDsFI2vvWGSURAyB98p5uky0Qt7TRzheYWqBx5TehjnlLY
	X2PcVaRIhsYPk4x7b2Ue4ej6lsUjoaIW9jj11iKCnhevl50Wdb/dM+HJQusQnvNXKXqpchEoffp/h
	QC4tt0An7Pjw8doXD7RUSc4pp2exGBQPKwpkHPGFYWoNEDGHwr7j2tMLa8Ab378sVJ+AtfypVIory
	iJD9M05A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qTh-0000000FwOq-2m58;
	Fri, 13 Mar 2026 00:34:09 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qTe-0000000FwO5-2Yyd
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 00:34:08 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-661d929219bso1884190a12.0
        for <kexec@lists.infradead.org>; Thu, 12 Mar 2026 17:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773362044; cv=none;
        d=google.com; s=arc-20240605;
        b=IajBwgmnRMr/n7zT2QaA773JHh2dZ5YwyALnmDupRQXYPYCMCP41tt3EkTcitGIfjx
         +H8KknD37UI5XuGi0Rq5bL+XB3x+h9muIOeaCaH56mZzfUALq0n2dw2jVeIQLhkGRaWx
         x8yeYlFYaz7ta0CmseR6IK2YgDZpwGjiIkAyihhFf+UlHxPIa/MNPyjzqP9MusQlpIHL
         uX1uyq1jdmAuO3TTOQevoo3r1a9eo4bWKLDdiyF1nAYyQ42IHvv/LQqG2E0CLzyJnBEe
         IF8npBKNIpAjXEtLH4ijF1ENmFc1oXKuRR31dcOKRrzpl+JBvjVhGpr6ZJgJkdNEZt0S
         f9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pnJL3Iw0wwI9nfGsL4UNGadpWjx4M7Li4XWaHu9e8Ms=;
        fh=gITrxpr6scYMr/aMN9R/9siFXAOm6Uu1BJ2VPshYSJo=;
        b=i1dJ5L9BhgaaC4OhfKsD9mZe+KTi5+nfqNIrqzD3jZAfPZXs+gbrEXGmYyosyqbcJG
         EJb9rJtk++AB5cpbuaSdIwm70y0WshJuJ1K7Fjt6rlR6F4dJLh0ZFRRvUNU78wWbs3dY
         3qzZWSnTPZGnk1cYYt6ViuPVkTP/lml/TZ8Eek5/0fIZkDGKmtzYa+caOza9DmpUSyg2
         /ibgFoFI8TceXWOdKH6zO39nY7KdPJJbgBLm76gX/Yeh0Pw4p21ywTncOLLhvtKN6z/H
         k2Y/8Hbd8ES6/2vucZjNma268iwWaP0kdq0Yz0FpI8ia9J9XoG6JZkuMMxB5cNaxkem7
         lA7Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1773362044; x=1773966844; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnJL3Iw0wwI9nfGsL4UNGadpWjx4M7Li4XWaHu9e8Ms=;
        b=BUuNkR3KjVoYJ2XcxsJWfiQvvHD9MOp0e2NH6vApPHXNiMSdZyve7jUNZwFeJmyHtA
         SpjfVpnXk36ftHIdPxaYeCpqx0F+5SKBc1dObnQlrIuUz6TrSIbRBMIZ7uiDf0O+kN8J
         rsEtxoocNeFfvKl8r8tdaV8ZwCqAhLAvprgXU9QMkxK/9/qn443lrFCmW5kg9WaiKlJg
         BzL27XYMVFiEaqYlhxoNDZmx6rcKmNxYsraRG/jScJOsYqoMoM8Hjbgn+YituaGzQMdN
         vQCLINBwocSRFkB9k8mPFKKpt5qc9NbdkCDOYOgR4aGlgLAyMcN8MRgFNFru57Vb/Aa4
         Dh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773362044; x=1773966844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pnJL3Iw0wwI9nfGsL4UNGadpWjx4M7Li4XWaHu9e8Ms=;
        b=pwxl8nltA/o/NBngfzY+koe44ZknN9g6TlovlbHO1TK2Sq7zV0IEVaNq486lg47dow
         CXtlo5+jMC1tl0Ewv0xvE+O+nCpifG5qbsB8g7Oy6VqH2UvBO+I8L8Et4U8WbyyYBi6F
         f+O2fon01N4TvFiXXiBcBw/Q0vjUyKEwynqq1VOdQPAJTO2JCNv3VA+DSOOAC5VE4/mx
         G9zrVidxq4xkktrFuPSaxGqKTb25mwWISV+t81RNXVgdoJzSRX68j9SO/6nhf6KpD9yq
         1W638aoNmIU/f0pZJ0Vkx9TNMNjoM/eTsJFDxoHkLcIwW7T9ihlGyo5970RXCKhkpbfi
         9f5w==
X-Forwarded-Encrypted: i=1; AJvYcCXo7T3aa6HtOE4EBf+AyOkQEetpUlKDk0Bv+2PTbLaLWOUJ122mU1NY3INMq1B/8aNPJBkQ1A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwMPba0lH1hUognfJXRTHiPzkmrXt6xNgMOQFBmpeOUi7s9wDxU
	YgERaEAM//Er7vStjeuxzFXn/3Pa3qSezsuzwHV4L6oaWbeD9mAPkssnJyHoWESzGZ3UeapGdBv
	bGQmyrsrWRw9b1R/XoHVO2oAUqgKSoU+wxb9InZzQaw==
X-Gm-Gg: ATEYQzymrGZ3EMgZnz/t0PkAYqiX1myHYyybARumobdcofXhIo6etWRBsgtzvRntKJw
	auH+mfFGgTOBROlvnA80RUHbWk+VRyEm0D5xC5gQABbT5BjhttjelD66+0/CjNAUeimAxwFHOXJ
	bBrYcpfUD45NIp3ohPfWPzjwg0zqu4GK9L9x86jWG0lH8N0CWQLGCJELg+08I40EZvUZAmrjtLM
	EbQ5r/q5wqGJe4PwaR06GNNcU050N2rWmmGbJJET3sVSzC1YAAFeVrS/INdJqBRp6OEZ7SJx4aI
	rty2J6XhTXHacTGihQ/2qF5Xlasn9/1mX0NAFQ==
X-Received: by 2002:a05:6402:3486:b0:662:e094:8dcd with SMTP id
 4fb4d7f45d1cf-663bb3d3be3mr643429a12.27.1773362043907; Thu, 12 Mar 2026
 17:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-8-dmatlack@google.com>
 <20260226160353.6f3371bc@shazbot.org> <20260303210733.GG972761@nvidia.com>
In-Reply-To: <20260303210733.GG972761@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 12 Mar 2026 20:33:27 -0400
X-Gm-Features: AaiRm50W9P4A7h3ayFJS5r_ZVIe8OM2EYEDEiGqBav5AUONhmByKJOVge3skGH0
Message-ID: <CA+CK2bDADhFcMVGoJew9RoJ-DsVhYhiZJGJVwfzTBZdGX++8Ng@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_173406_684897_55AFB2EA 
X-CRM114-Status: GOOD (  15.38  )
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

On Tue, Mar 3, 2026 at 4:07=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Thu, Feb 26, 2026 at 04:03:53PM -0700, Alex Williamson wrote:
> > > @@ -203,5 +225,6 @@ void vfio_pci_liveupdate_cleanup(void)
> > >     if (!liveupdate_enabled())
> > >             return;
> > >
> > > +   WARN_ON_ONCE(pci_liveupdate_unregister_fh(&vfio_pci_liveupdate_fh=
));
> >
> > This is propagation of a poor API choice in liveupdate, the unregister
> > should return void, it shouldn't be allowed to fail, IMO.  Thanks,
>
> +1
>
> "destroy" functions that fail are evil. :)

Generally, I agree that unregister, free, or destroy functions
shouldn't return errors. However, this situation is tricky because the
state is controlled by user space. The only relavent scenario where
this function fails is:

"-EBUSY if the live update session is active and cannot be quiesced."

If there are active sessions (incoming or outgoing) with preserved
data, how can we safely unregister while they are in-flight? It is a
rare condition, but since the user can cause it, they need to be
notified that unloading the module right now is not a good idea.

Pasha

>
> Jason

