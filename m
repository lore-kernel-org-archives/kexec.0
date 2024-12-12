Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6975DE7717F
	for <kexec@archiver.kernel.org>; Thu, 12 Dec 2024 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w9FENNGUBCFJ/l24CnwKVG/DRQRmDVPvP5daidTG5Q0=; b=JJc8nWAgd3MXoqk0E04APnlyZd
	vJForUpcCnTsTnLsojfhp9jem0O7ZagJKZ2FYHcVI1dFxqdpmbm8mkI5YV7nhMn4NWFKUDOBJj/fv
	ogGFwCj3SSTB4O+XmOR9k383ToVCLg1cqXT8kTTJbmblRLP76ZWgGwtxONpXy0uEbPWeM5lNGV9Dw
	U3Jhbe995TsArqy4nc2ay/4EskuiihuP1fvDtge2/3NmNIgQfrTanN0ZYn1BfH6RVvyjKJw6AKwKV
	O3F7XyPqI64qC8/4EkU5jqJ3X+AxJtW5R8P105sCZDhDFfqSVfAoogIW2EIt6lxWpfhdt7qGRmfSX
	dL26KrDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLh9C-000000009iG-0bLx;
	Thu, 12 Dec 2024 11:14:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLh9A-000000009ht-191f
	for kexec@lists.infradead.org;
	Thu, 12 Dec 2024 11:14:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734002059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9FENNGUBCFJ/l24CnwKVG/DRQRmDVPvP5daidTG5Q0=;
	b=MZKEngPAxcVceTpXeKwURXUCu9W/5rXjnYhy/tC1liklDTLg7TlKPkf+KkX4q/eD9ursVT
	hgJpUbcEjH6F1m+WN7TtWA+67CSWeJUKKiUMgMAOhz6Ee+peYZ5iZ57ZxfMqm1741QNqTn
	VUc7FXScCAHFfjO/xq1i/LQIRQ1TRNc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-9Rw1nMbaMxKbwf9dmmZwcA-1; Thu, 12 Dec 2024 06:12:44 -0500
X-MC-Unique: 9Rw1nMbaMxKbwf9dmmZwcA-1
X-Mimecast-MFC-AGG-ID: 9Rw1nMbaMxKbwf9dmmZwcA
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4afd9b88ac2so32449137.0
        for <kexec@lists.infradead.org>; Thu, 12 Dec 2024 03:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001963; x=1734606763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9FENNGUBCFJ/l24CnwKVG/DRQRmDVPvP5daidTG5Q0=;
        b=rzM2yUL6lnTu68Elu8oEz1iwm53wSihsiGHa0R4kP0e+1Jt0gzA5Mlz2KPGLAYXiWA
         laXWZ8YUSmVpKuiMOgsW76xFSQWH1BRDIt43T3O/BL/EO+mkAxLyqrsKlQF5lj3TPOx7
         IXd6dTmIaUKFjjcHL8RFLkBFgFCWAjJkJlRu+7VbJiPQfd6uBXYtXNNaanoJZMjFwVZh
         r+q8DJiMip+lSaYYzlnNHdI6Asw3BZ77/zLhSIhCqK4mek8lQRunuGhO4+qKfIlh947g
         ms3b15so93hMyCZUHbbiq9yQAq9LRoW/1iW73yaBbVd6MDe9ALVO5jI88xcK5aBawEmT
         BvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk9NcnbtuSRxS+EyucBGfIrcTrKj4iNusHVPMsUAx4Zfk/5ig82ypytxuKOsAGfVNAgePAag==@lists.infradead.org
X-Gm-Message-State: AOJu0YwKSAYxIF2et3mv+Aff+WoqgPkr/kiRngyqqhzjRc+2L9+FLELc
	qqM7VdLhI30aL3w3tHahQlBasiFLfcWByP1Gd4D32s+AOnnMe+S0FEU2qxGJR9vYCGIID8aogz1
	HzIpti1+DY4pUtCLdDfRNCADHgtJSB1zQWG2Ew+LdHatQeezp8xud5IJw7zGHg4TYw9+I+WC7vv
	uFw1mrPAvxBNwTjI0wHuD7S7bg3uYqXJ5j
X-Gm-Gg: ASbGncv61BjDnQEsYSRC4GeZB+hDYaGrPZVxmmli9XjDBRkUuj+ecGTC+5Y6RMfC+pA
	yhpTh6IckFBzsb+MBT/mu2Uvis2QJDmMjsk2knbo=
X-Received: by 2002:a67:f859:0:b0:4b2:4836:cd82 with SMTP id ada2fe7eead31-4b24836cec0mr2164957137.22.1734001963687;
        Thu, 12 Dec 2024 03:12:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeS6cHs34LlOt5XaThX8i/UA9PauWXPrFd7gcQfKkgK+QOfOA+wdaboOIsT7vqH+OSbXpifWqzA6U3dUe9ZhM=
X-Received: by 2002:a67:f859:0:b0:4b2:4836:cd82 with SMTP id
 ada2fe7eead31-4b24836cec0mr2164949137.22.1734001963447; Thu, 12 Dec 2024
 03:12:43 -0800 (PST)
MIME-Version: 1.0
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com> <20241211124240.GA310916@fedora>
In-Reply-To: <20241211124240.GA310916@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 12 Dec 2024 19:12:32 +0800
Message-ID: <CAFj5m9+XcbryvRQkfpWUcLO_Jcx0iQxbuW3ga1-t8bKX6ssBWg@mail.gmail.com>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	"x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, 
	kexec <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, 
	Paolo Bonzini <bonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vtNWJwRdw_fWaAgbxxioH4Eqt9MvEz-AytMMsTu7qMI_1734001964
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_031420_374728_A97F4B86 
X-CRM114-Status: UNSURE (   7.66  )
X-CRM114-Notice: Please train this message.
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

On Thu, Dec 12, 2024 at 3:01=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Dec 10, 2024 at 09:56:43AM +0800, Jason Wang wrote:
> > Adding more virtio-blk people here.
>
> Please try Ming Lei's recent fix in Jens' tree:
>
>   virtio-blk: don't keep queue frozen during system suspend
>   commit: 7678abee0867e6b7fb89aa40f6e9f575f755fb37

This commit has been merged to v6.13-rc2.


