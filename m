Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UChfl-0003KF-1P
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 02:32:09 +0000
Date: Tue, 5 Mar 2013 11:32:06 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: consolidate crash late initialization
Message-ID: <20130305023206.GL16128@verge.net.au>
References: <1338372309-24983-1-git-send-email-vdavydov@parallels.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1338372309-24983-1-git-send-email-vdavydov@parallels.com>
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
To: Vladimir Davydov <vdavydov@parallels.com>
Cc: kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On Wed, May 30, 2012 at 02:05:09PM +0400, Vladimir Davydov wrote:
> Use one module_init() instead of two.

I'm not sure I understand the motivation for this change.

> ---
>  kernel/kexec.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 4e2e472..c3341cb 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1240,7 +1240,6 @@ static int __init crash_notes_memory_init(void)
>  	}
>  	return 0;
>  }
> -module_init(crash_notes_memory_init)
>  
>  
>  /*
> @@ -1520,7 +1519,13 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	return 0;
>  }
>  
> -module_init(crash_save_vmcoreinfo_init)
> +static int __init crash_init(void)
> +{
> +	crash_notes_memory_init();
> +	crash_save_vmcoreinfo_init();
> +	return 0;
> +}
> +module_init(crash_init)
>  
>  /*
>   * Move into place and start executing a preloaded standalone
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
