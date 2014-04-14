Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZWVM-0002lV-Dq
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 02:20:17 +0000
Date: Mon, 14 Apr 2014 11:19:51 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/fs2dt : Fix endianess issue with initrd base and
 size
Message-ID: <20140414021951.GM22411@verge.net.au>
References: <20140411101030.8033.95615.stgit@nimbus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140411101030.8033.95615.stgit@nimbus>
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
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

On Fri, Apr 11, 2014 at 12:10:30PM +0200, Laurent Dufour wrote:
> The initrd values exposed in the device tree of the kexeced kernel must be
> encoded in Big Endian format.
> 
> Without this patch, kexeced LE kernel are expected to panic when dealing
> with the initrd image.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Thanks, applied.

> ---
>  kexec/fs2dt.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
> index 5e6b98d..2a90979 100644
> --- a/kexec/fs2dt.c
> +++ b/kexec/fs2dt.c
> @@ -531,7 +531,7 @@ static void putnode(void)
>  	/* Add initrd entries to the second kernel */
>  	if (initrd_base && initrd_size && !strcmp(basename,"chosen/")) {
>  		int len = 8;
> -		unsigned long long initrd_end;
> +		uint64_t bevalue;
>  
>  		dt_reserve(&dt, 12); /* both props, of 6 words ea. */
>  		*dt++ = cpu_to_be32(3);
> @@ -539,7 +539,8 @@ static void putnode(void)
>  		*dt++ = cpu_to_be32(propnum("linux,initrd-start"));
>  		pad_structure_block(len);
>  
> -		memcpy(dt,&initrd_base,len);
> +		bevalue = cpu_to_be64(initrd_base);
> +		memcpy(dt, &bevalue, len);
>  		dt += (len + 3)/4;
>  
>  		len = 8;
> @@ -547,10 +548,10 @@ static void putnode(void)
>  		*dt++ = cpu_to_be32(len);
>  		*dt++ = cpu_to_be32(propnum("linux,initrd-end"));
>  
> -		initrd_end = initrd_base + initrd_size;
> +		bevalue = cpu_to_be64(initrd_base + initrd_size);
>  		pad_structure_block(len);
>  
> -		memcpy(dt,&initrd_end,len);
> +		memcpy(dt, &bevalue, len);
>  		dt += (len + 3)/4;
>  
>  		reserve(initrd_base, initrd_size);
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
