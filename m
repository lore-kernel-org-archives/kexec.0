Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrLpV-0002ae-5z
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 08:11:34 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (Postfix) with ESMTPS id 8EBCCC0A1B1F
 for <kexec@lists.infradead.org>; Wed, 28 Oct 2015 08:11:12 +0000 (UTC)
Date: Wed, 28 Oct 2015 16:11:06 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] vmcore-dmesg: Collect full dmesg regardless of
 logged_chars
Message-ID: <20151028081106.GE30645@dhcp-128-73.nay.redhat.com>
References: <1446018641-11404-1-git-send-email-dliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1446018641-11404-1-git-send-email-dliu@redhat.com>
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

Hi, Dangyi

On 10/28/15 at 03:50pm, Dangyi Liu wrote:
> logged_chars would be set to 0 by `dmesg -c`, but full dmesg is useful
> for debugging. So instead of using logged_chars directly, we calculate
> it by ourselves.
> 
> Now logged_chars is set to the minimum of log_end and log_buf_len, as
> the same logic as crash utility is using.
> 
> Signed-off-by: Dangyi Liu <dliu@redhat.com>
> ---
> Changes:
>   v1->v2: Update comment and commit message
> 
>  vmcore-dmesg/vmcore-dmesg.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
> index f47ee11..134a4ef 100644
> --- a/vmcore-dmesg/vmcore-dmesg.c
> +++ b/vmcore-dmesg/vmcore-dmesg.c
> @@ -540,6 +540,12 @@ static void dump_dmesg_legacy(int fd)
>  		exit(53);
>  	}
>  
> +	/*
> +	 * To collect full dmesg including the part before `dmesg -c` is useful for

Sorry I did not consider about the line length when replying your V1.
Although I'm not sure if kexec-tools strictly use 80 lines coding style
but IMO I still think it is better to do it.

> +	 * later debugging. Use same logic as what crash utility is using.
> +	 */
> +	logged_chars = log_end < log_buf_len ? log_end : log_buf_len;
> +
>  	write_to_stdout(buf + (log_buf_len -  logged_chars), logged_chars);
>  }
>  
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
