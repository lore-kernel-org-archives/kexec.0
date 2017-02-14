Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdlgT-0005tO-0A
 for kexec@lists.infradead.org; Tue, 14 Feb 2017 22:34:55 +0000
Date: Tue, 14 Feb 2017 23:34:21 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v4 11/11] kexec: Add option to get crash kernel region size
Message-ID: <20170214223421.GL10876@olila.local.net-space.pl>
References: <1487106563-722-1-git-send-email-eric.devolder@oracle.com>
 <1487106563-722-12-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1487106563-722-12-git-send-email-eric.devolder@oracle.com>
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

On Tue, Feb 14, 2017 at 03:09:23PM -0600, Eric DeVolder wrote:
> From: Daniel Kiper <daniel.kiper@oracle.com>
>
> Crash kernel region size is available via sysfs on Linux running on
> bare metal. However, this does not work when Linux runs as Xen dom0.
> In this case Xen crash kernel region size should be established using
> __HYPERVISOR_kexec_op hypercall (Linux kernel kexec functionality does
> not make a lot of sense in Xen dom0). Sadly hypercalls are not easily
> accessible using shell scripts or something like that. Potentially we
> can check "xl dmesg" output for crashkernel option but this is not nice.
> So, let's add this functionality, for Linux running on bare metal and
> as Xen dom0, to kexec-tools. This way kdump scripts may establish crash
> kernel region size in one way regardless of platform. All burden of
> platform detection lies on kexec-tools.
>
> Figure (and unit) displayed by this new kexec-tools functionality is
> the same as one taken from /sys/kernel/kexec_crash_size.
>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> ---
> v4: Incorporated feedback:
>     - changes for coding convention and formatting
>     - Changed commit description to make it clear that
>       get_crash_kernel_load_range() is a stub on some archs
> v3: Incorporated feedback:
>     - changes for coding convention and formatting
>     - restructured to introduce get_crash_kernel_load_range() for each
>       architecture, and then a single function in kexec/kexec.c to call
>       the per-architecture get_crash_kernel_load_range() and print the
>       result.
> v2: Incorporated feedback:
>     - utilize the is_crashkernel_mem_reserved() function common in all archs
>     - for ppc and ppc64, utilize device-tree values to print size
>     - for unsupported architectures, print appropriate message
> v1: Posted to kexec-tools mailing list
> ---
>  kexec/kexec.8 |  3 +++
>  kexec/kexec.c | 19 +++++++++++++++++++
>  kexec/kexec.h |  4 +++-
>  3 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/kexec/kexec.8 b/kexec/kexec.8
> index f4b39a6..e0131b4 100644
> --- a/kexec/kexec.8
> +++ b/kexec/kexec.8
> @@ -179,6 +179,9 @@ Load a helper image to jump back to original kernel.
>  .TP
>  .BI \-\-reuseinitrd
>  Reuse initrd from first boot.
> +.TP
> +.BI \-\-print-ckr-size
> +Print crash kernel region size, if available.
>
>
>  .SH SUPPORTED KERNEL FILE TYPES AND OPTIONS
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index a2ba79d..eccd988 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -995,6 +995,7 @@ void usage(void)
>  	       "     --mem-max=<addr> Specify the highest memory address to\n"
>  	       "                      load code into.\n"
>  	       "     --reuseinitrd    Reuse initrd from first boot.\n"
> +	       "     --print-ckr-size Print crash kernel region size.\n"
>  	       "     --load-preserve-context Load the new kernel and preserve\n"
>  	       "                      context of current kernel during kexec.\n"
>  	       "     --load-jump-back-helper Load a helper image to jump back\n"
> @@ -1218,6 +1219,21 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
>  	return ret;
>  }
>
> +static void print_crashkernel_region_size(void)
> +{
> +	uint64_t start = 0, end = 0;
> +
> +	if (is_crashkernel_mem_reserved() &&
> +		get_crash_kernel_load_range(&start, &end)) {

get_crash_kernel_load_range() call should start in the same
column as is_crashkernel_mem_reserved() call starts.

So, we should have:

        if (is_crashkernel_mem_reserved() &&
            get_crash_kernel_load_range(&start, &end)) {

> +			fprintf(stderr, "get_crash_kernel_load_range() failed.\n");
> +			return;

Please just only two tabs.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
