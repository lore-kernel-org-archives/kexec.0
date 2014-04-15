Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZzGE-0006b0-Tr
 for kexec@lists.infradead.org; Tue, 15 Apr 2014 09:02:36 +0000
Date: Tue, 15 Apr 2014 11:02:08 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] Save PG_head_mask in VMCOREINFO
Message-ID: <20140415110208.453a95f7@hananiah.suse.cz>
In-Reply-To: <20140411175039.00fa75ea@hananiah.suse.cz>
References: <20140411175039.00fa75ea@hananiah.suse.cz>
Mime-Version: 1.0
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

On Fri, 11 Apr 2014 17:50:39 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

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

Any opinion on this patch?

TIA,
Petr T

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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
