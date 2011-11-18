Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RRDyg-0001QE-8M
 for kexec@lists.infradead.org; Fri, 18 Nov 2011 02:14:55 +0000
Date: Fri, 18 Nov 2011 11:13:40 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch] kexec: improve the debug printf in
 get_crash_notes_per_cpu()
Message-ID: <20111118021339.GN14082@verge.net.au>
References: <1321449584-25551-1-git-send-email-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1321449584-25551-1-git-send-email-xiyou.wangcong@gmail.com>
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

On Wed, Nov 16, 2011 at 09:19:44PM +0800, WANG Cong wrote:
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks, applied.

> ---
> diff --git a/kexec/crashdump.c b/kexec/crashdump.c
> index 945b052..e7ac42c 100644
> --- a/kexec/crashdump.c
> +++ b/kexec/crashdump.c
> @@ -102,8 +102,8 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
>  		die("Cannot parse %s: %s\n", crash_notes, strerror(errno));
>  	*addr = (uint64_t) temp;
>  	*len = MAX_NOTE_BYTES; /* we should get this from the kernel instead */
> -#if 0
> -	printf("crash_notes addr = %Lx\n", *addr);
> +#ifdef DEBUG
> +	printf("%s: crash_notes addr = %Lx\n", __function__, *addr);
>  #endif
>  
>  	fclose(fp);
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
