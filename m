Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WNbin-0006SV-LI
 for kexec@lists.infradead.org; Wed, 12 Mar 2014 05:28:54 +0000
Date: Wed, 12 Mar 2014 14:28:27 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3] vmcore-dmesg stack smashing happend in extreme case
Message-ID: <20140312052827.GB16939@verge.net.au>
References: <1394600718-20718-1-git-send-email-zzou@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394600718-20718-1-git-send-email-zzou@redhat.com>
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
To: Arthur Zou <zzou@redhat.com>
Cc: kexec@lists.infradead.org

On Wed, Mar 12, 2014 at 01:05:18PM +0800, Arthur Zou wrote:
> Description
> in dump_dmesg_structured() the out_buf size is 4096, and if the
> length is less than 4080( 4096-16 ) it won't really write out.
> Normally, after writing one or four chars to the out_buf, it will
> check the length of out_buf. But in extreme cases, 19 chars was
> written to the out_buf before checking the length. This may cause
> the stack corruption. If the length was 4079 (won't realy write out),
> and then write 19 chars to it. the out_buf will overflow.
> 
> Solution
> Change 16 to 64 thus can make sure that always have 64bytes before
> moving to next records. why using 64 is that a long long int can take
> 20 bytes. so the length of timestamp can be 44 ('[','.',']',' ') in
> extreme case.
> 
> Signed-off-by: Arthur Zou <zzou@redhat.com>
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks, applied.

> ---
>  vmcore-dmesg/vmcore-dmesg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
> index 0345660..e15cd91 100644
> --- a/vmcore-dmesg/vmcore-dmesg.c
> +++ b/vmcore-dmesg/vmcore-dmesg.c
> @@ -674,7 +674,7 @@ static void dump_dmesg_structured(int fd)
>  			else
>  				out_buf[len++] = c;
>  
> -			if (len >= OUT_BUF_SIZE - 16) {
> +			if (len >= OUT_BUF_SIZE - 64) {
>  				write_to_stdout(out_buf, len);
>  				len = 0;
>  			}
> -- 
> 1.8.4.2
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
