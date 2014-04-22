Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WcR07-0003pt-H0
 for kexec@lists.infradead.org; Tue, 22 Apr 2014 03:04:04 +0000
Date: Tue, 22 Apr 2014 11:01:58 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Save PG_head_mask in VMCOREINFO
Message-ID: <20140422030158.GJ8084@dhcp-16-105.nay.redhat.com>
References: <20140411175039.00fa75ea@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140411175039.00fa75ea@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Sasha Levin <sasha.levin@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@intel.com>, Shaohua Li <shli@kernel.org>

On 04/11/14 at 05:50pm, Petr Tesarik wrote:
> To allow filtering of huge pages, makedumpfile must be able to
> identify them in the dump. This can be done by checking the
> appropriate page flag, so communicate its value to makedumpfile
> through the VMCOREINFO interface.
> 
> There's only one small catch. Depending on how many page flags
> are available on a given architecture, this bit can be called
> PG_head or PG_compound.
> 
> I sent a similar patch back in 2012, but Eric Biederman did not
> like using an #ifdef. So, this time I'm adding a common symbol
> (PG_head_mask) instead.
> 
> See https://lkml.org/lkml/2012/11/28/91 for the previous version.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
> ---
>  include/linux/page-flags.h | 3 +++
>  kernel/kexec.c             | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index d1fe1a7..bc2007e 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -348,6 +348,9 @@ static inline void ClearPageCompound(struct page
> *page) ClearPageHead(page);
>  }
>  #endif
> +
> +#define PG_head_mask ((1L << PG_head))

Hi Petr,

I am fine with this trick which define one name PG_head_mask, but can
stands for both PG_head and PG_compound. 

I guess Eric may suggest the implementation like it done in
mm/memory-failure.c . In that file it explicitly defines both of them.

Thanks
Baoquan

> +
>  #else
>  /*
>   * Reduce page flag use as much as possible by overlapping
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index c8380ad..e6f3aec 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1622,6 +1622,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  #ifdef CONFIG_MEMORY_FAILURE
>  	VMCOREINFO_NUMBER(PG_hwpoison);
>  #endif
> +	VMCOREINFO_NUMBER(PG_head_mask);
>  	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
>  
>  	arch_crash_save_vmcoreinfo();
> -- 
> 1.8.4.5
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
