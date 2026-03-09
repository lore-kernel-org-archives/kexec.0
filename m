Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62816EFCD9B
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mL+d40KjyhuL+4bMpXUsYaQzeUUDZaEOQ6AdzLVzNPg=; b=HmRUclqykYS/VMlfPkvG/vYb+d
	FQ1aHMLW12VQVqGuV4F8uMTYNpomG5FGjal6psh//9EFGMkqAQFfJmNT8XhL6pvq3qwYI+sXgNr3m
	2Jc54rxw8mmEKvzt3SZ8LgseyrqTp5TSEQ1SzHNExRzXNb3Hk/g7UUbITUs1JcbkwutGo5N73SNmY
	0guquBTiKBHDE19FGWmiwxQGTI35N3dS0tAu2piZqbb/cSEg57fBe0cziqk0bt1NaNj4OBLZTePKL
	6DwVWwiSsWF6QcsMqfe/vH8JeUfRfQczibjuOHg6v5tZv+ZXBQY6p4D8g70kMrWToTiQRYuM2KV2h
	FtcVn51Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzeTT-00000007pb3-44fS;
	Mon, 09 Mar 2026 17:32:59 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzeTR-00000007pae-0S1K
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 17:32:58 +0000
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-38a2f196cbaso48210061fa.1
        for <kexec@lists.infradead.org>; Mon, 09 Mar 2026 10:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773077574; cv=none;
        d=google.com; s=arc-20240605;
        b=eUDju/JJzfIczz5GlwPzS/EDkA+OwM+h6X9A5agWTxcaLp6vneaaC+sHBkkTN51Mos
         eWEyeblDQTXMT5pN/l6R3gr0AEeFXzXE0zD1diR6rXcKd43gVTDJVZx9qbTrCK2qAUJL
         /gzmOoqglUlXo9eh9LOr9BVL/rlaG1b3wg0eFPNjjZDBgJf8PgrnN2wOgYuhij3hQroS
         rVQoVaWgrqGCH1Uvxdz4CpmaP1Kr/IhkwycGhj4FFOAffYHIM2Gxz3ER6hU49hluz0WV
         0LZ/1inLgc5lVnG+eKdTcpQlxa7Ottu3mvcMhYUQMDoeYsKoC3mlTizxkGQY9/N1vUQi
         MonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mL+d40KjyhuL+4bMpXUsYaQzeUUDZaEOQ6AdzLVzNPg=;
        fh=covrqwqZzwWckkrb94+p3rSwJQyQ3+emY+431mrm6cg=;
        b=OTwHOvhGFK+9b3ZEsEHcKSjSz5ZkYA4jG+EwaQXIc+caGjEriZXyQ+cveLQei4SQm0
         +HPCRqzHDMYSs/vsSDDpuUWAtwO/TD9AILLluOp379aMvSQJEsdhpyxs+afiScO0uxKN
         Yh7CUNV5tZIn19qaXMfBKwkitxfDx4vw0O/pojSII2DJqlhZFZD9Tcmt/GbKZDjdf95j
         pAQBpzl0m2+QtI/0gDgxwHog2e35bYa2uZUMhkD9CfUa5S3CDBx2uM2+ypt3NDJkcn/5
         YHddvRaMHFZhquIOg1Ec9E9dj13+hGxsv/Fl4AAjh6CXH1pyPDv/sCxBBhLIzdhLntsI
         jgnQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773077574; x=1773682374; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mL+d40KjyhuL+4bMpXUsYaQzeUUDZaEOQ6AdzLVzNPg=;
        b=jJA5hMQnQTT+Aw9kY4yR15MWWpSv5ovXDWQN+k2gxMyxchnZRovzHJCSngrafTN5Sv
         8fJ2ThWf6QGTIlWPgmv+1pghPQWbzmr+flP7WOj8eVDwj0hu8vbGFDO+spQ/fqmJd2n/
         +Si0+T1O2cF7rzEEM5QuZxppTI9p506dEj8oW1D3UYplijaPJe1tBdQJ9wqcUrdMkd6i
         1Uc8DeMgaSAZUWfGbC+kjgsRdZ9cmD6/jCZDvWaKAt8t02+XWYA5qrZQ2dTRY9Gxdkav
         q/eS/zUGZkG37ua7LLnxj+pqvl3TU5DTcbWd63mnJ0ekUCFbpavLDShlmRYS/k62LWK5
         2NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773077574; x=1773682374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mL+d40KjyhuL+4bMpXUsYaQzeUUDZaEOQ6AdzLVzNPg=;
        b=LfBnZXUhesUsOSNS8KItJ7YPW0Ut19zTesZGdXh6WJTiepD9axbtMtujTnntXOoLVf
         uGvk7XyatVe3oa9KriSpbA3tQhSir73DvGb+MFqQY4VLU4D9DDtAMN/Ht78bWR4P6Fn/
         862xS3Jd+ggeDaZW8OXnMPo1SCkjRJ2x1MfUm2O3YgerdxrqLDL0vVX8g9ogBUTD9O7v
         TYPX5m3fFd+PvnuYFUrV5zlmW95jRvelDFRo6oh31Hdt7UMVknar2xAT6dxj+O9yONtW
         09kqwFN9teHVF+AnnN5gp3LVyTyNRkFaQuxtZujN2F4JPYjwmnx00FnDS4AzOqsT3SWJ
         vJZw==
X-Forwarded-Encrypted: i=1; AJvYcCU+3eIxniNWjF13+yUdsnS4ZvG9qxl4aDj1GHMWADw1rfgl0c4+QzyNhli3OFONV87HDeV+nA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwoOnRF+XFzafbKZfBWOhzqUP7B6j29DfSCfact3KkJmtpSc+Zk
	H5LfQJsggz0lep8QDU8dW/TPkzA/ryLfuX4OZHPvigIKtJ1q+X0NBT2QZmh5YHRyN/Lyjd0Rs33
	tCWFRyKAgbB7sB5Rg2cgw7CLM/DHNaGjqmu4qwo4J
X-Gm-Gg: ATEYQzyb2ZaIXVh4yBL8Psc88xIP7jl/VDO5LQN/7uZhhrBaJVIu3J5xNdC1U7Gh8k4
	hxqbAQbiJlswr8DhIoC1Z3iRyLwqNGbko/nfOg2Nc+6hIFK+n3aPmCrqWmCtKAFIqlffN9gqwk6
	m9KnVJsXDVDJVQz3VfMm6QJ+xcEAAG1gDff2MX0KBa++CUBK3g7XRPJjraV27yrKhIeuI5MrWMY
	n1bJxzIKRA2v2DzPQYkO8SejXwMD3DbFfR7fncYHR/CQ4GsUQ+J/wj+Hx4pCIZHK1mcTEBDDDNM
	Bj6aAiKB
X-Received: by 2002:a2e:9e89:0:b0:389:fc6b:943f with SMTP id
 38308e7fff4ca-38a40b72dbbmr31791631fa.11.1773077573745; Mon, 09 Mar 2026
 10:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org> <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org> <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org>
In-Reply-To: <20260227105720.522ca97f@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Mon, 9 Mar 2026 10:32:25 -0700
X-Gm-Features: AaiRm51UQkPGi_THgF8Q61sl9tHSSk61beTImuWL9a-lckj5dJAcnYvj7LG9bmc
Message-ID: <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
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
X-CRM114-CacheID: sfid-20260309_103257_186134_10A242F8 
X-CRM114-Status: GOOD (  30.75  )
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

On Fri, Feb 27, 2026 at 9:57=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Fri, 27 Feb 2026 09:07:48 -0800
> David Matlack <dmatlack@google.com> wrote:
>
> > On Fri, Feb 27, 2026 at 7:47=E2=80=AFAM Alex Williamson <alex@shazbot.o=
rg> wrote:
> > >
> > > On Fri, 27 Feb 2026 00:51:18 +0000
> > > David Matlack <dmatlack@google.com> wrote:
> > >
> > > > On 2026-02-26 05:00 PM, Alex Williamson wrote:
> > > > > On Thu, 29 Jan 2026 21:24:57 +0000
> > > > > David Matlack <dmatlack@google.com> wrote:
> > > > > >
> > > > > > - vdev->reset_works =3D !ret;
> > > > > >   pci_save_state(pdev);
> > > > > >   vdev->pci_saved_state =3D pci_store_saved_state(pdev);
> > > > >
> > > > > Isn't this a problem too?  In the first kernel we store the initi=
al,
> > > > > post reset state of the device, now we're storing some arbitrary =
state.
> > > > > This is the state we're restore when the device is closed.
> > > >
> > > > The previous kernel resets the device and restores it back to its
> > > > post reset state in vfio_pci_liveupdate_freeze() before handing off
> > > > control to the next kernel. So my intention here is that VFIO will
> > > > receive the device in that state, allowing it to call
> > > > pci_store_saved_state() here to capture the post reset state of the
> > > > device again.
> > > >
> > > > Eventually we want to drop the reset in vfio_pci_liveupdate_freeze(=
) and
> > > > preserve vdev->pci_saved_state across the Live Update. But I was ho=
ping
> > > > to add that in a follow up series to avoid this one getting too lon=
g.
> > >
> > > I appreciate reviewing this in smaller chunks, but how does userspace
> > > know whether the kernel contains a stub implementation of liveupdate =
or
> > > behaves according to the end goal?
> >
> > Would a new VFIO_DEVICE_INFO_CAP be a good way to communicate this
> > information to userspace?
>
> Sorry if I don't have the whole model in my head yet, but is exposing
> the restriction to the vfio user of the device sufficient to manage the
> liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP pushes
> the knowledge to QEMU... what does QEMU do with that knowledge?  Who
> imposes the policy decision to decide what support is sufficient?

Hm.. good questions. I don't think we want userspace inspecting bits
exposed by the kernel and trying to infer exactly what's being
preserved and whether it's "good enough" to use. And such a UAPI would
become tech debt once we finish development, I suspect.

A better approach would be to hide this support from userspace until
we decide it is ready for production use-cases.

To enable development and testing, we can add an opt-in mechanism,
such as CONFIG_EXPERIMENTAL or a kernel parameter. For example, adding
something like this to vfio_pci_liveupdate_preserve():

if (!IS_ENABLED(CONFIG_EXPERIMENTAL)) {
        pr_warn("vfio-pci file preservation requires
CONFIG_EXPERIMENTAL to enable!\n");
        return -EOPNOTSUPP;
}

Once we feel the support is ready, we can just submit a patch to
delete those lines, and there will be no left-over UAPI.

