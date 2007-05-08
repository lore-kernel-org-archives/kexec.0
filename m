Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HlFaq-0007PN-Tx
	for kexec@lists.infradead.org; Mon, 07 May 2007 22:38:27 -0400
Date: Tue, 8 May 2007 11:38:11 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 3/5] kexec add strict-prototypes
Message-ID: <20070508023811.GA8170@verge.net.au>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE30.8080500@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <463FBE30.8080500@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

On Mon, May 07, 2007 at 05:02:56PM -0700, Geoff Levand wrote:
> Add -Wstrict-prototypes to EXTRA_CFLAGS and fix the powerpc compiler warnings.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Hi Geoff,

I'm all for fixing up this kind of thing, but I'm not sure that
hardcoding it into -Wstrict-prototypes is the right way to go.
People who want -Wstrict-prototypes can just add it to CFLAGS
in the environment and fix problems from there. Then again, it is
kind of nice to get rid of all this crap :-)

Could you split the configure.ac patch and the fixes into two separate
patches so that they can be considered separtely?

> ---
>  configure.ac                   |    2 -
>  kexec/arch/ppc64/kexec-ppc64.c |   61 +++++++++++++++++++----------------------
>  2 files changed, 30 insertions(+), 33 deletions(-)
> 
> --- kexec-tools-hacked.orig/configure.ac
> +++ kexec-tools-hacked/configure.ac
> @@ -59,7 +59,7 @@ if test "${host_alias}" ; then
>  	OBJDIR="$OBJDIR-${host_alias}"
>  fi 
>  
> -EXTRA_CFLAGS='-Wall -g -fno-strict-aliasing $(CPPFLAGS) $(EXTRA_CPPFLAGS)'
> +EXTRA_CFLAGS='-Wall -g -fno-strict-aliasing -Wstrict-prototypes $(CPPFLAGS) $(EXTRA_CPPFLAGS)'
>  BUILD_CFLAGS='-O2 -Wall $(CPPFLAGS)'
>  
>  # Check whether ppc64. Add -m64 for building 64-bit binary
> --- kexec-tools-hacked.orig/kexec/arch/ppc64/kexec-ppc64.c
> +++ kexec-tools-hacked/kexec/arch/ppc64/kexec-ppc64.c
> @@ -45,10 +45,7 @@ unsigned long long crash_base, crash_siz
>  unsigned int rtas_base, rtas_size;
>  int max_memory_ranges;
>  
> -static int sort_base_ranges();
> -
> -
> -static void cleanup_memory_ranges()
> +static void cleanup_memory_ranges(void)
>  {
>  	if (memory_range)
>  		free(memory_range);
> @@ -64,7 +61,7 @@ static void cleanup_memory_ranges()
>   * Allocate memory for various data structures used to hold
>   * values of different memory ranges
>   */
> -static int alloc_memory_ranges()
> +static int alloc_memory_ranges(void)
>  {
>  	int memory_range_len;
>  
> @@ -105,7 +102,7 @@ err1:
>   * max_memory_ranges variable. This variable replaces MAX_MEMORY_RANGES
>   * macro used earlier.
>   */
> -static int count_memory_ranges()
> +static int count_memory_ranges(void)
>  {
>  	char device_tree[256] = "/proc/device-tree/";
>  	struct dirent *dentry;
> @@ -132,8 +129,32 @@ static int count_memory_ranges()
>  	return 0;
>  }
>  
> +/* Sort the base ranges in memory - this is useful for ensuring that our
> + * ranges are in ascending order, even if device-tree read of memory nodes
> + * is done differently. Also, could be used for other range coalescing later
> + */
> +static int sort_base_ranges(void)
> +{
> +	int i, j;
> +	unsigned long long tstart, tend;
> +
> +	for (i = 0; i < nr_memory_ranges - 1; i++) {
> +		for (j = 0; j < nr_memory_ranges - i - 1; j++) {
> +			if (base_memory_range[j].start > base_memory_range[j+1].start) {
> +				tstart = base_memory_range[j].start;
> +				tend = base_memory_range[j].end;
> +				base_memory_range[j].start = base_memory_range[j+1].start;
> +				base_memory_range[j].end = base_memory_range[j+1].end;
> +				base_memory_range[j+1].start = tstart;
> +				base_memory_range[j+1].end = tend;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
>  /* Get base memory ranges */
> -static int get_base_ranges()
> +static int get_base_ranges(void)
>  {
>  	int local_memory_ranges = 0;
>  	char device_tree[256] = "/proc/device-tree/";
> @@ -204,32 +225,8 @@ static int get_base_ranges()
>  	return 0;
>  }

The change to sort_base_ranges() seems like a lot of diff for very
little change. Is it whitespace fixes. If so could you put that in a
separate patch?

> -/* Sort the base ranges in memory - this is useful for ensuring that our
> - * ranges are in ascending order, even if device-tree read of memory nodes
> - * is done differently. Also, could be used for other range coalescing later
> - */
> -static int sort_base_ranges()
> -{
> -	int i, j;
> -	unsigned long long tstart, tend;
> -
> -	for (i = 0; i < nr_memory_ranges - 1; i++) {
> -		for (j = 0; j < nr_memory_ranges - i - 1; j++) {
> -			if (base_memory_range[j].start > base_memory_range[j+1].start) {
> -				tstart = base_memory_range[j].start;
> -				tend = base_memory_range[j].end;
> -				base_memory_range[j].start = base_memory_range[j+1].start;
> -				base_memory_range[j].end = base_memory_range[j+1].end;
> -				base_memory_range[j+1].start = tstart;
> -				base_memory_range[j+1].end = tend;
> -			}
> -		}
> -	}
> -	return 0;
> -}
> -
>  /* Sort the exclude ranges in memory */
> -static int sort_ranges()
> +static int sort_ranges(void)
>  {
>  	int i, j;
>  	unsigned long long tstart, tend;
> 
> -- 
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
