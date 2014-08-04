Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XEJ96-0002cp-Eh
 for kexec@lists.infradead.org; Mon, 04 Aug 2014 14:21:53 +0000
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <brking@linux.vnet.ibm.com>;
 Mon, 4 Aug 2014 10:21:30 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 78271C9002E
 for <kexec@lists.infradead.org>; Mon,  4 Aug 2014 10:21:19 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s74ELQsW65601730
 for <kexec@lists.infradead.org>; Mon, 4 Aug 2014 14:21:26 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s74ELQAA014896
 for <kexec@lists.infradead.org>; Mon, 4 Aug 2014 10:21:26 -0400
Message-ID: <53DF96E5.7000601@linux.vnet.ibm.com>
Date: Mon, 04 Aug 2014 09:21:25 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] kexec: Export kexec_in_progress
References: <53D6B270.5020403@linux.vnet.ibm.com>
In-Reply-To: <53D6B270.5020403@linux.vnet.ibm.com>
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
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org, Wendy Xiong <wenxiong@linux.vnet.ibm.com>, linux-scsi <linux-scsi@vger.kernel.org>, "James E.J. Bottomley" <JBottomley@parallels.com>

On 07/28/2014 03:28 PM, Brian King wrote:
> 
> Export kexec_in_progress for use by device drivers and other modules
> to optimize kexec boot.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
> 
>  kernel/kexec.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -puN kernel/kexec.c~kexec_export_in_prog kernel/kexec.c
> --- linux/kernel/kexec.c~kexec_export_in_prog	2014-07-23 17:05:24.851887935 -0500
> +++ linux-bjking1/kernel/kexec.c	2014-07-23 17:05:24.856887970 -0500
> @@ -1716,3 +1716,5 @@ int kernel_kexec(void)
>  	mutex_unlock(&kexec_mutex);
>  	return error;
>  }
> +
> +EXPORT_SYMBOL_GPL(kexec_in_progress);

Eric,

Can I get an ack on this so we can take this entire series through the SCSI tree?

Thanks!

Brian


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
