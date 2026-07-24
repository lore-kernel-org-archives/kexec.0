Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67029C531C9
	for <kexec@archiver.kernel.org>; Fri, 24 Jul 2026 21:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/VuhMIt3y5/j6Le1Z4BNgwX3UBNQKNT5cbNU5pubERw=; b=ZmUEj8ZwowfKYIflk03Xc8qlTQ
	KLcNmU2gxr4OKq8NuRXRAUoJtg9XVwIoynHQChJCXkRAS3vER4MzuRdTzDQpIbQomQFmoVHcDiQYk
	FqSdTagSawwyKZkfM7tOJvUS66sadKtkbIiBqaRx92pW5pNfy+bdsvWBhhFUFykfddzv6Ez9HLzSj
	ATyCfPGY2R+2GrUBB8IlRm/at08OscGNCmXfg3MIUBqzONpI3XpiDQSUycS/exYB0XMt+2y3tX8kg
	bVyINsvs000wf5LQSMSLRwJeeIWnjKd3q1sF0t8YZLkNxkH2+z2K5gEtt2+priq/Pte9lpOrOHhzv
	C98+db5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNqt-0000000HHKz-1bYW;
	Fri, 24 Jul 2026 21:54:43 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNqq-0000000HHKe-2s1P
	for kexec@lists.infradead.org;
	Fri, 24 Jul 2026 21:54:42 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so915554a91.3
        for <kexec@lists.infradead.org>; Fri, 24 Jul 2026 14:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784930079; cv=none;
        d=google.com; s=arc-20260327;
        b=K6bsLt7AjLStamrwHVP20xoG31fGmnwhVIZFBQts4RoRO+px18kPFiEO3fOs3DGRNb
         OcMdxvkUbAsdIq0SGLu6sw8bK+zqqjo2kNBFoXnlMPrBObARPM41QZeWjmT3iRIGO7TH
         J/CgZi+Hhk6KAaenSf5mq2dynEPRHB5arb1ehFd0gItVtIXUo51/oegnmy5WB68+ABGI
         Gw74q9qqQnhrVOlQWyCWooceIan3O/S/kZECyaN1ew5MmIcbShO24C5k/X6OfiygWIpE
         xfQ48RHd2L6JttgbwfV8rFzsLyKR1GjChISQmffclSEKUVfaqeAaoEgIf+jrkPbU25EC
         hcew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/VuhMIt3y5/j6Le1Z4BNgwX3UBNQKNT5cbNU5pubERw=;
        fh=Vqc4ln53D4bxOegRoXRnAZ9HbLniKRCPC/zyIqSj7Z4=;
        b=V46iFvdqyvV8y2w866kjIfU6NabTEiqUErSyArokiT3v8YJ/Z5PLUkfv/mAvywv5jR
         pllmZiEJOF41cpNe98K2oHzfcukqgYrPRI9ls7U+dmQyoiY1PczFY4y8e3PH2MYC4Fo0
         ARkkbi+/NI0jaw0YMqJSi5jo5npDp7945HAcf7w1quAAb1WfyHNIJ9Aca6CvFM+iZOlS
         ft7dCAWCtMz8v2IRBM5Dq9pCDdYe78UFCkPs5qNLHY7FfNyYhDbbq6x+FEbshgMQueet
         tfxsiECH5dm9QxAEw8w21PzB5Gu1F4LVzFL6jyvdTquM7NpH6YSlViht90t0sOBI370Z
         zVJA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784930079; x=1785534879; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/VuhMIt3y5/j6Le1Z4BNgwX3UBNQKNT5cbNU5pubERw=;
        b=Fsf4ZuPyudUo59BkaJwu18mrTXR0shklJskre/XghvSfYvyuqM+g79a50IK2zFL3gC
         7FqYRDrxTCSNcFG2cynX1p/Vu7ElJ0M28Tcm0+r2N7ixSAA/hLqgUJhotjWd/tol95RC
         M4B/wr7CofPsLlDCqb9DqVZswXv45CGmBC4OvuqmAZO+MBl38wN4lRFn/lzcvtIMNqcI
         OfYcyCMXFxwPILlgoZChXIzmvIOqe1s/l9P3DAih1FR/PQuR4nCMCCR3eja1BoEhAKVa
         n51HkAxS97fPuK9mkQJ0orgYnHmYGWTnnkLOKxi8g7IbDSHO5RCkSXbXVyW1Ke1jzjat
         gcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784930079; x=1785534879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/VuhMIt3y5/j6Le1Z4BNgwX3UBNQKNT5cbNU5pubERw=;
        b=Oiy3WEH+Qko5nmQ3eBAom6S2aCKvawj8UrsgKNGqUfKHFRn39NaipqF4DD3q7W2PSe
         XPRYM9N5wyZh1cKQ6dIzTng5rfmMidDtfM6NbLFNFTXLMltrMJEW0LhYCVwmelHjBh1m
         jCYWhF876Li77pyKWJridSL/StVNoTsndgKDJfajZvS3+RU8DCp83lrV8Zn4QEeAVHVz
         F6mpfPCgRf2iSonl1vede8e8a7yDEZnPPNw11ag02GJXK8BkFHaSCKyl4Fn3VIYt7LNd
         79+vwgkPU177/yi07SFB733UGxIh4X5f0x2dvkfESsarF5O1VTyUoWt+5qCd2kjQm4po
         q+Yg==
X-Gm-Message-State: AOJu0YwnIb6vJVAB9VxDuTPQXlHRMTWk4R03/a17Bkx02HdFC6fYeETX
	9OSsdtqeVj6Cl/3b2GBRKGQ4vxV5bAGmbcHcEthpsbP/gant2NSg+i6Q0kLn3TkLAJzEYfqBAL2
	V61VlgBglaGgCd9jIIKv9OIZqXfp4iNm0AHdJkEcp
X-Gm-Gg: AR+sD11RFBvRxYMSPH1xzhJruMDKHCYN1HenxwUXhwa48DrdBk3QcRJcczARfUkOUMu
	KEBwLnqUV8V0p7/ribUaO7Y5yePFyPihvKW+dCqnOjVODb7vq0nqXj8RPOQLsK7FW59zv8YuThb
	aWYpf9Zq56LmaKfRrcnB+gUsOZ2QzxMJizdYTeLXfG94uwwQHIVO6Z8ferR2ChzZ9fb7wGKsoAk
	ymGk54/aAzzwx+cW3EXGgJ50p3JduNwpww188npQy0a2LIwt3qsLxGLZQbZ6w==
X-Received: by 2002:a17:90b:3f0c:b0:387:e0bb:57f1 with SMTP id
 98e67ed59e1d1-38f2975d581mr178977a91.34.1784930078557; Fri, 24 Jul 2026
 14:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260710212616.1351130-7-dmatlack@google.com> <20260724205506.GA1012423@bhelgaas>
In-Reply-To: <20260724205506.GA1012423@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Fri, 24 Jul 2026 14:54:11 -0700
X-Gm-Features: AUfX_myY_bxyw4-P1Rbrabgs4s-tLloBKDJhDTUU1nvReA0LfPMvmIQUGRTYqPg
Message-ID: <CALzav=c8amq1hTRCwHbQOZvhNKtissagzzXX+RGeRgUiKPOcbw@mail.gmail.com>
Subject: Re: [PATCH v7 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_145440_760674_98CA05E5 
X-CRM114-Status: GOOD (  23.64  )
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

On Fri, Jul 24, 2026 at 1:55=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jul 10, 2026 at 09:26:09PM +0000, David Matlack wrote:

> > -static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *out=
going, struct pci_dev *dev)
> > +static int pci_liveupdate_preserve_device_again(struct pci_dev *dev)
>
> Could pci_liveupdate_preserve_device_again() be folded into
> pci_liveupdate_preserve_device()?  That's the only caller, and having
> so many *liveupdate_preserve*() functions gets to be a bit of a maze
> of small functions:
>
>   __pci_liveupdate_preserve_device
>   pci_liveupdate_preserve_device_again
>   pci_liveupdate_preserve_device
>   pci_liveupdate_preserve_path
>   pci_liveupdate_preserve
>
> Maybe even more could be squashed; pci_liveupdate_preserve() is the
> only caller of pci_liveupdate_preserve_path(), which is itself the
> only caller of pci_liveupdate_preserve_device().
>
> As a reader, I think there's some advantage in collecting the whole
> "preserve" flow in one place, but maybe nesting depth would be an
> issue, especially for the unpreserve cleanup in the failure path.
> Maybe a "goto" error path could mitigate part of that.
>
> If there's any squashing, I guess the place to start would be in
> earlier patches, e.g., "PCI: liveupdate: Track outgoing preserved PCI
> devices" and "PCI: liveupdate: Track incoming preserved PCI devices".

I'll see what I can do in v8 to avoid splitting the
preserve/unpreserve logic across so many functions. I suspect it can
go from 5 to 2-3 while still having a reasonable amount of nesting.

> > +#define for_each_pci_dev_in_path(_d, _start, _end) \
> > +     for ((_d) =3D (_start); (_d) !=3D (_end); (_d) =3D (_d)->bus->sel=
f)
>
> I think you might want pci_upstream_bridge() instead of (_d)->bus->self;
> see https://git.kernel.org/linus/c6bde215acfd ("PCI: Add
> pci_upstream_bridge()").  I think VFs are currently out of scope, but
> no harm in making this future-proof.

Yes in fact I noticed pci_upstream_bridge() while working on other
changes in v8 and already swapped to it :). It also makes the code
more readable.

> Other than "_end", this looks fairly generic and might be a candidate
> for putting in include/linux/pci.h.  I think there might be other
> potential users, e.g., calc_map_type_and_dist(),
> pci_enable_atomic_ops_to_root(), pcie_bandwidth_available(),
> get_upstream_port(), pcie_find_root_port(),
> pci_is_thunderbolt_attached().
>
> The "_end" termination case could perhaps be done in the body instead
> of the macro since it depends on the use case and several of the other
> loops that iterate over the path already include terminations in the
> body.

Sounds good. I'll move it to include/linux/pci.h and and handle _end
in the loop bodies. Then once this series lands I can send a follow up
to convert those users to use the new iterator.

