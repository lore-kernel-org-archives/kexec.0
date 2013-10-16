Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VWLXF-0000Eb-GY
 for kexec@lists.infradead.org; Wed, 16 Oct 2013 07:28:50 +0000
Date: Wed, 16 Oct 2013 16:28:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/fs2dt: fix endianess conversion
Message-ID: <20131016072826.GC29696@verge.net.au>
References: <20131015170528.10192.71185.stgit@nimbus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131015170528.10192.71185.stgit@nimbus>
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
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

On Tue, Oct 15, 2013 at 07:05:28PM +0200, Laurent Dufour wrote:
> While reviewing fs2dt.c in the common kexec directory, in order to use it to
> support little endian ppc64 architecture, I found some endianess
> conversion's issues.
> 
> In dt_reserve, dt_base is a pointer and thus should not be converted.
> 
> In checkprop, values read from the device tree are big endian encoded and
> should be converted if CPU is running in little endian mode.
> 
> In add_dyn_reconf_usable_mem_property__, fix extraneous endianess conversion
> of rlen which should be natively used to increase the dt pointer.

These changes seem logical to me.

However, I'm unsure how the code might have worked as-is.
In particular I'm pretty sure ARM was running in little endian
mode when I worked on DT support for it. Perhaps these code
paths were not executed. Or the errors cancelled themselves out somehow?

> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  kexec/fs2dt.c |   19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
> index 242a15e..5d774ae 100644
> --- a/kexec/fs2dt.c
> +++ b/kexec/fs2dt.c
> @@ -84,7 +84,7 @@ static void dt_reserve(unsigned **dt_ptr, unsigned words)
>  		offset = *dt_ptr - dt_base;
>  		dt_base = new_dt;
>  		dt_cur_size = new_size;
> -		*dt_ptr = cpu_to_be32((unsigned)dt_base + offset);
> +		*dt_ptr = dt_base + offset;
>  		memset(*dt_ptr, 0, (new_size - offset)*4);
>  	}
>  }
> @@ -112,19 +112,22 @@ static void checkprop(char *name, unsigned *data, int len)
>  	if ((data == NULL) && (base || size || end))
>  		die("unrecoverable error: no property data");
>  	else if (!strcmp(name, "linux,rtas-base"))
> -		base = *data;
> +		base = be32_to_cpu(*data);
>  	else if (!strcmp(name, "linux,tce-base"))
> -		base = *(unsigned long long *) data;
> +		base = be64_to_cpu(*(unsigned long long *) data);
>  	else if (!strcmp(name, "rtas-size") ||
>  			!strcmp(name, "linux,tce-size"))
> -		size = *data;
> +		size = be32_to_cpu(*data);
>  	else if (reuse_initrd && !strcmp(name, "linux,initrd-start"))
>  		if (len == 8)
> -			base = *(unsigned long long *) data;
> +			base = be64_to_cpu(*(unsigned long long *) data);
>  		else
> -			base = *data;
> +			base = be32_to_cpu(*data);
>  	else if (reuse_initrd && !strcmp(name, "linux,initrd-end"))
> -		end = *(unsigned long long *) data;
> +		if (len == 8)
> +			end = be64_to_cpu(*(unsigned long long *) data);
> +		else
> +			end = be32_to_cpu(*data);
>  
>  	if (size && end)
>  		die("unrecoverable error: size and end set at same time\n");
> @@ -267,7 +270,7 @@ static void add_dyn_reconf_usable_mem_property__(int fd)
>  	pad_structure_block(rlen);
>  	memcpy(dt, ranges, rlen);
>  	free(ranges);
> -	dt += cpu_to_be32((rlen + 3)/4);
> +	dt += (rlen + 3)/4;
>  }
>  
>  static void add_dyn_reconf_usable_mem_property(struct dirent *dp, int fd)
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
