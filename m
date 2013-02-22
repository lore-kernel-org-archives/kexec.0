Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8r7y-0002wV-Fj
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 11:49:23 +0000
Message-ID: <51275B3F.7010503@citrix.com>
Date: Fri, 22 Feb 2013 11:49:19 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] kexec: add public interface for improved load/unload
 sub-ops
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-4-git-send-email-david.vrabel@citrix.com>
 <20130221222928.GA18464@host-192-168-1-59.local.net-space.pl>
In-Reply-To: <20130221222928.GA18464@host-192-168-1-59.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 21/02/13 22:29, Daniel Kiper wrote:
> On Thu, Feb 21, 2013 at 05:48:09PM +0000, David Vrabel wrote:
>> From: David Vrabel <david.vrabel@citrix.com>
>>
>> Add replacement KEXEC_CMD_load and KEXEC_CMD_unload sub-ops to the
>> kexec hypercall.  These new sub-ops allow a priviledged guest to
>> provide the image data to be loaded into Xen memory or the crash
>> region instead of guests loading the image data themselves and
>> providing the relocation code and metadata.
>>
>> The old interface is provided to guests requesting an interface
>> version prior to 4.3.
>>
[...]
>> +/*
>> + * Load a kexec image into memory.
>> + *
>> + * For KEXEC_TYPE_DEFAULT images, the segments may be anywhere in RAM.
>> + * The image is relocated prior to being executed.
>> + *
>> + * For KEXEC_TYPE_CRASH images, each segment of the image must reside
>> + * in the memory region reserved for kexec (KEXEC_RANGE_MA_CRASH) and
>> + * the entry point must be within the image. The caller is responsible
>> + * for ensuring that multiple images do not overlap.
> 
> What do you mean by "The caller is responsible for ensuring
> that multiple images do not overlap."?

The intention here is to allow for safe replacement of a crash image by
loading the second image at a different location in the crash region.

This won't actually work however, as the control pages (also allocated
from the crash region) will conflict.

This is the behaviour of the Linux implementation.  It's less than ideal
and something I plan to look at later on (it's low priority as replacing
crash images isn't an interesting use case).

>> + */
>> +
>> +#define KEXEC_CMD_kexec_load 4
>> +typedef struct xen_kexec_load {
>> +    uint8_t  type;        /* One of KEXEC_TYPE_* */
>> +    uint16_t arch;        /* ELF machine type (EM_*). */
>> +    uint32_t __pad;
> 
> Why do you need __pad here?

To ensure that the following uint64_t is aligned to 8 bytes in both 32
and 64-bit.

Annoyingly uint64_t only has 4 byte alignment on 32-bit architectures.

>> +    uint64_t entry_maddr; /* image entry point machine address. */
>> +    uint32_t nr_segments;
>> +    XEN_GUEST_HANDLE_64(xen_kexec_segment_t) segments;
>> +} xen_kexec_load_t;
>> +DEFINE_XEN_GUEST_HANDLE(xen_kexec_load_t);
>> +
>> +/*
>> + * Unload a kexec image.
>> + *
>> + * Type must be one of KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH.
>> + */
>> +#define KEXEC_CMD_kexec_unload 5
>> +typedef struct xen_kexec_unload {
>> +    uint8_t type;
>> +} xen_kexec_unload_t;
>> +DEFINE_XEN_GUEST_HANDLE(xen_kexec_unload_t);
>> +
>> +#else /* __XEN_INTERFACE_VERSION__ < 0x00040300 */
>> +
>> +#undef KEXEC_CMD_kexec_load
>> +#undef KEXEC_CMD_kexec_unload
>> +#define KEXEC_CMD_kexec_load KEXEC_CMD_kexec_load_v1
>> +#define KEXEC_CMD_kexec_unload KEXEC_CMD_kexec_unload_v1
> 
> Could you define all constants in one place at the
> beginning of this file? It is very difficult to
> see what is going on. Especially those undefs are
> crazy for me.

I was copying the style used for sched_op_compat.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
