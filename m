Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3304FF46C53
	for <kexec@archiver.kernel.org>; Mon,  6 Apr 2026 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cOKcd1E+kh/rgDmBatc+5AEkevvJqYiqh34IKuXZ368=; b=2x8cUAEn5yNY/9w5wo61vVhpBK
	mfE1OPVKEWQvfj0Nthn5wQqPEvrYhf2yD0A5E8gcFZ3dI0LCIPsXGQIn+1TK+0CuiQyLS2eiVEVgD
	RDk4JZ2kTIAYp+HnxY5Mh7Euwg6us+4dejus3R1H0vK13Tjqly0cRhxpwRfT69BjVadloY6MqrP6m
	EknnJQYSshXuhRpEdRzBN8SSxaLBsIRowiBzbZXy25dzBjO2ydLGP5URomfy3UKtMOAyZAkDw0iwH
	L9nVu4qdcMFqkeCxc11nb/V5AbPThgu4xJ5Idhar/2rutTGxQQfxDsvqOpwfL0OS53md6sVZOKsWm
	h2tAi5rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9mTS-00000005Izg-20Qb;
	Mon, 06 Apr 2026 16:06:50 +0000
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9mTQ-00000005Iz9-1lFb
	for kexec@lists.infradead.org;
	Mon, 06 Apr 2026 16:06:49 +0000
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-38ce0ab821cso29698831fa.0
        for <kexec@lists.infradead.org>; Mon, 06 Apr 2026 09:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775491605; cv=none;
        d=google.com; s=arc-20240605;
        b=MVIeCznowsDI2qcjyZQPhPtHjJsodefx9/ZEc0D8vf0sRqldl0dqLMOW1w+9sod8fq
         F98dQopn0hnEDQP90+6Xu0fHjzNtW2lvsR752nPlYp6uUImrGNEo9PzgKIqTqr4r2moW
         YzcyPpfLUa7+VCN3Chb9T6mfGY1e1EHbJaKe3brXgTRGl8Evk0Rwiak/4yoXjdTSCKPo
         AubMPD8eXpyoSAVH3yVuvEoCLr75qnr5lhNNOLbu4rBnB04db086FOlKId/7izR0wiIs
         U1eUtiJNcFQ1IrWY8oIyWCS1noJ3GbTpMUfW7oJVfR+yohGotFqjrA3RYnSI5Pa24k0u
         w8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cOKcd1E+kh/rgDmBatc+5AEkevvJqYiqh34IKuXZ368=;
        fh=Jg5g2jLzFracLJUM38EJtnlNOuUFfqvxjwYFazMXujM=;
        b=aNm7rv+88xpV9wLBW8ttVqxKdUUdEQnKT8vT1AWiSfIzJtuSBX8g349hy28+/0nS/w
         RP0HuW7b0F2es0L3qK2w6VV1NCzT88vAwTvOotaOh6KvaZo4jgf+IeHH7wjxsufyQgO3
         EX2jppyA9K8XB4Oy6oXyNf0/CJVZ4K+ETESHAEmHsMP6R09FyerB0ucnlv5Ih6OlwXhD
         rrow/jPPmGyacwu6oKqMdyeW1nCd5twwtIgrhTXHISYZMa8Z30SLhCjmAviAdtDcCeta
         RtFhhzarc3N+X7Y1arDIO6WSnDPvmrHzR8/M/DPnEn02jJJaP2F45/yHJ7G7OQnwpyIB
         lUeA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775491605; x=1776096405; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOKcd1E+kh/rgDmBatc+5AEkevvJqYiqh34IKuXZ368=;
        b=ggxVs6+C7JmtabKWmXjy76FASQ9CoTEOT+1nM7EkEbOkvB5QY35zOncSUnO1AW1Imb
         VjWb9cTqStaXuNomJ+ITYxWrfCadDWTxzyxCSo0Oqu0/ZRS/wg2/ci1RkIjkvIsrexOZ
         wmp0zu95OVAhg7z9y83V70H/t6RKgm2oHxB98oKVLdvJZwZCBsuNmzAKuA9wSti42OVL
         w3yTzS+usVkKJujRKM4uOmliC1A+mz8q0VkSWircxAcTd4TUmYRca6e2jd0wutU92g2M
         +KIWk2aaRzmiOGW0B7NR4sQeFPix+1hvyZkpnYasI7WYQqusGgiyI2IP+7rDBNYfVFP1
         5FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491605; x=1776096405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cOKcd1E+kh/rgDmBatc+5AEkevvJqYiqh34IKuXZ368=;
        b=cTV713UPkoMHRQ6cK2tXcxAyw0tIVnR+f7dDT8qZlhIDlWKtPVtSEzhiT/NliAi+9+
         H8KprRTUkBmWZk7pyzhHPox3RnjJ0bQjU0DSW32QwM5gIjWFQIOVLQmp+tL93xgXe1Hh
         1QXnLN03a/CkIMO6RogH6MLMLpySAxOyWqRqXrmFYTV6VqxIcEG6kidULIn+GVJWN5Er
         BMMm6oecG2k6T+4Q3YQi90n8+3GvidDd5sBTvyYgEnnF7XYLhzJ1ibx2hLEQbmNQxpjF
         t+tcCfIqb8Gr5nN3+kHOMPrOssoyTWz06Qi9aV2M4bXLN4PShf6+Q0Hb7wJGjQ1LuVxy
         wFig==
X-Forwarded-Encrypted: i=1; AJvYcCWCF1vxH5ymIZUAlRKBWGZ3LEjPnfNKA3Hwcgd9DQ1IBic7/GGuePryDUB1U8NrAPOS+0aZIw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxAod178e3UR9wyim9UrWCLT29MMo6ZtgXQ9lkUWCQ2q08U21nQ
	IpJgJHtxnlJvYq2Q/UYbmYFL1/nyvHLDATG8lCAuNufQzNL92PjkM94WDSc2dmZMrCSU2bNuXdu
	yA5oNX5wFPiU6UKKE1t+RBwB7gqY4fWcnRCszXdmS
X-Gm-Gg: AeBDievOhXe0QuymLtojSOzwsoXt3DjWGqjGaLrA0FZiqlFHwk1lT9JtHEi69mRqrhJ
	XENXnIaB3J1uf7oqskvCvKhIX1knNUeDTRbQaj6/NbdzpUd/4nJ4Wjafoh+qgvWX7t1q8hF7taD
	EKJf56K6vUDT2iSH/eDP4azk0FyeVh3MZgD3dnyrD+tt/QfwQJ3KXRlux10S0HNF7B48WBVKROU
	Viuiu2jCEXqhjlbu2KdsjUAFq/2rPAK0KppTEo0g7dArJcU/pxa82C1S+l3UqRkXBljlQQx33oV
	SzRxBaDq
X-Received: by 2002:a05:6512:33cd:b0:5a3:d2ef:2f93 with SMTP id
 2adb3069b0e04-5a3d2ef2ff2mr3364086e87.30.1775491604807; Mon, 06 Apr 2026
 09:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-3-dmatlack@google.com>
 <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev> <CALzav=eyf4XRTi8MfE_GBNSm+tjmfX7=d0M8Aj5Hh0vJn7huew@mail.gmail.com>
 <c4138f66-edf2-4689-b5fe-16dc4839e9c3@linux.dev>
In-Reply-To: <c4138f66-edf2-4689-b5fe-16dc4839e9c3@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Mon, 6 Apr 2026 09:06:15 -0700
X-Gm-Features: AQROBzBbHlG2eO4NjewlbX-rvy8OZhgqlWaRP6spr5d6_KAEWYAdDGH-j6HkrWs
Message-ID: <CALzav=ei_xSfM0MTdPFhGDjNwe3EQ0vHPiEk=vszFX-Xi_KjQw@mail.gmail.com>
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
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
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_090648_511763_CF734CCA 
X-CRM114-Status: GOOD (  22.95  )
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

On Sun, Apr 5, 2026 at 9:56=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> wr=
ote:
> =E5=9C=A8 2026/4/3 14:58, David Matlack =E5=86=99=E9=81=93:
> > On Thu, Apr 2, 2026 at 2:29=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev=
> wrote:
> >> On 3/23/26 4:57 PM, David Matlack wrote:
> >>> +config PCI_LIVEUPDATE
> >>> +     bool "PCI Live Update Support (EXPERIMENTAL)"
> >>> +     depends on PCI && LIVEUPDATE
> >>> +     help
> >>> +       Support for preserving PCI devices across a Live Update. This=
 option
> >>> +       should only be enabled by developers working on implementing =
this
> >>> +       support. Once enough support as landed in the kernel, this op=
tion
> >>> +       will no longer be marked EXPERIMENTAL.
> >>> +
> >>> +       If unsure, say N.
> >> Currently, it only supports 'n' or 'y'. Is it possible to add 'm'
> >> (modular support)?
> >>
> >> This would allow the feature to be built as a kernel module. For
> >> development
> >>
> >> purposes, modularization means we only need to recompile a single modu=
le
> >>
> >> for testing, rather than rebuilding the entire kernel. Compiling a
> >> module should
> >>
> >> be significantly faster than a full kernel build.
> > I don't think it is possible for CONFIG_PCI_LIVEUPDATE to support 'm'.
> > pci_setup_device() (which is under CONFIG_PCI) needs to call
> > pci_liveupdate_setup_device(), and CONFIG_PCI cannot be built as a
> > module. This call is necessary so the PCI core knows whether a device
> > being enumerated was preserved across a previous Live Update.
>
> After the following changes, the liveupdate.ko can be generated
> successfully.

Sure but you've broken the feature. Now devices can be probed before
liveupdate.ko is loaded and the PCI core will have an incorrect view
of which devices were preserved by the previous kernel.

