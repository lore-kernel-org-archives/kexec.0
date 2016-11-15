Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c6bL2-0001C7-Jc
 for kexec@lists.infradead.org; Tue, 15 Nov 2016 10:51:42 +0000
Subject: Re: [PATCH v1 1/2] xen/kexec: Find out whether an kexec type is
 loaded.
References: <1479161573-12671-1-git-send-email-konrad.wilk@oracle.com>
 <1479161573-12671-2-git-send-email-konrad.wilk@oracle.com>
From: David Vrabel <david.vrabel@citrix.com>
Message-ID: <ad36a8c0-dc60-2a56-e6ea-37f3a1b0492f@citrix.com>
Date: Tue, 15 Nov 2016 10:51:11 +0000
MIME-Version: 1.0
In-Reply-To: <1479161573-12671-2-git-send-email-konrad.wilk@oracle.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, kexec@lists.infradead.org
Cc: elena.ufimtseva@oracle.com, daniel.kiper@oracle.com

On 14/11/16 22:12, Konrad Rzeszutek Wilk wrote:
> The tools that use kexec are asynchronous in nature and do
> not keep state changes. As such provide an hypercall to find
> out whether an image has been loaded for either type.
> 
> Note: No need to modify XSM as it has one size fits all
> check and does not check for subcommands.
[...]
> --- a/tools/libxc/include/xenctrl.h
> +++ b/tools/libxc/include/xenctrl.h
> @@ -2574,6 +2574,14 @@ int xc_kexec_load(xc_interface *xch, uint8_t type, uint16_t arch,
>   */
>  int xc_kexec_unload(xc_interface *xch, int type);
>  
> +/*
> + * Find out whether the image has been succesfully loaded.
> + *
> + * The can be either KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH.
> + * If zero is returned that means the image is loaded for the type.

Suggest return 0 if an image is not loaded, 1 if an image is loaded, but
I'll leave this for the toolstack maintainers to decide.

> --- a/xen/common/kexec.c
> +++ b/xen/common/kexec.c
> @@ -1169,6 +1169,28 @@ static int kexec_unload(XEN_GUEST_HANDLE_PARAM(void) uarg)
>      return kexec_do_unload(&unload);
>  }
>  
> +static int kexec_status(XEN_GUEST_HANDLE_PARAM(void) uarg)
> +{
> +    xen_kexec_status_t status;
> +    int base, bit, pos;
> +
> +    if ( unlikely(copy_from_guest(&status, uarg, 1)) )
> +        return -EFAULT;
> +
> +    if ( test_bit(KEXEC_FLAG_IN_PROGRESS, &kexec_flags) )
> +        return -EBUSY;

No need to check in progress here.

> +
> +    if ( kexec_load_get_bits(status.type, &base, &bit) )
> +        return -EINVAL;
> +
> +    pos = (test_bit(bit, &kexec_flags) != 0);
> +
> +    if ( !test_bit(base + pos, &kexec_flags) )
> +        return -ENOENT;

return !!test_bit(...);

It also occurs to be that this testing of bits races with
kexec_swap_image().  This race also affects kexec_exec().

>  static int do_kexec_op_internal(unsigned long op,
>                                  XEN_GUEST_HANDLE_PARAM(void) uarg,
>                                  bool_t compat)
> @@ -1208,6 +1230,9 @@ static int do_kexec_op_internal(unsigned long op,
>      case KEXEC_CMD_kexec_unload:
>          ret = kexec_unload(uarg);
>          break;
> +    case KEXEC_CMD_kexec_status:
> +	ret = kexec_status(uarg);
> +	break;

Tabs!

> --- a/xen/include/public/kexec.h
> +++ b/xen/include/public/kexec.h
> @@ -227,6 +227,17 @@ typedef struct xen_kexec_unload {
>  } xen_kexec_unload_t;
>  DEFINE_XEN_GUEST_HANDLE(xen_kexec_unload_t);
>  
> +/*
> + * Figure out whether we have an image loaded. An return value of
> + * zero indicates success while XEN_ENODEV implies no image loaded.
> + *
> + * Type must be one of KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH.

Return 0 if no image is loaded. 1 if an image is loaded and -ve on an error.

David


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
