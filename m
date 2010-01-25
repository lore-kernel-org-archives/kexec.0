Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NZJIq-0004Sc-0V
	for kexec@lists.infradead.org; Mon, 25 Jan 2010 07:24:08 +0000
Date: Mon, 25 Jan 2010 18:23:57 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix --reuse-cmdline so it is usable.
Message-ID: <20100125072352.GD23849@verge.net.au>
References: <m1d4167c5s.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1d4167c5s.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Tue, Jan 19, 2010 at 12:05:03AM -0800, Eric W. Biederman wrote:
> 
> A colleague of mine implemented kdump and it used --reuse-cmdline
> with some rather interesting and unexpected results.
> 
> Update the getopt specification so that --reuse-cmdline does not
> attempt to take an argument that it will not use.
> 
> Update the processing of --append so that --reuse-cmdline followed
> by --append actually appends the parameters specified by --reuse-cmdline.

Hi Eric,

sorry for being slow. Been semi-offline for LCA and am now catching
up on things.

[snip]

> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index a1cec86..f4c22a6 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -994,6 +994,22 @@ void check_reuse_initrd(void)
>  	free(line);
>  }
>  
> +const char *concat_cmdline(const char *base, const char *append)
> +{
> +	const char *cmdline;
> +	if (!base && !append)
> +		return NULL;
> +	if (!base)
> +		return append;
> +	if (!append)
> +		return base;
> +	cmdline = xmalloc(strlen(base) + 1 + strlen(append) + 1);
> +	strcpy(cmdline, base);
> +	strcat(cmdline, " ");
> +	strcat(cmdline, append);
> +	return cmdline;
> +}
> +

This introduces a memory leak.

Perhaps it should strdup append and base in the !base and !append cases
respectively and expect the caller to always call free.

I realise that its a small leak in a programme that will soon exit anyway.
But for the sake of being able to use tools like valgrind to analyse
problems it seems to me that leaks are worth avoiding.  (Not that I have
run valgrind on kexec-tools to see what happens :-)

[snip]


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
