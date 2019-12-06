Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1idLpG-00069a-Vb
 for kexec@lists.infradead.org; Fri, 06 Dec 2019 22:11:52 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: assign bitmap2 fd for sub process during
 refiltering
Date: Fri, 6 Dec 2019 22:11:01 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035977E6@BPXM09GP.gisp.nec.co.jp>
References: <1575358627-17152-1-git-send-email-piliu@redhat.com>
In-Reply-To: <1575358627-17152-1-git-send-email-piliu@redhat.com>
Content-Language: en-US
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
To: Pingfan Liu <piliu@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Pingfan,

> -----Original Message-----
> In refiltering mode, each sub process inherits bitmap2->fd from parent.
> Then they lseek()/read() on the same fd, which means that they interference
> with each other.
> 
> This breaks the purpose of SPLITTING_FD_BITMAP(i) for each sub process.
> Fix it by assigning a sub process dedicated fd to bitmap2->fd.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>

Thanks for the patch.
I'm still reading the code, but it might be better to apply this to bitmap1->fd
as well?  see you next week..

Thanks,
Kazu

> ---
>  makedumpfile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index d76a435..1dc8640 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -8857,7 +8857,8 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
>  	if (info->flag_cyclic) {
>  		if (!prepare_bitmap2_buffer())
>  			return FALSE;
> -	}
> +	} else if (info->flag_refiltering)
> +		info->bitmap2->fd = info->fd_bitmap;
> 
>  	/*
>  	 * Write pages and bitmap cyclically.
> --
> 2.7.5
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
