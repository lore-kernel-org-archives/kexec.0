Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3176C43458
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wBlFK0541y0Zc/79OGH2Qmor8SYhSUoS64EeY6OiQnk=; b=qbaq0vkmFWXfiXD7TSqhcTTbF2
	zPHc0TG9XT0P0LCF5WyR+mSR2F46L+gkqNYuuIn2a9XYVH8Ll3TvqDKdOYDUyL65+cULmSI++fauk
	3iRBL5dKFfFyIzHNoT1uHtoYcEU5NZqYyHvzvSvssn07iQP6UicxBLN7rVzMSJ2/gBBDYgrYSZp7J
	h0dJ4aIb+ZIffp0BTasG4QOOAluyy5N9YqIr2ejwL7KWeNOypz8d29vI+rfaEdcFKBp6C5ri17Irm
	6zdjOhJ889wNb9ndpULDixSp1ljqucjU98zkiNvX3PeWDDWWocuGqU3XGOwcgpEPS9+GRjat9Cwvy
	Z2awRlNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiC1w-000000054Ca-1hHI;
	Fri, 10 Jul 2026 14:16:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiC1u-000000054CU-30sg
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 14:16:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1124260051;
	Fri, 10 Jul 2026 14:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7B01F000E9;
	Fri, 10 Jul 2026 14:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783692997;
	bh=wBlFK0541y0Zc/79OGH2Qmor8SYhSUoS64EeY6OiQnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mp0sLUNWJUriS9GasCZYYGX9cDD2E6Htf1I4L5b2Z4r8o9oI+vFCeiwYxQo09so1z
	 mMLhynXQApdClVn5iNc5Kxn1uAwMdzFja3z/Dar0ICAVsOdBNk+tW90D41MVHpQMzy
	 3Pj05EsVxckLT+UrHNlXw7+G5YWMtWCTUC7I+SLo=
Date: Fri, 10 Jul 2026 16:16:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavol Sakac <sakacpav@amazon.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	David Woodhouse <dwmw@amazon.co.uk>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Alexander Graf <graf@amazon.com>, linux-mm@kvack.org,
	kexec@lists.infradead.org, nh-open-source@amazon.com
Subject: Re: [RFC PATCH 00/14] driver core: defer per-VF sysfs creation for
 fast SR-IOV bring-up
Message-ID: <2026071004-strum-perkiness-5d9b@gregkh>
References: <20260702174033.32116-1-sakacpav@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702174033.32116-1-sakacpav@amazon.de>
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

On Thu, Jul 02, 2026 at 07:40:19PM +0200, Pavol Sakac wrote:
> Virtualization hardware keeps increasing in CPU-core and VF density.
> Kernel is trending towards preserving VFs using LUO across a kexec
> which will put SR-IOV in live-update hotpath. VFs must be re-added to
> the sysfs tree, along with its supporting devices (e.g. vfio,
> iommu_groups). On production hardware a single VF can consume ~80 kernfs
> nodes. With thousands of VFs on modern hardware, hundreds of thousands
> of kernfs nodes need to be created, which can add 100ms+ to the boot
> time and to guest downtime.

Hundreds of thousands?  You have a hundred sysfs files per device?

> Proposed here is a PoC of deferred materialization of sysfs files until
> first access to avoid cost of kernfs node creation in hot path. In the
> reproducer below using a synthetic VF to isolate the sysfs overhead,
> the per-device sysfs-creation time is reduced by ~74%. It exploits the
> expected access pattern of hypervisors, where only a subset of device
> files need to be accessed to attach a VF to a VM on the hot path.

Ick, that access pattern could change with other users, this feels very
fragile.

> To allow lazy init scheme, a minimal set of files and directories is
> built per device: a device directory resolves directly to the device's
> kobject and is used to materialize attributes at access time. The
> access is trapped in kernfs at the dir-read or path-walk stage and
> depending on the trigger, either the full directory or a single file is
> materialized.
> 
> The changes are two logically distinct parts:
> 
>   1. Refactor of hardcoded device_add / iommu_group sysfs attribute
>      creation to a table-driven form to allow walkability of all
>      attributes and single point of definition for attributes
>      regardless of lazy opt-in to avoid duplicate definitions and
>      associated maintainability issues with it.

This is probably a good idea anyway.  Want to just send this as a series
to start with, so we can take that?

>   2. Lazy-init infra to front-run access to device files at lookup/
>      readdir time to trigger materialization. Opt-in per device: PCI VFs
>      and VFIO devices opt in via device_set_sysfs_lazy(); iommu_group
>      opts in at the kobject level.

This is going to get complex.  Where exactly is the bottleneck?  I'm
guessing that systems with that many devices also have many hundreds of
CPUs, right?  Are we hitting a single lock somewhere?  There have been
changes in kernfs in the past to split up the locks to be more
fine-grained, perhaps that needs to continue to solve this?

> As a PoC, the code does not yet follow this logical structure in the
> commit sequence and likely does not yet cover all corner cases.
> 
> Synthetic reproducer measurements
> ---------------------------------
>   devices   per-dev time   total time       kernfs nodes (base -> lazy)
>   -------   ------------   --------------   ----------------------------
>      500    31.8->8.3 us    15.9-> 4.1 ms     36,417 ->  3,922  (72.8->7.8/dev)
>     1000    33.2->8.7 us    33.2-> 8.7 ms     73,427 ->  8,432  (73.4->8.4/dev)
>     2500    32.8->9.1 us    82.0->22.7 ms    184,421 -> 21,925  (73.8->8.8/dev)
>     5000    33.0->8.7 us   165.1->43.5 ms    369,401 -> 44,406  (73.9->8.9/dev)
> 
> The reproducer is synthetic: an in-kernel module registers N unbound
> platform devices (60 attributes / 4 groups, ~74 kernfs nodes each; no
> config space, BARs, or probe) in one timed burst that models SR-IOV
> enablement. It runs as a two-kernel A/B from one vanilla 7.1-rc2 tree
> (eager baseline vs patched, plus a patched/opt-in-OFF arm), 20 runs per
> point. Measures only sysfs-creation slice.

I sure hope sr-iov devices are NOT platform devices.  If so, please go
fix that up first :)

> Deferral removes ~74% of the sysfs-creation time and ~88% of the kernfs
> nodes. At 5000 devices that is 121.6 ms removed (165.1 -> 43.5 ms) and
> ~325,000 fewer kernfs nodes (369,401 -> 44,406). The table-driven rework
> adds a +7..+11% eager-path time overhead to non-opted devices.

You're just deferring this work to happen later, so when is that
"later"?  And what about multi-threaded probing of the bus, doesn't that
speed stuff up too?

> Available as a docker image that orchestrates builds in qemu guest and
> prints results as a table (x86_64 Linux host with /dev/kvm assumed):
> 
>    docker run --device /dev/kvm ghcr.io/pavsa/linux-lazy-sysfs-vf-bench:7.1-rc2
> 
> Assumptions / Trade-offs
> ------------------------
> The saving depends on the access pattern of hypervisors, and on no
> component walking the whole device tree on the hot path to avoid full
> materialization. Both are expected to hold on optimized hypervisors.

Hah, as if.  Many userspace tools, once a device is notified, walk the
whole tree of it to read the attributes.  You are going to be fighting
that problem constantly...

> An actual production hypervisor was observed in local testing to
> materialize an additional 5-10% of total nodes on average on the hot
> path.
> 
> Overhead: +7..+11% eager-path time overhead applies to every non-opted
> device going through device_add() as all struct devices traverse the
> walker and can't be gated under a config option.
> The lazy opt-in infra can be gated under config option to have zero
> impact if disabled.

Again, where exactly is the time being spent?  What lock is "hot"?

> Final words
> -----------
> This is an RFC to first get feedback on the decisions taken at driver
> core + kernfs level before engaging maintainers of other subsystems
> if we want to pursue this further or pivot to something else.
> 
> The code is at a proof-of-concept quality written with AI assistance
> with some known limitations with main target to gather potential
> savings and initiate conversation.
> 
> Feedback appreciated for:
> - table-driven attribute refactor targeting common device add path /
>   suggestions for more efficient/less invasive approach

What's wrong with the normal way attributes are defined and allocated?
They should all be tables today, and the driver core creating them when
needed, no individual driver should ever be doing that on its own.

thanks,

greg k-h

