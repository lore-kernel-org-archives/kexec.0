Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uf313-0000Su-5a
 for kexec@lists.infradead.org; Wed, 22 May 2013 06:59:19 +0000
Date: Wed, 22 May 2013 15:57:12 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: turn off mmap for free page scan
Message-Id: <20130522155712.0940be98ced5e3bcfde55acd@mxc.nes.nec.co.jp>
In-Reply-To: <E1UcggB-0005hJ-E0@eag09.americas.sgi.com>
References: <E1UcggB-0005hJ-E0@eag09.americas.sgi.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: cpw@sgi.com
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

On Wed, 15 May 2013 13:43:59 -0500
Cliff Wickman <cpw@sgi.com> wrote:

> From: Cliff Wickman <cpw@sgi.com>
> 
> Because addresses of each successive page structure are often descending
> it is much faster to use read()'s, so set off info->flag_usemmap
> while doing exclude_free_page().
> 
> Signed-off-by: Cliff Wickman <cpw@sgi.com>

Sounds good.
BTW, do you have a speed measurement like your another patch ?

> I find this to speed the scan of page structures for a 1TB system from
> 60sec to 30sec.


Thanks
Atsushi Kumagai

> ---
>  makedumpfile.c |   15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> Index: makedumpfile.mmap/makedumpfile.c
> ===================================================================
> --- makedumpfile.mmap.orig/makedumpfile.c
> +++ makedumpfile.mmap/makedumpfile.c
> @@ -3925,9 +3925,18 @@ _exclude_free_page(void)
>  	return TRUE;
>  }
>  
> +/*
> + * Note that this is a very lengthy process, even using mmap(2). The
> + * page structures in the free lists are read one-at-a-time, but using
> + * readpage_elf(), which reads an entire page.  And addresses of each
> + * successive page structure are often descending, which means that each
> + * read is another mmap(2) operation.
> + * It is much faster to use read()'s, so set off info->flag_usemmap here.
> + */
>  int
>  exclude_free_page(void)
>  {
> +	int save = info->flag_usemmap;
>  	/*
>  	 * Check having necessary information.
>  	 */
> @@ -3961,8 +3970,12 @@ exclude_free_page(void)
>  	/*
>  	 * Detect free pages and update 2nd-bitmap.
>  	 */
> -	if (!_exclude_free_page())
> +	info->flag_usemmap = 0;
> +	if (!_exclude_free_page()) {
> +		info->flag_usemmap = save;
>  		return FALSE;
> +	}
> +	info->flag_usemmap = save;
>  
>  	return TRUE;
>  }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
