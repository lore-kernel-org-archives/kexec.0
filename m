Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99B9C44507
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 23:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ivaQUJu/mRyfMnuwfBNsGTkWkGDvNgiNwDOd9icGQ3M=; b=2BXH26ecnEwy7qKJcdz3/MSUQ9
	o3a83I+Kd5I8BuiXjz9OwSnLh3vjyB+yVnUgpU16zSFS213Rk+7M1b+jAFN6YUbgJE3nyqMeEmTTc
	WyEPShemR/V/y7Y2VUEv8bCcaO13WVIOinb8qXz5m7mvUUQ+AVp4qDXogSLzr7cfiIEOKIsAWin6Y
	xW+skm/4aB4N2tnQeU4/hmpDCuz4SF1XfMIDROnFAchwX4LH/DwMMGlfHMBJ6En2lPF+J332hKEUt
	fNRTOJIUl4htNFHHivtjNmTQEEet1jhBEDeup6XLNkkrUO+xfTkjxbWuo7HenFM5RJ/Ex1K4RaYPr
	OmYOwjdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjQQd-0000000AZWA-1fDI;
	Mon, 13 Jul 2026 23:51:15 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjQQa-0000000AZVp-2etM
	for kexec@lists.infradead.org;
	Mon, 13 Jul 2026 23:51:14 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2caced6038eso5394375ad.0
        for <kexec@lists.infradead.org>; Mon, 13 Jul 2026 16:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783986672; cv=none;
        d=google.com; s=arc-20260327;
        b=ogwQJ3lrrJkdBXPkng9q9kobJ0Xw03nEDnCk1espCs8YkhahLJdFDzZtMY+0Jtg4gt
         50fhIwYhWXSqr19ThQYv7VvB5OAMJu3zhHLVklqMwZuT0ig84UCMpM3K4MabtL28LSxU
         W6C83zzfgEPwCbn1vs98MXNbv+kfxceeGtucIdS0+MKtCiCt490vdGY+Is/bHAZ0sctp
         nVcjkRDUl9PH2sBPvq9Fsd2MEQWrytBVn5eWTk7gh+Zc9gIQfZkhq/70WxLv0R+3QmFU
         m0FchRCjjjqUJUQBxr6oLuq9yPgg8ler6P2G5mZZn87/MYfZ0QLcI3Tb58f0r63bPlTi
         ea6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ivaQUJu/mRyfMnuwfBNsGTkWkGDvNgiNwDOd9icGQ3M=;
        fh=SrK+iVpE53Exlcy/dyO4hYN5LmHPxgKUx+ESSA9iYZA=;
        b=X1pm9C5YDDhUTuIuRfBzodWICWQI3DBnpFT/chCEojidWbrZ3BeKj/cr5OhxWY9Rs8
         c1jq7eTQMIfpFpiYUpl9z/oAS4ETSvV6lxkAdrsz60AIO9OeHi2GdtLHwDGHYLtQKarH
         +hMDOQ8Oypc0MpAIvr/831PmNkge/NdsTCZj2w/6+NZM4xLkYWhG8IllvA4tQsjyad9X
         es/YCIMsjsjf0p3F6Jy+EodLBHyRgKiCXIe1CrsVh6Gju7FlAy3SLGwnezR+q3YaeTfp
         oKoVm/41Dh9zbEn6quvjicwDmHKwyYdGI5JuJtde3oJzy3fpK7cSAX8GygNPrkJu47Mo
         PgeQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783986672; x=1784591472; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ivaQUJu/mRyfMnuwfBNsGTkWkGDvNgiNwDOd9icGQ3M=;
        b=Lzcm3p9qm28MsCOd8Txwb9zaAVDxgQH4wyDGRle4kCwkdujZSgC6lVonkfu2Q7Yzm2
         PTW1cWBh2YLe92HCrdv+gFPE4xxXgynK4gV7Ee4KUa/P7NBtAPNOJ8+heMJikWbImIXv
         sO2kjw0KLdgl9n1aTwA3JPyAooGETCKNihw7KD6aLZAievotXYcAbuQuxaKnzU6LRBf9
         C78OtKgz3Lxp+G5pBEZgbKaafiTSkGvwLmuuAPENpvSKqMWuChRMWJhd0JjGFU5EHuCk
         2feiAAHErAAYPOQ+6LlsApPlEoy4R0fNAAbASf7jom/KTE8TXVWTkamxeZG6ihkvlBKS
         KrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783986672; x=1784591472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivaQUJu/mRyfMnuwfBNsGTkWkGDvNgiNwDOd9icGQ3M=;
        b=kyEfcg+uBFbx/cWEFde2AX9+5o57VcPmcVUXETK7zxuGL28dg4WaeEI/3QnWw/1gCI
         P6+U+SD3dMlBFcu2wypBtyd0n5AzLz+Y93pvrcaB7i6QLWvOGjkUAG1WjLjRinZRz7lg
         uhb9bP2FDmgZs7U1W5nKvYQT/GcMLcXxnpS0KgoqoSbstlkkzYARiy5wOXzr/z5Ft/T9
         ma7KzAA1WSiv/BCffcRXjNCFHCDxr6Dk4NIQRlKAS0pHwnIn1YB3Mwr21npzK/KVOOu9
         jECgTJD0o9TAcf50PPI5Jin1kr3yh4BwQ9JY2i6zBnI2S90g5dk3vKyA97/l1n34f/hI
         8Naw==
X-Forwarded-Encrypted: i=1; AHgh+Rol9Tk85zbe2Bxb+FQtY5wzeK4uX0J1LfoorAKDXwJOqMQ63SFiTEJs3xvEQ0VaudxvTJ4Xig==@lists.infradead.org
X-Gm-Message-State: AOJu0YydxduDKZ9F04fY8L8bBIw/UrXAwzowzp+vIMdGxCqDeomqnWW1
	zeaViXpPokrI++Z0x/xZBaWLF+yoYfNqDfp/HulHiQjB3686sWsjL4FcIAGbR4ZwPJdhUyPcY71
	CVmGT0yAEptpXCBEyvbdLTkPF/V5Wpjz1UzG7AK74
X-Gm-Gg: AfdE7cn3U2qSNmXsMwWXJULPiZpajoHokt5/6iSPTm90eL+lDaDbrjBqnXGLutOalpP
	PfXtAfw5q9d6lxuZ4xGXs9qTRVXQwbF53M5/cZ6THtscw8UzyAgvq7uXYG9jUJ828YI54MW4JQ+
	0pf/nULENpr2ohrhYi3T+SSfwy8lvj4kyje2Ztn6FCcm1zC6oD3ZZJGHMvrUdpaNjkuaTC9hF5w
	sUO19VVk6/lfCU0FHo6lOk1SZGFt7vrf4BcpVDVGmiyjbEPZkLboPelXvthdCUjUWRTkmFo
X-Received: by 2002:a17:903:4b2b:b0:2cc:db7a:251 with SMTP id
 d9443c01a7336-2ce8285a73bmr140395465ad.2.1783986671057; Mon, 13 Jul 2026
 16:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260702174033.32116-1-sakacpav@amazon.de> <2026071004-strum-perkiness-5d9b@gregkh>
In-Reply-To: <2026071004-strum-perkiness-5d9b@gregkh>
From: David Matlack <dmatlack@google.com>
Date: Mon, 13 Jul 2026 16:50:44 -0700
X-Gm-Features: AVVi8CcmTY0c0Vp441sR3RbEM49xvL1OMRcgoloehgq4aoKMDkzxTiu2LMLBmtw
Message-ID: <CALzav=eCzxZ5980kazjSUDFn1d4Dz+cWbyZyg-MVMca9jntn4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] driver core: defer per-VF sysfs creation for
 fast SR-IOV bring-up
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavol Sakac <sakacpav@amazon.de>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, David Woodhouse <dwmw@amazon.co.uk>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Samiullah Khawaja <skhawaja@google.com>, 
	Alexander Graf <graf@amazon.com>, linux-mm@kvack.org, kexec@lists.infradead.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_165112_686988_B0C1F99F 
X-CRM114-Status: GOOD (  47.79  )
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

On Fri, Jul 10, 2026 at 7:16=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 02, 2026 at 07:40:19PM +0200, Pavol Sakac wrote:
> > Virtualization hardware keeps increasing in CPU-core and VF density.
> > Kernel is trending towards preserving VFs using LUO across a kexec
> > which will put SR-IOV in live-update hotpath. VFs must be re-added to
> > the sysfs tree, along with its supporting devices (e.g. vfio,
> > iommu_groups). On production hardware a single VF can consume ~80 kernf=
s
> > nodes. With thousands of VFs on modern hardware, hundreds of thousands
> > of kernfs nodes need to be created, which can add 100ms+ to the boot
> > time and to guest downtime.
>
> Hundreds of thousands?  You have a hundred sysfs files per device?
>
> > Proposed here is a PoC of deferred materialization of sysfs files until
> > first access to avoid cost of kernfs node creation in hot path. In the
> > reproducer below using a synthetic VF to isolate the sysfs overhead,
> > the per-device sysfs-creation time is reduced by ~74%. It exploits the
> > expected access pattern of hypervisors, where only a subset of device
> > files need to be accessed to attach a VF to a VM on the hot path.
>
> Ick, that access pattern could change with other users, this feels very
> fragile.
>
> > To allow lazy init scheme, a minimal set of files and directories is
> > built per device: a device directory resolves directly to the device's
> > kobject and is used to materialize attributes at access time. The
> > access is trapped in kernfs at the dir-read or path-walk stage and
> > depending on the trigger, either the full directory or a single file is
> > materialized.
> >
> > The changes are two logically distinct parts:
> >
> >   1. Refactor of hardcoded device_add / iommu_group sysfs attribute
> >      creation to a table-driven form to allow walkability of all
> >      attributes and single point of definition for attributes
> >      regardless of lazy opt-in to avoid duplicate definitions and
> >      associated maintainability issues with it.
>
> This is probably a good idea anyway.  Want to just send this as a series
> to start with, so we can take that?
>
> >   2. Lazy-init infra to front-run access to device files at lookup/
> >      readdir time to trigger materialization. Opt-in per device: PCI VF=
s
> >      and VFIO devices opt in via device_set_sysfs_lazy(); iommu_group
> >      opts in at the kobject level.
>
> This is going to get complex.  Where exactly is the bottleneck?  I'm
> guessing that systems with that many devices also have many hundreds of
> CPUs, right?  Are we hitting a single lock somewhere?  There have been
> changes in kernfs in the past to split up the locks to be more
> fine-grained, perhaps that needs to continue to solve this?

+1 I also am wondering if the time can be eliminated entirely instead
of deferred.

It would be nice to have a section of the cover letter that explains
where the time is being spent and why lazy initialization was chosen
over alternative approaches.

>
> > As a PoC, the code does not yet follow this logical structure in the
> > commit sequence and likely does not yet cover all corner cases.
> >
> > Synthetic reproducer measurements
> > ---------------------------------
> >   devices   per-dev time   total time       kernfs nodes (base -> lazy)
> >   -------   ------------   --------------   ---------------------------=
-
> >      500    31.8->8.3 us    15.9-> 4.1 ms     36,417 ->  3,922  (72.8->=
7.8/dev)
> >     1000    33.2->8.7 us    33.2-> 8.7 ms     73,427 ->  8,432  (73.4->=
8.4/dev)
> >     2500    32.8->9.1 us    82.0->22.7 ms    184,421 -> 21,925  (73.8->=
8.8/dev)
> >     5000    33.0->8.7 us   165.1->43.5 ms    369,401 -> 44,406  (73.9->=
8.9/dev)
> >
> > The reproducer is synthetic: an in-kernel module registers N unbound
> > platform devices (60 attributes / 4 groups, ~74 kernfs nodes each; no
> > config space, BARs, or probe) in one timed burst that models SR-IOV
> > enablement. It runs as a two-kernel A/B from one vanilla 7.1-rc2 tree
> > (eager baseline vs patched, plus a patched/opt-in-OFF arm), 20 runs per
> > point. Measures only sysfs-creation slice.
>
> I sure hope sr-iov devices are NOT platform devices.  If so, please go
> fix that up first :)
>
> > Deferral removes ~74% of the sysfs-creation time and ~88% of the kernfs
> > nodes. At 5000 devices that is 121.6 ms removed (165.1 -> 43.5 ms) and
> > ~325,000 fewer kernfs nodes (369,401 -> 44,406). The table-driven rewor=
k
> > adds a +7..+11% eager-path time overhead to non-opted devices.
>
> You're just deferring this work to happen later, so when is that
> "later"?  And what about multi-threaded probing of the bus, doesn't that
> speed stuff up too?
>
> > Available as a docker image that orchestrates builds in qemu guest and
> > prints results as a table (x86_64 Linux host with /dev/kvm assumed):
> >
> >    docker run --device /dev/kvm ghcr.io/pavsa/linux-lazy-sysfs-vf-bench=
:7.1-rc2
> >
> > Assumptions / Trade-offs
> > ------------------------
> > The saving depends on the access pattern of hypervisors, and on no
> > component walking the whole device tree on the hot path to avoid full
> > materialization. Both are expected to hold on optimized hypervisors.
>
> Hah, as if.  Many userspace tools, once a device is notified, walk the
> whole tree of it to read the attributes.  You are going to be fighting
> that problem constantly...

This series could still benefit Live Update scenarios where the
initial userspace stack is small and tightly controlled to resume VMs
as quickly as possible after kexec-ing into the new kernel. It enables
userspace to decide when to incur the cost of creating these files (or
never create them).

But I agree that eliminating the time entirely would be better.

>
> > An actual production hypervisor was observed in local testing to
> > materialize an additional 5-10% of total nodes on average on the hot
> > path.
> >
> > Overhead: +7..+11% eager-path time overhead applies to every non-opted
> > device going through device_add() as all struct devices traverse the
> > walker and can't be gated under a config option.
> > The lazy opt-in infra can be gated under config option to have zero
> > impact if disabled.
>
> Again, where exactly is the time being spent?  What lock is "hot"?
>
> > Final words
> > -----------
> > This is an RFC to first get feedback on the decisions taken at driver
> > core + kernfs level before engaging maintainers of other subsystems
> > if we want to pursue this further or pivot to something else.
> >
> > The code is at a proof-of-concept quality written with AI assistance
> > with some known limitations with main target to gather potential
> > savings and initiate conversation.
> >
> > Feedback appreciated for:
> > - table-driven attribute refactor targeting common device add path /
> >   suggestions for more efficient/less invasive approach
>
> What's wrong with the normal way attributes are defined and allocated?
> They should all be tables today, and the driver core creating them when
> needed, no individual driver should ever be doing that on its own.
>
> thanks,
>
> greg k-h

