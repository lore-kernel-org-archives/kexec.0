Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UG4O8-0001DV-0H
 for kexec@lists.infradead.org; Thu, 14 Mar 2013 09:23:56 +0000
Date: Thu, 14 Mar 2013 10:23:46 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 10/13] kexec: ppc64: use _ALIGN* to make the logic clear
Message-ID: <20130314092345.GM11196@verge.net.au>
References: <5140B511.7020109@gmail.com>
 <5140B853.2050906@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5140B853.2050906@gmail.com>
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Mar 14, 2013 at 01:33:07AM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> By replacing all the explicit align opertion with marco _ALIGN*,
> the code logic could be more clear.

This appears to break the ppc64 build.

powerpc64-unknown-linux-gnu-gcc -Wall -Wextra -Wpointer-arith -Wwrite-strings -Wformat -O2 -fomit-frame-pointer -pipe -fno-strict-aliasing -Wall -Wstrict-prototypes -I/home/horms/local/opt/crosstool/powerpc-970/gcc-4.1.1-glibc-2.3.6/powerpc64-unknown-linux-gnu/include -I./include -I./util_lib/include -Iinclude/  -I./kexec/arch/ppc64/include -c -MD -o kexec/arch/ppc64/fs2dt.o kexec/arch/ppc64/fs2dt.c
kexec/arch/ppc64/fs2dt.c: In function 'putnode':
kexec/arch/ppc64/fs2dt.c:492: warning: passing argument 4 of 'scandir' from
incompatible pointer type
kexec/arch/ppc64/fs2dt.c:738:1: error: unterminated argument list invoking
macro "_ALIGN"
kexec/arch/ppc64/fs2dt.c: In function 'create_flatten_tree':
kexec/arch/ppc64/fs2dt.c:701: error: '_ALIGN' undeclared (first use in this
function)
kexec/arch/ppc64/fs2dt.c:701: error: (Each undeclared identifier is
reported only once
kexec/arch/ppc64/fs2dt.c:701: error: for each function it appears in.)
kexec/arch/ppc64/fs2dt.c:701: error: expected ';' at end of input
kexec/arch/ppc64/fs2dt.c:676: warning: unused variable 'buf'
kexec/arch/ppc64/fs2dt.c:675: warning: unused variable 'tlen'
kexec/arch/ppc64/fs2dt.c:672: warning: unused parameter 'bufp'
kexec/arch/ppc64/fs2dt.c:672: warning: unused parameter 'sizep'
kexec/arch/ppc64/fs2dt.c:701: warning: control reaches end of non-void function

> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  kexec/arch/ppc64/crashdump-ppc64.c |    4 ++--
>  kexec/arch/ppc64/fs2dt.c           |    6 ++----
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
> index b8a63bd..49cab12 100644
> --- a/kexec/arch/ppc64/crashdump-ppc64.c
> +++ b/kexec/arch/ppc64/crashdump-ppc64.c
> @@ -298,7 +298,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
>  		 * to the next page size boundary though, so makedumpfile can
>  		 * read it safely without going south on us.
>  		 */
> -		cend = (cend + page_size - 1) & (~(page_size - 1));
> +		cend = _ALIGN(cend, page_size);
>  
>  		crash_memory_range[memory_ranges].start = cstart;
>  		crash_memory_range[memory_ranges++].end = cend;
> @@ -400,7 +400,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  	info->backup_src_start = BACKUP_SRC_START;
>  	info->backup_src_size = BACKUP_SRC_SIZE;
>  	/* Create a backup region segment to store backup data*/
> -	sz = (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
> +	sz = _ALIGN(BACKUP_SRC_SIZE, align);
>  	tmp = xmalloc(sz);
>  	memset(tmp, 0, sz);
>  	info->backup_start = add_buffer(info, tmp, sz, sz, align,
> diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
> index 9750c34..62edc93 100644
> --- a/kexec/arch/ppc64/fs2dt.c
> +++ b/kexec/arch/ppc64/fs2dt.c
> @@ -698,8 +698,7 @@ int create_flatten_tree(char **bufp, off_t *sizep, char *cmdline)
>  	dt_reserve(&dt, 1);
>  	*dt++ = 9;
>  
> -	len = sizeof(bb[0]);
> -	len += 7; len &= ~7;
> +	len = _ALIGN(sizeof(bb[0], 8);
>  
>  	bb->off_mem_rsvmap = len;
>  
> @@ -714,8 +713,7 @@ int create_flatten_tree(char **bufp, off_t *sizep, char *cmdline)
>  	len *= sizeof(unsigned);
>  	bb->off_dt_strings = bb->off_dt_struct + len;
>  
> -	len = propnum("");
> -	len +=  3; len &= ~3;
> +	len = _ALIGN(propnum(""), 4);
>  	bb->totalsize = bb->off_dt_strings + len;
>  
>  	bb->magic = 0xd00dfeed;
> -- 
> 1.7.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
