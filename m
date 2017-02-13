Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdPKE-0004Ty-Cr
 for kexec@lists.infradead.org; Mon, 13 Feb 2017 22:42:28 +0000
Date: Mon, 13 Feb 2017 23:41:56 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3 11/11] kexec: Add option to get crash kernel region size
Message-ID: <20170213224156.GI9543@olila.local.net-space.pl>
References: <1486764462-14176-1-git-send-email-eric.devolder@oracle.com>
 <1486764462-14176-12-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1486764462-14176-12-git-send-email-eric.devolder@oracle.com>
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

On Fri, Feb 10, 2017 at 04:07:42PM -0600, Eric DeVolder wrote:
> From: Daniel Kiper <daniel.kiper@oracle.com>
>
> From: Daniel Kiper <daniel.kiper@oracle.com>

Hmmm... One is sufficient...

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
> ---
>  kexec/kexec.8 |  3 +++
>  kexec/kexec.c | 20 ++++++++++++++++++++
>  kexec/kexec.h |  4 +++-
>  3 files changed, 26 insertions(+), 1 deletion(-)
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
> index a2ba79d..0be1be4 100644
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
> @@ -1218,6 +1219,22 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
>  	return ret;
>  }
>
> +static void print_crashkernel_region_size(void)
> +{
> +	uint64_t start = 0, end = 0;

This initialization is not needed.

> +
> +	if (is_crashkernel_mem_reserved()) {
> +		int ret = get_crash_kernel_load_range(&start, &end);

I do not like mixing code with variable declarations.

> +		if (ret != 0) {

if (ret)

> +			fprintf(stderr, "get_crash_kernel_load_range failed.\n");

s/get_crash_kernel_load_range/get_crash_kernel_load_range()/

> +			return;
> +		}
> +	}

Please add empty line here.

> +	if (start != end)

if (!ret && start != end)

There is no guarantee that in case of error nobody touched start and/or
end in get_crash_kernel_load_range() call.

> +		printf("%lu\n", end - start + 1);
> +	else
> +		printf("0\n");
> +}

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
