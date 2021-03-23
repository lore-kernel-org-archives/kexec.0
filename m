Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOi62-00FAuS-9Z
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 14:33:29 +0000
Date: Tue, 23 Mar 2021 22:33:03 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v1 1/3] kernel/resource: make walk_system_ram_res() find
 all busy IORESOURCE_SYSTEM_RAM resources
Message-ID: <20210323143303.GC13786@MiWiFi-R3L-srv>
References: <20210322160200.19633-1-david@redhat.com>
 <20210322160200.19633-2-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210322160200.19633-2-david@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Keith Busch <keith.busch@intel.com>, Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>, Oscar Salvador <osalvador@suse.de>, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org, kexec@lists.infradead.org

On 03/22/21 at 05:01pm, David Hildenbrand wrote:
> It used to be true that we can have busy system RAM only on the first level
> in the resourc tree. However, this is no longer holds for driver-managed
> system RAM (i.e., added via dax/kmem and virtio-mem), which gets added on
> lower levels.
> 
> We have two users of walk_system_ram_res(), which currently only
> consideres the first level:
> a) kernel/kexec_file.c:kexec_walk_resources() -- We properly skip
>    IORESOURCE_SYSRAM_DRIVER_MANAGED resources via
>    locate_mem_hole_callback(), so even after this change, we won't be
>    placing kexec images onto dax/kmem and virtio-mem added memory. No
>    change.
> b) arch/x86/kernel/crash.c:fill_up_crash_elf_data() -- we're currently
>    not adding relevant ranges to the crash elf info, resulting in them
>    not getting dumped via kdump.
> 
> This change fixes loading a crashkernel via kexec_file_load() and including
> dax/kmem and virtio-mem added System RAM in the crashdump on x86-64. Note
> that e.g,, arm64 relies on memblock data and, therefore, always considers
> all added System RAM already.
> 
> Let's find all busy IORESOURCE_SYSTEM_RAM resources, making the function
> behave like walk_system_ram_range().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Signed-off-by: David Hildenbrand <david@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: x86@kernel.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  kernel/resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 627e61b0c124..4efd6e912279 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -457,7 +457,7 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
>  {
>  	unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>  
> -	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, true,
> +	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, false,
>  				     arg, func);

Thanks, David, this is a good fix.

Acked-by: Baoquan He <bhe@redhat.com>

>  }
>  
> -- 
> 2.29.2
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
