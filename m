Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMfNW-0007ur-CQ
 for kexec@lists.infradead.org; Thu, 19 Sep 2013 14:38:47 +0000
Date: Thu, 19 Sep 2013 22:38:15 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RESEND PATCH] vmcore-dmesg: Understand >= v3.11-rc4 dmesg
Message-ID: <20130919143815.GA4487@dhcp-16-126.nay.redhat.com>
References: <1379506903-24407-1-git-send-email-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379506903-24407-1-git-send-email-lkundrak@v3.sk>
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
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Joe Perches <joe@perches.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On 09/18/13 at 02:21pm, Lubomir Rintel wrote:
> Symbol name changed with the following commit:
> 62e32ac printk: rename struct log to struct printk_log
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
> 
> I believe this can now be applied, as the change went into 3.11 kernel release.
> Thank you!

It works for me, thanks.

But there's still a minor issue, can you also update other
comments besides of SIZEOF(log)? I think it's better to mention that
log has been renamed printk_log since 3.11 kernel.

> 
>  vmcore-dmesg/vmcore-dmesg.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
> index 0f477c0..bfc19e9 100644
> --- a/vmcore-dmesg/vmcore-dmesg.c
> +++ b/vmcore-dmesg/vmcore-dmesg.c
> @@ -324,19 +324,27 @@ static void scan_vmcoreinfo(char *start, size_t size)
>  			*symbol[i].vaddr = vaddr;
>  		}
>  
> -		/* Check for "SIZE(log)=" */
> +		/* Check for "SIZE(printk_log)" or older "SIZE(log)=" */
>  		if (memcmp("SIZE(log)=", pos, 10) == 0)
>  			log_sz = strtoull(pos + 10, NULL, 10);
> +		if (memcmp("SIZE(printk_log)=", pos, 17) == 0)
> +			log_sz = strtoull(pos + 17, NULL, 10);
>  
>  		/* Check for struct log field offsets */
>  		if (memcmp("OFFSET(log.ts_nsec)=", pos, 20) == 0)
>  			log_offset_ts_nsec = strtoull(pos + 20, NULL, 10);
> +		if (memcmp("OFFSET(printk_log.ts_nsec)=", pos, 27) == 0)
> +			log_offset_ts_nsec = strtoull(pos + 27, NULL, 10);
>  
>  		if (memcmp("OFFSET(log.len)=", pos, 16) == 0)
>  			log_offset_len = strtoul(pos + 16, NULL, 10);
> +		if (memcmp("OFFSET(printk_log.len)=", pos, 23) == 0)
> +			log_offset_len = strtoul(pos + 23, NULL, 10);
>  
>  		if (memcmp("OFFSET(log.text_len)=", pos, 21) == 0)
>  			log_offset_text_len = strtoul(pos + 21, NULL, 10);
> +		if (memcmp("OFFSET(printk_log.text_len)=", pos, 28) == 0)
> +			log_offset_text_len = strtoul(pos + 28, NULL, 10);
>  
>  		if (last_line)
>  			break;
> -- 
> 1.7.1
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
