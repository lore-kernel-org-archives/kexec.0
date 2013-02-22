Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8o3x-00072H-Gm
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 08:33:02 +0000
Message-Id: <51273B8502000078000C03BF@nat28.tlf.novell.com>
Date: Fri, 22 Feb 2013 08:33:57 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 3/8] kexec: add public interface for
 improved load/unload sub-ops
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-4-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361468894-18655-4-git-send-email-david.vrabel@citrix.com>
Mime-Version: 1.0
Content-Disposition: inline
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
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

>>> On 21.02.13 at 18:48, David Vrabel <david.vrabel@citrix.com> wrote:
> --- a/xen/include/public/kexec.h
> +++ b/xen/include/public/kexec.h
> @@ -116,12 +116,12 @@ typedef struct xen_kexec_exec {
>   * type  == KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH [in]
>   * image == relocation information for kexec (ignored for unload) [in]
>   */
> -#define KEXEC_CMD_kexec_load            1
> -#define KEXEC_CMD_kexec_unload          2
> -typedef struct xen_kexec_load {
> +#define KEXEC_CMD_kexec_load_v1         1 /* obsolete since 0x00040300 */
> +#define KEXEC_CMD_kexec_unload_v1       2 /* obsolete since 0x00040300 */
> +typedef struct xen_kexec_load_v1 {
>      int type;
>      xen_kexec_image_t image;
> -} xen_kexec_load_t;
> +} xen_kexec_load_v1_t;

You can't change type names like this without also guarding them
with a __XEN_INTERFACE_VERSION__ conditional or providing
backward compatibility #define-s.

>  
>  #define KEXEC_RANGE_MA_CRASH      0 /* machine address and size of crash area */
>  #define KEXEC_RANGE_MA_XEN        1 /* machine address and size of Xen itself */
> @@ -152,6 +152,64 @@ typedef struct xen_kexec_range {
>      unsigned long start;
>  } xen_kexec_range_t;
>  
> +#if __XEN_INTERFACE_VERSION__ >= 0x00040300
> +/*
> + * A contiguous chunk of a kexec image and it's destination machine
> + * address.
> + */
> +typedef struct xen_kexec_segment {
> +    XEN_GUEST_HANDLE_64(const_void) buf;
> +    uint64_t buf_size;
> +    uint64_t dest_maddr;
> +    uint64_t dest_size;
> +} xen_kexec_segment_t;
> +DEFINE_XEN_GUEST_HANDLE(xen_kexec_segment_t);
> +
> +/*
> + * Load a kexec image into memory.
> + *
> + * For KEXEC_TYPE_DEFAULT images, the segments may be anywhere in RAM.
> + * The image is relocated prior to being executed.
> + *
> + * For KEXEC_TYPE_CRASH images, each segment of the image must reside
> + * in the memory region reserved for kexec (KEXEC_RANGE_MA_CRASH) and
> + * the entry point must be within the image. The caller is responsible
> + * for ensuring that multiple images do not overlap.
> + */
> +
> +#define KEXEC_CMD_kexec_load 4
> +typedef struct xen_kexec_load {
> +    uint8_t  type;        /* One of KEXEC_TYPE_* */

uint8_t __pad1;

> +    uint16_t arch;        /* ELF machine type (EM_*). */
> +    uint32_t __pad;

Put nr_segments here instead?

> +    uint64_t entry_maddr; /* image entry point machine address. */
> +    uint32_t nr_segments;
> +    XEN_GUEST_HANDLE_64(xen_kexec_segment_t) segments;
> +} xen_kexec_load_t;
> +DEFINE_XEN_GUEST_HANDLE(xen_kexec_load_t);

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
