Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 5 Oct 2020 18:12:49 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v12 7/9] kdump: add threshold for the required memory
Message-ID: <20201005171248.GB14576@gaia>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-8-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200907134745.25732-8-chenzhou10@huawei.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Chen Zhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On Mon, Sep 07, 2020 at 09:47:43PM +0800, Chen Zhou wrote:
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 3f735cb37ace..d11d597a470d 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -378,6 +378,15 @@ int __init reserve_crashkernel_low(void)
>  }
>  
>  #if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> +
> +/*
> + * Add a threshold for required memory size of crashkernel. If required memory
> + * size is greater than threshold, just go for high allocation directly. The
> + * value of threshold is set as half of the total low memory.
> + */
> +#define REQUIRED_MEMORY_THRESHOLD	(memblock_mem_size(CRASH_ADDR_LOW_MAX >> \
> +			PAGE_SHIFT) >> 1)
> +
>  #ifdef CONFIG_KEXEC_CORE
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
> @@ -422,7 +431,7 @@ void __init reserve_crashkernel(void)
>  		 * So try low memory first and fall back to high memory
>  		 * unless "crashkernel=size[KMG],high" is specified.
>  		 */
> -		if (!high)
> +		if (!high && crash_size <= REQUIRED_MEMORY_THRESHOLD)
>  			crash_base = memblock_find_in_range(CRASH_ALIGN,
>  						CRASH_ADDR_LOW_MAX,
>  						crash_size, CRASH_ALIGN);

Since any change now is affecting the x86 semantics slightly, I'd
suggest you drop this patch. We can add it later if needed, once the
core changes are in.

Thinking about this, if one requires a crashkernel reservation that
allocates all of the ZONE_DMA, it would probably be noticed and explicit
,high/,low options can be used.

Note that we are also trying to make ZONE_DMA full 32-bit on non-RPi4
hardware.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
