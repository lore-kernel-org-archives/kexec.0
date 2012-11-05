Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TVFwv-0003F9-01
 for kexec@lists.infradead.org; Mon, 05 Nov 2012 06:14:19 +0000
Date: Mon, 5 Nov 2012 15:04:27 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCHv3 8/9] Add support for filtering out user pages under Xen4
Message-Id: <20121105150427.3503c58ffc8e323b19a6ba14@mxc.nes.nec.co.jp>
In-Reply-To: <201208241743.23829.ptesarik@suse.cz>
References: <201208241743.23829.ptesarik@suse.cz>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ptesarik@suse.cz
Cc: kexec@lists.infradead.org, Norbert.Trapp@ts.fujitsu.com

Hello Petr,

I'm sorry for having kept you waiting.
I have a small comment for this patch.

On Fri, 24 Aug 2012 17:43:23 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

> In Xen-4.0+, usage of a page must be determined from its PGC_xxx
> flags, which are stored in the highest bits of the _count field
> of struct page_info.
> 
> Let's keep the original function for Xen3 only and add a new
> function for walking the pages under Xen4. This avoids adding many
> new conditionals to the inner loop and also makes the logic easier
> to follow for all Xen versions.
> 
> Signed-off-by: Norbert Trapp <norbert.trapp@ts.fujitsu.com>
> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
> 
> ---
>  makedumpfile.c |  102 
> +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  makedumpfile.h |   25 +++++++++++++
>  2 files changed, 121 insertions(+), 6 deletions(-)
> 
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -78,6 +78,31 @@ int get_mem_type(void);
>  #define LSEEKED_PDATA	(3)
>  
>  /*
> + * Xen page flags
> + */
> +#define BITS_PER_BYTE (8)
> +#define BITS_PER_LONG (BITS_PER_BYTE * sizeof(long))

BITPERBYTE is already defined as meaning the same as BITS_PER_BYTE,
so I will change this patch to use BITPERBYTE instead of BITS_PER_BYTE
when merging.

  makedumpfile.h:
    164
    165 #define BITPERBYTE              (8)
    166 #define PGMM_CACHED             (512)


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
