Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mx3aL-00D8Sv-Ui
 for kexec@lists.infradead.org; Tue, 14 Dec 2021 08:54:59 +0000
Date: Tue, 14 Dec 2021 16:54:40 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
Message-ID: <20211214085440.GA3023@MiWiFi-R3L-srv>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211210065533.2023-4-thunder.leizhen@huawei.com>
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
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

On 12/10/21 at 02:55pm, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> To make the functions reserve_crashkernel() as generic,
> replace some hard-coded numbers with macro CRASH_ADDR_LOW_MAX.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

If you made change to this patch, please remove the old Acked-by. If you
didn't contribute change, Signed-off-by should be taken off.

Compared this with the version I acked, only see
memblock_free() -> memblock_phys_free() update which should be done
from the rebase.

So ack this one again, and please also consider adding Co-developed-by.

> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/kernel/setup.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 6424ee4f23da2cf..bb2a0973b98059e 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -489,8 +489,9 @@ static void __init reserve_crashkernel(void)
>  	if (!crash_base) {
>  		/*
>  		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> -		 * crashkernel=x,high reserves memory over 4G, also allocates
> -		 * 256M extra low memory for DMA buffers and swiotlb.
> +		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
> +		 * also allocates 256M extra low memory for DMA buffers
> +		 * and swiotlb.
>  		 * But the extra memory is not required for all machines.
>  		 * So try low memory first and fall back to high memory
>  		 * unless "crashkernel=size[KMG],high" is specified.
> @@ -518,7 +519,7 @@ static void __init reserve_crashkernel(void)
>  		}
>  	}
>  
> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> +	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
>  		memblock_phys_free(crash_base, crash_size);
>  		return;
>  	}
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
