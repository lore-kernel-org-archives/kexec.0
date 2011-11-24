Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RTSic-0007X9-5V
 for kexec@lists.infradead.org; Thu, 24 Nov 2011 06:23:37 +0000
Date: Thu, 24 Nov 2011 14:20:51 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: fix off-by-one bug in page_to_pfn()
Message-Id: <20111124142051.8b5df388.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <4ECC8A6F.3040606@cn.fujitsu.com>
References: <4ECC8A6F.3040606@cn.fujitsu.com>
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
To: wency@cn.fujitsu.com
Cc: tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org

Hi Wen,

Thank you for the patch. 
I will check it.

Thanks
Kumagai


On Wed, 23 Nov 2011 13:53:51 +0800
Wen Congyang <wency@cn.fujitsu.com> wrote:

> The pfn region in a mmd is [mmd->pfn_start, mmd->pfn_end).
> So the max index should be mmd->pfn_end - mmd->pfn_start -1.
> If index >=(not >) mmd->pfn_end - mmd->pfn_start, we should check
> the next mmd.
> 
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> 
> ---
>  makedumpfile.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 7b7c266..db8e53f 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -2879,7 +2879,7 @@ page_to_pfn(unsigned long page)
>  		if (page < mmd->mem_map)
>  			continue;
>  		index = (page - mmd->mem_map) / SIZE(page);
> -		if (index > mmd->pfn_end - mmd->pfn_start)
> +		if (index >= mmd->pfn_end - mmd->pfn_start)
>  			continue;
>  		pfn = mmd->pfn_start + index;
>  		break;
> -- 
> 1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
