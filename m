Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yb0-f174.google.com ([209.85.213.174])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bnN8R-0003m7-Vx
 for kexec@lists.infradead.org; Fri, 23 Sep 2016 09:51:14 +0000
Received: by mail-yb0-f174.google.com with SMTP id d69so64337015ybf.2
 for <kexec@lists.infradead.org>; Fri, 23 Sep 2016 02:50:51 -0700 (PDT)
Date: Fri, 23 Sep 2016 15:20:46 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] kexec/fs2dt: Check for NULL pointer in
 dt_copy_old_root_param()
Message-ID: <20160923095046.GB22928@localhost.localdomain>
References: <1474615059-9510-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1474615059-9510-1-git-send-email-maddy@linux.vnet.ibm.com>
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
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

On 23/09/2016:12:47:39 PM, Madhavan Srinivasan wrote:
> In dt_copy_old_root_param(), FILE * returned
> from fopen is not checked for NULL pointer
> before passinig to fclose(). This could trigger
> a segfault. Patch adds a check.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  kexec/fs2dt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
> index 6ed2399759cf..2c1ebdf525f4 100644
> --- a/kexec/fs2dt.c
> +++ b/kexec/fs2dt.c
> @@ -540,7 +540,8 @@ static void dt_copy_old_root_param(void)
>  	if (last_cmdline)
>  		free(last_cmdline);
>  
> -	fclose(fp);
> +	if (fp)
> +		fclose(fp);

Looks fine, however a better practise could be to return just after fopen() if
fp was null.

~Pratyush

>  }
>  
>  /*
> -- 
> 2.7.4
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
