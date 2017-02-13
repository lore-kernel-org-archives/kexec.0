Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdP3O-0005QD-Nv
 for kexec@lists.infradead.org; Mon, 13 Feb 2017 22:25:05 +0000
Date: Mon, 13 Feb 2017 23:24:31 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3 07/11] crashdump/ppc: Add
 get_crash_kernel_load_range() function
Message-ID: <20170213222431.GG9543@olila.local.net-space.pl>
References: <1486764462-14176-1-git-send-email-eric.devolder@oracle.com>
 <1486764462-14176-8-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1486764462-14176-8-git-send-email-eric.devolder@oracle.com>
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

On Fri, Feb 10, 2017 at 04:07:38PM -0600, Eric DeVolder wrote:
> From: Daniel Kiper <daniel.kiper@oracle.com>
>
> Implement get_crash_kernel_load_range() in support of
> print crash kernel region size option.
>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  kexec/arch/ppc/crashdump-powerpc.c | 22 +++++++++++++++++++++-
>  kexec/arch/ppc/kexec-ppc.c         | 27 +++++++++++++++++++++++++++
>  kexec/arch/ppc/kexec-ppc.h         |  1 +
>  3 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
> index 3dc35eb..fc5d70c 100644
> --- a/kexec/arch/ppc/crashdump-powerpc.c
> +++ b/kexec/arch/ppc/crashdump-powerpc.c
> @@ -397,6 +397,27 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size)
>  		usablemem_rgns.size, base, size);
>  }
>
> +int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
> +{
> +	unsigned long long value;
> +	int ret = 0;
> +
> +	if (get_devtree_value("/proc/device-tree/chosen/linux,crashkernel-base", &value))

Could not you define this path as a constant somewhere? It is used in a
few places, so, it would be nice.

> +		*start = value;
> +	else {
> +		*start = 0;
> +		ret = -1;
> +	}

I would add empty line here.

> +	if (get_devtree_value("/proc/device-tree/chosen/linux,crashkernel-size", &value))

Ditto.

> +		*end = *start + value - 1;
> +	else {
> +		*end = 0;
> +		ret = -1;
> +	}
> +
> +	return ret;
> +}
> +
>  int is_crashkernel_mem_reserved(void)
>  {
>  	int fd;
> @@ -407,4 +428,3 @@ int is_crashkernel_mem_reserved(void)
>  	close(fd);
>  	return 1;
>  }
> -

Nice but this cleanup should be a separate patch if you wish.
Otherwise it is a bit confusing.

> diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
> index d046110..d9cdb9c 100644
> --- a/kexec/arch/ppc/kexec-ppc.c
> +++ b/kexec/arch/ppc/kexec-ppc.c
> @@ -423,6 +423,33 @@ err_out:
>  	return -1;
>  }
>
> +int get_devtree_value(const char *fname, unsigned long long *pvalue)
> +{
> +	/* Return 1 if fname/value valid, 0 otherwise */

Most if not all functions in kexec/arch/ppc/kexec-ppc.c return -1 in case
of error and 0 if everything went OK. Please follow this convention.

> +	FILE *file;
> +	char buf[MAXBYTES];
> +	int ret = 1, n = -1;
> +	unsigned long long value = 0;
> +
> +	if ((file = fopen(fname, "r"))) {
> +		n = fread(buf, 1, MAXBYTES, file);
> +		fclose(file);
> +	}
> +
> +	if (n == sizeof(uint32_t))
> +		value = ((uint32_t *)buf)[0];

I would prefer *((uint32_t *)buf) but as I can see this is a convention
in this file, so, let's leave it as is.

> +	else if (n == sizeof(uint64_t)) {
> +		value = ((uint64_t *)buf)[0];

Ditto.

> +	else {
> +		fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
> +		ret = 0;
> +	}
> +
> +	if (pvalue)
> +		*pvalue = value;

Add empty line here.

> +	return ret;
> +}
> +
>  /* Get devtree details and create exclude_range array
>   * Also create usablemem_ranges for KEXEC_ON_CRASH
>   */
> diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
> index 904cf48..0e52d18 100644
> --- a/kexec/arch/ppc/kexec-ppc.h
> +++ b/kexec/arch/ppc/kexec-ppc.h
> @@ -75,6 +75,7 @@ extern unsigned long dt_address_cells, dt_size_cells;
>  extern int init_memory_region_info(void);
>  extern int read_memory_region_limits(int fd, unsigned long long *start,
>  					unsigned long long *end);
> +extern int get_devtree_value (const char *fname, unsigned long long *pvalue);

Remove extra space between function name and parentheses.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
