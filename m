Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKun9-0005hU-Hn
 for kexec@lists.infradead.org; Wed, 23 Sep 2020 02:46:00 +0000
Date: Wed, 23 Sep 2020 10:45:48 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/3] MIPS: Crash kernel should be able to see old memories
Message-ID: <20200923024548.GL25604@MiWiFi-R3L-srv>
References: <1600828257-31316-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1600828257-31316-1-git-send-email-chenhc@lemote.com>
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
To: Huacai Chen <chenhc@lemote.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Huacai Chen <chenhuacai@gmail.com>, kexec@lists.infradead.org, linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, Eric Biederman <ebiederm@xmission.com>, Fuxin Zhang <zhangfx@lemote.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 09/23/20 at 10:30am, Huacai Chen wrote:
> Kexec-tools use mem=X@Y to pass usable memories to crash kernel, but in
> commit a94e4f24ec836c8984f83959 ("MIPS: init: Drop boot_mem_map") all
> BIOS passed memories are removed by early_parse_mem(). I think this is
> reasonable for a normal kernel but not for a crash kernel, because a
> crash kernel should be able to see all old memories, even though it is
> not supposed to use them.

I am not familiar with MIPS code, but we analyze and fill memmap= to
pass usable memory to crashkenrel in kexec-tools, do you mean you are
specifying memmap= or mem= by hand?

And we don't have mem=X@Y, only mem=nn[KMG].

> 
> Fixes: a94e4f24ec836c8984f83959 ("MIPS: init: Drop boot_mem_map")
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/kernel/setup.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 4c04a86..e2804a2 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -392,8 +392,10 @@ static int __init early_parse_mem(char *p)
>  	 */
>  	if (usermem == 0) {
>  		usermem = 1;
> +#ifndef CONFIG_CRASH_DUMP
>  		memblock_remove(memblock_start_of_DRAM(),
>  			memblock_end_of_DRAM() - memblock_start_of_DRAM());
> +#endif
>  	}
>  	start = 0;
>  	size = memparse(p, &p);
> -- 
> 2.7.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
