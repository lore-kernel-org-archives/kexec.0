Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from andromeda.dapyr.net ([206.212.254.10])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QvLi0-0007Yd-R8
	for kexec@lists.infradead.org; Mon, 22 Aug 2011 04:01:58 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 4/4] kexec/arch/i386: Add get_memory_ranges_xen() function
Date: Mon, 22 Aug 2011 00:01:24 -0400
References: <20110821135459.GE17323@router-fw-old.local.net-space.pl>
In-Reply-To: <20110821135459.GE17323@router-fw-old.local.net-space.pl>
MIME-Version: 1.0
Message-Id: <201108220001.24399.konrad.wilk@oracle.com>
Reply-To: konrad.wilk@oracle.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Kiper <dkiper@net-space.pl>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, ian.campbell@citrix.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, vgoyal@redhat.com

> get_memory_ranges_sysfs() and get_memory_ranges_proc_iomem()
> are unreliable under Xen. Proper machine memory map could be
> obtained under Xen by calling __HYPERVISOR_memory_op hypercall
> with XENMEM_machine_memory_map argument. get_memory_ranges_xen()
> does that. It is implemented using ioctl() or libxenctrl interface.
> This solution is compatible with 3.x and 4.x Xen versions.
> 
> Signed-off-by: Daniel Kiper <dkiper@net-space.pl>
> ---
>  configure.ac                       |    3 +
>  kexec/arch/i386/kexec-x86-common.c |  203 
++++++++++++++++++++++++++++++++++--
>  2 files changed, 197 insertions(+), 9 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 172a52a..0d09bba 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -157,6 +157,9 @@ if test "$with_xen" = yes ; then
>  	AC_CHECK_HEADER(xenctrl.h,
>  		AC_CHECK_LIB(xenctrl, xc_version, ,
>  		AC_MSG_NOTICE([Xen support disabled])))
> +	if test "$ac_cv_lib_xenctrl_xc_version" = yes ; then
> +		AC_CHECK_FUNCS(xc_get_machine_memory_map)
> +	fi
>  fi
>  
>  dnl ---Sanity checks
> diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-
common.c
> index 8f59c6c..609d35d 100644
> --- a/kexec/arch/i386/kexec-x86-common.c
> +++ b/kexec/arch/i386/kexec-x86-common.c
> @@ -17,6 +17,10 @@
>   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
> +#define _XOPEN_SOURCE	600
> +#define _BSD_SOURCE
> +
> +#include <fcntl.h>
>  #include <stddef.h>
>  #include <stdio.h>
>  #include <errno.h>
> @@ -24,12 +28,29 @@
>  #include <string.h>
>  #include <limits.h>
>  #include <stdlib.h>
> +#include <stdio.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
>  #include "../../kexec.h"
>  #include "../../kexec-syscall.h"
>  #include "../../firmware_memmap.h"
>  #include "../../crashdump.h"
>  #include "kexec-x86.h"
>  
> +#ifdef HAVE_LIBXENCTRL
> +#ifdef HAVE_XC_GET_MACHINE_MEMORY_MAP
> +#include <xenctrl.h>
> +#else
> +#define __XEN_TOOLS__	1
> +#include <x86/x86-linux.h>
> +#include <xen/xen.h>
> +#include <xen/memory.h>
> +#include <xen/sys/privcmd.h>
> +#endif /* HAVE_XC_GET_MACHINE_MEMORY_MAP */
> +#endif /* HAVE_LIBXENCTRL */
> +
>  static struct memory_range memory_range[MAX_MEMORY_RANGES];
>  
>  /**
> @@ -129,6 +150,172 @@ static int get_memory_ranges_sysfs(struct memory_range 
**range, int *ranges)
>  	return 0;
>  }
>  
> +#ifdef HAVE_LIBXENCTRL
> +static unsigned e820_to_kexec_type(uint32_t type)
> +{
> +	switch (type) {
> +		case E820_RAM:
> +			return RANGE_RAM;
> +		case E820_ACPI:
> +			return RANGE_ACPI;
> +		case E820_NVS:
> +			return RANGE_ACPI_NVS;
> +		case E820_RESERVED:

For E820_UNUSABLE you want to do that too?

> +		default:
> +			return RANGE_RESERVED;

Or should E820_UNUSABLE returne its own type of RANGE?
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
