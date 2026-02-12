Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78433EEA866
	for <kexec@archiver.kernel.org>; Thu, 12 Feb 2026 22:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6eofuDKmKOLfCuq2pM2DyljxyLUgC9fSyFIoGCkDY4s=; b=IANm7UR6y3tjvviKSIpHRarr/3
	wVofPsb3CoruJGqYenGEQByZKr4mI005Ap2XQF7Jp0wpeRo3iWr4txoyKqchoqOR4c3IyCUQRBfV5
	Kb7w5bug+LPDHhB+RALPHqTrmNAQr0xedBPaFUAyeNY+npaR3RK2uCqoE8b+QAEeL1zADPtqWqHyG
	tOI5JHf0WSDSGBfk+mlNJsLP9CbDthQtws4DKCZY3sVv8qtsEtoeFsOZgmyXDI551UyCFdYnhbnDr
	YI+mhH4JmtdZIVaaeoTHttyqLq7Gc5fmpHwD6yqeQkBKIci/r6wZ0RgsszcQ44iMFFwoi/mhLhjXT
	67Veqsvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqeu6-00000002gkn-1lRa;
	Thu, 12 Feb 2026 22:11:18 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqeu4-00000002gkP-2H3c
	for kexec@lists.infradead.org;
	Thu, 12 Feb 2026 22:11:17 +0000
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1756120B7165;
	Thu, 12 Feb 2026 14:11:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1756120B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770934274;
	bh=6eofuDKmKOLfCuq2pM2DyljxyLUgC9fSyFIoGCkDY4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d4QIqslBtpFWC040wupD6krQmTY8sHskhhAPvaKI9GV20GwJXRM5kMyuIhO1E6GIA
	 YLhkjzbBniOJ98SDKPyB0H9C8pvPFPPkCvWC6ipxvwQVoeq07fNHbr9HYzlVKZMSfN
	 k8yzi9xnba4S7yLurcLNLQ7bWk23zxxqp873raEg=
Message-ID: <32c4bc2a-5dd1-c54d-a089-45bfad6eec94@linux.microsoft.com>
Date: Thu, 12 Feb 2026 14:11:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] mshv: Add kexec blocking support
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 rppt@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: kexec@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176962212724.85424.5690118672585914211.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <176962212724.85424.5690118672585914211.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_141116_625287_D38B36DB 
X-CRM114-Status: GOOD (  31.55  )
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

On 1/28/26 09:42, Stanislav Kinsburskii wrote:
> Add kexec notifier to prevent kexec when VMs are active or memory
> is deposited. The notifier blocks kexec operations if:
> - Active VMs exist in the partition table
> - Pages are still deposited to the hypervisor
> 
> The kernel cannot access hypervisor deposited pages: any access
> triggers a GPF. Until the deposited page state can be handed over
> to the next kernel, kexec must be blocked if there is any shared
> state between kernel and hypervisor.
> 
> For L1 host virtualization, attempt to withdraw all deposited memory before
> allowing kexec to proceed. If withdrawal fails or pages remain deposited
> block the kexec operation.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>   drivers/hv/Makefile            |    1 +
>   drivers/hv/hv_proc.c           |    4 ++
>   drivers/hv/mshv_kexec.c        |   66 ++++++++++++++++++++++++++++++++++++++++
>   drivers/hv/mshv_root.h         |   14 ++++++++
>   drivers/hv/mshv_root_hv_call.c |    2 +
>   drivers/hv/mshv_root_main.c    |    7 ++++
>   6 files changed, 94 insertions(+)
>   create mode 100644 drivers/hv/mshv_kexec.c
> 
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index a49f93c2d245..bb72be5cc525 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -15,6 +15,7 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
>   hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>   mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
>   	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
> +mshv_root-$(CONFIG_KEXEC) += mshv_kexec.o
>   mshv_vtl-y := mshv_vtl_main.o
>   
>   # Code that must be built-in
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 89870c1b0087..39bbbedb0340 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -15,6 +15,8 @@
>    */
>   #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
>   
> +atomic_t hv_pages_deposited;
> +
>   /* Deposits exact number of pages. Must be called with interrupts enabled.  */
>   int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>   {
> @@ -93,6 +95,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>   		goto err_free_allocations;
>   	}
>   
> +	atomic_add(page_count, &hv_pages_deposited);
> +
>   	ret = 0;
>   	goto free_buf;
>   
> diff --git a/drivers/hv/mshv_kexec.c b/drivers/hv/mshv_kexec.c
> new file mode 100644
> index 000000000000..5222b2e4ff97
> --- /dev/null
> +++ b/drivers/hv/mshv_kexec.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026, Microsoft Corporation.
> + *
> + * Live update orchestration management for mshv_root module.
> + *
> + * Author: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> + */
> +
> +#include <linux/kexec.h>
> +#include <linux/notifier.h>
> +#include <asm/mshyperv.h>
> +#include "mshv_root.h"
> +
> +static BLOCKING_NOTIFIER_HEAD(overlay_notify_chain);
> +
> +static int mshv_block_kexec_notify(struct notifier_block *nb,
> +				   unsigned long action, void *arg)
> +{
> +	if (!hash_empty(mshv_root.pt_htable)) {
> +		pr_warn("mshv: Cannot perform kexec while VMs are active\n");
> +		return -EBUSY;
> +	}
> +
> +	if (hv_l1vh_partition()) {
> +		int err;
> +
> +		/* Attempt to withdraw all the deposited pages */
> +		err = hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE,
> +					      hv_current_partition_id);
> +		if (err) {
> +			pr_err("mshv: Failed to withdraw memory from L1 virtualization: %d\n",
> +			       err);
> +			return err;
> +		}
> +	}
> +
> +	if (atomic_read(&hv_pages_deposited)) {
> +		pr_warn("mshv: Cannot perform kexec while pages are deposited\n");
> +		return -EBUSY;
> +	}
> +	return 0;
> +}
> +

What guarantees another deposit won't happen after this. Are all cpus
"locked" in kexec path and not doing anything at this point?

Thanks,
-Mukesh



> +static struct notifier_block mshv_kexec_notifier = {
> +	.notifier_call = mshv_block_kexec_notify,
> +};
> +
> +int __init mshv_kexec_init(void)
> +{
> +	int err;
> +
> +	err = kexec_block_notifier_register(&mshv_kexec_notifier);
> +	if (err) {
> +		pr_err("mshv: Could not register kexec notifier: %pe\n",
> +		       ERR_PTR(err));
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +void __exit mshv_kexec_exit(void)
> +{
> +	(void)kexec_block_notifier_unregister(&mshv_kexec_notifier);
> +}
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 3c1d88b36741..311f76262d10 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -17,6 +17,7 @@
>   #include <linux/build_bug.h>
>   #include <linux/mmu_notifier.h>
>   #include <uapi/linux/mshv.h>
> +#include <hyperv/hvhdk.h>
>   
>   /*
>    * Hypervisor must be between these version numbers (inclusive)
> @@ -319,6 +320,7 @@ int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 a
>   extern struct mshv_root mshv_root;
>   extern enum hv_scheduler_type hv_scheduler_type;
>   extern u8 * __percpu *hv_synic_eventring_tail;
> +extern atomic_t hv_pages_deposited;
>   
>   struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
>   					   u64 uaddr, u32 flags);
> @@ -333,4 +335,16 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
>   void mshv_region_movable_fini(struct mshv_mem_region *region);
>   bool mshv_region_movable_init(struct mshv_mem_region *region);
>   
> +#if IS_ENABLED(CONFIG_KEXEC)
> +int mshv_kexec_init(void);
> +void mshv_kexec_exit(void);
> +#else
> +static inline int mshv_kexec_init(void)
> +{
> +	return 0;
> +}
> +
> +static inline void mshv_kexec_exit(void) { }
> +#endif
> +
>   #endif /* _MSHV_ROOT_H_ */
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 06f2bac8039d..4203af5190ee 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -73,6 +73,8 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
>   		for (i = 0; i < completed; i++)
>   			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
>   
> +		atomic_sub(completed, &hv_pages_deposited);
> +
>   		if (!hv_result_success(status)) {
>   			if (hv_result(status) == HV_STATUS_NO_RESOURCES)
>   				status = HV_STATUS_SUCCESS;
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 5fc572e31cd7..d55aa69d130c 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2330,6 +2330,10 @@ static int __init mshv_parent_partition_init(void)
>   	if (ret)
>   		goto deinit_root_scheduler;
>   
> +	ret = mshv_kexec_init();
> +	if (ret)
> +		goto deinit_irqfd_wq;
> +
>   	spin_lock_init(&mshv_root.pt_ht_lock);
>   	hash_init(mshv_root.pt_htable);
>   
> @@ -2337,6 +2341,8 @@ static int __init mshv_parent_partition_init(void)
>   
>   	return 0;
>   
> +deinit_irqfd_wq:
> +	mshv_irqfd_wq_cleanup();
>   deinit_root_scheduler:
>   	root_scheduler_deinit();
>   exit_partition:
> @@ -2356,6 +2362,7 @@ static void __exit mshv_parent_partition_exit(void)
>   	hv_setup_mshv_handler(NULL);
>   	mshv_port_table_fini();
>   	misc_deregister(&mshv_dev);
> +	mshv_kexec_exit();
>   	mshv_irqfd_wq_cleanup();
>   	root_scheduler_deinit();
>   	if (hv_root_partition())
> 
> 


