Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Weey3-0001V6-D7
 for kexec@lists.infradead.org; Mon, 28 Apr 2014 06:23:07 +0000
Date: Mon, 28 Apr 2014 14:21:46 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: fix free partial_bitmap2 error
Message-ID: <20140428062146.GB1625@dhcp-16-105.nay.redhat.com>
References: <1398390182-8480-1-git-send-email-zzou@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398390182-8480-1-git-send-email-zzou@redhat.com>
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
To: Arthur Zou <zzou@redhat.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

On 04/25/14 at 09:43am, Arthur Zou wrote:
> Description:
> In create_dump_bitmap, after prepare_bitmap2_buffer_cyclic was invoked,
> info->partial_bitmap2 will pointed to a block of contiguous memory. But
> free it in a wrong way because what free_bitmap2_buffer() free is
> info->bitmap2 not info->partial_bitmap2.
> 
> Signed-off-by: Arthur Zou <zzou@redhat.com>
> ---
>  makedumpfile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index ce4a866..f0d2997 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5143,7 +5143,8 @@ create_dump_bitmap(void)
>  
>  			info->num_dumpable = get_num_dumpable_cyclic();
>  
> -			free_bitmap2_buffer();
> +			if (info->partial_bitmap2 != NULL)
> +				free(info->partial_bitmap2);

ACK

Hi Atsushi,

Maybe in my case which the lzo dump random failure triggered by this
one.  Because for elf dump, since the wrong calculation of
cyclic_bufsize is corrected, OOM never happened. For this bug, it didn't
happen either after the fix applied in this patch.

So I guess the 80% of free memory is a safe value, though it's very
close to the OOM threshold.

Thanks
Baoquan


>  		}
>  
>  	} else {
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
