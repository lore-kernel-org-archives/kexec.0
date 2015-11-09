Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZvcAO-0006X7-0z
 for kexec@lists.infradead.org; Mon, 09 Nov 2015 02:26:44 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 996AF42E5A6
 for <kexec@lists.infradead.org>; Mon,  9 Nov 2015 02:26:22 +0000 (UTC)
Date: Mon, 9 Nov 2015 10:26:12 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3] vmcore-dmesg: Collect full dmesg regardless of
 logged_chars
Message-ID: <20151109022612.GA20386@dhcp-128-32.nay.redhat.com>
References: <1446023724-12445-1-git-send-email-dliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1446023724-12445-1-git-send-email-dliu@redhat.com>
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
To: Dangyi Liu <dliu@redhat.com>
Cc: kexec@lists.infradead.org

On 10/28/15 at 05:15pm, Dangyi Liu wrote:
> logged_chars would be set to 0 by `dmesg -c`, but full dmesg is useful
> for debugging. So instead of using logged_chars directly, we calculate
> it by ourselves.
> 
> Now logged_chars is set to the minimum of log_end and log_buf_len, as
> the same logic as crash utility is using.
> 
> Signed-off-by: Dangyi Liu <dliu@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> ---
> Changes:
>   v1->v2: Update comment and commit message.
>   v2->v3: Adjust maximum line length
> 
>  vmcore-dmesg/vmcore-dmesg.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
> index f47ee11..0364636 100644
> --- a/vmcore-dmesg/vmcore-dmesg.c
> +++ b/vmcore-dmesg/vmcore-dmesg.c
> @@ -540,6 +540,12 @@ static void dump_dmesg_legacy(int fd)
>  		exit(53);
>  	}
>  
> +	/*
> +	 * To collect full dmesg including the part before `dmesg -c` is useful
> +	 * for later debugging. Use same logic as what crash utility is using.
> +	 */
> +	logged_chars = log_end < log_buf_len ? log_end : log_buf_len;
> +
>  	write_to_stdout(buf + (log_buf_len -  logged_chars), logged_chars);
>  }
>  
> -- 
> 2.4.3
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
