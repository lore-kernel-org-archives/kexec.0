Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NC4c4-0000qt-Pz
	for kexec@lists.infradead.org; Sun, 22 Nov 2009 05:03:57 +0000
Date: Sun, 22 Nov 2009 16:03:50 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec.c: workaround getline and fscanf to make it
	*libc agnostic. Tested against klibc and dietlibc.
Message-ID: <20091122050350.GF2728@verge.net.au>
References: <1258845169-4999-1-git-send-email-andrea.adami@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1258845169-4999-1-git-send-email-andrea.adami@gmail.com>
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
To: Andrea Adami <andrea.adami@gmail.com>
Cc: Yuri Bushmelev <jay4mail@gmail.com>, kexec@lists.infradead.org

On Sun, Nov 22, 2009 at 12:12:49AM +0100, Andrea Adami wrote:
> 
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> Signed-off-by: Yuri Bushmelev <jay4mail@gmail.com>
> ---
>  kexec/kexec.c |   38 ++++++++++++++++++++++++++++++--------
>  1 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index ce105cd..a3ca79c 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -933,15 +933,32 @@ void usage(void)
>  
>  static int kexec_loaded(void)
>  {
> -	int ret;
> +	long ret = -1;
>  	FILE *fp;
> +	char *p;
> +	char line[3];
>  
>  	fp = fopen("/sys/kernel/kexec_loaded", "r");
>  	if (fp == NULL)
>  		return -1;
> -	fscanf(fp, "%d", &ret);
> +/*	fscanf(fp, "%d", &ret); */

	I'm not sure this comment is needed.
	If you'd like to keep it, please indent it by one tab
	and replace the between '/*' and 'fscanf' with a single space.

	/* fscanf(fp, "%d", &ret); */

> +	p = fgets(line, sizeof(line), fp);
>  	fclose(fp);
> -	return ret;
> +
> +	if ( NULL == p)
> +		return -1;
> +
> +	ret = strtol(line, &p, 10);
> +
> +	if (ret > INT_MAX)
> +	/* Too long */

	Please remove this comment or move it to immediately
	above the if statement.

	/* Too long */
	if (ret > INT_MAX)
		...

> +		return -1;
> +
> +	if (p == line)
> +	/* No digits were found */

	Again, please remove this comment or move it to immediately
	above the if statement.

> +		return -1;
> +
> +	return (int)ret;
>  }
>  
>  /*
> @@ -989,18 +1006,23 @@ static void remove_parameter(char *line, const char *param_name)
>  char *get_command_line(void)
>  {
>  	FILE *fp;
> -	size_t len;
> -	char *line = NULL;
> +	const int sizeof_line = 1024;

	Should they type of sizeof_line be const size_t ?

> +	char *line = malloc(sizeof_line); /* according to strdup() later */

	Could line be char line[1024] ?
>  
>  	fp = fopen("/proc/cmdline", "r");
>  	if (!fp)
> -		die("Could not read /proc/cmdline.");
> -	getline(&line, &len, fp);
> +		die("Could not open /proc/cmdline.");
> +
> +	if ( NULL == fgets(line, sizeof(line), fp) ) {

	* The reverse of this logic makes more sense to me:

	  if (fgets(line, sizeof(line), fp) == NULL) {

	* Should sizeof(line) be sizeof_line?
	  Or alternatively line changed from a pointer to an array.

	  As it stands sizeof(line) == 4 (on x86_32, glibc)

> +		die("Can't read /proc/cmdline.");
> +
> +/* 	getline(&line, &len, fp); */

	Again, I don't think this comment is needed,
	but if you want to keep it please indent it by one tab
	and replace the between '/*' and 'getline' with a single space.

>  	fclose(fp);

	fclose looks like it needs to be indented by two tabs.

> +	}
>  
>  	if (line) {
>  		/* strip newline */
> -		*(line + strlen(line) - 1) = 0;
> +		line[strlen(line) - 1] = '\0';
>  
>  		remove_parameter(line, "BOOT_IMAGE");
>  		if (kexec_flags & KEXEC_ON_CRASH)
> -- 
> 1.6.4.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
