Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Shahab Vahedi <Shahab.Vahedi@synopsys.com>
Subject: Re: [PATCH v2 3/5] memblock: allow to specify flags with
 memblock_add_node()
Date: Mon, 4 Oct 2021 19:31:41 +0000
Message-ID: <26257713-7e2e-f3bd-8d8e-73d664193f68@synopsys.com>
References: <20211004093605.5830-1-david@redhat.com>
 <20211004093605.5830-4-david@redhat.com>
In-Reply-To: <20211004093605.5830-4-david@redhat.com>
Content-Language: en-US
Content-ID: <E90DB24CCA06ED4AAE9B59099C8A674B@namprd12.prod.outlook.com>
MIME-Version: 1.0
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
To: David Hildenbrand <david@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Jianyong Wu <Jianyong.Wu@arm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 10/4/21 11:36 AM, David Hildenbrand wrote:
> We want to specify flags when hotplugging memory. Let's prepare to pass
> flags to memblock_add_node() by adjusting all existing users.
> 
> Note that when hotplugging memory the system is already up and running
> and we might have concurrent memblock users: for example, while we're
> hotplugging memory, kexec_file code might search for suitable memory
> regions to place kexec images. It's important to add the memory directly
> to memblock via a single call with the right flags, instead of adding the
> memory first and apply flags later: otherwise, concurrent memblock users
> might temporarily stumble over memblocks with wrong flags, which will be
> important in a follow-up patch that introduces a new flag to properly
> handle add_memory_driver_managed().
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/arc/mm/init.c               | 4 ++--
>  arch/ia64/mm/contig.c            | 2 +-
>  arch/ia64/mm/init.c              | 2 +-
>  arch/m68k/mm/mcfmmu.c            | 3 ++-
>  arch/m68k/mm/motorola.c          | 6 ++++--
>  arch/mips/loongson64/init.c      | 4 +++-
>  arch/mips/sgi-ip27/ip27-memory.c | 3 ++-
>  arch/s390/kernel/setup.c         | 3 ++-
>  include/linux/memblock.h         | 3 ++-
>  include/linux/mm.h               | 2 +-
>  mm/memblock.c                    | 9 +++++----
>  mm/memory_hotplug.c              | 2 +-
>  12 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
> index 699ecf119641..110eb69e9bee 100644
> --- a/arch/arc/mm/init.c
> +++ b/arch/arc/mm/init.c
> @@ -59,13 +59,13 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>  
>  		low_mem_sz = size;
>  		in_use = 1;
> -		memblock_add_node(base, size, 0);
> +		memblock_add_node(base, size, 0, MEMBLOCK_NONE);
>  	} else {
>  #ifdef CONFIG_HIGHMEM
>  		high_mem_start = base;
>  		high_mem_sz = size;
>  		in_use = 1;
> -		memblock_add_node(base, size, 1);
> +		memblock_add_node(base, size, 1, MEMBLOCK_NONE);
>  		memblock_reserve(base, size);
>  #endif

arch/arc part: Acked-by: Shahab Vahedi <shahab@synopsys.com>

-- 
Shahab
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
