Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549A7F4BB67
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WVyG+GjslObEPoiorlcEtEb0lbImQuwl2+xBSlYjPvU=; b=GXbWyeF0aK9XWou2QiV6rGYOEX
	PB0C4rqcYu7Q48cGa3AVEuxn39s+sI47tSP+BLtJKgvopd/m/HFcZ8fiwY9Sjb5YanD1dv4/em9Iy
	vQJZhQ9Wp0V8Fc/Fa0baFpcZbVuMQNs9TM2Fs3mGPurkQnZcvVxIhjz9kz/1ovyiCVq3bi70PGxm+
	v8vyx9peaSXXcAfTASO0SM3iGoQOcWDKXkIyDc6tAYY77L6EUVh2GiIQtX4oETDFso/Bnbb5A116i
	yUOnlx/rVtMKfyv35FSNzM9oWI4WMk81JQVHb0Vb/MNYKSeljAMeB3S4dFxRCa63pK6WzQcpdhWFk
	ffBIiwVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuwLi-00000002V4D-2P1b;
	Tue, 24 Feb 2026 17:37:30 +0000
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuwLg-00000002V3r-0wTU
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 17:37:29 +0000
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-567404384b7so4073664e0c.3
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 09:37:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771954647; cv=none;
        d=google.com; s=arc-20240605;
        b=Xr+rzZidSvwPhrO9Sg3wUUJRBR093GvdwxDmsaH6r7pnKfBxZgbTmaPg/na9sHubYb
         VHrwdGctxDJtthooZ21mQYkXxXNs7PmKwyeb0cIRL/gTGu/b0gkQ6Yl91PLmcKopn22U
         tTimlq8+IWEXUTi+JTo8eFfs4R8UYzddd+NNYCIHFw4RRpD4h7hPMTfUuw/qg5VVjXCK
         KZmjxPmTSLahXj4u2JMxbvQT+IEcHI8x9yHISHuggJuctRltz+OYJvK8fcM9ONLDbb3j
         RobHd6RM0QiK+4Vu+wK4jCnEEoOfszsfH6mOdR6uvAaLc7wkfUjJPL1aza9HuiZSwC7j
         gisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WVyG+GjslObEPoiorlcEtEb0lbImQuwl2+xBSlYjPvU=;
        fh=7h7o2fPhmw5tHIS/k4BsbqBYekzrluv3nuNuFXKQGcg=;
        b=Sp+g/SoFvb0RN6vxQAlTsmPFc1yYwty9Gzw67RBnJiX7sA5inRagzHXWKlwxs9AoKJ
         8ObHAMr2yBIwy7k1iQABMK5xvORozoR4eKIvX0qNP9lvG4sjSd06LQMRlYDVvrqO3YtY
         OywbuajNZj9+A4OkebFgC0lxLBtC8hmKjMGnTc31+BQe0FMhXLznWUugLEm9mrCGzQfm
         uijwJjkzqNyCIUJvJeGNTPJ2pSnzja7mIoA0R991i/9Tie/TKFcO1HuuMuCbzrJmcHUR
         zM4QUu9k6schZ2xjnp/JMASx/Wpl6N/ZKydNshaQVWsVIr8gIz7yH78sSSWuViZ9wq6N
         iDSA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771954647; x=1772559447; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVyG+GjslObEPoiorlcEtEb0lbImQuwl2+xBSlYjPvU=;
        b=1A536UhD+G2Fu5JKmMCguN8GnyCzR7cbwxVwUMqT57gK+xOEKjTvWs9l4V0ruo3VHq
         +Shyo4zpWOLVAqNxlEX94m2aFTx/m737aZY9ABZXMX3EKTSaNjSQAVDgI/rmrKnl59ox
         UiooB8rmuEDrnAMawmzPewkbcGfpGT6yt6LA3dKoLX/WXxkvFyc7nkJYX2UOKnmO0H48
         75nFpUhP1sueYCFfOq14lCHC5Ku1Z60VVO6O4ZbM6YJOBa064fPKtfAloP+a9HENh3/K
         5xluxr95wGY/R+YZ+nMQ+UOPF+K2T+blxaBvWLJiZMcwHgfqKGUKdi4kHO3r77UiTEuu
         xA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771954647; x=1772559447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WVyG+GjslObEPoiorlcEtEb0lbImQuwl2+xBSlYjPvU=;
        b=S54xLKvmeEtNViyeMDBKB6posirdI3dKNADNiV4tOj4XXquIYkdJCvvlAKbMtwpFWD
         8fUAePE4yZRdPr0FIgA/a8oawW2ozv8QXb5Hwmh7BcWx6Hewm1X1hEl5T3saikuFseF+
         hmRCc+X7CHaejrjxSKjva18LrPTLcoTcrNxzgGXkzhwKYC7ju3zWRZ4q2ax355AWF94K
         IV8GSD3SlcoSiaiNNNbuxiRlH3yUIwScvpz7Qw4aG6rWwbDwU4NOPjmG3/fTcv9YIsx8
         ymNtqsnt7v2PPHACACKS3f3t6CIULXziFEBhhpiFr3zNjUcyYxtQIvhMZb8Blr7hoFSV
         dlMA==
X-Forwarded-Encrypted: i=1; AJvYcCXk2qkJGqZ8MWjzaihYlPuZcIrbh1UoMCDVOyzN/D8nTvGXa7YUVBBpvaWnBUIV/oY5NiyOcw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzFO4WHMSndW8jPcXhkX0+2lo6SB5Py5kQHCSv2w/k4URw3Nb5T
	HNE4OWnKkE72VlcJevYRhuxeX7HbvpFFoctorq2/oHIUGVOWS/MCkB3y2A2B8E7u/9CcxlbgqdO
	CeGdMIVU3MhHxOXjbH2F4y0ClIt7M9Zd+3a4kV2pt
X-Gm-Gg: ATEYQzwTe/4YeGNHnLe/iHj5gn17R0kdc68enJ6ZECuKw7JSApT26pBR8FbGXX+RO0g
	5yrI75DNogzHDm81fHSy9e6teW/4mgVAZAtYC2H7W/3Iuk+q4GTfjFU+i5MDPghcToirMW3Y+SQ
	InZutyOtVt7JhcukABYiVLUxU4nCZUwEsfcNijeFNMnE00TOG0R38TQnhpF8St3QZ7fudQRPoET
	VfozTC45pptT6p8pmepwKHmSnedLTS7wn//H10H1iT+3YohsSQ4vPQIizDYixMVdAytZaUbLSKW
	/PhypDY=
X-Received: by 2002:a05:6102:e11:b0:5f5:3835:4796 with SMTP id
 ada2fe7eead31-5feb2eebe4fmr7234443137.15.1771954646379; Tue, 24 Feb 2026
 09:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-4-dmatlack@google.com>
 <aZ1xAyN0vgLWIi5y@google.com>
In-Reply-To: <aZ1xAyN0vgLWIi5y@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Feb 2026 09:36:50 -0800
X-Gm-Features: AaiRm51zYRUGqNlquBQBjZ_Ao68Y3fgUdHKViouV8m9qg-AcIptaKIFOE6taQzc
Message-ID: <CALzav=cMsDyUrOPgkr5ouROPmsEAN2icsL266M4FxY3P6BNd1w@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel
 during Live Update
To: Pranjal Shrivastava <praan@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
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
X-CRM114-CacheID: sfid-20260224_093728_275746_9D334E2E 
X-CRM114-Status: GOOD (  15.49  )
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

On Tue, Feb 24, 2026 at 1:36=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
> On Thu, Jan 29, 2026 at 09:24:50PM +0000, David Matlack wrote:

> > +     if (pci_liveupdate_incoming_nr_devices())
> > +             return false;
>
> Following the comment on Patch 2 regarding propagating errors, the check
> if (pci_liveupdate_incoming_nr_devices()) should be made explicit to
> distinguish between "Preservation Active" and "Retrieval Failed".

As mentioned in the previous patch, the errors mean "no incoming
devices" rather than "retrieval failed".

> >                               while (parent->parent) {
> > -                                     if ((!pcibios_assign_all_busses()=
) &&
> > +                                     if (!assign_all_busses &&
> >                                           (parent->busn_res.end > max) =
&&
> >                                           (parent->busn_res.end <=3D ma=
x+i)) {
> >                                               j =3D 1;
>
> Looks like we over-ride the pci=3Dassign-busses boot param here.
> We should document how this change affects the pci=3Dassign-busses kernel
> command line. If both are present, the inheritance required by LUO would
> likely take precedence to prevent DMA corruption, but a doc update & a
> warning to the user would be nice.

Good call, I'll add a log message and update kernel-parameters.txt in v3.

