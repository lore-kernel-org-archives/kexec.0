Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OP3U6-0003mp-Ra
	for kexec@lists.infradead.org; Thu, 17 Jun 2010 01:01:36 +0000
Date: Thu, 17 Jun 2010 09:40:14 +0900 (JST)
Message-Id: <20100617.094014.156021983.igawa@mxs.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: works on 2.6.32
From: Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
In-Reply-To: <E1OOt1M-0001Gb-Qb@eag09.americas.sgi.com>
References: <E1OOt1M-0001Gb-Qb@eag09.americas.sgi.com>
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
To: cpw@sgi.com
Cc: kexec@lists.infradead.org

Hi, Cliff.

From: Cliff Wickman <cpw@sgi.com>
Subject: [PATCH] makedumpfile: works on 2.6.32
Date: Wed, 16 Jun 2010 08:51:12 -0500
> 
> LATEST_VERSION is updated to KERNEL_VERSION(2, 6, 32), as this seems to
> work on 2.6.32 and prevents a makedumpfile grumbling.
> 
> Tested on SGI UV, which is x86_64.
> 
> Diffed against makedumpfile-1.3.5
> 
> Signed-off-by: Cliff Wickman <cpw@sgi.com>

Thank you for separating the patches.
Merged and pushed (also the 'output files filling ramdisk' patch).
git://makedumpfile.git.sourceforge.net/gitroot/makedumpfile/makedumpfile

BTW, I'm testing makedumpfile for 2.6.32 - 34 kernel now.
After this testing, I'll release makedumpfile-1.3.6.

-- 
Regards,
Masayuki Igawa

> ---
>  makedumpfile.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: makedumpfile-1.3.5/makedumpfile.h
> ===================================================================
> --- makedumpfile-1.3.5.orig/makedumpfile.h
> +++ makedumpfile-1.3.5/makedumpfile.h
> @@ -449,7 +449,7 @@ do { \
>  #define KVER_MIN_SHIFT 16
>  #define KERNEL_VERSION(x,y,z) (((x) << KVER_MAJ_SHIFT) | ((y) << KVER_MIN_SHIFT) | (z))
>  #define OLDEST_VERSION		KERNEL_VERSION(2, 6, 15)/* linux-2.6.15 */
> -#define LATEST_VERSION		KERNEL_VERSION(2, 6, 31)/* linux-2.6.31 */
> +#define LATEST_VERSION		KERNEL_VERSION(2, 6, 32)/* linux-2.6.32 */
>  
>  /*
>   * vmcoreinfo in /proc/vmcore
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
