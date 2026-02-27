Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2147AFEFB6A
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y7MEfERrDZZYp0c3EO05mpNNZJ5XP1zAqLXvGoyft2Y=; b=oHwcQ5laxn8SVmM7Tnkti5y4MY
	l33OnMIwNKrhkIU8nTwupj3D4TKFDvoU+DJS5zOUd4MPcD/YXf4UEB/V+uDD0VC4wlZ0nvbdH+ATE
	2VlAegwh9hCh+JxrcOZh/y/6haL60mNGX/9Rmp9WPo0UENwAskvzJRpWAQkuhmlJJb3DiyyVl5MS4
	/umvNQE0Y6jaSoERgxByXP1qyhpjWeiyny+lRs1PPQTckr2Y8H6Htli1842W/dN/v+L+oO+Bj1wOa
	Hu2Vas0PkgkSPF897MDmwij6EUTUMv5f/AEfG4wUsVV/ABKdXhcZKBZkXNmx2+YNipnrVXAZGSEWJ
	irwifBJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw1K9-00000008m8H-2SeD;
	Fri, 27 Feb 2026 17:08:21 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw1K7-00000008m7Y-2CJ1
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 17:08:20 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-389f200c26eso25857401fa.0
        for <kexec@lists.infradead.org>; Fri, 27 Feb 2026 09:08:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772212097; cv=none;
        d=google.com; s=arc-20240605;
        b=LwNPKYsQ0OuK9iA3a5VvGbdjVF1EZPWuB5/pNXC98dhVlCMltpUjuwaBg4l85MrdIR
         IQ7AKx6gtfZg+IwmZiUw3neOxCgKPbhZ/sbtxTkQICQHGk2nWcBsf/OozPqHQR7OAfij
         eowZ6NmbX2jN1mm9E3eKn3+tfe3+PStFERK8ZlboUuu6hHuox1HOR7RVs9dRKoAMJHFM
         14BTSWI3MMuXQHwvF2bOnm09bPKxuGtnwU2bpocseUPrnQgWX9yC3rz4NZNPvd/pCQWk
         cXINq7ZHlCWzIeIKNKeyy5PAtGrKagOQVWo50ysMIRpevSercvYkWoERofOdYF7MT92J
         G+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y7MEfERrDZZYp0c3EO05mpNNZJ5XP1zAqLXvGoyft2Y=;
        fh=mkKcmVuNwrktEwUv+05rk4iRauFQCZWdd4KWowNNfqU=;
        b=g6Ls0bfPNGZh3lFQ+UCWPYZY9WtxcWP3TspetH26KoDwukIWhhSgEunJ6UX2Z1JK60
         +JiU4p2PAlyAuS1olMkH+aWaTXhNLDIUvSPDf/0nk255glaNc5/2zv2/M+hgSbHyE8UD
         vqxwQBmpSHdXwOU3VcI/ad4zj3My+EXQcjn37apT08OIcZ5X88yLjrr+5GqNMHWaiH9n
         xIFlWvcdiIAwrHaO9NPvCdpqYEYHoXKJ5No7JjCdvnsOKZ0ur0pBcf4pYilIeF23HZMK
         YToL5HcK7IaEhC4WjMETNsX1bqeRRh5cqr7Tt0R6/+ZBKeqnlG0kA31BkcY4kX3RB/0R
         JvYg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772212097; x=1772816897; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7MEfERrDZZYp0c3EO05mpNNZJ5XP1zAqLXvGoyft2Y=;
        b=C4wVtOokzKrbZfhgBmGOV0l2YLxztPrZdhFtLHibPppd29oq5PnwlIgL6SjI4sRcpG
         FbNUHAZ0iEX7H8NJUntaT2gglHwEsNap4Dmm7cD0uL+Os/DnLtr6hV5qYa8N8z45B2ql
         TBkxJWCgLxuMInUxnKyztqVXZ0xZDm0z5h5EY8pV/eUO2qbahyMjQO/sQdoa6OvHYmxf
         gcKGASlUCZ4KZAKMrkEoAWV331bc04AyNW81JqXOmA2YlJASHmOebq3YfcCQ/VgF/ds4
         OhF5+fkudEGSEFOs2XSIEpzIEz45XkRINs8/sm2g8lX38HN7rfwQTZSrexpN0obtM6dF
         m5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772212097; x=1772816897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7MEfERrDZZYp0c3EO05mpNNZJ5XP1zAqLXvGoyft2Y=;
        b=eLNzIBUdA+s91QzTAshxUtbaeCgLkAs5zVeFLmeL1eibjPKZg9cUWFdNTI67K9+8YI
         sqpzt5ELc6lS5DwpJNLC/rRertbOHItgsBNO5h9QLUjxN5FOPdKpLaiupgf1tsqArh35
         gPI31LQ+af19qpg6L8cbxqJCKlle6kwiLCbzJ/crMtXhJgiM6Qb8Dsmgy0/Tdhztw4UM
         CVm9v+7MsBSc9lV7EQKKPfpN/d5y6kDuw5c6CrETxpaSQLqX/dkLGU5+jp+aXcV3st/c
         J0HSQZOK18Bry9a9ADeHwsHu0QeTqexJieJEsbIebtoZ4H5gRhBKXlbwrAG8cixdOCoF
         jVJg==
X-Forwarded-Encrypted: i=1; AJvYcCWMYIBi7ItDl3EMc764IGsxNP8scSsgOPBH6mve7mW/FCtmWZ6ehsu2XUhlfDNwc+9IkcAFrg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyTXCTRw4PLyU4aEyJ2Nr5aV7JQ5eWf0pESjwWop3+N3/Tf/Y0Y
	mXfh38DSSWdglvqWHe6d6K7CK5Vx5zZyFJ7WTW7LP8NKawvORtHHKFx1GxA8vUEZO6esXdIwCRb
	E9cTCYjiv4GCssWu1M1lEkELX6QsnZoBKz3l0rdfq
X-Gm-Gg: ATEYQzyOE7jDa5eTr/zkjETuTuQp4puSnpIxfEsHpqx8/6w2n4Mox6SPlFT9JqDY3cB
	73+KuZbnz/XDkHSm3bJekSW8VtDDu4ExapZM2105oMrKWM1Dw7WgsV2s4N3bkU06N78nUk8DCl/
	MzELKh5pfr1PV7dphoDcQAgDZjGDFzAgh6JweXeREUxY9bWu7Nn1vK1sMXgRxJ/yxCUzOhfaR4b
	L+cUQr8JGZldGnkggdY+vsnbcpfCXRxNQG2OwJL6i2CbNiWgH4ZonMA4IfenBNkzRlgIYleyunz
	rMI42U0Km8JPWY8wqg==
X-Received: by 2002:a05:651c:50f:b0:385:f7ce:f321 with SMTP id
 38308e7fff4ca-389ff15f271mr19911451fa.26.1772212096622; Fri, 27 Feb 2026
 09:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org> <aaDqhjdLyf1qSTSh@google.com> <20260227084658.3767d801@shazbot.org>
In-Reply-To: <20260227084658.3767d801@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 27 Feb 2026 09:07:48 -0800
X-Gm-Features: AaiRm519T9RurPcNiWyO80VEVhcFvT0_H9lBfATMd1KVW4QtGFBpubzCvVI4oqQ
Message-ID: <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260227_090819_613022_ED16A907 
X-CRM114-Status: GOOD (  22.80  )
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

On Fri, Feb 27, 2026 at 7:47=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Fri, 27 Feb 2026 00:51:18 +0000
> David Matlack <dmatlack@google.com> wrote:
>
> > On 2026-02-26 05:00 PM, Alex Williamson wrote:
> > > On Thu, 29 Jan 2026 21:24:57 +0000
> > > David Matlack <dmatlack@google.com> wrote:
> > > >
> > > > - vdev->reset_works =3D !ret;
> > > >   pci_save_state(pdev);
> > > >   vdev->pci_saved_state =3D pci_store_saved_state(pdev);
> > >
> > > Isn't this a problem too?  In the first kernel we store the initial,
> > > post reset state of the device, now we're storing some arbitrary stat=
e.
> > > This is the state we're restore when the device is closed.
> >
> > The previous kernel resets the device and restores it back to its
> > post reset state in vfio_pci_liveupdate_freeze() before handing off
> > control to the next kernel. So my intention here is that VFIO will
> > receive the device in that state, allowing it to call
> > pci_store_saved_state() here to capture the post reset state of the
> > device again.
> >
> > Eventually we want to drop the reset in vfio_pci_liveupdate_freeze() an=
d
> > preserve vdev->pci_saved_state across the Live Update. But I was hoping
> > to add that in a follow up series to avoid this one getting too long.
>
> I appreciate reviewing this in smaller chunks, but how does userspace
> know whether the kernel contains a stub implementation of liveupdate or
> behaves according to the end goal?

Would a new VFIO_DEVICE_INFO_CAP be a good way to communicate this
information to userspace?

> Also, didn't we violate our own contract in this patch by adding the
> reset_works field to the serialization data without updating the
> compatibility string?  Thanks,

Yes, I will fix that in v3.

