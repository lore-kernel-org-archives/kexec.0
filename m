Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TxCfb-0008J0-6z
 for kexec@lists.infradead.org; Mon, 21 Jan 2013 08:24:04 +0000
Date: Mon, 21 Jan 2013 17:18:54 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile, sadump: fix bug in checking a given
 physical address is present on memory
Message-Id: <20130121171854.d59f6c6f1b5b25ca609cb3ec@mxc.nes.nec.co.jp>
In-Reply-To: <20130121.151501.404516000.d.hatayama@jp.fujitsu.com>
References: <20130121.151501.404516000.d.hatayama@jp.fujitsu.com>
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
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

Thanks for your three patches for sadump.
I'll merge them to v1.5.2.


Thanks
Atsushi Kumagai

On Mon, 21 Jan 2013 15:15:01 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> Due to lack of checking if sadump flag, interface for ELF had been
> used wrongly for sadump format. By this, all the ranges had been
> ignored and most kinds of filtering had been failed except for zero
> pages.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>  makedumpfile.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 314dc46..7ce7138 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3027,7 +3027,7 @@ clear_bit_on_2nd_bitmap_for_kernel(unsigned long long pfn)
>  static inline int
>  is_in_segs(unsigned long long paddr)
>  {
> -	if (info->flag_refiltering) {
> +	if (info->flag_refiltering || info->flag_sadump) {
>  		static struct dump_bitmap bitmap1 = {0};
>  
>  		if (bitmap1.fd == 0)
> -- 
> 1.7.7.6
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
