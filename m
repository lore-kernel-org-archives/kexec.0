Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZmtzN-0004cS-Bv
 for kexec@lists.infradead.org; Fri, 16 Oct 2015 01:39:22 +0000
Date: Fri, 16 Oct 2015 10:38:56 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] util_lib: Silence ar informational message
Message-ID: <20151016013855.GC20667@verge.net.au>
References: <1444346484.29301.81.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1444346484.29301.81.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org

Hi Geoff,

On Thu, Oct 08, 2015 at 04:21:24PM -0700, Geoff Levand wrote:
> Add the -c option to ar to silence the informational
> message 'ar creating libutil.a'.  ar outputs this
> message to stderr, and some tools interpret this as
> a build warning.

I am wondering about the portability of -c.
I tried to find some documentation of it and drew a blank.
Do you have any thoughts on this?

> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  util_lib/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util_lib/Makefile b/util_lib/Makefile
> index 54ccdc5..15b84e5 100644
> --- a/util_lib/Makefile
> +++ b/util_lib/Makefile
> @@ -18,5 +18,5 @@ $(UTIL_LIB): CPPFLAGS += -I$(srcdir)/util_lib/include
>  
>  $(UTIL_LIB): $(UTIL_LIB_OBJS)
>  	@$(MKDIR) -p $(@D)
> -	$(AR) rs $(UTIL_LIB) $(UTIL_LIB_OBJS)
> +	$(AR) rs -c $(UTIL_LIB) $(UTIL_LIB_OBJS)
>  
> -- 
> 2.5.0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
