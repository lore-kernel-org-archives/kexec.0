Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUZRB-000817-4T
 for kexec@lists.infradead.org; Fri, 01 May 2020 17:26:59 +0000
Subject: Re: [PATCH] kexec: Discard loaded image on memory hotplug
References: <20200501165701.24587-1-james.morse@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <40b07632-b044-d1cd-96a2-81eec3da93e7@redhat.com>
Date: Fri, 1 May 2020 19:26:39 +0200
MIME-Version: 1.0
In-Reply-To: <20200501165701.24587-1-james.morse@arm.com>
Content-Language: en-US
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
To: James Morse <james.morse@arm.com>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc: Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>

On 01.05.20 18:57, James Morse wrote:
> On x86, the kexec payload contains a copy of the current memory map.
> If memory is added or removed, this copy of the memory map becomes
> stale. Getting this wrong may prevent the next kernel from booting.
> The first kernel may die if it tries to re-assemble the next kernel
> in memory that has been removed.
> 
> Discard the loaded kexec image when the memory map changes, user-space
> should reload it.
> 
> Kdump is unaffected, as it is placed within the crashkernel reserved
> memory area and only uses this memory. The stale memory map may affect
> generation of the vmcore, but the kdump kernel should be in a position
> to validate it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> This patch obsoletes:
>  * kexec/memory_hotplug: Prevent removal and accidental use
> https://lore.kernel.org/linux-arm-kernel/20200326180730.4754-1-james.morse@arm.com/
> 
>  kernel/kexec_core.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c19c0dad1ebe..e1901e5bd4b5 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/fs.h>
>  #include <linux/kexec.h>
> +#include <linux/memory.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/highmem.h>
> @@ -22,10 +23,12 @@
>  #include <linux/elf.h>
>  #include <linux/elfcore.h>
>  #include <linux/utsname.h>
> +#include <linux/notifier.h>
>  #include <linux/numa.h>
>  #include <linux/suspend.h>
>  #include <linux/device.h>
>  #include <linux/freezer.h>
> +#include <linux/pfn.h>
>  #include <linux/pm.h>
>  #include <linux/cpu.h>
>  #include <linux/uaccess.h>
> @@ -1219,3 +1222,40 @@ void __weak arch_kexec_protect_crashkres(void)
>  
>  void __weak arch_kexec_unprotect_crashkres(void)
>  {}
> +
> +/*
> + * If the memory layout changes, any loaded kexec image should be evicted
> + * as it may contain a copy of the (now stale) memory map. This also means
> + * we don't need to check the memory is still present when re-assembling the
> + * new kernel at machine_kexec() time.
> + */

Onlining/offlining is not a change of the memory map.



-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
