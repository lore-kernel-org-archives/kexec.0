Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <a9070375-e4d0-d17f-6749-a7701c1a9bf3@oracle.com>
Date: Mon, 13 Dec 2021 08:29:07 -0600
Subject: Re: [PATCH v17 04/10] x86: kdump: move xen_pv_domain() check and
 insert_resource() to setup_arch()
Content-Language: en-US
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-5-thunder.leizhen@huawei.com>
From: john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhen Lei <thunder.leizhen@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

On 12/10/21 12:55 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> We will make the functions reserve_crashkernel() as generic, the
> xen_pv_domain() check in reserve_crashkernel() is relevant only to
> x86, the same as insert_resource() in reserve_crashkernel[_low]().
> So move xen_pv_domain() check and insert_resource() to setup_arch()
> to keep them in x86.
> 
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>

  Acked-by: John Donnelly <john.p.donnelly@oracle.com>

> ---
>   arch/x86/kernel/setup.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index bb2a0973b98059e..7ae00716a208f82 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -456,7 +456,6 @@ static int __init reserve_crashkernel_low(void)
>   
>   	crashk_low_res.start = low_base;
>   	crashk_low_res.end   = low_base + low_size - 1;
> -	insert_resource(&iomem_resource, &crashk_low_res);
>   #endif
>   	return 0;
>   }
> @@ -480,11 +479,6 @@ static void __init reserve_crashkernel(void)
>   		high = true;
>   	}
>   
> -	if (xen_pv_domain()) {
> -		pr_info("Ignoring crashkernel for a Xen PV domain\n");
> -		return;
> -	}
> -
>   	/* 0 means: find the address automatically */
>   	if (!crash_base) {
>   		/*
> @@ -531,7 +525,6 @@ static void __init reserve_crashkernel(void)
>   
>   	crashk_res.start = crash_base;
>   	crashk_res.end   = crash_base + crash_size - 1;
> -	insert_resource(&iomem_resource, &crashk_res);
>   }
>   #else
>   static void __init reserve_crashkernel(void)
> @@ -1143,7 +1136,17 @@ void __init setup_arch(char **cmdline_p)
>   	 * Reserve memory for crash kernel after SRAT is parsed so that it
>   	 * won't consume hotpluggable memory.
>   	 */
> -	reserve_crashkernel();
> +	if (xen_pv_domain())
> +		pr_info("Ignoring crashkernel for a Xen PV domain\n");
> +	else {
> +		reserve_crashkernel();
> +#ifdef CONFIG_KEXEC_CORE
> +		if (crashk_res.end > crashk_res.start)
> +			insert_resource(&iomem_resource, &crashk_res);
> +		if (crashk_low_res.end > crashk_low_res.start)
> +			insert_resource(&iomem_resource, &crashk_low_res);
> +#endif
> +	}
>   
>   	memblock_find_dma_reserve();
>   


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
