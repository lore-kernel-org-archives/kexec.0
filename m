Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxYCI-0027I2-HM
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 17:36:12 +0000
Date: Wed, 15 Dec 2021 18:36:02 +0100
From: Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH v2 3/5] add slurp_proc_file()
Message-ID: <20211215183602.2797fdf5@rhtmp>
In-Reply-To: <20211215101836.1181165-4-svens@linux.ibm.com>
References: <20211215101836.1181165-1-svens@linux.ibm.com>
 <20211215101836.1181165-4-svens@linux.ibm.com>
MIME-Version: 1.0
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
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

Hi Sven,

sorry, i need to nag again.

On Wed, 15 Dec 2021 11:18:34 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> slurp_file() cannot be used to read proc files, as they are returning
> a size of zero in stat(). Add a function slurp_proc_file() which is
> similar to slurp_file(), but doesn't require the size of the file to
> be known.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  kexec/kexec.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index f63b36b771eb..a1acba2adf2a 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1106,6 +1106,38 @@ static void remove_parameter(char *line, const char *param_name)
>  	}
>  }
>  
> +static char *slurp_proc_file(const char *filename, size_t *len)
> +{
> +	ssize_t ret, startpos = 0;
> +	unsigned int size = 64;
> +	char *buf = NULL, *tmp;
> +	int fd;
> +
> +	fd = open(filename, O_RDONLY);
> +	if (fd == -1)
> +		return NULL;
> +
> +	do {
> +		size *= 2;
> +		tmp = realloc(buf, size);
> +		if (!tmp) {
> +			free(buf);
> +			return NULL;
> +		}
> +		buf = tmp;
> +
> +		ret = read(fd, buf + startpos, size - startpos);
> +		if (ret < 0) {
> +			free(buf);
> +			return NULL;
> +		}
> +		startpos += ret;
> +		*len = startpos;
> +	} while (ret == size);

I don't think this will work as intended. 

1) read returns the bytes read. So ret has a maximum value of
   size - startpos and thus can only be equal to size on the first pass
   when startpos = 0.

2) it's not an error when read reads less bytes than requested but can
   happen when, e.g. it get's interrupted.

The simplest solution I see is to simply use 'while (ret)' Even when
that means that there is an extra pass in the loop with an extra
call to realloc.

The cleaner solution probably would be to put the read into a second
loop. I.e. the following should work (no tested)

	do {
		[...]
		do {
			ret = read(fd, buf + startpos, size - startpos);
			if (ret < 0) {
				free(buf);
				return NULL;
			}
			startpos += ret;
		while (ret && startpos != size);

		*len = startpos;
	} while (ret);

Thanks
Philipp


> +
> +	return buf;
> +}
> +
>  /*
>   * Returns the contents of the current command line to be used with
>   * --reuse-cmdline option.  The function gets called from architecture specific


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
