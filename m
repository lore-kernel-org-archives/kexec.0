Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4dn-0002U6-Bc
 for kexec@lists.infradead.org; Mon, 28 Jan 2019 10:59:49 +0000
Date: Mon, 28 Jan 2019 11:59:44 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] makedumpfile: honor the CFLAGS from environment variables
Message-ID: <20190128105944.fwm57pnbyvkap5fo@verge.net.au>
References: <20190128105045.30565-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128105045.30565-1-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>

On Mon, Jan 28, 2019 at 06:50:45PM +0800, Kairui Song wrote:
> This make it easier for passing extra cflags, for example hardening
> flags could be passed in with enviroment variable.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>

Thanks, I like this a lot.

I would like to wake a little to see if there is review from
others before applying this.

> ---
>  Makefile | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 612b9d0..b511a78 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -8,11 +8,11 @@ ifeq ($(strip $CC),)
>  CC	= gcc
>  endif
>  
> -CFLAGS = -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
> -	  -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE \
> -	  -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
> -CFLAGS_ARCH	= -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
> -		    -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
> +CFLAGS_ARCH = $(CFLAGS) -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
> +	      -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
> +CFLAGS += -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
> +	 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE \
> +	 -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
>  # LDFLAGS = -L/usr/local/lib -I/usr/local/include
>  
>  HOST_ARCH := $(shell uname -m)
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
