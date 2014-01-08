Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0mAd-0003pB-B3
 for kexec@lists.infradead.org; Wed, 08 Jan 2014 05:59:16 +0000
Message-ID: <52CCE8B9.8060008@cn.fujitsu.com>
Date: Wed, 08 Jan 2014 13:57:13 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: -v shows if lzo or snappy support enabled
 or not
References: <20140108054033.GA6109@dhcp-17-89.nay.redhat.com>
In-Reply-To: <20140108054033.GA6109@dhcp-17-89.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Chao <chaowang@redhat.com>, kexec@lists.infradead.org

Hello chao

On 01/08/2014 01:40 PM, WANG Chao wrote:
> It would be great to have makedumpfile -v to show if lzo or snappy
> support is enabled or not, since --help prints too much and we have to
> scroll back three screens to check it out.
> 
> Using "+lzo" to indicate lzo is enabled and vice versa "-lzo" for lzo is
> disabled. Same for snappy.
> 
> For exmaple, If lzo and snappy support are enabled,
> 
>     $ ./makedumpfile -v
>     makedumpfile: version 1.5.5 (released on 18 Dec 2013)
>     +lzo +snappy
> 
> If both of them are disabled,
> 
>     $ ./makedumpfile -v
>     makedumpfile: version 1.5.5 (released on 18 Dec 2013)
>     -lzo -snappy

This is weird... we may even think we have lzo/snappy enabled
since an option is always specified with '-'.

My idea is to have "with lzo/snappy enabled" directly appended
when lzo/snappy enabled.

And is it ok to add such info to the version ? I don't know.
kumagai may give the answer.

Thanks.

> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>
> ---
>  print_info.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/print_info.c b/print_info.c
> index 90b6cee..242b42c 100644
> --- a/print_info.c
> +++ b/print_info.c
> @@ -26,7 +26,17 @@ void
>  show_version(void)
>  {
>  	MSG("makedumpfile: version " VERSION " (released on " RELEASE_DATE ")\n");
> -	MSG("\n");
> +#ifdef USELZO
> +	MSG("+lzo ");
> +#else
> +	MSG("-lzo ");
> +#endif
> +#ifdef USESNAPPY
> +	MSG("+snappy ");
> +#else
> +	MSG("-snappy ");
> +#endif
> +	MSG("\n\n");
>  }
>  
>  void
> 


-- 
Thanks.
Zhang Yanfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
