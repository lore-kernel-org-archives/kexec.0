Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKv3D-0006wV-LU
 for kexec@lists.infradead.org; Wed, 23 Sep 2020 03:02:37 +0000
Subject: Re: [PATCH 1/3] MIPS: Crash kernel should be able to see old memories
References: <1600828257-31316-1-git-send-email-chenhc@lemote.com>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <e91c0c4d-ff35-1eee-22c5-e2e258e618ec@loongson.cn>
Date: Wed, 23 Sep 2020 11:02:20 +0800
MIME-Version: 1.0
In-Reply-To: <1600828257-31316-1-git-send-email-chenhc@lemote.com>
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
To: Huacai Chen <chenhc@lemote.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: Huacai Chen <chenhuacai@gmail.com>, kexec@lists.infradead.org, linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, Fuxin Zhang <zhangfx@lemote.com>

On 09/23/2020 10:30 AM, Huacai Chen wrote:
> Kexec-tools use mem=X@Y to pass usable memories to crash kernel, but in
> commit a94e4f24ec836c8984f83959 ("MIPS: init: Drop boot_mem_map") all
> BIOS passed memories are removed by early_parse_mem(). I think this is
> reasonable for a normal kernel but not for a crash kernel, because a
> crash kernel should be able to see all old memories, even though it is
> not supposed to use them.
>
> Fixes: a94e4f24ec836c8984f83959 ("MIPS: init: Drop boot_mem_map")
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   arch/mips/kernel/setup.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 4c04a86..e2804a2 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -392,8 +392,10 @@ static int __init early_parse_mem(char *p)
>   	 */
>   	if (usermem == 0) {
>   		usermem = 1;
> +#ifndef CONFIG_CRASH_DUMP
>   		memblock_remove(memblock_start_of_DRAM(),
>   			memblock_end_of_DRAM() - memblock_start_of_DRAM());
> +#endif

Hi, Huacai,

For this patch, I knew something what had happened. "mem=" parsing
works wrong for Loongson64. You can referenced the follow patch:
https://patchwork.kernel.org/patch/11789555/

memblock_add() calls memblock_add_range(,,, MAX_NUMNODES,)
For Loongson64 enabling NUMA, we need memblock_add_node(). (Or
using memblock_set_node() after memblock_add())

Besides, "mem=" may be useless for kdump. Youling had submitted a patch
about removing "mem="  serveral days ago.

For Loongson64 platform, you can try crashkernel=SIZE@38M after fixed 
"mem=".
38M means 40M - 2M, 2M is needed because old firmware compatibility.

Thanks,
- Jinyang.

>   	}
>   	start = 0;
>   	size = memparse(p, &p);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
