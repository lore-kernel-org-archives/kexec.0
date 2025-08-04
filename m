Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A76CA0FFF
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OwTFCa47yjLyOw4GeTmYZtCVh1CzB3NwU8kncZE+7No=; b=EEpr+jzQ3fC6egOJHfWZ5XZiGU
	KP9P3RtclyqgUywC3KZ7PovcuM+HpmWF/lOkVAh1LeGszp5WJHqbiRxv8an59adspHknQxngmt9ze
	rVCOsdeNYMz6pt4ABXxEPRTgDRYYWPmj852p7St+F2Yc17CsiUMgYNYg/piGKVMHGZsGUkfNlAJ/g
	RewrIhMrt8vWZxg9wm4jDLTqFnq1uHS1ypLKV8eBLPN8czqUR+nFFI5bZzH3pokB6Vz9ldcAzs06Q
	DlLRy7GgrFpxMZh/kuA0SAaqnMis7tDot9eyv/M9geCRl7xkYjG93hMlTiDuaaBp3qcXyMVGVFcKy
	TG6LKwwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPg5-00000008G1s-0kwh;
	Sat, 30 Aug 2025 17:47:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uj4Jl-0000000BRfH-2zug
	for kexec@lists.infradead.org;
	Mon, 04 Aug 2025 23:10:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C516345EBB
	for <kexec@lists.infradead.org>; Mon,  4 Aug 2025 23:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E42C4CEFE
	for <kexec@lists.infradead.org>; Mon,  4 Aug 2025 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754349008;
	bh=OqU7HKlaaB+/yr85e8O0qFFV2mhIIMzXHyes2/pyXiM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=emQpYAhD7UcEV34gva/+Tj2Gk9HQNqUdMMzPJsgGAVXqLM/GSpEW0RmrusIHZTWSQ
	 mEV05f0QR6bajRjLIlWSa4IZkibAVyg4gSoG1hESJs7QfWJCgW+96Fhmr1oQfTfwpl
	 nIHxlfFJvZrseS1hYf6Q3mjx8ENyoaIVdtOIGJqNpVL1n4lK0bFMm8V4jnzkU3vH/b
	 tLPlNK/xDGtMOmbSsd4E8WBwGr4Ke0RfftUuh7rvJZlwnP4K1Ju/4GTwr2NXN4YQri
	 iuNdj9ZHC2K+Angv3b50xnFEgKLlXyjSAR/TYKmgNbMrw2C3xzIYlYhcs3/lPMPl6x
	 gBj8HPi9LxthA==
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-458bf57a4e7so20455e9.1
        for <kexec@lists.infradead.org>; Mon, 04 Aug 2025 16:10:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXn78jmfsvYxcj5ws+3OgZvKbvXZgyQD+D/SToHVhsRcbuMSgNo6cl9K3uKIaZsAd4GLqaOcg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxA6YeCc3dkSNz6rcz/Idr4VsXGCTYDlxKC2mEW+t9Ulkxf1VH9
	a+p+8Bi5/COJYgMgGAumYhXJwLnS6sEZ462H/UKil+0qfHyUpuBZH7izq/ox9VPz8hM6jTeZ/F7
	sPDk3Ta/kzca34qdaN8DrkYc3ESDbEMG86nd7aXJB
X-Google-Smtp-Source: AGHT+IHKpk+HdsX+UkmoGsNTrjTyAvv+GZeP3pJG7v7GzWXQDB8HcuYU8JvYjjZGY3fLVdxWGYKFXeKl60hxqHiBoUI=
X-Received: by 2002:a05:600c:3b8c:b0:43d:409c:6142 with SMTP id
 5b1f17b1804b1-459e13212bamr553835e9.0.1754349006808; Mon, 04 Aug 2025
 16:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <CALzav=d_Bjfy=6if+rPmxgGJfUV8ijnQ5hf40HoH6Yozg_H6Ew@mail.gmail.com>
In-Reply-To: <CALzav=d_Bjfy=6if+rPmxgGJfUV8ijnQ5hf40HoH6Yozg_H6Ew@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 4 Aug 2025 16:09:54 -0700
X-Gmail-Original-Message-ID: <CAF8kJuP09jvpB--fLy6Ju6rRuKFS5r8vyq1ne7ragbv0suWzLQ@mail.gmail.com>
X-Gm-Features: Ac12FXy7avNazRoYmbC_NeBMrj_2tPBaCG8ggpo_BqxQQnqN6_SKMsJk-VIeXn4
Message-ID: <CAF8kJuP09jvpB--fLy6Ju6rRuKFS5r8vyq1ne7ragbv0suWzLQ@mail.gmail.com>
Subject: Re: Live Update MC (LPC): Call for Presentations
To: David Matlack <dmatlack@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, kexec@lists.infradead.org, 
	Linux MM Mailing List <linux-mm@kvack.org>, linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>, 
	"pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>, David Rientjes <rientjes@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>, 
	Changyuan Lyu <changyuanl@google.com>, "graf@amazon.com" <graf@amazon.com>, 
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "jgowans@amazon.com" <jgowans@amazon.com>, 
	"ptyadav@amazon.de" <ptyadav@amazon.de>, "jgg@nvidia.com" <jgg@nvidia.com>, "rppt@kernel.org" <rppt@kernel.org>, 
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu US <witu@nvidia.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, dave.hansen@intel.com, 
	David Hildenbrand <david@redhat.com>, Frank van der Linden <fvdl@google.com>, jork.loeser@microsoft.com, 
	Junaid Shahid <junaids@google.com>, pankaj.gupta.linux@gmail.com, 
	Pratyush Yadav <pratyush@kernel.org>, kpraveen.lkml@gmail.com, 
	Vishal Annapurve <vannapurve@google.com>, Steve Sistare <steven.sistare@oracle.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250804_161009_797320_B87FD1CD 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sat, 30 Aug 2025 10:30:04 -0700
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

Hi David,

Thanks for organizing this.

On Fri, Aug 1, 2025 at 8:33=E2=80=AFAM David Matlack <dmatlack@google.com> =
wrote:
> Topics to be discussed at the microconference include:
>   - Live Update Orchestrator (state machine, userspace API, implementatio=
n)
>   - Generic infrastructure for preserving file descriptors across Live Up=
dates
>   - Live Update support for specific files (memfd, iommufd, VFIO cdev, et=
c.)
>   - Integration of Live Update with the PCI subsystem and Linux device mo=
del

I will submit a topic proposal for the Live Update with PCI subsystems.
The PCI RFC V1 discussion thread is here:
https://lore.kernel.org/lkml/20250728-luo-pci-v1-0-955b078dd653@kernel.org

Thanks

Chris

