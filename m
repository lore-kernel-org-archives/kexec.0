Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W19BC-000328-Hc
 for kexec@lists.infradead.org; Thu, 09 Jan 2014 06:33:24 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2] makedumpfile: -v shows if lzo or snappy support
 enabled or not
Date: Thu, 9 Jan 2014 06:30:30 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971D9F5A@BPXM01GP.gisp.nec.co.jp>
References: <20140109043630.GA25090@dhcp-17-89.nay.redhat.com>
In-Reply-To: <20140109043630.GA25090@dhcp-17-89.nay.redhat.com>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Chao <chaowang@redhat.com>
Cc: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 2014/01/09 13:37:17, kexec <kexec-bounces@lists.infradead.org> wrote:
> It would be great to have makedumpfile -v to show if lzo or snappy
> support is enabled or not, since --help prints too much and we have to
> scroll back three screens to check it out.
> 
> For exmaple, If lzo and snappy support are enabled,
> 
> 	$ ./makedumpfile -v
> 	makedumpfile: version 1.5.5 (released on 18 Dec 2013)
> 	lzo	enabled
> 	snappy	enabled
> 
> If both of them are disabled,
> 
> 	$ ./makedumpfile -v
> 	makedumpfile: version 1.5.5 (released on 18 Dec 2013)
> 	lzo	disabled
> 	snappy	disabled
> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>

Thanks, I'll merge this into v1.5.6.

Atsushi Kumagai

> ---
>  print_info.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/print_info.c b/print_info.c
> index 90b6cee..ddaa642 100644
> --- a/print_info.c
> +++ b/print_info.c
> @@ -26,6 +26,16 @@ void
>  show_version(void)
>  {
>  	MSG("makedumpfile: version " VERSION " (released on " RELEASE_DATE ")\n");
> +#ifdef USELZO
> +	MSG("lzo\tenabled\n");
> +#else
> +	MSG("lzo\tdisabled\n");
> +#endif
> +#ifdef USESNAPPY
> +	MSG("snappy\tenabled\n");
> +#else
> +	MSG("snappy\tdisabled\n");
> +#endif
>  	MSG("\n");
>  }
>  
> -- 
> 1.8.4.2
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
