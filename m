Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwlD3-009e4P-0G
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 13:17:43 +0000
Date: Mon, 13 Dec 2021 21:17:13 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v17 01/10] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
Message-ID: <20211213131713.GA23510@MiWiFi-R3L-srv>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211210065533.2023-2-thunder.leizhen@huawei.com>
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
> Move CRASH_ALIGN to header asm/kexec.h for later use.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Suggested-by: Baoquan He <bhe@redhat.com>

I remember Dave and I discussed and suggested this when reviewing.
You can remove my Suggested-by.

For this one, I would like to add ack:

Acked-by: Baoquan He <bhe@redhat.com>

> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>  arch/x86/include/asm/kexec.h | 3 +++
>  arch/x86/kernel/setup.c      | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 11b7c06e2828c30..3a22e65262aa70b 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -18,6 +18,9 @@
>  
>  # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
>  
> +/* 16M alignment for crash kernel regions */
> +#define CRASH_ALIGN		SZ_16M
> +
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/string.h>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 6a190c7f4d71b05..5cc60996eac56d6 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -392,9 +392,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>  
>  #ifdef CONFIG_KEXEC_CORE
>  
> -/* 16M alignment for crash kernel regions */
> -#define CRASH_ALIGN		SZ_16M
> -
>  /*
>   * Keep the crash kernel below this limit.
>   *
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
