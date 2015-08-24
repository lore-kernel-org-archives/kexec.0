Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZTiPj-0006wn-Qi
 for kexec@lists.infradead.org; Mon, 24 Aug 2015 03:27:17 +0000
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t7O3Qt39000945
 for <kexec@lists.infradead.org>; Sun, 23 Aug 2015 23:26:55 -0400
Date: Sun, 23 Aug 2015 23:26:54 -0400 (EDT)
From: Chao Fan <cfan@redhat.com>
Message-ID: <1092641039.13744341.1440386814925.JavaMail.zimbra@redhat.com>
In-Reply-To: <1440386153-21638-2-git-send-email-cfan@redhat.com>
References: <1440386153-21638-1-git-send-email-cfan@redhat.com>
 <1440386153-21638-2-git-send-email-cfan@redhat.com>
Subject: Re: [PATCH]makedumpfile.c: check rhe return value ofset_page_size
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
To: kexec@lists.infradead.org

Sorry, the format is not good. I will rearrange the patches and repost.

So NACK these patches.

Maybe they should be put in one patch since they are used to remove the coverity scan error report.

----- Original Message -----
> From: "Chao Fan" <cfan@redhat.com>
> To: kexec@lists.infradead.org
> Cc: "Chao Fan" <cfan@redhat.com>
> Sent: Monday, August 24, 2015 11:15:52 AM
> Subject: [PATCH]makedumpfile.c: check rhe return value ofset_page_size
> 
> check_return: Calling function "set_page_size" without checking
> return value (as is done elsewhere 5 out of 6 times).
> 
> makedumpfile.c:8793: example_checked: "set_page_size(dh.block_size)"
> has its value checked in "set_page_size(dh.block_size)". But in
> makedumpfile.c:3213, the function "set_page_size" will not check
> the return value.
> 
> Signed-off-by: Chao Fan <cfan@redhat.com>
> ---
>  makedumpfile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 32f5459..53efc04 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3213,7 +3213,8 @@ initial(void)
>  			MSG("because the cyclic mode doesn't support sadump format.\n");
>  		}
>  
> -		set_page_size(sadump_page_size());
> +		if (!set_page_size(sadump_page_size()))
> +			return FALSE;
>  
>  		if (!sadump_initialize_bitmap_memory())
>  			return FALSE;
> --
> 2.4.3
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
