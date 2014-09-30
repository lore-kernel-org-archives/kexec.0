Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XYtKG-0005oP-Pg
 for kexec@lists.infradead.org; Tue, 30 Sep 2014 09:02:29 +0000
Date: Tue, 30 Sep 2014 17:02:01 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: Enable --mem-usage for s390x
Message-ID: <20140930090201.GB9989@dhcp-16-116.nay.redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
 <20140924171904.1db5ac90@holzheu>
 <20140925094412.GI8697@dhcp-16-116.nay.redhat.com>
 <20140926101057.14549a12@holzheu>
 <20140926085546.GA30346@dhcp-16-116.nay.redhat.com>
 <20140926133441.5e58303c@holzheu>
 <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
 <20140929151413.4e9bd1ab@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140929151413.4e9bd1ab@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

On 09/29/14 at 03:14pm, Michael Holzheu wrote:
> Implement is_vmalloc_addr() using /proc/iommem parsing to enable the new
> makedumpfile option "--mem-usage".
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>


Hi Michael,

This idea looks good to me. One question, should it be put in
arch/s390.c since this is only for s390? Then iomem_for_each_line() need
be declared in makedumpfile.h .

If later it's needed by other arch, can be taken out to makedumpfile.c,
that should be better. Surely this is only my personal concern, if
Atsushi like to accept it, I am fine too.

Thanks
Baoquan

> ---
>  makedumpfile.c |   26 ++++++++++++++++++++++++++
>  makedumpfile.h |    3 ++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -9227,6 +9227,32 @@ int is_crashkernel_mem_reserved(void)
>  	return !!crash_reserved_mem_nr;
>  }
>  
> +struct addr_check {
> +	unsigned long addr;
> +	int found;
> +};
> +
> +static int phys_addr_callback(void *data, int nr, char *str,
> +			      unsigned long base, unsigned long length)
> +{
> +	struct addr_check *addr_check = data;
> +	unsigned long addr = addr_check->addr;
> +
> +	if (addr >= base && addr < base + length) {
> +		addr_check->found = 1;
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +int is_iomem_phys_addr(unsigned long addr)
> +{
> +	struct addr_check addr_check = {addr, 0};
> +
> +	iomem_for_each_line("System RAM\n", phys_addr_callback, &addr_check);
> +	return addr_check.found;
> +}
> +
>  static int get_page_offset(void)
>  {
>  	struct utsname utsname;
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -820,7 +820,7 @@ unsigned long long vaddr_to_paddr_s390x(
>  #define get_machdep_info()	get_machdep_info_s390x()
>  #define get_versiondep_info()	TRUE
>  #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
> -#define is_vmalloc_addr(X)	TRUE
> +#define is_vmalloc_addr(X)	(!is_iomem_phys_addr(X))
>  #endif          /* s390x */
>  
>  #ifdef __ia64__ /* ia64 */
> @@ -1567,6 +1567,7 @@ int read_disk_dump_header(struct disk_du
>  int read_kdump_sub_header(struct kdump_sub_header *kh, char *filename);
>  void close_vmcoreinfo(void);
>  int close_files_for_creating_dumpfile(void);
> +int is_iomem_phys_addr(unsigned long addr);
>  
>  
>  /*
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
