Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8hre-0003mj-HG
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 01:55:55 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1361496375-30994-1-git-send-email-sasha.levin@oracle.com>
Date: Thu, 21 Feb 2013 17:55:27 -0800
In-Reply-To: <1361496375-30994-1-git-send-email-sasha.levin@oracle.com> (Sasha
 Levin's message of "Thu, 21 Feb 2013 20:26:15 -0500")
Message-ID: <87vc9l5cz4.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: prevent double free on image allocation failure
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
To: Sasha Levin <sasha.levin@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Sasha Levin <sasha.levin@oracle.com> writes:

> If kimage_normal_alloc() fails to initialize an allocated kimage, it will free
> the image but would still set 'rimage', as a result kexec_load will try
> to free it again.
>
> This would explode as part of the freeing process is accessing internal
> members which point to uninitialized memory.

Agreed.

I don't think that failure path has ever actually been exercised.

The code is wrong, and it is worth fixing.

Andrew I do you think you could queue this up?  I don't have a handy tree.

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
> ---
>  kernel/kexec.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 2348bd6..855bfbb 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -242,8 +242,6 @@ static int kimage_normal_alloc(struct kimage **rimage, unsigned long entry,
>  	if (result)
>  		goto out;
>  
> -	*rimage = image;
> -
>  	/*
>  	 * Find a location for the control code buffer, and add it
>  	 * the vector of segments so that it's pages will also be

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
