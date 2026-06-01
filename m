Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A617CD5BD1
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0e7u8ODv5hGAN3SwrIVi3OVbVFu5joHm/GWqQlQCsiU=; b=k0hWwlud1DluJjDkehz42QUpoh
	5S/Z8oKhy5K1mcH9Ztr7gEUE6JQz1Nvd0TWBg2zL4teQ5PXmapD1hAi0E2bnUXSfxL1slVIYU6pU9
	XMhYKsudKosgQp9kiuvNhgj5ZtAm7YAnzkE4qgjiT4c5DV+x3MMCLDjcRkLU2+o8DZGJX12dlZjIw
	FSlq1ZHtRUZLNatHo4kDNVsTmN+Koyq6CZUhhJEW8wjZmbNxfX+fYIJYi4reNGzPewIwjv5i91xIz
	v7f6/WpS2OzB2qJzl7RbE1PavNSgHgX/EwD/60Dket9iykgu3B+VnzDph20to2T0g60U9kAwDdo8U
	bGb10zKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU5uq-0000000BWQQ-3JjK;
	Mon, 01 Jun 2026 16:55:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU5un-0000000BWPe-3lLd
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 16:55:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780332899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e7u8ODv5hGAN3SwrIVi3OVbVFu5joHm/GWqQlQCsiU=;
	b=hjsut6mWWyFQMC3uJyb9R6tzEMMSGt51Fyc+nU7VUaV3EW4Gd3aUEQQ0m/V+O9qtEIgOeT
	vJ7ZqlD1WJbNTngGwW8p8WZyuwaxEKB+hHAOhr4qZWDILVpq1UXJUrKq+LYhn1Jp/XCmPO
	pUaUbP4ismDYcg2kViwsvCMxzKutMBc=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-Ujfa4qutNCOZT1GurnkQbQ-1; Mon, 01 Jun 2026 12:54:56 -0400
X-MC-Unique: Ujfa4qutNCOZT1GurnkQbQ-1
X-Mimecast-MFC-AGG-ID: Ujfa4qutNCOZT1GurnkQbQ_1780332896
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6751db2792dso4066100137.3
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 09:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780332896; x=1780937696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0e7u8ODv5hGAN3SwrIVi3OVbVFu5joHm/GWqQlQCsiU=;
        b=q9w4IxUeN0rG3R18PENCqw183VreHhwoRk6rT3yBzIBtelqOyF2k1KodLBGZtnUCUb
         XBJSPb8/sYXZ1ZryfNloF/kR4H2ArY083trcrJly7c2M+VDHq++iyuk19iTgcnF3/99r
         9OBH5hiK6ayyFUNIji9123lz1QaWT2hpXztsHZD7NmUEbl5b/j3ytqbIuZd0XPVumtlk
         txonidX+kruPEfkfOdAWOUWNTezklpj9Y1xrimcaP9v8ET16F+uMosKBm825vleZLulT
         vLCm0yJdLRQ3DG7OeJzF5lURBom49O6Po2vDu82sA18QwkNx1Dt7hFUN9Z8GyQ/eRvlm
         wSig==
X-Forwarded-Encrypted: i=1; AFNElJ/wAO8hwYm1QVmvPThBYkW/31SOIIcvrdrsUJE/75lEtlORilsa02Fysse37SJ8XyUgjTGTOg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzO8Id6InFFnYtvdx06t/fKROR3aFfxW6TQHOgLWr0uLko4f2lM
	3iGIioCMreOkDS2HbS3qiW0aimIG3B0udfLzrm1Fhta3XiTBBoP4w5GTjIdohZC6e5X8bdgTwoe
	EiPgixirN2nYsNFHjP3EjFc74eqsYkyeYfpEsoOXNJtHeY48o4oLNZKFZpa8cGTJyOUBDugPXof
	Wiym0gg8HzpICZG8+pPnTQUbO2P6FKDJbwMR6a
X-Gm-Gg: Acq92OHvzpBjCDR76P5XyghcJPuPSNZHNRqBOdAt8sklXwpRM/Dblxdatau8V3RNbV0
	1FN8HjMvYLg2899GEmbKxAnVvLSfu6TMR28Ekh8eH0/sUgVdfe12nWwsgBWkrFTxaguHcz7lp9V
	R3WXjkGzFJNQ0hTGBTlSRZ54EoYTASajG9JvTRsgDZDJ+zUWPgLxctYtkE4w/r6a6Fz1vc6L2GR
	xB5J6WL4RcGscmIN3/36K/NA9bshlv398E3ImrsSw5DB8nxwaqIGKs7ttBluVOEITkDqGc=
X-Received: by 2002:a05:6102:41c1:b0:6d3:aad5:6d2d with SMTP id ada2fe7eead31-6d3aad571d5mr1975294137.18.1780332895716;
        Mon, 01 Jun 2026 09:54:55 -0700 (PDT)
X-Received: by 2002:a05:6102:41c1:b0:6d3:aad5:6d2d with SMTP id
 ada2fe7eead31-6d3aad571d5mr1975273137.18.1780332895334; Mon, 01 Jun 2026
 09:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260518193204.14273-1-djeffery@redhat.com> <DIXT3WV9XAWK.3E0JOPV2K6NC1@kernel.org>
In-Reply-To: <DIXT3WV9XAWK.3E0JOPV2K6NC1@kernel.org>
From: David Jeffery <djeffery@redhat.com>
Date: Mon, 1 Jun 2026 12:54:42 -0400
X-Gm-Features: AVHnY4JlEP4O7SvjLzcCS-aNG7BrnY8TX1LnwVykV7UvnzLu5Qi3VLZ62Fw9ZAA
Message-ID: <CA+-xHTGSuo-i872=-SG5pf+xGAN71TDQ=5f-H0kuv9g8G3uqZA@mail.gmail.com>
Subject: Re: [PATCH v16 0/5] shut down devices asynchronously
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tarun Sahu <tarunsahu@google.com>, Pasha Tatashin <tatashin@google.com>, 
	=?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>, 
	kexec@lists.infradead.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yyjFWXCsBkj07e2Fi66VDdSot5fr9dpOTyctesZw7yI_1780332896
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_095502_013367_46C8FAB8 
X-CRM114-Status: GOOD (  19.72  )
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

On Mon, Jun 1, 2026 at 11:10=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon May 18, 2026 at 9:31 PM CEST, David Jeffery wrote:
> > These patches are now rebased against the driver-core tree's driver-cor=
e-next
> > branch.
>
> [...]
>
> > Changes from V15:
> >
> > The async_shutdown bit field is converted to a device flags bit Convert=
 all
> > patches to use the flag bit accessor macros to set or check if async sh=
utdown
> > should be used Added documentation on the kernel parameter to control u=
se of
> > async shutdown
>
> Did you have a look at the Sashiko report from v15 [1]? Some of the conce=
rns
> raised seem valid at a quick glance.
>
> (It seems that this version has not been picked up by Sashiko (despite yo=
u
> mentioning they are based on driver-core-next). I'd assume it doesn't lik=
e that
> the series was not sent with '--base'.)
>
> Can you have a look at [1] please?
>
> Thanks,
> Danilo
>
> [1] https://sashiko.dev/#/patchset/20260429175016.7915-1-djeffery%40redha=
t.com

This does look to have found some legitimate issues in need of
correction. I'll get them fixed.

Thanks,
David Jeffery


