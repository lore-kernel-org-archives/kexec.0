Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdlbn-00049v-0G
 for kexec@lists.infradead.org; Tue, 14 Feb 2017 22:30:06 +0000
Date: Tue, 14 Feb 2017 23:29:29 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v4 07/11] crashdump/ppc: Add
 get_crash_kernel_load_range() function
Message-ID: <20170214222929.GK10876@olila.local.net-space.pl>
References: <1487106563-722-1-git-send-email-eric.devolder@oracle.com>
 <1487106563-722-8-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1487106563-722-8-git-send-email-eric.devolder@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: panand@redhat.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, kexec@lists.infradead.org, horms@verge.net.au, dyoung@redhat.com

On Tue, Feb 14, 2017 at 03:09:19PM -0600, Eric DeVolder wrote:
> From: Daniel Kiper <daniel.kiper@oracle.com>
>
> Implement get_crash_kernel_load_range() in support of
> print crash kernel region size option.
>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> ---
> v4: Incorporated feedback:
>     - changes for coding convention and formatting
> v3: Incorporated feedback:
>     - changes for coding convention and formatting
>     - restructured to introduce get_crash_kernel_load_range() for each
>       architecture, and then a single function in kexec/kexec.c to call
>       the per-architecture get_crash_kernel_load_range() and print the
>       result.
>     - changed print_crashkernel_region_size() to get_crash_kernel_load_range()
>     - introduced get_devtree_value()
> v2: Incorporated feedback:
>     - utilize the is_crashkernel_mem_reserved() function common in all archs
>     - utilize device-tree values to print size
> v1: Posted to kexec-tools mailing list
> ---
>  kexec/arch/ppc/crashdump-powerpc.c | 27 ++++++++++++++++++++++++++-
>  kexec/arch/ppc/kexec-ppc.c         | 28 ++++++++++++++++++++++++++++
>  kexec/arch/ppc/kexec-ppc.h         |  1 +
>  3 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
> index 3dc35eb..186005c 100644
> --- a/kexec/arch/ppc/crashdump-powerpc.c
> +++ b/kexec/arch/ppc/crashdump-powerpc.c
> @@ -16,6 +16,9 @@
>  #include "kexec-ppc.h"
>  #include "crashdump-powerpc.h"
>
> +#define DEVTREE_CRASHKERNEL_BASE "/proc/device-tree/chosen/linux,crashkernel-base"
> +#define DEVTREE_CRASHKERNEL_SIZE "/proc/device-tree/chosen/linux,crashkernel-size"
> +
>  #ifdef CONFIG_PPC64
>  static struct crash_elf_info elf_info64 = {
>  class: ELFCLASS64,
> @@ -397,11 +400,33 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size)
>  		usablemem_rgns.size, base, size);
>  }
>
> +int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
> +{
> +	unsigned long long value;
> +	int ret = 0;
> +
> +	if (!get_devtree_value(DEVTREE_CRASHKERNEL_BASE, &value))
> +		*start = value;
> +	else {
> +		*start = 0;

I have a feeling that this is not needed. If it is true then we can also
drop curly brackets and leave just ret assignment only.

> +		ret = -1;
> +	}
> +
> +	if (!get_devtree_value(DEVTREE_CRASHKERNEL_SIZE, &value))
> +		*end = *start + value - 1;
> +	else {
> +		*end = 0;

Ditto.

IIRC, same thing applies to ppc64.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
