Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3i2m-0007P5-7H
 for kexec@lists.infradead.org; Thu, 16 Jan 2014 08:11:21 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: --dump-dmesg characters printing fix
Date: Thu, 16 Jan 2014 08:08:06 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971DBED3@BPXM01GP.gisp.nec.co.jp>
References: <20140114085806.GA8523@dhcp-17-89.nay.redhat.com>
In-Reply-To: <20140114085806.GA8523@dhcp-17-89.nay.redhat.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 2014/01/14 17:58:35, WANG Chao <chaowang@redhat.com> wrote:
> To keep the output of makedumpfile --dump-dmesg being consistent with
> dmesg utility, this patch introduces two changes:
> 
> 1. If a character is non-printable, print its hex value ("\\x%02x")
> 2. No special handling for "\n" ("\n" -> ".")
> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>

Thanks, I was just about to fix it !
I'll merge this patch into v1.5.6.


Atsushi Kumagai

> ---
>  makedumpfile.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index ef08d91..73467ab 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3848,12 +3848,10 @@ dump_log_entry(char *logptr, int fp)
>  	sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
>  
>  	for (i = 0, p = msg; i < text_len; i++, p++) {
> -		if (*p == '\n')
> -			sprintf(buf, "%s.", buf);
> -		else if (isprint(*p) || isspace(*p))
> +		if (isprint(*p) || isspace(*p))
>  			sprintf(buf, "%s%c", buf, *p);
>  		else
> -			sprintf(buf, "%s.", buf);
> +			sprintf(buf, "%s\\x%02x", buf, *p);
>  	}
>  
>  	sprintf(buf, "%s\n", buf);
> -- 
> 1.8.4.2
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
