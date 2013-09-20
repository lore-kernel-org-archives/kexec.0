Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMpsL-0005et-6k
 for kexec@lists.infradead.org; Fri, 20 Sep 2013 01:51:18 +0000
Date: Fri, 20 Sep 2013 09:50:47 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] vmcore-dmesg: Understand >= v3.11-rc4 dmesg
Message-ID: <20130920015047.GA4989@dhcp-16-126.nay.redhat.com>
References: <20130919143815.GA4487@dhcp-16-126.nay.redhat.com>
 <1379602186-13617-1-git-send-email-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379602186-13617-1-git-send-email-lkundrak@v3.sk>
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

On 09/19/13 at 04:49pm, Lubomir Rintel wrote:
> Symbol name changed with the following commit:
> 62e32ac printk: rename struct log to struct printk_log
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dave Young <dyoung@redhat.com>
> ---

Acked-by: Dave Young <dyoung@redhat.com>


> 
> Changes for v2:
>   * Clarified printk_log vs. log in some comments.
> 
>  vmcore-dmesg/vmcore-dmesg.c |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
> index 0f477c0..dd222cd 100644
> --- a/vmcore-dmesg/vmcore-dmesg.c
> +++ b/vmcore-dmesg/vmcore-dmesg.c
> @@ -34,10 +34,10 @@ static loff_t logged_chars_vaddr;
>  static loff_t log_first_idx_vaddr;
>  static loff_t log_next_idx_vaddr;
>  
> -/* struct log size */
> +/* struct printk_log (or older log) size */
>  static uint64_t log_sz;
>  
> -/* struct log field offsets */
> +/* struct printk_log (or older log) field offsets */
>  static uint64_t log_offset_ts_nsec = UINT64_MAX;
>  static uint16_t log_offset_len = UINT16_MAX;
>  static uint16_t log_offset_text_len = UINT16_MAX;
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
> -		/* Check for struct log field offsets */
> +		/* Check for struct printk_log (or older log) field offsets */
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
