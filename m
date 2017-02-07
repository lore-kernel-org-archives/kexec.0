Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cb8I4-00027E-Ta
 for kexec@lists.infradead.org; Tue, 07 Feb 2017 16:06:54 +0000
Date: Tue, 7 Feb 2017 17:06:09 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 07/12] crashdump/ppc: Add
 print_crashkernel_region_size() function
Message-ID: <20170207160609.GF13477@olila.local.net-space.pl>
References: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
 <1486410144-28595-8-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1486410144-28595-8-git-send-email-eric.devolder@oracle.com>
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
Cc: andrew.cooper3@citrix.com, dyoung@redhat.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Mon, Feb 06, 2017 at 01:42:19PM -0600, Eric DeVolder wrote:
> From: Daniel Kiper <daniel.kiper@oracle.com>
>
> Follow similar x86 patch.
>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  kexec/arch/ppc/crashdump-powerpc.c | 34 +++++++++++++++++++++++++++-------
>  kexec/arch/ppc/kexec-ppc.c         | 23 +++++++++++++++++++++++
>  kexec/arch/ppc/kexec-ppc.h         |  1 +
>  3 files changed, 51 insertions(+), 7 deletions(-)
>
> diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
> index 3dc35eb..4c12452 100644
> --- a/kexec/arch/ppc/crashdump-powerpc.c
> +++ b/kexec/arch/ppc/crashdump-powerpc.c
> @@ -397,14 +397,34 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size)
>  		usablemem_rgns.size, base, size);
>  }
>
> +int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
> +{
> +	unsigned long long value;
> +	if (get_devtree_value("/proc/device-tree/chosen/linux,crashkernel-base", &value)) {
> +		*start = value;
> +	}

Curly brackets are not needed here.

> +	else
> +		*start = 0;
> +	if (get_devtree_value("/proc/device-tree/chosen/linux,crashkernel-size", &value)) {
> +		*end = *start + value - 1;
> +	}

Ditto.

> +	else
> +		*end = 0;

I think that you should return -1 if get_devtree_value() returned error
here and there.

> +	return 0;
> +}
> +
>  int is_crashkernel_mem_reserved(void)
>  {
> -	int fd;
> -
> -	fd = open("/proc/device-tree/chosen/linux,crashkernel-base", O_RDONLY);
> -	if (fd < 0)
> -		return 0;
> -	close(fd);
> -	return 1;
> +	return get_devtree_value("/proc/device-tree/chosen/linux,crashkernel-base", NULL);

is_crashkernel_mem_reserved() change begs separate patch.

>  }
>
> +void print_crashkernel_region_size(void)
> +{
> +        uint64_t start = 0, end = 0;
> +
> +        if (is_crashkernel_mem_reserved()) {
> +                get_crash_kernel_load_range(&start, &end);

Please check value returned by get_crash_kernel_load_range() here.

> +                printf("%llu\n", end - start + 1);
> +        } else
> +                printf("0\n");
> +}
> diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
> index d046110..78e8fb8 100644
> --- a/kexec/arch/ppc/kexec-ppc.c
> +++ b/kexec/arch/ppc/kexec-ppc.c
> @@ -423,6 +423,29 @@ err_out:
>  	return -1;
>  }
>
> +int get_devtree_value (const char *fname, unsigned long long *pvalue)

Redundant space between function name and bracket.

> +{
> +	/* Return 1 if fname/value valid, 0 otherwise */
> +	FILE *file;
> +	char buf[MAXBYTES];
> +	int rcode = 1, n = -1;

s/rcode/ret/ And please follow convention and return -1 in case of error.

> +	unsigned long long value = 0;

Lack of empty line here.

> +	if ((file = fopen(fname, "r"))) {
> +		n = fread(buf, 1, MAXBYTES, file);
> +		fclose(file);
> +	}
> +	if (n == sizeof(uint32_t)) {
> +		value = ((uint32_t *)buf)[0];

Curly brackets are not needed here.

> +	} else if (n == sizeof(uint64_t)) {
> +		value = ((uint64_t *)buf)[0];

Ditto.

> +	} else {
> +		fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
> +		rcode = 0;
> +	}
> +	if (pvalue) *pvalue = value;

"*pvalue = value;" should be in line below "if".

> +	return rcode;

Please do not glue all lines into one giant block here and there. It is unreadable.

> +}
> +
>  /* Get devtree details and create exclude_range array
>   * Also create usablemem_ranges for KEXEC_ON_CRASH
>   */
> diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
> index 904cf48..69189f0 100644
> --- a/kexec/arch/ppc/kexec-ppc.h
> +++ b/kexec/arch/ppc/kexec-ppc.h
> @@ -71,6 +71,7 @@ extern unsigned char reuse_initrd;
>  extern const char *ramdisk;
>
>  /* Method to parse the memory/reg nodes in device-tree */
> +extern int get_devtree_value (const char *fname, unsigned long long *pvalue);

Put get_devtree_value() under read_memory_region_limits().

>  extern unsigned long dt_address_cells, dt_size_cells;
>  extern int init_memory_region_info(void);
>  extern int read_memory_region_limits(int fd, unsigned long long *start,

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
