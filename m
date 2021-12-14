Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxAjz-00EuNT-CB
 for kexec@lists.infradead.org; Tue, 14 Dec 2021 16:33:24 +0000
Date: Tue, 14 Dec 2021 17:32:42 +0100
From: Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH] kernel/crash_core.c: No judgment required
Message-ID: <20211214173242.192f47e8@rhtmp>
In-Reply-To: <20211210032003.16278-1-sensor1010@163.com>
References: <20211210032003.16278-1-sensor1010@163.com>
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
To: lizhe <sensor1010@163.com>
Cc: dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hi lizhe,

On Thu,  9 Dec 2021 19:20:03 -0800
lizhe <sensor1010@163.com> wrote:

> No judgment required ck_cmdline is NULL
> its caller has alreadly judged, see __parse_crashkernel
> function
> 
> Signed-off-by: lizhe <sensor1010@163.com>
> ---
>  kernel/crash_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index eb53f5ec62c9..9981cf9b9fe4 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -221,9 +221,6 @@ static __init char *get_last_crashkernel(char *cmdline,
>  		p = strstr(p+1, name);
>  	}
>  
> -	if (!ck_cmdline)
> -		return NULL;
> -
>  	return ck_cmdline;
>  }
>  

I agree that the if-block is not needed and can be removed. However, I
cannot follow your reasoning in the commit message. Could you please
explain it in more detail.

The reason why I think that the 'if' can be removed is that the
expression can only be true when ck_cmdline = NULL. But with that the
last three lines are equivalent to

	if (!ck_cmdline)
		return ck_cmdline;

	return ck_cmdline;

Which simply doesn't make any sense.

Thanks
Philipp


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
