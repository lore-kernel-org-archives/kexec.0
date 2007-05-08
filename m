Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HlIsh-00020U-IY
	for kexec@lists.infradead.org; Tue, 08 May 2007 02:09:05 -0400
Date: Tue, 8 May 2007 15:08:58 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 1/5] kexec debug output improvments
Message-ID: <20070508060857.GC8170@verge.net.au>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE27.4060402@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <463FBE27.4060402@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

On Mon, May 07, 2007 at 05:02:47PM -0700, Geoff Levand wrote:
> kexec debug output improvments.
>  - Add better type checking for the debug output macro dfprintf().
>  - Add a convenence macro dprintf().
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  kexec/kexec.h |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> --- kexec-tools-hacked.orig/kexec/kexec.h
> +++ kexec-tools-hacked/kexec/kexec.h
> @@ -217,10 +217,12 @@ int parse_iomem_single(char *str, uint64
>  
>  #define MAX_LINE	160
>  
> +#define dprintf(args...) dfprintf(stdout, args)
>  #ifdef DEBUG
> -#define dfprintf(args...)	do {fprintf(args);} while(0)
> +#define dfprintf(_f, _args...) do {fprintf(_f, _args);} while(0)
>  #else
> -#define dfprintf(args...)	do { } while(0)
> +static inline int __attribute__ ((format (printf, 1, 2)))
> +	dfprintf(FILE *f, const char *fmt, ...) {return 0;}
>  #endif

I think that this should be

static inline int __attribute__ ((format (printf, 2, 3)))

am I crazy?

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
