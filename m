Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dYBy4-0006Lt-BS
 for kexec@lists.infradead.org; Thu, 20 Jul 2017 13:58:21 +0000
Subject: Re: [makedumpfile PATCH RFC v0.1] Implemented the
 --fill-excluded-pages=<value> feature
References: <1500394753-5900-1-git-send-email-eric.devolder@oracle.com>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <033f6c25-c6d4-275c-c563-22b484b74231@oracle.com>
Date: Thu, 20 Jul 2017 02:57:53 -0700
MIME-Version: 1.0
In-Reply-To: <1500394753-5900-1-git-send-email-eric.devolder@oracle.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, ats-kumagai@wm.jp.nec.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

I have fixed the problem with the patch below.
I will re-submit soon.
eric

On 07/18/2017 09:19 AM, Eric DeVolder wrote:
> When a page is excluded by any of the existing dump levels,
> that page may still be written to the ELF dump file, depending
> upon the PFN_EXCLUDED mechanism.
> 
> The PFN_EXCLUDED mechanism looks for N consecutive "not
> dumpable" pages, and if found, the current ELF segment is
> closed out and a new ELF segment started, at the next dumpable
> page. Otherwise, if the PFN_EXCLUDED criteria is not meet (that
> is, there is a mix of dumpable and not dumpable pages, but not
> N consecutive not dumpable pages) all pages are written to the
> dump file.
> 
> This patch implements a mechanism for those "not dumpable" pages
> that are written to the ELF dump file to fill those pages with
> constant data, rather than the original data. In other words,
> the dump file still contains the page, but its data is wiped.
> 
> The motivation for doing this is to protect real user data from
> "leaking" through to a dump file when that data was asked to be
> omitted. This is especially important for effort I currently am
> working on to allow further refinement of what is allowed to be
> dumped, all in an effort to protect user (customer) data.
> 
> The patch is simple enough, however, it causes problems with
> crash; crash is unable to load the resulting ELF dump file.
> For example, I do the following as a test scenario for this
> change:
> 
> - Obtain a non-filtered dump file (eg. dump level 0, no -d option,
>    or straight copy of /proc/vmcore)
> - Run vmcore through 'crash' to ensure loads ok, test with
>    commands like: ps, files, etc.
>    % crash vmlinux vmcore
> - Apply this patch and rebuild makedumpfile
> - Run vmcore through makedumpfile *without* --fill-excluded-pages
>    and with filtering to ensure no uintended side effects of patch:
>    % ./makedumpfile -E -d31 -x vmlinux vmcore newvmcore
> - Run new vmcore through crash to ensure still loads ok, test
>    with commands like: ps, files, etc.
>    % crash vmlinux newvmcore
> - Run vmcore through makedumpfile *with* --fill-excluded-pages
>    and with filtering to check side effects of patch:
>    % ./makedumpfile -E -d31 --fill-excluded-pages=0 -x vmlinux vmcore newvmcore2
> - Run new vmcore through crash to ensure still loads ok, test
>    with commands like: ps, files, etc.
>    % crash vmlinux newvmcore2
> 
> But crash yields errors like:
>    [...]
>    This GDB was configured as "x86_64-unknown-linux-gnu"...
> 
>    crash: cannot determine thread return address
>    please wait... (gathering kmem slab cache data)
>    crash: invalid kernel virtual address: 1c  type: "kmem_cache objsize/object_size"
> 
> If the patch is correct/accurate, then that may mean that crash
> is using data which it should not be.
> 
> The more likely scenario is that the patch is not correct/accurate,
> and I'm corrupting the dump file.
> 
> Please provide feedback!!
> ---
>   makedumpfile.c | 28 +++++++++++++++++++++-------
>   makedumpfile.h |  3 +++
>   2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index e69b6df..3f9816a 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -7102,7 +7102,7 @@ out:
>   
>   int
>   write_elf_load_segment(struct cache_data *cd_page, unsigned long long paddr,
> -		       off_t off_memory, long long size)
> +		       off_t off_memory, long long size, struct cycle *cycle)
>   {
>   	long page_size = info->page_size;
>   	long long bufsz_write;
> @@ -7126,10 +7126,18 @@ write_elf_load_segment(struct cache_data *cd_page, unsigned long long paddr,
>   		else
>   			bufsz_write = size;
>   
> -		if (read(info->fd_memory, buf, bufsz_write) != bufsz_write) {
> -			ERRMSG("Can't read the dump memory(%s). %s\n",
> -			    info->name_memory, strerror(errno));
> -			return FALSE;
> +		if (info->flag_fill_excluded_pages && !is_dumpable(info->bitmap2, paddr_to_pfn(paddr), cycle)) {
> +			unsigned k;
> +			unsigned long *p = (unsigned long *)buf;
> +			for (k = 0; k < info->page_size; k += sizeof(unsigned long)) {
> +				*p++ = info->fill_excluded_pages_value;
> +			}
> +		} else {
> +			if (read(info->fd_memory, buf, bufsz_write) != bufsz_write) {
> +				ERRMSG("Can't read the dump memory(%s). %s\n",
> +				    info->name_memory, strerror(errno));
> +				return FALSE;
> +			}
>   		}
>   		filter_data_buffer((unsigned char *)buf, paddr, bufsz_write);
>   		paddr += bufsz_write;
> @@ -7396,7 +7404,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>   				 */
>   				if (load.p_filesz)
>   					if (!write_elf_load_segment(cd_page, paddr,
> -								    off_memory, load.p_filesz))
> +								    off_memory, load.p_filesz, &cycle))
>   						return FALSE;
>   
>   				load.p_paddr += load.p_memsz;
> @@ -7438,7 +7446,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>   		 */
>   		if (load.p_filesz)
>   			if (!write_elf_load_segment(cd_page, paddr,
> -						    off_memory, load.p_filesz))
> +						    off_memory, load.p_filesz, &cycle))
>   				return FALSE;
>   
>   		off_seg_load += load.p_filesz;
> @@ -11007,6 +11015,7 @@ static struct option longopts[] = {
>   	{"splitblock-size", required_argument, NULL, OPT_SPLITBLOCK_SIZE},
>   	{"work-dir", required_argument, NULL, OPT_WORKING_DIR},
>   	{"num-threads", required_argument, NULL, OPT_NUM_THREADS},
> +	{"fill-excluded-pages", optional_argument, NULL, OPT_FILL_EXCLUDED_PAGES},
>   	{0, 0, 0, 0}
>   };
>   
> @@ -11163,6 +11172,11 @@ main(int argc, char *argv[])
>   		case OPT_NUM_THREADS:
>   			info->num_threads = MAX(atoi(optarg), 0);
>   			break;
> +		case OPT_FILL_EXCLUDED_PAGES:
> +			info->flag_fill_excluded_pages = 1;
> +			if (optarg)
> +				info->fill_excluded_pages_value = strtoul(optarg, NULL, 0);
> +			break;
>   		case '?':
>   			MSG("Commandline parameter is invalid.\n");
>   			MSG("Try `makedumpfile --help' for more information.\n");
> diff --git a/makedumpfile.h b/makedumpfile.h
> index e32e567..4069672 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1135,6 +1135,8 @@ struct DumpInfo {
>   	int		flag_vmemmap;        /* kernel supports vmemmap address space */
>   	int		flag_excludevm;      /* -e - excluding unused vmemmap pages */
>   	int		flag_use_count;      /* _refcount is named _count in struct page */
> +	int		flag_fill_excluded_pages;    /* if pages are excluded but still dumped (see PFN_EXCLUDED operation), replace with page with fill */
> +	unsigned long	fill_excluded_pages_value; /* fill value for excluded pages */
>   	unsigned long	vaddr_for_vtop;      /* virtual address for debugging */
>   	long		page_size;           /* size of page */
>   	long		page_shift;
> @@ -2143,6 +2145,7 @@ struct elf_prstatus {
>   #define OPT_SPLITBLOCK_SIZE	OPT_START+14
>   #define OPT_WORKING_DIR         OPT_START+15
>   #define OPT_NUM_THREADS	OPT_START+16
> +#define OPT_FILL_EXCLUDED_PAGES	OPT_START+17
>   
>   /*
>    * Function Prototype.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
