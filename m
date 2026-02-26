Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39449FD45FC
	for <kexec@archiver.kernel.org>; Thu, 26 Feb 2026 00:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ACpb0o7E3VaAsC1KFvr2yXYuV7ohO1EROiDs9rJDa00=; b=1Fu6rR3kLM530/T1wGPJrS5ayj
	Nmc+UlgCQYkD7cMAeZ/qz7YmGPkgZ6llKG134V1U39BPFaeyNbD+7Mo97GDbWj3rUJciLf1wFTxad
	r0nv9YPsafaEjFALRTAFOVnh0q3h6dj07nE0K4nsjJV0nC1tKol2Mccy/PPz57SwHsxmlasPYN79/
	Dw9UofEcsC3oPFIeGRZle34tQqd1wBOBqX0/H/+UreAXfnLhmRSYgwLqjP2Rbx+ZsO61vRlXwlH1s
	/Bp8MxZtXTM5VfoyZ2B4iPKATvpcn8mYHyLbC4wptJNpVnPf9Ix8tssiUxQa+uk5yDoLOuVFJe1AF
	5tqfdIbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvPWN-000000059hJ-1qw1;
	Thu, 26 Feb 2026 00:46:27 +0000
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvPWJ-000000059gy-2Ms1
	for kexec@lists.infradead.org;
	Thu, 26 Feb 2026 00:46:26 +0000
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-56a8ebde349so349632e0c.1
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 16:46:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772066782; cv=none;
        d=google.com; s=arc-20240605;
        b=lVYo4KtSjI+kbW1Xe6n/d00f3SjzhMUrWiAtd6UbNJ4V46YOMCDZEOyuCdok8FKsSp
         b84QWTKtfNcff+HO/kjGlZP4NM7nsPfxIUd7lFH5xeqgd/OtYp3ZapkTn0ZpF27ahp0O
         D620KfTvMxmtH3Jf4U9Uuf9AyaPPTUQ74z050NIzmzeVIWDr6aCTv1Do/EXORFa+ICZy
         eJZkrfYIy/sYOigvK5WjiqKF1Whx4E29N9wR3dih3RrdF9d0ULJAMvYCRjzZ9VhiWeqn
         lO0ugN48pxGak425rny8WniBccR3jIAhHGaDUh+G+UNqbome1bbol7cVS1O9w16hPFAW
         oC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ACpb0o7E3VaAsC1KFvr2yXYuV7ohO1EROiDs9rJDa00=;
        fh=EKSi2aismS30NFMaT3P9+KJ/qYqHiCXM/9bvdKkhPLA=;
        b=kTPt9OC/JKSa3bhvncmtztRw0wUtPSCC7TqZZhLEu4XyOMaB0x2emb0i5KUeRoxFOi
         kDH23AXJZdAu7WyC09yJS25Fz3dBCC2PvOWHvt2o95rGhQlUxa1Om2P1Q4WyxZczbukt
         f5aZLf+k25vlNNJuoOz7dE7QczkFJ0Fr0NmAmJMHBBcl5OEep6zVNZ+VBGujQ6d/ZaO4
         k8TKbLyfZyn72MvawVG9VEmaZc319uvGIpo/nUAwR2HxmfvVUIlc2t95FxiHEb1gAoy+
         L77jov3UJ+9N7ukDLmE8ah6hbqVpkYIZYFc2NISilCDw+pqKcx28esuvWOa8o2XMMZ8B
         0MLA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772066782; x=1772671582; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACpb0o7E3VaAsC1KFvr2yXYuV7ohO1EROiDs9rJDa00=;
        b=MIOwjXiJG69KuLycaAHba+wq8UC0cYcAWpFNStQU8Ge2/2vz0aT6YK8QbvXpc0kRj8
         rmWcYQNWaGS7xIlk6TJ1L8jB63jCbskRqd2Ubj2rIWJbasN7BU66BSYHizuapd0BQiWz
         yLcWtOQeR3qUn8wHWJTts6MfQIXk876ICjkockA5DJkMrrlWoP+pZk8HINL0/s/py1V4
         7dMiqfKXFYMH/D1ZuHEWp/qBwrLFAejQWGmVvE8NBvA3ZXFeQt9PAgMysEhI20kSYnJG
         V0CloPH1+eH3B5vvSz7yXDyHuAeN+jSKh+e8M5cYy67QwwKMS8GRAxtLVT8xgkmB4j3Z
         qDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772066782; x=1772671582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ACpb0o7E3VaAsC1KFvr2yXYuV7ohO1EROiDs9rJDa00=;
        b=rRWMDXSpxDjgnVp1I8QJkdBkzz+1FG58bk1aU8rtFul4p/l5duArB4nIP+XAAhciMi
         5bwHeaExXVCzebd+Qm05ZUDcgxbjU+RKuZY10PkBwPSybjIgXoGmKHSCrvMGJFKwhmGE
         joTun7Gd6DXJnFKO8Pc+L9pvR5GX6v9CmC3FIdExIB6zQ6P9aGwxm+FiIyQ/F0TJkvLl
         xv+ApPq1vGmF2Ay/9Oc+86EvuErLjneI6fT1GdDwRmAN/41G8O1BaS6dnATUc5EGmrNz
         sAU+Ssk5A5HfG1fY5XSl3lQiYZ3+Dvo7rhJqciPsJ7pyCrcmsHH5nVAUGWVn64hlFJme
         Yo0w==
X-Forwarded-Encrypted: i=1; AJvYcCVH+OSzSHhEevrw5/zP96TpXw46mZbrajTnbORwZDbt+4N/vqS6N9suCZ4iFXWLGpGLeOmlcA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxN3/jJ4xrc8nX211k9KAoIvONp5H0wQ0LLE9Dul+bc7vt+RQUr
	HspKyT0OeFnvfLj+c5e4ZKRSHAQ/0PN67KaG62WhuyJGqqFH0VQ065Y/4lnde9/PcMHDFQNagTd
	UFKhQthvpMlgiSVUhAePDcBcJKrHAHSkW7MBly9u/
X-Gm-Gg: ATEYQzxZQrY6e9x3lzV7ScqmP0116OqysAwiK56K2alo0aibxa10jL9h5gIAU19OzdS
	LhkkdpsNs+oKAMG1mQVT0VaezKUU3KlrOVAziieycKgyDrkIY5wptvQ+rFVMRDqJTxiC8hBW/ir
	LyNmKA79DsDQGeyh/U6BXsUmawrgRTkRaDJdNVuMpURrqkhQhDyBHzHQBkpea4HRR2E2h+Ovqxg
	E74D8tUJqZi7NRWN7Js7+Qnwz4Rky4NtVHxVY64bh2P5P7OqaLxWlheyGdYEStaEBI/NIvo8k1P
	UGsRCpY=
X-Received: by 2002:a05:6102:94d:b0:5e5:6eee:8adb with SMTP id
 ada2fe7eead31-5feb2e8f35emr8956594137.4.1772066781725; Wed, 25 Feb 2026
 16:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-8-dmatlack@google.com>
 <aZ6rB-zmpaR3RLB_@google.com>
In-Reply-To: <aZ6rB-zmpaR3RLB_@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 25 Feb 2026 16:45:52 -0800
X-Gm-Features: AaiRm53bfmGZyNFLKGENFMQ0ksttnoZ823ayheFdxpLxg9pxKiAgxb_V1e66-JA
Message-ID: <CALzav=fQtLd0DfWcVku1BDUzcvvYu7MBY+=G7rMMr-gjLUioAA@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
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
X-CRM114-CacheID: sfid-20260225_164625_294450_3971B4DE 
X-CRM114-Status: GOOD (  12.94  )
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

On Tue, Feb 24, 2026 at 11:56=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
> On Thu, Jan 29, 2026 at 09:24:54PM +0000, David Matlack wrote:

> >  int __init vfio_pci_liveupdate_init(void)
> >  {
> > +     int ret;
> > +
> >       if (!liveupdate_enabled())
> >               return 0;
> >
> > -     return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > +     ret =3D liveupdate_register_file_handler(&vfio_pci_liveupdate_fh)=
;
> > +     if (ret)
> > +             return ret;
>
> Nit: We might need to handle the retval here if we remove the
> liveupdate_enabled() check above (as discussed in patch 2).

I think you mean for the below call to pci_liveupdate_register_fh(),
but yes agreed :).

