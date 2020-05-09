Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 8 May 2020 17:45:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] mm/memory_hotplug: Allow arch override of non boot
 memory resource names
Message-Id: <20200508174536.77c7aa3d5d0220cedd07f2e9@linux-foundation.org>
In-Reply-To: <20200326180730.4754-3-james.morse@arm.com>
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-3-james.morse@arm.com>
Mime-Version: 1.0
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
To: James Morse <james.morse@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, Eric Biederman <ebiederm@xmission.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

On Thu, 26 Mar 2020 18:07:29 +0000 James Morse <james.morse@arm.com> wrote:

> Memory added to the system by hotplug has a 'System RAM' resource created
> for it. This is exposed to user-space via /proc/iomem.
> 
> This poses problems for kexec on arm64. If kexec decides to place the
> kernel in one of these newly onlined regions, the new kernel will find
> itself booting from a region not described as memory in the firmware
> tables.
> 
> Arm64 doesn't have a structure like the e820 memory map that can be
> re-written when memory is brought online. Instead arm64 uses the UEFI
> memory map, or the memory node from the DT, sometimes both. We never
> rewrite these.
> 
> Allow an architecture to specify a different name for these hotplug
> regions.
> 
> ...
>
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -42,6 +42,10 @@
>  #include "internal.h"
>  #include "shuffle.h"
>  
> +#ifndef MEMORY_HOTPLUG_RES_NAME
> +#define MEMORY_HOTPLUG_RES_NAME "System RAM"
> +#endif
> +
>  /*
>   * online_page_callback contains pointer to current page onlining function.
>   * Initially it is generic_online_page(). If it is required it could be
> @@ -103,7 +107,7 @@ static struct resource *register_memory_resource(u64 start, u64 size)
>  {
>  	struct resource *res;
>  	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> -	char *resource_name = "System RAM";
> +	char *resource_name = MEMORY_HOTPLUG_RES_NAME;
>  
>  	if (start + size > max_mem_size)
>  		return ERR_PTR(-E2BIG);

I suppose we should do this as well:

--- a/mm/memory_hotplug.c~mm-memory_hotplug-allow-arch-override-of-non-boot-memory-resource-names-fix
+++ a/mm/memory_hotplug.c
@@ -129,7 +129,8 @@ static struct resource *register_memory_
 			       resource_name, flags);
 
 	if (!res) {
-		pr_debug("Unable to reserve System RAM region: %016llx->%016llx\n",
+		pr_debug("Unable to reserve " MEMORY_HOTPLUG_RES_NAME
+				" region: %016llx->%016llx\n",
 				start, start + size);
 		return ERR_PTR(-EEXIST);
 	}

It assumes that MEMORY_HOTPLUG_RES_NAME will be a literal string, which
is the case in [3/3].


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
