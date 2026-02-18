Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C77CE9A03E
	for <kexec@archiver.kernel.org>; Wed, 18 Feb 2026 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XzHcrxOON8jnZMMjlbHxiE824NguULpJZRnb0nE+Xp0=; b=kcO0KVfwyH1tduNFC9JJTtKmks
	7zTUxpmC/sYajFRTPvVpkueX4p3038gju639ujeGeqV0jfkkh3cqoDF3FF7jvFn2KywRyH+KzEgQd
	HJhsSQ7dOm7hAcIt4AoG9aUskVEuHqCMxqpDqiS7MJu0/tod2H5T+aeDh7RnM6Cs2TdJUbbnP3tg+
	yEKKk04T7h702crwIEZR/4D3/7bsw1uI0BzpDkljO5uBR+BScinXOE5Wb8UuGaRe37wWwvc6SX+tP
	Rlab3pVkkZqppa77871hmMOXYxxprLmqzvnWbP1ODwIOnU7zkLk9UEKyBu0JghyDe4eTMJnHror/b
	eE1MRobA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vschk-00000009Rio-0AQv;
	Wed, 18 Feb 2026 08:14:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vschh-00000009RiQ-15mP
	for kexec@lists.infradead.org;
	Wed, 18 Feb 2026 08:14:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 64517419C4;
	Wed, 18 Feb 2026 08:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10272C19421;
	Wed, 18 Feb 2026 08:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771402474;
	bh=4jbu7KDwDe1/tD6r+TDAO9K/lxjskYIk/blBqfSgAWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xs1jYMqHrefB3a2AVvqZiA5aiU5Zst0Hre4yCPcMG4XhcB4zCC9+fZNwv4AkwAEXQ
	 aqIIFd6RK2YyViWjbM56BdTIghQ/MxTe1ccKmfnMWaeXWZkDCzQmwd69MPjuWOODzv
	 Ml+mDEUnPRjdI9mOMhmpltee8dZgwwAYb3hqYZgZ1+o3GCL6pBOJqNtOBKjcxsfN7v
	 Ggqwc/C3wj/fsDHkmcuZAH4pI443+nkVcPy5ok/+QRAzCriIOL2S8IRnPE24vAkqn6
	 rzMgdgkjXs9XZ8MNq+lOZdb9XmHGDkR8y5YgkaVoTA26ND+CrhWR3Y68fmCKfo5ETM
	 xiq1alRc4b46g==
Date: Wed, 18 Feb 2026 08:14:32 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	rppt@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mshv: Add kexec blocking support
Message-ID: <20260218081432.GI2236050@liuwe-devbox-debian-v2.local>
References: <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176962212724.85424.5690118672585914211.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <32c4bc2a-5dd1-c54d-a089-45bfad6eec94@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c4bc2a-5dd1-c54d-a089-45bfad6eec94@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_001437_352266_BE6170F1 
X-CRM114-Status: GOOD (  28.85  )
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

On Thu, Feb 12, 2026 at 02:11:13PM -0800, Mukesh R wrote:
> On 1/28/26 09:42, Stanislav Kinsburskii wrote:
> > Add kexec notifier to prevent kexec when VMs are active or memory
> > is deposited. The notifier blocks kexec operations if:
> > - Active VMs exist in the partition table
> > - Pages are still deposited to the hypervisor
> > 
> > The kernel cannot access hypervisor deposited pages: any access
> > triggers a GPF. Until the deposited page state can be handed over
> > to the next kernel, kexec must be blocked if there is any shared
> > state between kernel and hypervisor.
> > 
> > For L1 host virtualization, attempt to withdraw all deposited memory before
> > allowing kexec to proceed. If withdrawal fails or pages remain deposited
> > block the kexec operation.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >   drivers/hv/Makefile            |    1 +
> >   drivers/hv/hv_proc.c           |    4 ++
> >   drivers/hv/mshv_kexec.c        |   66 ++++++++++++++++++++++++++++++++++++++++
> >   drivers/hv/mshv_root.h         |   14 ++++++++
> >   drivers/hv/mshv_root_hv_call.c |    2 +
> >   drivers/hv/mshv_root_main.c    |    7 ++++
> >   6 files changed, 94 insertions(+)
> >   create mode 100644 drivers/hv/mshv_kexec.c
> > 
> > diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> > index a49f93c2d245..bb72be5cc525 100644
> > --- a/drivers/hv/Makefile
> > +++ b/drivers/hv/Makefile
> > @@ -15,6 +15,7 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
> >   hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
> >   mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
> >   	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
> > +mshv_root-$(CONFIG_KEXEC) += mshv_kexec.o
> >   mshv_vtl-y := mshv_vtl_main.o
> >   # Code that must be built-in
> > diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> > index 89870c1b0087..39bbbedb0340 100644
> > --- a/drivers/hv/hv_proc.c
> > +++ b/drivers/hv/hv_proc.c
> > @@ -15,6 +15,8 @@
> >    */
> >   #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
> > +atomic_t hv_pages_deposited;
> > +
> >   /* Deposits exact number of pages. Must be called with interrupts enabled.  */
> >   int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> >   {
> > @@ -93,6 +95,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> >   		goto err_free_allocations;
> >   	}
> > +	atomic_add(page_count, &hv_pages_deposited);
> > +
> >   	ret = 0;
> >   	goto free_buf;
> > diff --git a/drivers/hv/mshv_kexec.c b/drivers/hv/mshv_kexec.c
> > new file mode 100644
> > index 000000000000..5222b2e4ff97
> > --- /dev/null
> > +++ b/drivers/hv/mshv_kexec.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2026, Microsoft Corporation.
> > + *
> > + * Live update orchestration management for mshv_root module.
> > + *
> > + * Author: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > + */
> > +
> > +#include <linux/kexec.h>
> > +#include <linux/notifier.h>
> > +#include <asm/mshyperv.h>
> > +#include "mshv_root.h"
> > +
> > +static BLOCKING_NOTIFIER_HEAD(overlay_notify_chain);
> > +
> > +static int mshv_block_kexec_notify(struct notifier_block *nb,
> > +				   unsigned long action, void *arg)
> > +{
> > +	if (!hash_empty(mshv_root.pt_htable)) {
> > +		pr_warn("mshv: Cannot perform kexec while VMs are active\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	if (hv_l1vh_partition()) {
> > +		int err;
> > +
> > +		/* Attempt to withdraw all the deposited pages */
> > +		err = hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE,
> > +					      hv_current_partition_id);
> > +		if (err) {
> > +			pr_err("mshv: Failed to withdraw memory from L1 virtualization: %d\n",
> > +			       err);
> > +			return err;
> > +		}
> > +	}
> > +
> > +	if (atomic_read(&hv_pages_deposited)) {
> > +		pr_warn("mshv: Cannot perform kexec while pages are deposited\n");
> > +		return -EBUSY;
> > +	}
> > +	return 0;
> > +}
> > +
> 
> What guarantees another deposit won't happen after this. Are all cpus
> "locked" in kexec path and not doing anything at this point?
> 

An alternative is to block kexec if any pages have ever been deposited.
This is a very heavy-handed approach.

Wei

