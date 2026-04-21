Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D387F8FA64
	for <kexec@archiver.kernel.org>; Tue, 21 Apr 2026 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gAM3zLbl9RAB5ix2RgDFnveQg42iFe43IZ/4vSwL0po=; b=nbtpN1tiiI8Ws466mh3Hjckbeg
	K8elfaBjAIiWWCANH7xKSDgFUYg78Spn5UUGp/k+zjqd6b6S+ZVWn9/DgbrPuwwGbooySoGt36a63
	WOT+KF3KFOH374cJg9cCDy39BeRz4MohkStbej3rsR1PAsDnYy5DreBZQ8V5xAGcZWtzkCQidWGlE
	/4Kq/3WHiPuGXZZ5Vriw3tHXWgGPrCB7B56v+m1QlS2K08zNkv+UX6dCfhFhVFxJ9ICotCqugK3hT
	e3LjZJm16vp7qybGrVOAysRWU2rbeqtGvvtVY+Pnl3KF81PPv5DcheZPUcaDuQPn5FMmFaQMgVguQ
	huImW2ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFF5v-00000008yxn-1Pss;
	Tue, 21 Apr 2026 17:41:07 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFF5p-00000008yx9-0q5o
	for kexec@lists.infradead.org;
	Tue, 21 Apr 2026 17:41:02 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-38dd9f11a09so42186261fa.2
        for <kexec@lists.infradead.org>; Tue, 21 Apr 2026 10:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776793259; cv=none;
        d=google.com; s=arc-20240605;
        b=i2CuMXUMGevRE4LkFzebnSrfU9S5KHpPsRGupEwfrdSxvgajtgPKuTHz6R7u0uqrUQ
         Oltv6rfSo05hrY+eMFxohl/4zAwbiEsXcs6whnswmqt+zk/4GT7qmnRKYwRbFOoM1xbQ
         TYXL8eR3CDmQImo+0+3wlfDPXymwNcZNVY+g3EikMNmaqvw2M+tiZsldXYwdsZEAGO7e
         /m7/cwqeBU84RJupYHsxPlGLr5olTHcI8t6d8MwC6xNH1w4t12YqsaYadYxbIs0mli/p
         ORsEyYSl4SKqIoviJKPhhFddRvBarSLAx/igER2sGpYHLO+nd968lFVEPZgBqGiLbn3n
         mLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gAM3zLbl9RAB5ix2RgDFnveQg42iFe43IZ/4vSwL0po=;
        fh=3UCdsTuKW5uUbp4FfoHkF8XPzCc9+0+IkbJmwvlAtyU=;
        b=P7+L/4LUMQSfTkVnzwNqrKt3BNCwt0FXsLHlxZvj0bLrw3QLDFpR64df+QzpoBofhc
         79pMUpcCIIBD3p7OavLPVEwCq4Z2gFhxTgndck/yHhNx2E8Be0ESRP6xVApm1IMMr/n0
         pgDD8zrljKgYAXRpEZHabG1i83MYH+I8FVGJSIp/D/MZvnD9n+89pewKY65p5kELqb3G
         pbVXv9USXvM4pIk6ee7ujFwTZ4u66JkUoT0uOfSUPT7NpfL5Ai502aaZV9iGqt9LQ7Y9
         9kncuzsbKRRC06SND7R00U3556zBJ+5XxKVa5xEFzO1SIgkmq/xCjg7vJ8jayRb+hX8O
         MOyA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776793259; x=1777398059; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAM3zLbl9RAB5ix2RgDFnveQg42iFe43IZ/4vSwL0po=;
        b=weaEyl/7yN9qi52uhAgLClimdwXYmdHgyVCfke7eCDcbFdlsMc6/F30OFeIm0beC/0
         NLVoc+GoLjvqNEDLS+lIN3YFd7ZLJwjtyzEL5mKqhfOIl+Zp8Nu4i+v8ZfVVP8tVW0RI
         KINfv3vijNd8MMd/M1NJX3d6Llwdm/QdswXpG0B9PfNj6pf9f1TqiLEBk3YJig2LNUtm
         T3Io/QrnEq9pjX3OUxDSJQSQBOaEmBfRaa+QWSjlFGnPd2lSj/td3fh3KsTDgS7gwozR
         e4uRwHdyN7nvyAK2eG8T3AyazHf3v7rMom+MB0imok4yAMXYda4ZzymddlHfTRmnfqUm
         c6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793259; x=1777398059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gAM3zLbl9RAB5ix2RgDFnveQg42iFe43IZ/4vSwL0po=;
        b=tYbl8F5rEsvfGz8VPpvqTIZvJmHr9M3iGc0wbp9V+vIT7uTe4iYwJR8Nwa2PDw0IS5
         QOeUnvLiSAxVA+R15tew/c95L/GiNmWvPZ57Dtk25XC+sah6zGZJ+FYmF/sXWb7NpCL3
         /jOS+qKmRZcylZoM0KdNYpVDP6QLS2KhMbsyXp3UtZGmLPcysf4luhjOAq7OiWosor4I
         1lV/iaf6xTStLforFhAEkM1hPl/AYIc77LpXUwTCQWJuG73umzsX/rytyAK9SpVpLonL
         8Zklug1oeWNkerzQ51bXmUqNSmXG+sPuyWaVK9NBujZajBj5gGKBflKM7guaSQY9FGoH
         s2qQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BZsdVT52lkuqO4KGP2GU67EcYVZXtfexhaHvgkqJnjrTxGgMjIsWavg7sVrz5l95lm1m1PA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyhuAMfdmHBbS3eJkVZZnfxx969ZxmoM8Lfpx0yCFV652woGelA
	pGEqiG+2qyTI2OuOywWLT+USy8sW19QqNQuIsFtz5GF0yA6S1hQCWFTB2xPDi+YMtdfi5rRy/lr
	uwh3qZaEwbvzHBUYI3NOP3b2a3VptbEFjDgLQG5hj
X-Gm-Gg: AeBDies5C3aqkLDcPmuzrEHU7dDYHoPzxWKtd9KuFlNuekOZvY5sQsBjrTJ5IYYpSAF
	2a8KfuLy15IY9hJCiDYD+6jmdHTJVvEN0F05/giBsV4x+P8HX1XBXipjdxzKGnfdKXqle+U6vZg
	UOyfaZsYWyJYw56RnfZsZQuXW3s+xglMofkpkP/aAGfjNR2iTITVD9Pksprj5mZGM8p5QCk8Mx8
	xE8VxXimwC9ki96uChNaJEdIBRRyb4HvShXOaDORltpG1gbF8XVFLZFKlTBcnOmEfph45aFEhfL
	nE/tmHcmEpeMznEvKU1HDmUkLQBcPQ==
X-Received: by 2002:a2e:a594:0:b0:38d:ed62:f1d5 with SMTP id
 38308e7fff4ca-38ec7aa4a03mr63977601fa.17.1776793258292; Tue, 21 Apr 2026
 10:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-8-dmatlack@google.com>
In-Reply-To: <20260323235817.1960573-8-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 21 Apr 2026 10:40:29 -0700
X-Gm-Features: AQROBzAxQqecIHMlVLo5_fKuOniGGCbgFfk1LcXxhbCrQbMNTrTkqomhARN-2eM
Message-ID: <CALzav=ehpWA=XchL+XLZuaYfYmBTPNWDYt1W3LFY5-6+US4E7w@mail.gmail.com>
Subject: Re: [PATCH v3 07/24] vfio/pci: Preserve vfio-pci device files across
 Live Update
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_104101_303926_05AAA724 
X-CRM114-Status: GOOD (  18.03  )
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

On Mon, Mar 23, 2026 at 4:58=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:

> +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *ar=
gs)
> +{
> +       struct vfio_device *device =3D vfio_device_from_file(args->file);
> +       struct vfio_pci_core_device *vdev;
> +       struct pci_dev *pdev;
> +       int ret;
> +
> +       vdev =3D container_of(device, struct vfio_pci_core_device, vdev);
> +       pdev =3D vdev->pdev;
> +
> +       guard(mutex)(&device->dev_set->lock);
> +
> +       /*
> +        * Userspace must disable interrupts on the device prior to freez=
e so
> +        * that the device does not send any interrupts until new interru=
pt
> +        * handlers have been established by the next kernel.
> +        */
> +       if (vdev->irq_type !=3D VFIO_PCI_NUM_IRQS) {
> +               pci_err(pdev, "Freeze failed! Interrupts are still enable=
d.\n");
> +               return -EINVAL;
> +       }
> +
> +       ret =3D pci_load_saved_state(pdev, vdev->pci_saved_state);
> +       if (ret)
> +               return ret;
> +
> +       vfio_pci_core_try_reset(vdev);

I think a call to pci_clear_master() is needed here to so the device
stops issuing memory transactions while VFIO is trying to resetting
it. Otherwise I see these timeouts when running
vfio_pci_liveupdate_kexec_test with Intel DSA: "timed out waiting for
pending transaction; performing function level reset anyway".

Sashiko also wondered if pci_clear_master() is needed to ensure that
the device has bus mastering disabled during the kexec but I don't
think that is actually an issue. vfio_pci_core_enable() makes sure
that vdev->pci_saved_state has bus mastering disabled, so
pci_restore_state() below here should guaranteed it is clear during
kexec.

https://sashiko.dev/#/patchset/20260323235817.1960573-1-dmatlack%40google.c=
om?part=3D7

> +       pci_restore_state(pdev);
> +       return 0;
>  }

