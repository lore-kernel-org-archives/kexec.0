Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tvoa4-0003Gf-LZ
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 12:28:30 +0000
Date: Thu, 17 Jan 2013 13:28:03 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 1/3] kexec: extend hypercall with improved load/unload ops
Message-ID: <20130117122803.GC2871@host-192-168-1-59.local.net-space.pl>
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
 <1358353746-1899-2-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1358353746-1899-2-git-send-email-david.vrabel@citrix.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, xen-devel@lists.xen.org

On Wed, Jan 16, 2013 at 04:29:04PM +0000, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
>
> In the existing kexec hypercall, the load and unload ops depend on
> internals of the Linux kernel (the page list and code page provided by
> the kernel).  The code page is used to transition between Xen context
> and the image so using kernel code doesn't make sense and will not
> work for PVH guests.
>
> Add replacement KEXEC_CMD_kexec_load_v2 and KEXEC_CMD_kexec_unload_v2
> ops that no longer require a code page to be provided by the guest --
> Xen now provides the code for calling the image directly.
>
> The load_v2 op looks similar to the Linux kexec_load system call and
> allows the guest to provide the image data to be loaded into the crash
> kernel memory region.  The guest may also specify whether the image is
> 64-bit or 32-bit.
>
> The toolstack can now load images without kernel involvement.  This is
> required for supporting kexec of crash kernels from PV-ops kernels.
>
> Note: This also changes the behaviour of the kexec op when a image is
> loaded with the old ABI.  The code page will no longer be used which
> may result is incorrect behaviour in non-Linux guests.  This allowed
> the code to be simpler and support for the old ABI is being removed in
> a subsequent patch anyway.
>
> [ This is a prototype and has the following limitations:
>
> - no compat implementation for kexec_load_v2.
> - 64-bit images are not supported.
> - 32-bit images are called with paging enabled (Linux starts 32-bit
>   images with paging disabled). ]
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> ---
>  xen/arch/x86/machine_kexec.c       |   73 ++------------
>  xen/arch/x86/x86_64/compat_kexec.S |   25 -----
>  xen/common/kexec.c                 |  204 ++++++++++++++++++++++++++++++++++--
>  xen/include/public/kexec.h         |   44 ++++++++
>  xen/include/xen/kexec.h            |   18 ++--
>  5 files changed, 255 insertions(+), 109 deletions(-)
>
> diff --git a/xen/arch/x86/machine_kexec.c b/xen/arch/x86/machine_kexec.c
> index 8191ef1..7131d20 100644
> --- a/xen/arch/x86/machine_kexec.c
> +++ b/xen/arch/x86/machine_kexec.c
> @@ -12,62 +12,16 @@
>  #include <asm/fixmap.h>
>  #include <asm/hpet.h>
>
> -typedef void (*relocate_new_kernel_t)(
> -                unsigned long indirection_page,
> -                unsigned long *page_list,
> -                unsigned long start_address,
> -                unsigned int preserve_context);
> -
> -int machine_kexec_load(int type, int slot, xen_kexec_image_t *image)
> +int machine_kexec_load(struct kexec_image *image)
>  {
> -    unsigned long prev_ma = 0;
> -    int fix_base = FIX_KEXEC_BASE_0 + (slot * (KEXEC_XEN_NO_PAGES >> 1));
> -    int k;
> -
> -    /* setup fixmap to point to our pages and record the virtual address
> -     * in every odd index in page_list[].
> -     */
> -
> -    for ( k = 0; k < KEXEC_XEN_NO_PAGES; k++ )
> -    {
> -        if ( (k & 1) == 0 )
> -        {
> -            /* Even pages: machine address. */
> -            prev_ma = image->page_list[k];
> -        }
> -        else
> -        {
> -            /* Odd pages: va for previous ma. */
> -            if ( is_pv_32on64_domain(dom0) )
> -            {
> -                /*
> -                 * The compatability bounce code sets up a page table
> -                 * with a 1-1 mapping of the first 1G of memory so
> -                 * VA==PA here.
> -                 *
> -                 * This Linux purgatory code still sets up separate
> -                 * high and low mappings on the control page (entries
> -                 * 0 and 1) but it is harmless if they are equal since
> -                 * that PT is not live at the time.
> -                 */
> -                image->page_list[k] = prev_ma;
> -            }
> -            else
> -            {
> -                set_fixmap(fix_base + (k >> 1), prev_ma);
> -                image->page_list[k] = fix_to_virt(fix_base + (k >> 1));
> -            }
> -        }
> -    }
> -
>      return 0;
>  }
>
> -void machine_kexec_unload(int type, int slot, xen_kexec_image_t *image)
> +void machine_kexec_unload(struct kexec_image *image)
>  {
>  }
>
> -void machine_reboot_kexec(xen_kexec_image_t *image)
> +void machine_reboot_kexec(struct kexec_image *image)
>  {
>      BUG_ON(smp_processor_id() != 0);
>      smp_send_stop();
> @@ -75,7 +29,7 @@ void machine_reboot_kexec(xen_kexec_image_t *image)
>      BUG();
>  }
>
> -void machine_kexec(xen_kexec_image_t *image)
> +void machine_kexec(struct kexec_image *image)
>  {
>      struct desc_ptr gdt_desc = {
>          .base = (unsigned long)(boot_cpu_gdt_table - FIRST_RESERVED_GDT_ENTRY),
> @@ -116,22 +70,11 @@ void machine_kexec(xen_kexec_image_t *image)
>       */
>      asm volatile ( "lgdt %0" : : "m" (gdt_desc) );
>
> -    if ( is_pv_32on64_domain(dom0) )
> -    {
> -        compat_machine_kexec(image->page_list[1],
> -                             image->indirection_page,
> -                             image->page_list,
> -                             image->start_address);
> -    }
> +    if ( image->class == KEXEC_CLASS_32 )
> +        compat_machine_kexec(image->entry_maddr);

Why do you need that?

>      else
> -    {
> -        relocate_new_kernel_t rnk;
> -
> -        rnk = (relocate_new_kernel_t) image->page_list[1];
> -        (*rnk)(image->indirection_page, image->page_list,
> -               image->start_address,
> -               0 /* preserve_context */);
> -    }
> +        /* FIXME */
> +        panic("KEXEC_CLASS_64 not yet supported\n");
>  }
>
>  int machine_kexec_get(xen_kexec_range_t *range)
> diff --git a/xen/arch/x86/x86_64/compat_kexec.S b/xen/arch/x86/x86_64/compat_kexec.S
> index fc92af9..d853231 100644
> --- a/xen/arch/x86/x86_64/compat_kexec.S
> +++ b/xen/arch/x86/x86_64/compat_kexec.S
> @@ -36,21 +36,6 @@
>  ENTRY(compat_machine_kexec)
>          /* x86/64                        x86/32  */
>          /* %rdi - relocate_new_kernel_t  CALL    */
> -        /* %rsi - indirection page       4(%esp) */
> -        /* %rdx - page_list              8(%esp) */
> -        /* %rcx - start address         12(%esp) */
> -        /*        cpu has pae           16(%esp) */
> -
> -        /* Shim the 64 bit page_list into a 32 bit page_list. */
> -        mov $12,%r9
> -        lea compat_page_list(%rip), %rbx
> -1:      dec %r9
> -        movl (%rdx,%r9,8),%eax
> -        movl %eax,(%rbx,%r9,4)
> -        test %r9,%r9
> -        jnz 1b
> -
> -        RELOCATE_SYM(compat_page_list,%rdx)
>
>          /* Relocate compatibility mode entry point address. */
>          RELOCATE_MEM(compatibility_mode_far,%eax)
> @@ -118,12 +103,6 @@ compatibility_mode:
>          movl %eax, %gs
>          movl %eax, %ss
>
> -        /* Push arguments onto stack. */
> -        pushl $0   /* 20(%esp) - preserve context */
> -        pushl $1   /* 16(%esp) - cpu has pae */
> -        pushl %ecx /* 12(%esp) - start address */
> -        pushl %edx /*  8(%esp) - page list */
> -        pushl %esi /*  4(%esp) - indirection page */
>          pushl %edi /*  0(%esp) - CALL */
>
>          /* Disable paging and therefore leave 64 bit mode. */
> @@ -153,10 +132,6 @@ compatibility_mode:
>          ud2
>
>          .data
> -        .align 4
> -compat_page_list:
> -        .fill 12,4,0
> -
>          .align 32,0
>
>          /*
> diff --git a/xen/common/kexec.c b/xen/common/kexec.c
> index 25ebd6a..56bf8b4 100644
> --- a/xen/common/kexec.c
> +++ b/xen/common/kexec.c
> @@ -45,7 +45,7 @@ static Elf_Note *xen_crash_note;
>
>  static cpumask_t crash_saved_cpus;
>
> -static xen_kexec_image_t kexec_image[KEXEC_IMAGE_NR];
> +static struct kexec_image kexec_image[KEXEC_IMAGE_NR];
>
>  #define KEXEC_FLAG_DEFAULT_POS   (KEXEC_IMAGE_NR + 0)
>  #define KEXEC_FLAG_CRASH_POS     (KEXEC_IMAGE_NR + 1)
> @@ -316,7 +316,7 @@ void kexec_crash(void)
>
>  static long kexec_reboot(void *_image)
>  {
> -    xen_kexec_image_t *image = _image;
> +    struct kexec_image *image = _image;
>
>      kexecing = TRUE;
>
> @@ -732,9 +732,19 @@ static void crash_save_vmcoreinfo(void)
>  #endif
>  }
>
> +static void kexec_unload_slot(int slot)
> +{
> +    struct kexec_image *image = &kexec_image[slot];
> +
> +    if ( test_and_clear_bit(slot, &kexec_flags) )
> +    {
> +        machine_kexec_unload(image);
> +    }
> +}
> +
>  static int kexec_load_unload_internal(unsigned long op, xen_kexec_load_t *load)
>  {
> -    xen_kexec_image_t *image;
> +    struct kexec_image *image;
>      int base, bit, pos;
>      int ret = 0;
>
> @@ -750,9 +760,13 @@ static int kexec_load_unload_internal(unsigned long op, xen_kexec_load_t *load)
>
>          BUG_ON(test_bit((base + !pos), &kexec_flags)); /* must be free */
>
> -        memcpy(image, &load->image, sizeof(*image));
> +        if ( is_pv_32on64_domain(dom0) )
> +            image->class = KEXEC_CLASS_32;
> +        else
> +            image->class = KEXEC_CLASS_64;

Ditto.

> +        image->entry_maddr = load->image.start_address;
>
> -        if ( !(ret = machine_kexec_load(load->type, base + !pos, image)) )
> +        if ( !(ret = machine_kexec_load(image)) )
>          {
>              /* Set image present bit */
>              set_bit((base + !pos), &kexec_flags);
> @@ -767,11 +781,7 @@ static int kexec_load_unload_internal(unsigned long op, xen_kexec_load_t *load)
>      /* Unload the old image if present and load successful */
>      if ( ret == 0 && !test_bit(KEXEC_FLAG_IN_PROGRESS, &kexec_flags) )
>      {
> -        if ( test_and_clear_bit((base + pos), &kexec_flags) )
> -        {
> -            image = &kexec_image[base + pos];
> -            machine_kexec_unload(load->type, base + pos, image);
> -        }
> +        kexec_unload_slot(base + pos);
>      }
>
>      return ret;
> @@ -816,7 +826,7 @@ static int kexec_load_unload_compat(unsigned long op,
>  static int kexec_exec(XEN_GUEST_HANDLE_PARAM(void) uarg)
>  {
>      xen_kexec_exec_t exec;
> -    xen_kexec_image_t *image;
> +    struct kexec_image *image;
>      int base, bit, pos, ret = -EINVAL;
>
>      if ( unlikely(copy_from_guest(&exec, uarg, 1)) )
> @@ -845,6 +855,162 @@ static int kexec_exec(XEN_GUEST_HANDLE_PARAM(void) uarg)
>      return -EINVAL; /* never reached */
>  }
>
> +static int kexec_load_segments(xen_kexec_load_v2_t *load)
> +{
> +    unsigned s;
> +    bool_t valid_entry = 0;
> +
> +    for ( s = 0; s < load->nr_segments; s++ )
> +    {
> +        xen_kexec_segment_t seg;
> +        unsigned long to_copy;
> +        unsigned long src_offset;
> +        unsigned long dest;
> +
> +        if ( copy_from_guest_offset(&seg, load->segments, s, 1) )
> +            return -EFAULT;
> +
> +        /* Caller is responsible for ensuring the crash space is
> +           shared between multiple users of the load call.  Xen just
> +           validates the load is to somewhere within the region. */
> +
> +        if ( seg.dest_maddr < kexec_crash_area.start
> +             || seg.dest_maddr + seg.size > kexec_crash_area.start + kexec_crash_area.size)
> +            return -EINVAL;

This way you are breaking regular kexec support which
does not use prealocated area. As I said earlier you
should use kexec code from Linux Kernel (with relevant
changes). It has all needed stuff and you do not need
to reinvent the wheel.

> +
> +        if ( load->entry_maddr >= seg.dest_maddr
> +             && load->entry_maddr < seg.dest_maddr + seg.size)
> +            valid_entry = 1;
> +
> +        to_copy = seg.size;
> +        src_offset = 0;
> +        dest = seg.dest_maddr;
> +
> +        while ( to_copy )
> +        {
> +            unsigned long dest_mfn;
> +            size_t dest_off;
> +            void *dest_va;
> +            size_t size;
> +
> +            dest_mfn = dest >> PAGE_SHIFT;
> +            dest_off = dest & ~PAGE_MASK;
> +
> +            size = min(PAGE_SIZE - dest_off, to_copy);
> +
> +            dest_va = vmap(&dest_mfn, 1);
> +            if ( dest_va == NULL )
> +                return -EINVAL;
> +
> +            copy_from_guest_offset(dest_va, seg.buf, src_offset, size);
> +
> +            vunmap(dest_va);
> +
> +            to_copy -= size;
> +            src_offset += size;
> +            dest += size;
> +        }
> +    }
> +
> +    /* Entry point is somewhere in a loaded segment? */
> +    if ( !valid_entry )
> +        return -EINVAL;
> +
> +    return 0;
> +}
> +
> +static int slot_to_pos_bit(int slot)
> +{
> +    return KEXEC_IMAGE_NR + slot / 2;
> +}
> +
> +static int kexec_load_slot(int slot, xen_kexec_load_v2_t *load)
> +{
> +    struct kexec_image *image = &kexec_image[slot];
> +    int ret;
> +
> +    BUG_ON(test_bit(slot, &kexec_flags)); /* must be free */
> +
> +    /* validate and load each segment. */
> +    ret = kexec_load_segments(load);
> +    if ( ret < 0 )
> +        return ret;
> +
> +    image->entry_maddr = load->entry_maddr;
> +
> +    ret = machine_kexec_load(image);
> +    if ( ret < 0 )
> +        return ret;
> +
> +    /* Set image present bit */
> +    set_bit(slot, &kexec_flags);
> +
> +    /* Make new image the active one */
> +    change_bit(slot_to_pos_bit(slot), &kexec_flags);
> +
> +    crash_save_vmcoreinfo();
> +
> +    return ret;
> +}
> +
> +
> +static int kexec_load_v2(XEN_GUEST_HANDLE_PARAM(void) uarg)
> +{
> +    xen_kexec_load_v2_t load;
> +    int base, bit, pos, slot;
> +    struct kexec_image *image;
> +    int ret;
> +
> +    if ( unlikely(copy_from_guest(&load, uarg, 1)) )
> +        return -EFAULT;
> +
> +    if ( kexec_load_get_bits(load.type, &base, &bit) )
> +        return -EINVAL;
> +
> +    pos = (test_bit(bit, &kexec_flags) != 0);
> +    slot = base + !pos;
> +    image = &kexec_image[slot];
> +
> +    switch ( load.class )
> +    {
> +    case KEXEC_CLASS_32:
> +    case KEXEC_CLASS_64:
> +        image->class = load.class;
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +
> +    ret = kexec_load_slot(slot, &load);
> +
> +    /* Unload the old image if present and load successful */
> +    if ( ret == 0 && !test_bit(KEXEC_FLAG_IN_PROGRESS, &kexec_flags) )
> +    {
> +        kexec_unload_slot(slot ^ 0x1);
> +    }
> +
> +    return ret;
> +}
> +
> +static int kexec_unload_v2(XEN_GUEST_HANDLE_PARAM(void) uarg)
> +{
> +    xen_kexec_unload_v2_t unload;
> +    int base, bit, pos, slot;
> +
> +    if ( unlikely(copy_from_guest(&unload, uarg, 1)) )
> +        return -EFAULT;
> +
> +    if ( kexec_load_get_bits(unload.type, &base, &bit) )
> +        return -EINVAL;
> +
> +    pos = (test_bit(bit, &kexec_flags) != 0);
> +    slot = base + !pos;
> +
> +    kexec_unload_slot(slot);
> +
> +    return 0;
> +}
> +
>  static int do_kexec_op_internal(unsigned long op,
>                                  XEN_GUEST_HANDLE_PARAM(void) uarg,
>                                  bool_t compat)
> @@ -882,6 +1048,22 @@ static int do_kexec_op_internal(unsigned long op,
>      case KEXEC_CMD_kexec:
>          ret = kexec_exec(uarg);
>          break;
> +    case KEXEC_CMD_kexec_load_v2:
> +        spin_lock_irqsave(&kexec_lock, flags);
> +        if ( !test_bit(KEXEC_FLAG_IN_PROGRESS, &kexec_flags) )
> +            ret = kexec_load_v2(uarg);
> +        else
> +            ret = -EBUSY;
> +        spin_unlock_irqrestore(&kexec_lock, flags);
> +        break;
> +    case KEXEC_CMD_kexec_unload_v2:
> +        spin_lock_irqsave(&kexec_lock, flags);
> +        if ( !test_bit(KEXEC_FLAG_IN_PROGRESS, &kexec_flags) )
> +            ret = kexec_unload_v2(uarg);
> +        else
> +            ret = -EBUSY;
> +        spin_unlock_irqrestore(&kexec_lock, flags);
> +        break;
>      }
>
>      return ret;
> diff --git a/xen/include/public/kexec.h b/xen/include/public/kexec.h
> index 61a8d7d..4b7d637 100644
> --- a/xen/include/public/kexec.h
> +++ b/xen/include/public/kexec.h
> @@ -83,6 +83,8 @@
>  #define KEXEC_TYPE_DEFAULT 0
>  #define KEXEC_TYPE_CRASH   1
>
> +#define KEXEC_CLASS_32   1 /* 32-bit image. */
> +#define KEXEC_CLASS_64   2 /* 64-bit image. */

???

>
>  /* The kexec implementation for Xen allows the user to load two
>   * types of kernels, KEXEC_TYPE_DEFAULT and KEXEC_TYPE_CRASH.
> @@ -152,6 +154,48 @@ typedef struct xen_kexec_range {
>      unsigned long start;
>  } xen_kexec_range_t;
>
> +/*
> + * A contiguous chunk of a kexec image and it's destination machine
> + * address.
> + */
> +typedef struct xen_kexec_segment {
> +    XEN_GUEST_HANDLE(const_void) buf;
> +    uint32_t size;
> +    uint64_t dest_maddr;
> +} xen_kexec_segment_t;
> +DEFINE_XEN_GUEST_HANDLE(xen_kexec_segment_t);
> +
> +/*
> + * Load a kexec image into memory.
> + *
> + * Each segment of the image must reside in the memory region reserved
> + * for kexec (KEXEC_RANGE_MA_CRASH) and the entry point must be within
> + * the image.
> + *
> + * The caller is responsible for ensuring that multiple images do not
> + * overlap.
> + */
> +#define KEXEC_CMD_kexec_load_v2        4
> +typedef struct xen_kexec_load_v2 {
> +    uint8_t type;  /* One of KEXEC_TYPE_* */
> +    uint8_t class; /* One of KEXEC_CLASS_* */

Why do not use one member called flags (uint32_t or uint64_t)?
This way you could add quite easily new flags in the future.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
