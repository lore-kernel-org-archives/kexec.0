Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CD2FF8875
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5PgOh4MKm9Ysku8H251/i15pXVhU7vwYYgGQfsH0l+s=; b=H+ZquigEYmvHfGkar8rkauo0lz
	xWldn/LByat2A0IsVtQlAtAnbXACfMQmXKjY61K/DiXw3RMbTExxB/d1ESYfzU/b9APsoE6bxTqQy
	7vzdkKyIld15/BdGtP/j4ZtmQC+4R/z3KfXc6NDODsOFMdBipucksac7gPbVNsvmDNfYzOSt0Uqr/
	FM7EkrKpdJqiuF+90b10W3QAOUybrJjvafVCrW8Q47Q1QybU0/ey3cnI/RWO6CZu4DG9Mcr5cqI/x
	5cBIlK62NuoZL4e3G3KUltYx/gGCeWPyMiE3KK8dPpELiKWjk1rKmJbFCNxhH25GCBaZ2DcObbraU
	SLIWGC0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIDqH-00000004IB3-2pw8;
	Wed, 29 Apr 2026 22:57:17 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIDqE-00000004IAd-3U9u
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 22:57:16 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5a413f83226so1285460e87.1
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 15:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777503431; cv=none;
        d=google.com; s=arc-20240605;
        b=NeOOd4GZ2N1DY92qEkZDFx0TDDJkPzVxVMtjcFK4lSgyhDYScOjJdcPGZ9ZnXAYAAS
         8AsYg6OCy/Bmqcfmy/3/xL8DNYrEMGqKO5xVJJgapJG3DrE23/VHckTkFXU77PpIsIs0
         5Ir/Vs0Soag0jY6pKpvGMtIlCwVdgvWtgXaP3xuHBTBdyen/cQwJDkZfMNP+w+NBDz7v
         IA3uxZediya2XFZskuFJWhFMv9Iik3a0VoJ01BCJvQzUYZ8O/Gww671u5QCzjvwAu6H7
         iptNSX+7V6WFnOnbscnXW3Jt+JeG45yr8MDwrKksvYktH8IQhlgnAyNQXfSG7IeyxujB
         BzPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5PgOh4MKm9Ysku8H251/i15pXVhU7vwYYgGQfsH0l+s=;
        fh=k76FF3FR2QUGPylqRgQGputHo9YXktjALtaq4AIWRCY=;
        b=ET9B1W/8L5TNFoBnOwZNS7k85EyB4PzdiT8NLkXYIr8vPdFnTFZjvkTb4lW/ftuHGa
         4ttM2yY+EEEoEyMKwj5oHOVfl4Qw4U0/IQFA9d9sDu8lULannD6eHH+NzkSVrSja2WVI
         Uk/fJOx+yVmmH3sDQZ3+mECI/JNF9XQScULiQ2tG7yVXJ59E0eqf/FcHID5b1dW8WWWI
         Ox/ubMnBgC2xotp3GKZRBvXg5zipoERzEhrRhEq61y/E4oScpWAcB1rC4VJQEZtXPzsZ
         zrxDNggoCIR/eptVnpvqXhMHUhVRizXjN9OechyWsubbFJEKLA99oCOIemJ/PEkS64mX
         KYqQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777503431; x=1778108231; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PgOh4MKm9Ysku8H251/i15pXVhU7vwYYgGQfsH0l+s=;
        b=s6+wTPtgTjefLim9l7XmPkbkp54fyQL4coRHlf+58JbvrxA+aNOT2aX6gnMXnqb4VJ
         UIvTlDBVoyzAKbRuKRA+DIA1VGk4NCRYkR1Ao43VGfbGTss+vIzEoX/7f4znqPGtAKKW
         T5lmikKP1Um6ouSqMi6oe/8M7zZ+OhbErmCAi3pUzuqAByUrgwpsujPzIVACTP+DS0JG
         9IkWaohnRoobaYlavZpAR7jYu67/WxxV5+Laf/4+cBHWi7ttBNuQdxFns0u+hbrAh170
         tjpBScEkysKqZbDGUez8UQXStwsADf4+55g9msApM9SC5HfEsmHkVq8u8u+Uv9olUwx6
         1Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777503431; x=1778108231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5PgOh4MKm9Ysku8H251/i15pXVhU7vwYYgGQfsH0l+s=;
        b=HkT3h0px9lAJprCrb2n74MJ47t5HGNp/097YN2yuU3S6KmtgXHRUcl5loWDpGBBerN
         yHbidmU2+gyl9RaUUFu6pWCutxd5QsaOq0BQEY6JdDKQlvW7JaBSYe3U1nWQE6hlbXEB
         7MtrPs8cfNuqZjBS34ZbbDe39lEk+XS8CmwIGfVyYLVVzeiWIgrq2ZGk6tty/tSNUx/m
         aRU8SCq6p0qiNqjrCg+AP1fRLxp5w+FigJp7+5BSkfQ3gE/hwdoueLpfhm2IC/GbvW5P
         fjq9HYPWDTaafQTXfCpRnZC9eS0qhNnqoPf83lTDtwsg4aMigt6gTml9IGzOc5CRHdbC
         8pqw==
X-Forwarded-Encrypted: i=1; AFNElJ+bvVz9MuwToR4M3wrWmIvS8IjHHHxK0GryXSUOiAvqjAZMpu2WtfD5QUQKB5LzAl6uxTt4Og==@lists.infradead.org
X-Gm-Message-State: AOJu0YyPTtQSo0UemaLtsZ02Q3VB5wGzkQgkg6HN5wJQo6MSxf67wzks
	3dIq/y1iZmrLsMBu3EVH3ZcZvDY6dKlyC8NUdhgyaWJfk1DgU6Ov1ZCTy7ALQhsLN4KOiuQ6Y14
	HU84f4meondFuTqg32ALEHOiv/Qr3/ECodIMNzf6n
X-Gm-Gg: AeBDieuYoTsDLPC6yQ639KEr+AkltqOMUN+JH3Qc2pvXErH8TNgOWzSqWjcAy2DYQfb
	qxUd8U4W5m+aPftL+pd+LFuIyzMt8vgSp2qrlQkgjhO0NDZDEtXN8fWRBWOukzeABXXp3co1dld
	GtljXK1L/gKrXt111dnezzWDxedpbC6U+mhDsTyoOaSdfl0nllPH12mpmgIkJuMr5GAPS0c2b1D
	KT85Q3KKlATHs5pg4SOqNXMPWW6CPQz99SF7lGa5KOxJaobqdE+7eLdiAQEDPqLRxU/JNMTVQaz
	nCSkN4njFIYeQ138/fqBotd0oWosng==
X-Received: by 2002:a05:6512:1148:b0:5a7:4912:1a50 with SMTP id
 2adb3069b0e04-5a852741d7amr22979e87.20.1777503430946; Wed, 29 Apr 2026
 15:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-6-dmatlack@google.com>
 <20260427114745.00000656@linux.microsoft.com> <ae_J2pRWFf5qjZXb@google.com>
 <ae_SHCjNGrEPurzH@google.com> <20260429152814.000005f7@linux.microsoft.com>
In-Reply-To: <20260429152814.000005f7@linux.microsoft.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 29 Apr 2026 15:56:43 -0700
X-Gm-Features: AVHnY4Le9iheFK_YlZgcrAybDAS1kEhRs6kG_ymy3g2e8lI5OrgvcncvoFuHHPU
Message-ID: <CALzav=djG6T_NfwDD+aoobMfqdCkG0Xo8hHU2YkPc20uJdb-qw@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] PCI: liveupdate: Inherit bus numbers during Live Update
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_155714_918099_E66D85AC 
X-CRM114-Status: UNSURE (   8.66  )
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

On Wed, Apr 29, 2026 at 3:28=E2=80=AFPM Jacob Pan <jacob.pan@linux.microsof=
t.com> wrote:

> Below looks correct to me, but I have another question. How do you
> stablize PCI BARs? PCI BDF stability does not guarantee BARs don't get
> moved, right?

That's right, this series does not guarantee that BARs do not get
moved or sized. For P2P use-cases, we do need BARs to remain
stable and avoid sizing during enumeration. We also need to
ensure bridge windows are preserved.

My plan is to send another series to ready the PCI core for P2P
use-cases, sometime after this one.

