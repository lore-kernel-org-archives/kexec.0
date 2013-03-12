Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFNVq-00017P-Og
 for kexec@lists.infradead.org; Tue, 12 Mar 2013 11:36:59 +0000
Date: Tue, 12 Mar 2013 12:36:49 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
Message-ID: <20130312113649.GD13567@debian70-amd64.local.net-space.pl>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: kexec@lists.infradead.org, xen-devel@lists.xen.org

On Thu, Feb 21, 2013 at 05:48:11PM +0000, David Vrabel wrote:
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
> Default images are copied into Xen heap pages and a list of source and
> destination machine addresses is created.  This is list is used in
> kexec_reloc() to relocate the image to its destination.
>
> The old load and unload sub-ops are still available (as
> KEXEC_CMD_load_v1 and KEXEC_CMD_unload_v1) and are implemented on top
> of the new infrastructure.
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>

[...]

> diff --git a/xen/common/kexec.c b/xen/common/kexec.c

[...]

> -static int kexec_load_unload_compat(unsigned long op,
> -                                    XEN_GUEST_HANDLE_PARAM(void) uarg)
> +static int kexec_load_v1_compat(XEN_GUEST_HANDLE_PARAM(void) uarg)
>  {
>  #ifdef CONFIG_COMPAT
>      compat_kexec_load_v1_t compat_load;
> @@ -807,49 +990,113 @@ static int kexec_load_unload_compat(unsigned long op,
>      load.type = compat_load.type;
>      XLAT_kexec_image(&load.image, &compat_load.image);
>
> -    return kexec_load_unload_internal(op, &load);
> -#else /* CONFIG_COMPAT */
> +    return kexec_do_load_v1(&load);
> +#else
>      return 0;

-ENOSYS?

> -#endif /* CONFIG_COMPAT */
> +#endif
>  }

[...]

> +static int kexec_unload_v1_compat(XEN_GUEST_HANDLE_PARAM(void) uarg)
> +{
> +#ifdef CONFIG_COMPAT
> +    compat_kexec_load_v1_t compat_load;
> +    xen_kexec_unload_t unload;
> +
> +    if ( copy_from_guest(&compat_load, uarg, 1) )
> +        return -EFAULT;
> +
> +    unload.type = compat_load.type;
> +    return kexec_do_unload(&unload);
> +#else
> +    return 0;

-ENOSYS?

> +#endif
> +}

...and in other similar places...

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
