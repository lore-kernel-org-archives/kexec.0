Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USRpY-0003u6-48
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 12:51:21 +0000
Date: Wed, 17 Apr 2013 14:51:06 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
Message-ID: <20130417125106.GB906@debian70-amd64.local.net-space.pl>
References: <1366132390-5269-1-git-send-email-david.vrabel@citrix.com>
 <1366132390-5269-6-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1366132390-5269-6-git-send-email-david.vrabel@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: kexec@lists.infradead.org, Keir Fraser <keir@xen.org>, xen-devel@lists.xen.org

On Tue, Apr 16, 2013 at 06:13:07PM +0100, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
>
> In the existing kexec hypercall, the load and unload ops depend on
> internals of the Linux kernel (the page list and code page provided by
> the kernel).  The code page is used to transition between Xen context
> and the image so using kernel code doesn't make sense and will not
> work for PVH guests.
>
> Add replacement KEXEC_CMD_kexec_load and KEXEC_CMD_kexec_unload ops
> that no longer require a code page to be provided by the guest -- Xen
> now provides the code for calling the image directly.
>
> The new load op looks similar to the Linux kexec_load system call and
> allows the guest to provide the image data to be loaded.  The guest
> specifies the architecture of the image which may be a 32-bit subarch
> of the hypervisor's architecture (i.e., an EM_386 image on an
> EM_X86_64 hypervisor).
>
> The toolstack can now load images without kernel involvement.  This is
> required for supporting kexec when using a dom0 with an upstream
> kernel.
>
> Crash images are copied directly into the crash region on load.
> Default images are copied into domheap pages and a list of source and
> destination machine addresses is created.  This is list is used in
> kexec_reloc() to relocate the image to its destination.
>
> The old load and unload sub-ops are still available (as
> KEXEC_CMD_load_v1 and KEXEC_CMD_unload_v1) and are implemented on top
> of the new infrastructure.
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>

[...]

> +int machine_kexec_load(struct kexec_image *image)
> +{
> +    void *code_page;
> +    int ret;
> +
> +    switch ( image->arch )
>      {
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
> +    case EM_386:
> +    case EM_X86_64:
> +        break;
> +    default:
> +        return -EINVAL;
>      }
>
> +    code_page = __map_domain_page(image->control_code_page);
> +    memcpy(code_page, kexec_reloc, PAGE_SIZE);

memcpy(code_page, kexec_reloc, kexec_reloc_size);

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
