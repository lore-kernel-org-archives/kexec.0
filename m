Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7078E7DF19
	for <kexec@archiver.kernel.org>; Mon,  2 Feb 2026 18:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LIHmbN0vtM4SeA7+jGmffdOqzfQaVyhc47MhdLc1+1s=; b=Eiumg0c8Nj74y/Piyqloqt1FTi
	5idNOgcyoVXo19MYM5i3Y4cH67d7OsLzpwrnCNGcCO7RUJUy/r7MyDMp7A4ZA8jMt85n00ocGh8So
	n1zeiqHTS3aFADzITCV7yAQVoVTIKOqjwWVBZTegjQePjYqvh4RsyuFeJceJFF+3HyKF6z0QGTnUI
	byH7lAAkoE7+26ts7hdHqYCLf9cIVsj2Ielzaqppug2zyTW/mBDucNcqn5Z4GZfmyRf8gAhfqPaNJ
	xBztJtxmgNparSnJ56IfjIPSSSqrBT6jeW4o46/6nGpU8Sol3neCxtOrF5qQBitt4O6TSGNB08Mb8
	Jk9jD3JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmySQ-00000005PeI-2I1a;
	Mon, 02 Feb 2026 18:15:30 +0000
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmySO-00000005Pdx-04O6
	for kexec@lists.infradead.org;
	Mon, 02 Feb 2026 18:15:29 +0000
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-385d9fb297dso48070981fa.2
        for <kexec@lists.infradead.org>; Mon, 02 Feb 2026 10:15:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770056125; cv=none;
        d=google.com; s=arc-20240605;
        b=WY4kGgGnVdqoFtccmb99eMP1pYI83Ydic5QnZGWAskXjmL8Fwg9FoerbCuNWJCgJqP
         QwozLxaNFuUZWLhxf0n1pm37J9TRS7GjRCiZWt9SuNfWVG9RdRQAFSgqs1/34WCwBPZ6
         BAW+eVsOqUbBFIZQhLjnqi7PMwmvm8r1T11Bb6XztfNSf7YyaOUd1xa/QRgy7xWkDBQ9
         DfbA9oEWqJPbbOPfTZr9pDtgWHpAuGXtgH0LOnBIr6qMVN8gihRenhrQ1mIUL6/hCO5u
         bLXYqdi9Tn0kTKTxYPU00dIHPGE74FlVfw+N68zcaW5vwQMcmC+yhQUxpwbBW8MyFCOR
         cwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LIHmbN0vtM4SeA7+jGmffdOqzfQaVyhc47MhdLc1+1s=;
        fh=rN9+LU7ZBYRzGBBUKy3bdPTWV2LcOZUwykV7jGUbX98=;
        b=KluKg/+o32Enw0cEK0uTy9Hk8+uM2Uj4Flkj12at+03NTSUisxhwRK1S5HJmMvcANr
         rs0QZzDKwg6Ku8HqKQqusqx3JTgMmib0DaqFMUmz6WbOKKWp5O2obm3ZQ+mzA8aEbUyf
         1uxEtC0cUxN47MqxxlIkVYrwCV9IuejDR5o0dYmFF7fB6/QXzBad+92mnYMsqais9Jlw
         ee8pSEwBqN7p/Lunu3x9N8IFsh3Ie4rYZ2Fh/Ic/YpwYRb3s+ivvSj//16WE1IFwjVAS
         ttr26qTii985JBZrxD1NFNdrpvFto86usRcLINf3r8kiH3ukIRUwUSqty+gyx6H/v/5c
         s5fg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770056125; x=1770660925; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIHmbN0vtM4SeA7+jGmffdOqzfQaVyhc47MhdLc1+1s=;
        b=qpdAIdVLUyqdoz8CXYUFequ6ppOCmgO3xSbbHwKI4d5crFYA962rbv1AYp06Bs3hYf
         o5rZxXJdkUMe2syjS9U3xtGj2MOwmk2L+CY4wEOrqK16hQ/HaMsOxWA77mb5pW64NrFW
         ms5lPnLec5jlGqbm8sZTObEO9bvLWebNZzbd6pbJ1rnh/20ofa6lI54WyaBUQvT8DjZx
         u3Cg/3baepxU21NaTR5j/CWP7wri5Mpt+24iE+XASAircMJ1md4/iyfsHnQJyc4b2wLy
         YyI4m6jxndv3vuCncYK1xxPCD9RnfVN1kKJJbP0MnQIQwz+CQ16y0R7MhHq3vh9PZbxA
         XWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770056125; x=1770660925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LIHmbN0vtM4SeA7+jGmffdOqzfQaVyhc47MhdLc1+1s=;
        b=CZBOGgMpqVWZCcymiTnG2MN+GtD6ltdqO65HGd/CTWuDVBm09lJLZQBItG3IM4+c1P
         6Rhaxbo0tnvxk/tkJAEeYzIhDGsgJWLSG9AEd40REemOi5Qn3R27VzbOJeZ0GT9EuUlG
         LqDxnYRhF8xzVwH09zNI5qv4oyI4GIiWIqp26hubF/86OVATPbn2nhfGnFeEZPYZzGbW
         BeZDkRmTiaUE87wIe7QDQDlSAB7lgMTXqHcmbKu5skn5fyhzsCllplKyv+fQE00IQv24
         GKb9yX+Saqaid5qf/2HjfXv65yhdraydrapqSYIO2Us5WAjUPMj79smgwMgzY099b4GI
         hvcA==
X-Forwarded-Encrypted: i=1; AJvYcCWOQsu1beb7/W3JKqeOBiVFZcpAwC5QZLNi4drQbiU7DDEF05jH8mtNh4qw+t8QGNko5ikXGA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwgygSwIOtBnA61XbXA5+3dOoZ/kIovG7/IQTe4rqs2ndf5xKaX
	Flv7HKekPwZ8CmKnSQD6rYLSVduH7+QETbzoeINRns3/SA5X6X/3loPixDMhTIh6EYfDeeEYiB3
	z9ENMWlbamvaYm4Uac+rF9CQ9wV3/HlGNnbJY+85w
X-Gm-Gg: AZuq6aLwiB7YllyUqr9cvIzsNjioT5ZEXtMQcjISpvO618HXG6fuqHCjXR2Ih/l549T
	abtrED0tyxSbSJxfawHg6WTohPjKJz0lk92ukEWCcRARbzlrzHsUB7V3EmCWjyQTmIkMjqk00BL
	Mix52DIZFPoEcTTSBx3aICEcRIkvLfIDrnCXDTLraA/QyIc4vcc6LvUS6fI29Sj2bttldpqogQM
	n0NoPjJTGPK/9Zk2iBlimz5phzxM/NH8ndb9uL79Om+AuMwe1ogufRPxURu3ugRgmQuRA==
X-Received: by 2002:a2e:a54b:0:b0:383:1c18:ade6 with SMTP id
 38308e7fff4ca-3864662d728mr40696471fa.20.1770056124374; Mon, 02 Feb 2026
 10:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-3-dmatlack@google.com>
 <44484594-5b5d-4237-993c-ac1e173ad62e@linux.dev>
In-Reply-To: <44484594-5b5d-4237-993c-ac1e173ad62e@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Mon, 2 Feb 2026 10:14:56 -0800
X-Gm-Features: AZwV_QhgTJZ7rnxODmCU1qhjsI1pWSHh1k-rPTozueyr5OUveeJ2FC59ISanCNo
Message-ID: <CALzav=d1ZrHrWd-HhZJ8aY6aqxkBcLoet_5+-LL1mOakVTj6Ww@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Zhu Yanjun <yanjun.zhu@linux.dev>
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_101528_323708_E1DE6EF8 
X-CRM114-Status: GOOD (  22.46  )
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

On Sat, Jan 31, 2026 at 10:38=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> =
wrote:
>
> =E5=9C=A8 2026/1/29 13:24, David Matlack =E5=86=99=E9=81=93:
> > Add an API to enable the PCI subsystem to track all devices that are
> > preserved across a Live Update, including both incoming devices (passed
> > from the previous kernel) and outgoing devices (passed to the next
> > kernel).
> >
> > Use PCI segment number and BDF to keep track of devices across Live
> > Update. This means the kernel must keep both identifiers constant acros=
s
> > a Live Update for any preserved device. VFs are not supported for now,
> > since that requires preserving SR-IOV state on the device to ensure the
> > same number of VFs appear after kexec and with the same BDFs.
> >
> > Drivers that preserve devices across Live Update can now register their
> > struct liveupdate_file_handler with the PCI subsystem so that the PCI
> > subsystem can allocate and manage File-Lifecycle-Bound (FLB) global dat=
a
> > to track the list of incoming and outgoing preserved devices.
> >
> >    pci_liveupdate_register_fh(driver_fh)
> >    pci_liveupdate_unregister_fh(driver_fh)
>
> Can the above 2 functions support the virtual devices? For example,
> bonding, veth, iSWAP and RXE.
>
> These virtual devices do not have BDF. As such, I am not sure if your
> patches take these virtual devices in to account.

No this patch series only supports PCI devices, since those are the
only devices so far we've needed to support.

I am not familiar with any of the devices that you mentioned. If they
are virtual then does that mean it's all just software? In that case I
would be curious to know what problem is solved by preserving them in
the kernel, vs. tearing them down and rebuilding them across a Live
Udpate.

