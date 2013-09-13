Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKJf9-0007j0-Pd
 for kexec@lists.infradead.org; Fri, 13 Sep 2013 03:03:18 +0000
Message-ID: <52327FB8.4010208@mxc.nes.nec.co.jp>
Date: Fri, 13 Sep 2013 12:00:08 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: show needed memory
References: <E1VEnuJ-0000KK-Qu@eag09.americas.sgi.com>
In-Reply-To: <E1VEnuJ-0000KK-Qu@eag09.americas.sgi.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: cpw@sgi.com
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

Hello Cliff,

(2013/08/29 7:08), Cliff Wickman wrote:
> From: Cliff Wickman <cpw@sgi.com>
> 
> If there is not enough memory available to run in cyclic mode display
> how much more would be needed to do so.
> 
> Diffed against makedumpfile-1.5.4
> Signed-off-by: Cliff Wickman <cpw@sgi.com>

This patch depends on your "use non-cyclic when possible"
and it was rejected, I'll reject this patch too.


Thanks
Atsushi Kumagai

> ---
>   makedumpfile.c |    8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> Index: makedumpfile-1.5.4/makedumpfile.c
> ===================================================================
> --- makedumpfile-1.5.4.orig/makedumpfile.c
> +++ makedumpfile-1.5.4/makedumpfile.c
> @@ -7778,11 +7778,15 @@ plenty_of_memory(void)
>   {
>   	unsigned long free_size;
>   	unsigned long needed_size;
> +	long slack = 10; /* 10M extra */
> +	long meg = 1024*1024;
>   
>   	free_size = get_free_memory_size();
> -	needed_size = (info->max_mapnr * 2) / BITPERBYTE;
> -	if (free_size > (needed_size + (10*1024*1024)))
> +	needed_size = ((info->max_mapnr * 2) / BITPERBYTE) + (slack * meg);
> +	if (free_size > needed_size)
>   		return 1;
> +	PROGRESS_MSG("Need %ldM more memory to use noncyclic mode.\n",
> +		(needed_size - free_size)/meg);
>   	return 0;
>   }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
