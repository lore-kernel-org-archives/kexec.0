Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB44C5AD58
	for <kexec@archiver.kernel.org>; Fri, 20 Feb 2026 19:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nos4S2W/MH7DucXly1ylwYhWrSc0JMSiOmM7eQ5L0v0=; b=vzet2ypRqmvmoDt7AXbKWyTcop
	+OJ+AhMk7dSnGoY9W7n5A8ji/eoHaP9Kd3kT3phLFbnK5un6ApT547Hh1JG3b0KhcO2yrJLDnwdhD
	Q3J1L9r7ivDKv9k6pCgjjoq8B+akgNRWmUHecDujH1gS3lZ5GjJifGiFV0s1yeC16U11TvL6ZlpVo
	8/ROLnQrk4GgzY4NBlnuRvnzGVF9IqKN64mysAvccORQ1A2XOaGhr2YIB7XlGEzPnvHvnIlPe2e9D
	sBpPh2ajOg68IGfSl/XFuKMrbTNSmiINydOjGbGPwJTYfG7yxnuZuIw6qrxxTtj1wFK6sGrlSsV9G
	4jyRW6OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtVn9-0000000FU2A-2O3j;
	Fri, 20 Feb 2026 19:03:55 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtVn4-0000000FU1k-27f2
	for kexec@lists.infradead.org;
	Fri, 20 Feb 2026 19:03:51 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-38709888abbso19378831fa.1
        for <kexec@lists.infradead.org>; Fri, 20 Feb 2026 11:03:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771614227; cv=none;
        d=google.com; s=arc-20240605;
        b=IwWzg4Nr34xvXKx9lbJMtx4fQqUdNHCnTNUt9gjwb4N4YHn4li7JZjg3A0ArtV18v1
         Cru+P84j2qDYV1TSkNAg51jWJ/9Mdm4bmD0T1q6PA8TPXdGBYCmEn7q3lni0rhW/Kijt
         epQz9oOdrpf87Sf6icn8VOU5jfTlWLBtNnkw721EoqXAMQNLVe83DMGCaGu4EYjZRIzx
         8r2oqmYlNAZYkdt+vTYi5AedxPp5rZtSLQsvkM2zZK8XEUBa7BIKpQyB5Z/wuy8xGIDH
         xEY3IA+z3wjX8Ri9bU/PBAqzGU2KDfFfu9UXkkTU3K/Xs2sHwMpJ4VtXt8m/FlMRxThg
         /fEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nos4S2W/MH7DucXly1ylwYhWrSc0JMSiOmM7eQ5L0v0=;
        fh=DleMrb2+UiIH2iqug0RJI877dwpN5535JBdXJd/PMeg=;
        b=K4ARDzUVrVPMYP6+duzryLySdaXH5ZYKmfuHgTwWYEig/wR0NpfibhPB1xQDUh896l
         j1DJNAetGE8TZZbYhoxQdCEyXQJDADFVQe86+Oi6+7M9o+3T/aDLoSPlumx0A9wKg0iB
         ZKEtNfgDPwntmgW3l4b1vcWnT/9LgT0iXfhjtAU9NAv2LFbe/Bth1kyL5H9H5/Y3V5lE
         YJTwMGq+cTasOFTZr2dNpFg1u0wn+Xfd5brL8cf9tQEya5h2gxcZG/yq0OxLcMqBWBXh
         CJk6VYiruco4Ok0dDUHkB3VS5DsRldC2KhW7EFsYhnih4pMzU89GZ5TsolOoU0LbY2+5
         a1tg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771614227; x=1772219027; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nos4S2W/MH7DucXly1ylwYhWrSc0JMSiOmM7eQ5L0v0=;
        b=b41jz0UrFjTso4RoVVyUs857DVXmw9GajAbbgtCa7NuPrDKRELDzfJuwMtxQwADfMs
         Jat/bhyV998LiJs9qIT8zORHA5KpDoNaA6L4JCLkrln8YdW8uyBqWsVySsQgxkKyukHt
         rsGNDYeNhtHWyniLLHbElX1VFRr48S/pjbpdKVJO8Y4CGgrnqrjAeQ0gffpxJs/QIGTh
         XyC0nz7pJywFMX0OSfE+/HJvZj9r+xEesjW0A2JJdLSUB4NqzGbwWmOtZgJsiW8VG65t
         Z80VMT7eqZad+9YypQg8L/ZS40EuCHh13PuPDPvEeJvdW1KKWxbeF+zefxgHywWN4xUH
         NFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771614227; x=1772219027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nos4S2W/MH7DucXly1ylwYhWrSc0JMSiOmM7eQ5L0v0=;
        b=mTZGHzJDrfCB76p4r7Gc67X+aLrWuNQApiKOkBnIfE1c3U9wT+2HPPh7Zr3gHhel5M
         L3BcoXYewcEYuADjMdDvpRDIZCw0CUiNSYpJ/S9EhsrvCW4VSSTCdoQ9pP4nsAixBAzE
         6Yq6HQ5BQW4hoVkddi3PPgHX0vTmY53TuOqhuMpEhbpu8CIVuAnyg2mz9lAcNl3SKncH
         f4zA9wSyIlKGwhOl9Y7f66ICVYRbpXY//wCG5U8QDwkrXyXOGSanNV99yM2nN/O0eC+j
         dev5NUnGMdjooDMO6ePGZ93jHiB6qsKIMdodk/+kGAGqvEfjB9t76TB/gi76COQXqwbE
         hR0w==
X-Forwarded-Encrypted: i=1; AJvYcCX10unYOIlBwDIaqCSebfeRu7wCJrW7nSW4sTYq5s69lKkAO4XcI/18MoHGT6ZcfCpwddolVw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxBq2uzCXxDekksgGOjAuwsa3m5DZ0tcX8PjmkXUmUg1QWMzEPO
	rF9wO659ZlWeLPPf5QuuREX9VYQQeUCrWEISr9EEmcVGh05IZe6nMN1mjXPHRFruEVFAehTQ9Hk
	bARgFA6IxZzmJjbN+fG2mKXD+JVZf6KyB1qS/4LC4
X-Gm-Gg: AZuq6aJSmI2K9gz8TqPb9bsiyh/1u3aYQYqkobKKlvMcnZAiY0bb+8bvFLlD7ry0Nu7
	el/yoHj79vUpYTqCLUkXedsuREtEAsS/aQnP5EXVRr0ZQU/g7tEkp7mGXS2ccD4OKmNKVk8ZckM
	zDzvJHDq6pWXz6AWLmO1CFxWohD/oQmUodAHrGjdq4Dp7gN1wFIK00OIvtzXhnjp+OwrKNRSjMY
	xkEuvxD/coRsB6T9nKKOnFQrIkFQae5/9sOj9gcUpcgEYzEzFjAIsasuFeZQbTA81N+RyKl0Lv2
	NUWv56z77i0AA+ABlg==
X-Received: by 2002:ac2:4c56:0:b0:59f:8546:203c with SMTP id
 2adb3069b0e04-5a0ed894dd1mr165159e87.12.1771614226924; Fri, 20 Feb 2026
 11:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-3-dmatlack@google.com>
 <44484594-5b5d-4237-993c-ac1e173ad62e@linux.dev> <CALzav=d1ZrHrWd-HhZJ8aY6aqxkBcLoet_5+-LL1mOakVTj6Ww@mail.gmail.com>
 <7e49472c-4bbc-49fe-92c6-621e4675d882@linux.dev>
In-Reply-To: <7e49472c-4bbc-49fe-92c6-621e4675d882@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Fri, 20 Feb 2026 11:03:18 -0800
X-Gm-Features: AaiRm528gVDC51Vc6VmuyDJufgtIlxh6fV-eX6614wdRe-TzmLDadtAg2AEPmi8
Message-ID: <CALzav=dEykMZGsqz35TgvPqqZZFzG0kqojmry1Ya+Xf+zEgyAg@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
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
X-CRM114-CacheID: sfid-20260220_110350_615698_FEC21B2F 
X-CRM114-Status: GOOD (  30.12  )
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

On Tue, Feb 3, 2026 at 4:10=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev> wr=
ote:
>
> On 2/2/26 10:14 AM, David Matlack wrote:
> > On Sat, Jan 31, 2026 at 10:38=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.d=
ev> wrote:
> >> =E5=9C=A8 2026/1/29 13:24, David Matlack =E5=86=99=E9=81=93:
> >>> Add an API to enable the PCI subsystem to track all devices that are
> >>> preserved across a Live Update, including both incoming devices (pass=
ed
> >>> from the previous kernel) and outgoing devices (passed to the next
> >>> kernel).
> >>>
> >>> Use PCI segment number and BDF to keep track of devices across Live
> >>> Update. This means the kernel must keep both identifiers constant acr=
oss
> >>> a Live Update for any preserved device. VFs are not supported for now=
,
> >>> since that requires preserving SR-IOV state on the device to ensure t=
he
> >>> same number of VFs appear after kexec and with the same BDFs.
> >>>
> >>> Drivers that preserve devices across Live Update can now register the=
ir
> >>> struct liveupdate_file_handler with the PCI subsystem so that the PCI
> >>> subsystem can allocate and manage File-Lifecycle-Bound (FLB) global d=
ata
> >>> to track the list of incoming and outgoing preserved devices.
> >>>
> >>>     pci_liveupdate_register_fh(driver_fh)
> >>>     pci_liveupdate_unregister_fh(driver_fh)
> >> Can the above 2 functions support the virtual devices? For example,
> >> bonding, veth, iSWAP and RXE.
> >>
> >> These virtual devices do not have BDF. As such, I am not sure if your
> >> patches take these virtual devices in to account.
> > No this patch series only supports PCI devices, since those are the
> > only devices so far we've needed to support.
> >
> > I am not familiar with any of the devices that you mentioned. If they
> > are virtual then does that mean it's all just software? In that case I
> > would be curious to know what problem is solved by preserving them in
> > the kernel, vs. tearing them down and rebuilding them across a Live
> > Udpate.
>
> Bonding, veth, rxe, and siw can be used in KVM environments.
>
> Although these are software-only virtual devices with no associated
> hardware,
>
> they may maintain state that is observable by userspace.
>
> As a result, Live Update should preserve their state across the update.

Sorry for taking so long to get back to you.

Userspace should serialize the state of those devices out of the
kernel, persist it in memory or on disk across Live Update, and then
recreate it after Live Update.

This is why, for example, KVM does not need to direclty participate in
Live Update. The VMM serializes all KVM state from the kernel, saves
it, and then constructs a completely new KVM VM after the Live Update
using that state. KVM will only need to participate in Live Update
once there is hardware requirement. For example, I believe some of the
Confidential Computing hardware virtualization extensions require
certain memory structures used by hardware remain in place and cannot
be reallocated after Live Update. KVM would have to participate to
preserve those and reassociate them with the right VM after Live
Update.

