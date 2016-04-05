Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1anIzS-0007lo-HB
 for kexec@lists.infradead.org; Tue, 05 Apr 2016 04:53:23 +0000
Subject: Re: [PATCH] s390/kexec: Consolidate crash_map/unmap_reserved_pages()
 and arch_kexec_protect(unprotect)_crashkres()
References: <1459338441-21919-1-git-send-email-xlpang@redhat.com>
 <20160401194154.1b4c623f@holzheu> <56FF1F26.7020606@redhat.com>
 <20160404165801.64a14422@holzheu>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <570344A7.9060706@redhat.com>
Date: Tue, 5 Apr 2016 12:52:55 +0800
MIME-Version: 1.0
In-Reply-To: <20160404165801.64a14422@holzheu>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, Minfei Huang <mhuang@redhat.com>, kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, ebiederm@xmission.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On 2016/04/04 at 22:58, Michael Holzheu wrote:
> Hello Xunlei,
>
> On Sat, 2 Apr 2016 09:23:50 +0800
> Xunlei Pang <xpang@redhat.com> wrote:
>
>> On 2016/04/02 at 01:41, Michael Holzheu wrote:
>>> Hello Xunlei again,
>>>
>>> Some initial comments below...
>>>
>>> On Wed, 30 Mar 2016 19:47:21 +0800
>>> Xunlei Pang <xlpang@redhat.com> wrote:
>>>
> [snip]
>
>>>> +			os_info_crashkernel_add(0, 0);
>>>> +	}
>>>> +}
>>> Please do not move these functions in the file. If you leave it at their
>>> old location, the patch will be *much* smaller.
>> In fact, I did this wanting avoiding adding extra declaration.
> IMHO no extra declaration is necessary (see patch below).
>
> [snip]
>
>>>> +/*
>>>>   * PM notifier callback for kdump
>>>>   */
>>>>  static int machine_kdump_pm_cb(struct notifier_block *nb, unsigned long action,
>>>> @@ -43,12 +89,12 @@ static int machine_kdump_pm_cb(struct notifier_block *nb, unsigned long action,
>>>>  	switch (action) {
>>>>  	case PM_SUSPEND_PREPARE:
>>>>  	case PM_HIBERNATION_PREPARE:
>>>> -		if (crashk_res.start)
>>>> +		if (kexec_crash_image)
>>> Why this change?
>> arch_kexec_protect_crashkres() will do the unmapping once kdump kernel is loaded
>> (i.e. kexec_crash_image is non-NULL), so we should check "kexec_crash_image" here
>> and do the corresponding re-mapping. 
>>
>> NULL crashk_res_image means that kdump kernel is not loaded, in this case mapping is
>> already setup either initially in reserve_crashkernel() or by arch_kexec_unprotect_crashkres().
> Sorry, I missed this obvious part. So your change seems to be ok here.
>
> There is another problem with your patch: The vmem_remove_mapping() function
> can only remove mappings which have been added by vmem_add_mapping() before.
> Therefore currently the vmem_remove_mapping() call is a nop and we still have
> a RW mapping after the kexec system call.
>
> If you check "/sys/kernel/debug/kernel_page_tables" you will see that the
> crashkernel memory is still mapped RW after loading kdump.
>
> To fix this we could keep the memblock_remove() and call vmem_add_mapping()
> from a init function (see patch below).

Indeed, thanks for the catching.

>
> [snip]
>
>>>> --- a/arch/s390/kernel/setup.c
>>>> +++ b/arch/s390/kernel/setup.c
>>>> @@ -603,7 +603,7 @@ static void __init reserve_crashkernel(void)
>>>>  	crashk_res.start = crash_base;
>>>>  	crashk_res.end = crash_base + crash_size - 1;
>>>>  	insert_resource(&iomem_resource, &crashk_res);
>>>> -	memblock_remove(crash_base, crash_size);
>>>> +	memblock_reserve(crash_base, crash_size);
>>> I will discuss this next week in our team.
>> This can address the bad page warning when shrinking crashk_res.
> Yes, shrinking crashkernel memory is currently broken on s390. Heiko Carstens
> (on cc) plans to do some general rework that probably will automatically fix
> this issue.

Since this is not critical issue, I'm fine with leaving it to Heiko's rework.

> So I would suggest that you merge the following with your initial patch and
> then resend the merged patch.
>
> What do you think?

That's great, I will send v2 later. Thanks for the review.

Regards,
Xunlei

>
> Michael
> ---------------8<----
> s390/kdump: Consolidate crash_map/unmap_reserved_pages() - update
>
>  - Move functions back to keep the patch small
>  - Consolidate crash_map_reserved_pages/arch_kexec_unprotect_crashkres()
>  - Re-introduce memblock_remove()
>  - Call arch_kexec_unprotect_crashkres() in machine_kdump_pm_init()
>
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> ---
>  arch/s390/kernel/machine_kexec.c |   88 +++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 48 deletions(-)
>
> --- a/arch/s390/kernel/machine_kexec.c
> +++ b/arch/s390/kernel/machine_kexec.c
> @@ -35,52 +35,6 @@ extern const unsigned long long relocate
>  #ifdef CONFIG_CRASH_DUMP
>  
>  /*
> - * Map or unmap crashkernel memory
> - */
> -static void crash_map_pages(int enable)
> -{
> -	unsigned long size = resource_size(&crashk_res);
> -
> -	BUG_ON(crashk_res.start % KEXEC_CRASH_MEM_ALIGN ||
> -	       size % KEXEC_CRASH_MEM_ALIGN);
> -	if (enable)
> -		vmem_add_mapping(crashk_res.start, size);
> -	else {
> -		vmem_remove_mapping(crashk_res.start, size);
> -		if (size)
> -			os_info_crashkernel_add(crashk_res.start, size);
> -		else
> -			os_info_crashkernel_add(0, 0);
> -	}
> -}
> -
> -/*
> - * Map crashkernel memory
> - */
> -static void crash_map_reserved_pages(void)
> -{
> -	crash_map_pages(1);
> -}
> -
> -/*
> - * Unmap crashkernel memory
> - */
> -static void crash_unmap_reserved_pages(void)
> -{
> -	crash_map_pages(0);
> -}
> -
> -void arch_kexec_protect_crashkres(void)
> -{
> -	crash_unmap_reserved_pages();
> -}
> -
> -void arch_kexec_unprotect_crashkres(void)
> -{
> -	crash_map_reserved_pages();
> -}
> -
> -/*
>   * PM notifier callback for kdump
>   */
>  static int machine_kdump_pm_cb(struct notifier_block *nb, unsigned long action,
> @@ -90,12 +44,12 @@ static int machine_kdump_pm_cb(struct no
>  	case PM_SUSPEND_PREPARE:
>  	case PM_HIBERNATION_PREPARE:
>  		if (kexec_crash_image)
> -			crash_map_reserved_pages();
> +			arch_kexec_unprotect_crashkres();
>  		break;
>  	case PM_POST_SUSPEND:
>  	case PM_POST_HIBERNATION:
>  		if (kexec_crash_image)
> -			crash_unmap_reserved_pages();
> +			arch_kexec_protect_crashkres();
>  		break;
>  	default:
>  		return NOTIFY_DONE;
> @@ -106,6 +60,8 @@ static int machine_kdump_pm_cb(struct no
>  static int __init machine_kdump_pm_init(void)
>  {
>  	pm_notifier(machine_kdump_pm_cb, 0);
> +	/* Create initial mapping for crashkernel memory */
> +	arch_kexec_unprotect_crashkres();
>  	return 0;
>  }
>  arch_initcall(machine_kdump_pm_init);
> @@ -193,6 +149,42 @@ static int kdump_csum_valid(struct kimag
>  }
>  
>  /*
> + * Map or unmap crashkernel memory
> + */
> +static void crash_map_pages(int enable)
> +{
> +	unsigned long size = resource_size(&crashk_res);
> +
> +	BUG_ON(crashk_res.start % KEXEC_CRASH_MEM_ALIGN ||
> +	       size % KEXEC_CRASH_MEM_ALIGN);
> +	if (enable)
> +		vmem_add_mapping(crashk_res.start, size);
> +	else {
> +		vmem_remove_mapping(crashk_res.start, size);
> +		if (size)
> +			os_info_crashkernel_add(crashk_res.start, size);
> +		else
> +			os_info_crashkernel_add(0, 0);
> +	}
> +}
> +
> +/*
> + * Unmap crashkernel memory
> + */
> +void arch_kexec_protect_crashkres(void)
> +{
> +	crash_map_pages(0);
> +}
> +
> +/*
> + * Map crashkernel memory
> + */
> +void arch_kexec_unprotect_crashkres(void)
> +{
> +	crash_map_pages(1);
> +}
> +
> +/*
>   * Give back memory to hypervisor before new kdump is loaded
>   */
>  static int machine_kexec_prepare_kdump(void)
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
