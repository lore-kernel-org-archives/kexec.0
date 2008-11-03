Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kx8bp-0003mk-KX
	for kexec@lists.infradead.org; Mon, 03 Nov 2008 23:13:22 +0000
Date: Tue, 4 Nov 2008 10:13:19 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/4] slurpfile: use lseek() on character nodes instead
	of fstat() for file size
Message-ID: <20081103231317.GA24084@verge.net.au>
References: <1225749543-32683-1-git-send-email-sebastian@breakpoint.cc>
	<1225749543-32683-2-git-send-email-sebastian@breakpoint.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1225749543-32683-2-git-send-email-sebastian@breakpoint.cc>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org

On Mon, Nov 03, 2008 at 10:59:00PM +0100, Sebastian Andrzej Siewior wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> fstat() is used to determine the filesize before read() and
> it requires a filesystem. That it means it can not be used
> on character nodes. This makes it impossible to obtains the
> kernel from a char node like mtd or more likely ubi.
> We can't use this in every case because files in /proc don't
> support lseek(). This is required by the powerpc part to read
> some device-tree entries.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kexec/kexec.c |   22 ++++++++++++++++++++--
>  1 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 0616091..3c3f73e 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -467,7 +467,7 @@ char *slurp_file(const char *filename, off_t *r_size)
>  {
>  	int fd;
>  	char *buf;
> -	off_t size, progress;
> +	off_t size, progress, err;
>  	ssize_t result;
>  	struct stat stats;
>  	
> @@ -486,7 +486,25 @@ char *slurp_file(const char *filename, off_t *r_size)
>  		die("Cannot stat: %s: %s\n",
>  			filename, strerror(errno));
>  	}
> -	size = stats.st_size;
> +	/*
> +	 * Seek in case the kernel is a character node like /dev/ubi0_0.
> +	 * This does not work on regular files which live in /proc and
> +	 * we need this for some /proc/device-tree entries
> +	 */
> +	if (S_ISCHR(stats.st_mode)) {
> +
> +		size = lseek(fd, 0, SEEK_END);
> +		if (size < 0)
> +			die("Can not seek file %s: %s\n", filename, strerror(errno));
> +
> +		err = lseek(fd, 0, SEEK_SET);
> +		if (err < 0)
> +			die("Can not seek to the begin of file %s: %s\n", filename,
> +					strerror(errno));

Please reformat these lines so they are <= 80 columns wide.

> +	} else {
> +		size = stats.st_size;
> +	}
> +
>  	*r_size = size;
>  	buf = xmalloc(size);
>  	progress = 0;
> -- 
> 1.6.0.2
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
