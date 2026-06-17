Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38533CD98ED
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 22:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dxvS3kwOW4bWC0xsZqNZINpijY+mWNOP8Io4oLdd84w=; b=hlcJdyutveannYmmhq3uHPJlbf
	2WWXp2Kr8UOsvpto+0jhfvigF86JoGkiZWYWMLxjP/dMvY+DHDhjVtLqHawK/W2RCvqax3IiLVUO5
	u9df+8GRcWCsnQOCbyN3cY6boz0FIFNr8lEmmGbo0/7Oej5eciSAXuExvVknnQDMskrDv0/vhab30
	ODyqDVsF8UbZwQkyCf+VVa+88ka+gOhYH9opNw2+1eXsvvX4AcEXg0W3YciP+Ha98lxB3dZToQXbY
	lWjs0otHeG7c/NKc74K93lGI6i0Ft1+l9NTyVvR5LedRzbhCT/JYknkC+8RpSviEJr3lZxzRm9Px4
	fZhxSBlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZyQC-00000000OGn-0BqC;
	Wed, 17 Jun 2026 22:07:44 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZyQA-00000000OGS-109w
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 22:07:43 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1390f75d8bbso685650c88.0
        for <kexec@lists.infradead.org>; Wed, 17 Jun 2026 15:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781734061; cv=none;
        d=google.com; s=arc-20240605;
        b=HRgJG/+LE462GOf2qSZLAvbUV56Yu2kPgd8LFH1vy/dBA6G1aBq9rPHy9n3H5LhwEa
         rrpEayYD+1WG6DCG9b4ILCAHTEsqagdoYWcryXgzL+YRgyy/DUQOISBV6/v8qqUx1UQ9
         G4zvO+kr2Jsp4SGqA49sdgXsQqR0AYJsG7FXi7roNkgA3V4yEJjEZewnfsdWvkY7cJiq
         obs7q4eIPLzi4owwYp1ywCYVfORAhVhw+jF5dNkm5aqYDscqdEEmwT9P/DAdanXWTIoo
         2puYNgySlDHzu4SuyK41BtvzIk+A0rNIXvEvGnHHG8h6K6Bi28nsWAZZTVBM41hZFfMM
         Gqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dxvS3kwOW4bWC0xsZqNZINpijY+mWNOP8Io4oLdd84w=;
        fh=NmzZBCo2v6h/OOnChjJyHO5DmoEC8vLdB+rxb6oUc0I=;
        b=FUG+3kbjBf53JS15oD6D1QKtAb50lRTeDVS8CUdpgTTSHsG6pGmHN+e/9dUcuWoQ2I
         4En6sO6A1zd5khpRO+WtbsMPf3DEH3OpKRIfd7NmYHWEIJljvbJSG22+wRL5hX+CoYo/
         hZEUqYmbUtJWSJTMSZJQuwclLxDcIswyAAtChBZS6Pvb37nODQndSZUdZv1mjCkjx94I
         PIXi3CSO1hVO0cGNGhqnWbY+wkclvmn9SemhpXb0mcAv0DQUiVYECjTRarv5g/O4XvsY
         BU5P6etxLhYHdptDzkEa/ZG3w+gACbjy63PfbYn+Q3lXABeVKpb8TWBIIi+4ndh/1rFX
         4Ufw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781734061; x=1782338861; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxvS3kwOW4bWC0xsZqNZINpijY+mWNOP8Io4oLdd84w=;
        b=oBgzYVvDwHIvr2e9agY0oJ5Wtd7CJeoDMERrIxUNs5cnvUsn1ab8mSQ6Ixv6pd5py0
         rgxpIk7Y5CNNP6rV3lwfWSvdV8VdGtruHRTzA0gJt7e7ONZ5MT0r05Puy9aEMLQ5BTNb
         J1VZPvrYyfMyCZahgJcqxpJVUqRgx9QJxMZQatd3soKyTkXCi3RGde/GmLhJ9ynCm7Ep
         VxDhVriPOZpJAMoXSd/ARCkvV0VaCujzUonnYlzplyTDWIT9hdYMe/NGg/YNgIgrZ1LP
         3s7FPaX7/DvnoRA9N/2lD99XXJ/7i4EvdQ9VloVKU7yhcz/vrgILo+d49wS0J0/LnGnf
         qgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781734061; x=1782338861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dxvS3kwOW4bWC0xsZqNZINpijY+mWNOP8Io4oLdd84w=;
        b=M/hH0CUJpl0CMplLnwkpiWuNTNk85D+BJWwYDPtIIAApCIButuJkcvnrBGs/ChRPJ+
         ubRjipbShSImTLQFmxVdUuLQ+TPTG24DuBwWfNhk6H6S08Yuk/caBumYsTev6X0vQrgP
         j6URh72gq1dME3lppx4yjwSuKuDdo2vwTpNiz0/SuzD1A5zL7e0H/QtQLJdeusMtYif9
         9wGTL4Z+N7ZybOSc/8GknO836rqm9ACW3w7dKXqcijbkR8sHiaVqPtTgsUEC/XlpOsRl
         d7JdBNwS/oJQ+V5MFbB6jXY97fnb21FDovErDtqcTqKz7cW6/9zU1vEzC07QejpIMKjD
         AM6w==
X-Gm-Message-State: AOJu0YyeC2ORMW+LHwflOc3FPpMIGLwUHIDMsnmIZtWl5n7Co4OvgnDo
	SBltQx7fszNriA/xqhl1zqPdQ5G2ZQcAGtLhPF5wspDOj2Njei8WOeZTRYJLGzGEyolVuU8880F
	wPpBu7YOYrswx36cw/29QrZxCNVknzcDPuQf9EAz/
X-Gm-Gg: Acq92OFiPrs5rIAFOVg5O7fZVwbwFIYByDa5FhlHcj6PJ6rKKNvc+h3cXOA1um9Iqmm
	CBA9rBdFm2PsopUxgi1/ip4/IxvvR1FhS4HQivOr4uYLqGkU/aZ+QCkAeoGRvHQqSUbbaF+B62+
	+hTmo/2xOfsUYzrKKQ3W+cjWRi8VMBYfo4QtQk24V91MK4xZnNYiL/Uin7SmcgaP/w0mFZgQHyl
	xCSTFHXnwyVK2Eusnluf6aeT58Fc9BporHTisGoV+RdGMKX3vmQ6K7PakxwPg8Yt8ZoTTKGpnuJ
	fDrIzRk=
X-Received: by 2002:a05:7022:68a2:b0:130:6c8f:5a87 with SMTP id
 a92af1059eb24-1398f676be1mr2746710c88.13.1781734060068; Wed, 17 Jun 2026
 15:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com> <20260522202410.3104264-4-dmatlack@google.com>
 <178144432039.1257322.9644414453415904478.b4-review@b4> <ajBgj_aSuzMZG47e@google.com>
In-Reply-To: <ajBgj_aSuzMZG47e@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 17 Jun 2026 15:07:13 -0700
X-Gm-Features: AVVi8CfIvfIjd2Q6o3VPNKmTcz60wFd9tOmavE8DEafzVsI6S2ukw3P-Cv2hKdA
Message-ID: <CALzav=cGZs6sUcGFu854fTdH_rKTMBF0NK=+jKE-yE+N64XBPg@mail.gmail.com>
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI devices
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
X-CRM114-CacheID: sfid-20260617_150742_312576_ACDD570A 
X-CRM114-Status: GOOD (  12.29  )
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

On Mon, Jun 15, 2026 at 1:29=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
> On 2026-06-14 01:38 PM, Pasha Tatashin wrote:
> > On Fri, 22 May 2026 20:24:01 +0000, David Matlack <dmatlack@google.com>=
 wrote:

> > > +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void=
)
> > > +{
> > > +   struct pci_flb_incoming *incoming =3D NULL;
> > > +   int ret;
> >
> > Maybe make the error return static, and avoid another search through co=
mpatible
> > FLBs if it failed before?
>
> Good idea, will do.

Actually I'm not so sure this should be handled her. I would have to
create a statically allocated variable to cache the result, like you
said, and I would also have to invalidate it during FLB finish to
avoid use-after-free. That defeats one of the main benefits of FLB
which is that we don't have to manage global variables.

Can this be handled by LUO instead?

