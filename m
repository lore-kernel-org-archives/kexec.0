Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a20sf-0002Jp-LQ
 for kexec@lists.infradead.org; Thu, 26 Nov 2015 18:02:54 +0000
Date: Thu, 26 Nov 2015 19:02:28 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v2] kexec: fix mmap return code handling
Message-ID: <20151126190228.47e4213a@hananiah.suse.cz>
In-Reply-To: <20151126183231.33da064b@holzheu>
References: <20151125134741.55c7e21c@holzheu> <20151126183231.33da064b@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

On Thu, 26 Nov 2015 18:32:31 +0100
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> Hi Simon again,
> 
> After a bit more thinking: In theory mmap() could also return NULL.
> Therefore the following fix is probably the better one ...

No, if you let the kernel choose the address (i.e. call mmap with NULL
addr), it will return at least PAGE_SIZE (and a higher limit is usually
enforced by sys.vm.mmap_min_addr sysctl). Admittedly the limit is set
in arch-specific code, so theoretically there can be an architecture
which sets the limit to 0, but I doubt it, because it would break too
many assumptions in user space (for example gcc assumes that
dereferencing a NULL pointer terminates a process).

In short, this other fix is just as good as the previous one.

Regards,
Petr Tesarik

> ---
> Subject: [PATCH] kexec: fix mmap return code handling
> 
> When mmap fails, MAP_FAILED (that is, (void *) -1) is returned. Currently
> we assume that NULL is returned. Fix this and add the MAP_FAILED check.
> 
> Fixes: 95741713e790 ("kexec/s390x: use mmap instead of read for slurp_file")
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index cf6e03d..f0bd527 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -573,7 +573,7 @@ static char *slurp_file_generic(const char *filename, off_t *r_size,
>  			buf = slurp_fd(fd, filename, size, &nread);
>  		}
>  	}
> -	if (!buf)
> +	if ((use_mmap && (buf == MAP_FAILED)) || (!use_mmap && (buf == NULL)))
>  		die("Cannot read %s", filename);
>  
>  	if (nread != size)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
