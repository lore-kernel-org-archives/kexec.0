Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kI0cN-0008JJ-9m
 for kexec@lists.infradead.org; Tue, 15 Sep 2020 02:22:52 +0000
Date: Tue, 15 Sep 2020 10:20:23 +0800
From: Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v2 2/7] kernel/resource: move and rename
 IORESOURCE_MEM_DRIVER_MANAGED
Message-ID: <20200915022023.GD2007@L-31X9LVDL-1304.local>
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-3-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200908201012.44168-3-david@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, linux-acpi@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-nvdimm@lists.01.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Eric Biederman <ebiederm@xmission.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>

On Tue, Sep 08, 2020 at 10:10:07PM +0200, David Hildenbrand wrote:
>IORESOURCE_MEM_DRIVER_MANAGED currently uses an unused PnP bit, which is
>always set to 0 by hardware. This is far from beautiful (and confusing),
>and the bit only applies to SYSRAM. So let's move it out of the
>bus-specific (PnP) defined bits.
>
>We'll add another SYSRAM specific bit soon. If we ever need more bits for
>other purposes, we can steal some from "desc", or reshuffle/regroup what we
>have.

I think you make this definition because we use IORESOURCE_SYSRAM_RAM for
hotpluged memory? So we make them all in IORESOURCE_SYSRAM_XXX family?

>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Jason Gunthorpe <jgg@ziepe.ca>
>Cc: Kees Cook <keescook@chromium.org>
>Cc: Ard Biesheuvel <ardb@kernel.org>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Wei Yang <richardw.yang@linux.intel.com>
>Cc: Eric Biederman <ebiederm@xmission.com>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: kexec@lists.infradead.org
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> include/linux/ioport.h | 4 +++-
> kernel/kexec_file.c    | 2 +-
> mm/memory_hotplug.c    | 4 ++--
> 3 files changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>index 52a91f5fa1a36..d7620d7c941a0 100644
>--- a/include/linux/ioport.h
>+++ b/include/linux/ioport.h
>@@ -58,6 +58,9 @@ struct resource {
> #define IORESOURCE_EXT_TYPE_BITS 0x01000000	/* Resource extended types */
> #define IORESOURCE_SYSRAM	0x01000000	/* System RAM (modifier) */
> 
>+/* IORESOURCE_SYSRAM specific bits. */
>+#define IORESOURCE_SYSRAM_DRIVER_MANAGED	0x02000000 /* Always detected via a driver. */
>+
> #define IORESOURCE_EXCLUSIVE	0x08000000	/* Userland may not map this resource */
> 
> #define IORESOURCE_DISABLED	0x10000000
>@@ -103,7 +106,6 @@ struct resource {
> #define IORESOURCE_MEM_32BIT		(3<<3)
> #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
> #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
>-#define IORESOURCE_MEM_DRIVER_MANAGED	(1<<7)
> 
> /* PnP I/O specific bits (IORESOURCE_BITS) */
> #define IORESOURCE_IO_16BIT_ADDR	(1<<0)
>diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>index ca40bef75a616..dfeeed1aed084 100644
>--- a/kernel/kexec_file.c
>+++ b/kernel/kexec_file.c
>@@ -520,7 +520,7 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> 	/* Returning 0 will take to next memory range */
> 
> 	/* Don't use memory that will be detected and handled by a driver. */
>-	if (res->flags & IORESOURCE_MEM_DRIVER_MANAGED)
>+	if (res->flags & IORESOURCE_SYSRAM_DRIVER_MANAGED)
> 		return 0;
> 
> 	if (sz < kbuf->memsz)
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 4c47b68a9f4b5..8e1cd18b5cf14 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -105,7 +105,7 @@ static struct resource *register_memory_resource(u64 start, u64 size,
> 	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> 
> 	if (strcmp(resource_name, "System RAM"))
>-		flags |= IORESOURCE_MEM_DRIVER_MANAGED;
>+		flags |= IORESOURCE_SYSRAM_DRIVER_MANAGED;
> 
> 	/*
> 	 * Make sure value parsed from 'mem=' only restricts memory adding
>@@ -1160,7 +1160,7 @@ EXPORT_SYMBOL_GPL(add_memory);
>  *
>  * For this memory, no entries in /sys/firmware/memmap ("raw firmware-provided
>  * memory map") are created. Also, the created memory resource is flagged
>- * with IORESOURCE_MEM_DRIVER_MANAGED, so in-kernel users can special-case
>+ * with IORESOURCE_SYSRAM_DRIVER_MANAGED, so in-kernel users can special-case
>  * this memory as well (esp., not place kexec images onto it).
>  *
>  * The resource_name (visible via /proc/iomem) has to have the format
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
