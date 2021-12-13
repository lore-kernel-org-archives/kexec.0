Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <0d3e6361-0850-4273-6d43-8e40a80c6916@oracle.com>
Date: Mon, 13 Dec 2021 08:28:14 -0600
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
Content-Language: en-US
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
From: john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-4-thunder.leizhen@huawei.com>
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
> To make the functions reserve_crashkernel() as generic,
> replace some hard-coded numbers with macro CRASH_ADDR_LOW_MAX.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>

  Acked-by: John Donnelly <john.p.donnelly@oracle.com>

> ---
>   arch/x86/kernel/setup.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 6424ee4f23da2cf..bb2a0973b98059e 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -489,8 +489,9 @@ static void __init reserve_crashkernel(void)
>   	if (!crash_base) {
>   		/*
>   		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> -		 * crashkernel=x,high reserves memory over 4G, also allocates
> -		 * 256M extra low memory for DMA buffers and swiotlb.
> +		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
> +		 * also allocates 256M extra low memory for DMA buffers
> +		 * and swiotlb.
>   		 * But the extra memory is not required for all machines.
>   		 * So try low memory first and fall back to high memory
>   		 * unless "crashkernel=size[KMG],high" is specified.
> @@ -518,7 +519,7 @@ static void __init reserve_crashkernel(void)
>   		}
>   	}
>   
> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> +	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
>   		memblock_phys_free(crash_base, crash_size);
>   		return;
>   	}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
