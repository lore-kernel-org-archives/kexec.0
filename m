Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xvcd3-0000H5-NA
 for kexec@lists.infradead.org; Tue, 02 Dec 2014 01:51:50 +0000
Date: Tue, 2 Dec 2014 10:51:27 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/fs2dt: Use slurp_file_len to avoid partial read of
 files
Message-ID: <20141202015127.GF20072@verge.net.au>
References: <1417478380-16890-1-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1417478380-16890-1-git-send-email-anton@samba.org>
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
To: Anton Blanchard <anton@samba.org>
Cc: kexec@lists.infradead.org

On Tue, Dec 02, 2014 at 10:59:40AM +1100, Anton Blanchard wrote:
> The OPAL firmware is going to embed its symbol map in the device tree.
> The size is large enough to be more than a page, and it takes
> multiple reads to get the whole file. This is because sysfs uses
> the seq_file helpers which do a page at a time.
> 
> Unfortunately fs2dt has no handling for short reads and we die with:
> 
> unrecoverable error: short read from"/proc/device-tree//ibm,opal/firmware/symbol-map"
> 
> This patch uses the slurp_file_len helper which does the right thing.
> It moves the explicit open of the file further down for
> add_usable_mem_property and add_dyn_reconf_usable_mem_property.
> We should convert both of these to use the buffer provided by
> slurp_file_len at some stage.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Thanks, applied.

> ---
>  kexec/fs2dt.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
> index 304f6cb..3b4432d 100644
> --- a/kexec/fs2dt.c
> +++ b/kexec/fs2dt.c
> @@ -381,8 +381,8 @@ static void putprops(char *fn, struct dirent **nlist, int numlist)
>  {
>  	struct dirent *dp;
>  	int i = 0, fd;
> -	size_t len;
> -	ssize_t slen;
> +	off_t len;
> +	off_t slen;
>  	struct stat statbuf;
>  
>  	for (i = 0; i < numlist; i++) {
> @@ -443,23 +443,27 @@ static void putprops(char *fn, struct dirent **nlist, int numlist)
>  		*dt++ = cpu_to_be32(propnum(fn));
>  		pad_structure_block(len);
>  
> -		fd = open(pathname, O_RDONLY);
> -		if (fd == -1)
> -			die("unrecoverable error: could not open \"%s\": %s\n",
> -			    pathname, strerror(errno));
> +		if (len) {
> +			char *buf;
>  
> -		slen = read(fd, dt, len);
> -		if (slen < 0)
> -			die("unrecoverable error: could not read \"%s\": %s\n",
> -			    pathname, strerror(errno));
> -		if ((size_t)slen != len)
> -			die("unrecoverable error: short read from\"%s\"\n",
> -			    pathname);
> +			buf = slurp_file_len(pathname, len, &slen);
> +			if (slen != len)
> +				die("unrecoverable error: short read from\"%s\"\n",
> +				    pathname);
> +
> +			memcpy(dt, buf, slen);
> +			free(buf);
> +		}
>  
>  		checkprop(fn, dt, len);
>  
>  		dt += (len + 3)/4;
>  
> +		fd = open(pathname, O_RDONLY);
> +		if (fd == -1)
> +			die("unrecoverable error: could not open \"%s\": %s\n",
> +			    pathname, strerror(errno));
> +
>  		if (!strcmp(dp->d_name, "reg") && usablemem_rgns.size)
>  			add_usable_mem_property(fd, len);
>  		add_dyn_reconf_usable_mem_property(dp, fd);
> -- 
> 2.1.0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
