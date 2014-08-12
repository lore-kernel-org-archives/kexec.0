Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XH94A-0001w0-UC
 for kexec@lists.infradead.org; Tue, 12 Aug 2014 10:12:31 +0000
Date: Tue, 12 Aug 2014 18:10:49 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [Patch v3 5/7] prepare the dump loads for kcore analysis
Message-ID: <20140812101049.GE4887@dhcp-16-105.nay.redhat.com>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-6-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97246600@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97246600@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 08/01/14 at 07:12am, Atsushi Kumagai wrote:

> >  * Get ELF information about /proc/vmcore.
> >diff --git a/elf_info.h b/elf_info.h
> >index 3ce0138..ba27fdf 100644
> >--- a/elf_info.h
> >+++ b/elf_info.h
> >@@ -46,6 +46,7 @@ int get_elf_info(int fd, char *filename);
> > void free_elf_info(void);
> > int get_elf_loads(int fd, char *filename);
> > int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len);
> >+int get_kcore_dump_loads();
> >
> > int is_elf64_memory(void);
> > int is_xen_memory(void);
> >diff --git a/makedumpfile.h b/makedumpfile.h
> >index 7ffa1ee..8881c76 100644
> >--- a/makedumpfile.h
> >+++ b/makedumpfile.h
> >@@ -719,6 +719,7 @@ unsigned long long vaddr_to_paddr_x86(unsigned long vaddr);
> > #endif /* x86 */
> >
> > #ifdef __x86_64__
> >+int is_vmalloc_addr(ulong vaddr);
> > int get_phys_base_x86_64(void);
> > int get_machdep_info_x86_64(void);
> > int get_versiondep_info_x86_64(void);
> 
> It will fail to build due to undefined is_vmalloc_addr() except on
> x86_64, let's define it also for the other architectures like below:
> 
> #ifdef __x86__
>  int get_machdep_info_x86(void);
>  int get_versiondep_info_x86(void);
> +int is_vmalloc_addr_x86(ulong vaddr);
>  unsigned long long vaddr_to_paddr_x86(unsigned long vaddr);
>  #define get_phys_base()                TRUE
>  #define get_machdep_info()     get_machdep_info_x86()
>  #define get_versiondep_info()  get_versiondep_info_x86()
>  #define vaddr_to_paddr(X)      vaddr_to_paddr_x86(X)
> +#define is_vmalloc_addr(X)      is_vmalloc_addr_x86(X)
>  #endif /* x86 */
> 
> Besides, I think it's better to rename the is_vmalloc_addr() in
> arch/x86_64.c to is_vmalloc_addr_x86_64().

Great idea, will change.


> 
> 
> Thanks
> Atsushi Kumagai
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
