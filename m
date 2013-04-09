Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPT36-00026Q-94
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 07:33:00 +0000
Message-Id: <5163E04702000078000CB994@nat28.tlf.novell.com>
Date: Tue, 09 Apr 2013 08:32:55 +0100
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 3/8] kexec: add public interface for
 improved load/unload sub-ops
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
 <1365447593-11988-4-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1365447593-11988-4-git-send-email-david.vrabel@citrix.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: kexec@lists.infradead.org, Daniel Kiper <daniel.kiper@oracle.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Ian Campbell <Ian.Campbell@citrix.com>, xen-devel@lists.xen.org

>>> On 08.04.13 at 20:59, David Vrabel <david.vrabel@citrix.com> wrote:
> @@ -152,6 +152,63 @@ typedef struct xen_kexec_range {
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

So you made uint64_aligned_t available in the previous patch,
but now you don't use it?

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

Explicit padding please.

> +    uint16_t arch;        /* ELF machine type (EM_*). */
> +    uint32_t nr_segments;
> +    XEN_GUEST_HANDLE_64(xen_kexec_segment_t) segments;
> +    uint64_t entry_maddr; /* image entry point machine address. */
> +} xen_kexec_load_t;
> +DEFINE_XEN_GUEST_HANDLE(xen_kexec_load_t);
> +
> +/*
> + * Unload a kexec image.
> + *
> + * Type must be one of KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH.
> + */
> +#define KEXEC_CMD_kexec_unload 5
> +typedef struct xen_kexec_unload {
> +    uint8_t type;
> +} xen_kexec_unload_t;
> +DEFINE_XEN_GUEST_HANDLE(xen_kexec_unload_t);
> +
> +#else /* __XEN_INTERFACE_VERSION__ < 0x00040300 */
> +
> +#define KEXEC_CMD_kexec_load KEXEC_CMD_kexec_load_v1
> +#define KEXEC_CMD_kexec_unload KEXEC_CMD_kexec_unload_v1
> +typedef struct xen_kexec_load {
> +    int type;
> +    xen_kexec_image_t image;
> +} xen_kexec_load_t;

I don't really like this duplication, but I admit that the alternatives
I can think of aren't much better either.

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
