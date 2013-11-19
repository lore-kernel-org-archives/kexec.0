Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViZzY-0003KU-VH
 for kexec@lists.infradead.org; Tue, 19 Nov 2013 01:20:38 +0000
Date: Tue, 19 Nov 2013 10:20:14 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/4] kexec/xen: directly load images images into Xen
Message-ID: <20131119012014.GC17628@verge.net.au>
References: <1383749722-12091-1-git-send-email-david.vrabel@citrix.com>
 <1383749722-12091-5-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383749722-12091-5-git-send-email-david.vrabel@citrix.com>
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
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On Wed, Nov 06, 2013 at 02:55:22PM +0000, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
> 
> Xen 4.4 has an improvided kexec hypercall ABI that allows images to be
> loaded and executed without any kernel involvement.  Use the API
> provided by libxc to load images when running in a Xen guest.
> 
> Support for loading images via the kexec_load syscall in non-upstream
> ("classic") Xen kernels is no longer supported.
> 
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> ---
>  kexec/Makefile                  |    1 +
>  kexec/arch/i386/crashdump-x86.c |   20 +++++-
>  kexec/crashdump-xen.c           |   34 ++++++++++
>  kexec/crashdump.h               |    3 +-
>  kexec/kexec-xen.c               |  139 +++++++++++++++++++++++++++++++++++++++
>  kexec/kexec.c                   |   24 +++++--
>  kexec/kexec.h                   |    5 ++
>  7 files changed, 218 insertions(+), 8 deletions(-)
>  create mode 100644 kexec/kexec-xen.c
> 

[snip]

> diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
> new file mode 100644
> index 0000000..77f65c0
> --- /dev/null
> +++ b/kexec/kexec-xen.c
> @@ -0,0 +1,139 @@
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <elf.h>
> +#include "kexec.h"
> +#include "kexec-syscall.h"
> +#include "crashdump.h"
> +
> +#include "config.h"
> +
> +#ifdef HAVE_LIBXENCTRL
> +#include <xenctrl.h>
> +
> +#include "crashdump.h"
> +
> +int xen_kexec_load(struct kexec_info *info)
> +{
> +	uint32_t nr_segments = info->nr_segments;
> +	struct kexec_segment *segments = info->segment;
> +	xc_interface *xch;
> +	xc_hypercall_buffer_array_t *array = NULL;
> +	uint8_t type;
> +	uint8_t arch;
> +	xen_kexec_segment_t *xen_segs;
> +	int s;
> +	int ret = -1;
> +
> +	xch = xc_interface_open(NULL, NULL, 0);
> +	if (!xch)
> +		return -1;
> +
> +	xen_segs = calloc(nr_segments + 1, sizeof(*xen_segs));
> +	if (!xen_segs)
> +		goto out;
> +
> +	array = xc_hypercall_buffer_array_create(xch, nr_segments);
> +	if (array == NULL)
> +		goto out;
> +
> +	for (s = 0; s < nr_segments; s++) {
> +		DECLARE_HYPERCALL_BUFFER(void, seg_buf);
> +
> +		seg_buf = xc_hypercall_buffer_array_alloc(xch, array, s,
> +							  seg_buf, segments[s].bufsz);
> +		if (seg_buf == NULL)
> +			goto out;
> +		memcpy(seg_buf, segments[s].buf, segments[s].bufsz);
> +
> +		set_xen_guest_handle(xen_segs[s].buf.h, seg_buf);
> +		xen_segs[s].buf_size = segments[s].bufsz;
> +		xen_segs[s].dest_maddr = (uint64_t)segments[s].mem;
> +		xen_segs[s].dest_size = segments[s].memsz;
> +	}
> +
> +	/*
> +	 * Ensure 0 - 1 MiB is mapped and accessible by the image.
> +	 *
> +	 * This allows access to the VGA memory and the region
> +	 * purgatory copies in the crash case.
> +	 */
> +	set_xen_guest_handle(xen_segs[s].buf.h, HYPERCALL_BUFFER_NULL);
> +	xen_segs[s].buf_size = 0;
> +	xen_segs[s].dest_maddr = 0;
> +	xen_segs[s].dest_size = 1 * 1024 * 1024;
> +	nr_segments++;
> +
> +	type = (info->kexec_flags & KEXEC_ON_CRASH) ? KEXEC_TYPE_CRASH
> +		: KEXEC_TYPE_DEFAULT;
> +
> +	arch = (info->kexec_flags & KEXEC_ARCH_MASK) >> 16;
> +#if defined(_i386__) || defined(__x86_64__)
> +	if (!arch)
> +		arch = EM_386;
> +#endif
> +
> +	ret = xc_kexec_load(xch, type, arch, (uint64_t)info->entry,
> +			    nr_segments, xen_segs);
> +
> +out:
> +	xc_hypercall_buffer_array_destroy(xch, array);
> +	free(xen_segs);
> +	xc_interface_close(xch);
> +
> +	return ret;
> +}
> +
> +int xen_kexec_unload(uint64_t kexec_flags)
> +{
> +	xc_interface *xch;
> +	uint8_t type;
> +	int ret;
> +
> +	xch = xc_interface_open(NULL, NULL, 0);
> +	if (!xch)
> +		return -1;
> +
> +	type = (kexec_flags & KEXEC_ON_CRASH) ? KEXEC_TYPE_CRASH
> +		: KEXEC_TYPE_DEFAULT;
> +
> +	ret = xc_kexec_unload(xch, type);
> +
> +	xc_interface_close(xch);
> +
> +	return ret;
> +}
> +
> +void xen_kexec_exec(void)
> +{
> +	xc_interface *xch;
> +	
> +	xch = xc_interface_open(NULL, NULL, 0);
> +	if (!xch)
> +		return;
> +
> +	xc_kexec_exec(xch, KEXEC_TYPE_DEFAULT);
> +
> +	xc_interface_close(xch);
> +}
> +
> +#else /* ! HAVE_LIBXENCTRL */
> +
> +int xen_kexec_load(uint64_t entry,
> +		   uint32_t nr_segments, struct kexec_segment *segments,
> +		   uint64_t kexec_flags)
> +{
> +	return -1;
> +}
> +
> +int xen_kexec_unload(uin64_t kexec_flags);
> +{
> +	return -1;
> +}
> +
> +void xen_kexec_exec(void)
> +{
> +}
> +
> +#endif

[snip]

I have applied the following follow-up patch to resolves some errors.
Let me know if I messed it up.

From: Simon Horman <horms@verge.net.au>

[PATCH] kexec/xen: Correct some compile errors

Correct various problems introduced by
08cf823704b0fa3b ("kexec/xen: directly load images images into Xen").

These all relate to the case here HAVE_LIBXENCTRL is not set.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/kexec-xen.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index 77f65c0..e885246 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -2,6 +2,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
+#include <stdlib.h>
 #include <elf.h>
 #include "kexec.h"
 #include "kexec-syscall.h"
@@ -120,14 +121,12 @@ void xen_kexec_exec(void)
 
 #else /* ! HAVE_LIBXENCTRL */
 
-int xen_kexec_load(uint64_t entry,
-		   uint32_t nr_segments, struct kexec_segment *segments,
-		   uint64_t kexec_flags)
+int xen_kexec_load(struct kexec_info *UNUSED(info))
 {
 	return -1;
 }
 
-int xen_kexec_unload(uin64_t kexec_flags);
+int xen_kexec_unload(uint64_t kexec_flags)
 {
 	return -1;
 }
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
