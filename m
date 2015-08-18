Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZRd0S-0000U3-Kf
 for kexec@lists.infradead.org; Tue, 18 Aug 2015 09:16:33 +0000
Date: Tue, 18 Aug 2015 17:16:06 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Add persistent memory support
Message-ID: <20150818091606.GA19950@dhcp-128-28.nay.redhat.com>
References: <1439888406-15828-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1439888406-15828-1-git-send-email-bhe@redhat.com>
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
To: toshi.kani@hp.com
Cc: kexec@lists.infradead.org

Sorry, Toshi. Resend to you since your mail address was wrong in last
mail.

On 08/18/15 at 05:00pm, Baoquan He wrote:
> Kernel add E820_PRAM or E820_PMEM type for NVDIMM memory device.
> Now support them in kexec too.
> 
> Reported-by: Toshi Kani <toshi.kani@hp.com>
> Tested-by: Toshi Kani <toshi.kani@hp.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/x86/x86-linux.h            |  2 ++
>  kexec/arch/i386/crashdump-x86.c    | 16 +++++++++++++---
>  kexec/arch/i386/kexec-x86-common.c | 10 ++++++++++
>  kexec/arch/i386/x86-linux-setup.c  |  6 ++++++
>  kexec/firmware_memmap.c            |  4 ++++
>  kexec/kexec.h                      |  2 ++
>  6 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
> index 50c7324..7834751 100644
> --- a/include/x86/x86-linux.h
> +++ b/include/x86/x86-linux.h
> @@ -21,6 +21,8 @@ struct e820entry {
>  #define E820_RESERVED	2
>  #define E820_ACPI	3 /* usable as RAM once ACPI tables have been read */
>  #define E820_NVS	4
> +#define E820_PMEM       7
> +#define E820_PRAM       12
>  } __attribute__((packed));
>  #endif
>  
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 82bf239..da85f2a 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -301,6 +301,10 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
>  			type = RANGE_ACPI;
>  		} else if(memcmp(str,"ACPI Non-volatile Storage\n",26) == 0 ) {
>  			type = RANGE_ACPI_NVS;
> +		} else if(memcmp(str,"Persistent Memory (legacy)\n",27) == 0 ) {
> +			type = RANGE_PRAM;
> +		} else if(memcmp(str,"Persistent Memory\n",18) == 0 ) {
> +			type = RANGE_PMEM;
>  		} else if(memcmp(str,"reserved\n",9) == 0 ) {
>  			type = RANGE_RESERVED;
>  		} else if (memcmp(str, "GART\n", 5) == 0) {
> @@ -640,6 +644,8 @@ static void cmdline_add_memmap_internal(char *cmdline, unsigned long startk,
>  		strcat (str_mmap, "K$");
>  	else if (type == RANGE_ACPI || type == RANGE_ACPI_NVS)
>  		strcat (str_mmap, "K#");
> +	else if (type == RANGE_PMEM || type == RANGE_PRAM)
> +		strcat (str_mmap, "K!");
>  
>  	ultoa(startk, str_tmp);
>  	strcat (str_mmap, str_tmp);
> @@ -674,10 +680,12 @@ static int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
>  		endk = (memmap_p[i].end + 1)/1024;
>  		type = memmap_p[i].type;
>  
> -		/* Only adding memory regions of RAM and ACPI */
> +		/* Only adding memory regions of RAM and ACPI and Persistent Mem */
>  		if (type != RANGE_RAM &&
>  		    type != RANGE_ACPI &&
> -		    type != RANGE_ACPI_NVS)
> +		    type != RANGE_ACPI_NVS &&
> +		    type != RANGE_PMEM &&
> +		    type != RANGE_PRAM)
>  			continue;
>  
>  		if (type == RANGE_ACPI || type == RANGE_ACPI_NVS)
> @@ -997,7 +1005,9 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  		unsigned long start, end, size, type;
>  		if ( !( mem_range[i].type == RANGE_ACPI
>  			|| mem_range[i].type == RANGE_ACPI_NVS
> -			|| mem_range[i].type == RANGE_RESERVED))
> +			|| mem_range[i].type == RANGE_RESERVED
> +			|| mem_range[i].type == RANGE_PMEM
> +			|| mem_range[i].type == RANGE_PRAM))
>  			continue;
>  		start = mem_range[i].start;
>  		end = mem_range[i].end;
> diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
> index 3624192..90534a8 100644
> --- a/kexec/arch/i386/kexec-x86-common.c
> +++ b/kexec/arch/i386/kexec-x86-common.c
> @@ -94,6 +94,12 @@ static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges
>  		else if (memcmp(str, "ACPI Non-volatile Storage\n", 26) == 0) {
>  			type = RANGE_ACPI_NVS;
>  		}
> +		else if (memcmp(str, "Persistent Memory (legacy)\n", 27) == 0) {
> +			type = RANGE_ACPI_NVS;
> +		}
> +		else if (memcmp(str, "Persistent Memory\n", 18) == 0) {
> +			type = RANGE_ACPI_NVS;
> +		}
>  		else {
>  			continue;
>  		}
> @@ -149,6 +155,10 @@ unsigned xen_e820_to_kexec_type(uint32_t type)
>  			return RANGE_ACPI;
>  		case E820_NVS:
>  			return RANGE_ACPI_NVS;
> +		case E820_PMEM:
> +			return RANGE_PMEM;
> +		case E820_PRAM:
> +			return RANGE_PRAM;
>  		case E820_RESERVED:
>  		default:
>  			return RANGE_RESERVED;
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 9271c6c..c75adaa 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -705,6 +705,12 @@ static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
>  			case RANGE_ACPI_NVS:
>  				e820[i].type = E820_NVS;
>  				break;
> +			case RANGE_PMEM:
> +				e820[i].type = E820_PMEM;
> +				break;
> +			case RANGE_PRAM:
> +				e820[i].type = E820_PRAM;
> +				break;
>  			default:
>  			case RANGE_RESERVED:
>  				e820[i].type = E820_RESERVED;
> diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
> index 6be3c7c..4d84f00 100644
> --- a/kexec/firmware_memmap.c
> +++ b/kexec/firmware_memmap.c
> @@ -168,6 +168,10 @@ static int parse_memmap_entry(const char *entry, struct memory_range *range)
>  		range->type = RANGE_ACPI_NVS;
>  	else if (strcmp(type, "Uncached RAM") == 0)
>  		range->type = RANGE_UNCACHED;
> +	else if (strcmp(type, "Persistent Memory (legacy)") == 0)
> +		range->type = RANGE_PRAM;
> +	else if (strcmp(type, "Persistent Memory") == 0)
> +		range->type = RANGE_PMEM;
>  	else {
>  		fprintf(stderr, "Unknown type (%s) while parsing %s. Please "
>  			"report this as bug. Using RANGE_RESERVED now.\n",
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index b129c15..0fa977f 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -136,6 +136,8 @@ struct memory_range {
>  #define RANGE_ACPI	2
>  #define RANGE_ACPI_NVS	3
>  #define RANGE_UNCACHED	4
> +#define RANGE_PMEM		6
> +#define RANGE_PRAM		11
>  };
>  
>  struct memory_ranges {
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
