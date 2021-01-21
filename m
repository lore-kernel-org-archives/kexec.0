Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2VGB-0003Er-Po
 for kexec@lists.infradead.org; Thu, 21 Jan 2021 08:24:08 +0000
Date: Thu, 21 Jan 2021 16:23:56 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] vmalloc: remove redundant NULL check
Message-ID: <20210121082356.GH20161@MiWiFi-R3L-srv>
References: <1611216753-44598-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1611216753-44598-1-git-send-email-abaci-bugfix@linux.alibaba.com>
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
To: Yang Li <abaci-bugfix@linux.alibaba.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, dyoung@redhat.com, adobriyan@gmail.com, vgoyal@redhat.com

On 01/21/21 at 04:12pm, Yang Li wrote:
> Fix below warnings reported by coccicheck:
> ./fs/proc/vmcore.c:1503:2-7: WARNING: NULL check before some freeing
> functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
> ---
>  fs/proc/vmcore.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index c3a345c..9a15334 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1503,11 +1503,8 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	return 0;
>  
>  out_err:
> -	if (buf)
> -		vfree(buf);
> -
> -	if (dump)
> -		vfree(dump);
> +	vfree(buf);
> +	vfree(dump);

Looks good, thx.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
