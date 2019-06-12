Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hbBnH-0006nO-QX
 for kexec@lists.infradead.org; Wed, 12 Jun 2019 22:32:37 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5CMWRY2101922
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2019 18:32:30 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t37e6wwk5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2019 18:32:29 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Wed, 12 Jun 2019 23:31:51 +0100
Subject: Re: [PATCH V8 3/3] Call ima_kexec_cmdline to measure the cmdline args
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 12 Jun 2019 18:31:43 -0400
In-Reply-To: <20190612221549.28399-4-prsriva02@gmail.com>
References: <20190612221549.28399-1-prsriva02@gmail.com>
 <20190612221549.28399-4-prsriva02@gmail.com>
Mime-Version: 1.0
Message-Id: <1560378703.4578.91.camel@linux.ibm.com>
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
To: Prakhar Srivastava <prsriva02@gmail.com>, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dave Young <dyoung@redhat.com>, roberto.sassu@huawei.com, "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com, kexec <kexec@lists.infradead.org>

[Cc: kexec mailing list]

Hi Eric, Dave,

On Wed, 2019-06-12 at 15:15 -0700, Prakhar Srivastava wrote:
> During soft reboot(kexec_file_load) boot cmdline args
> are not measured.Thus the new kernel on load boots with
> an assumption of cold reboot.
> 
> This patch makes a call to the ima hook ima_kexec_cmdline,
> added in "Define a new IMA hook to measure the boot command
> line arguments"
> to measure the boot cmdline args into the ima log.
> 
> - call ima_kexec_cmdline from kexec_file_load.
> - move the call ima_add_kexec_buffer after the cmdline
> args have been measured.
> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>

Any chance we could get some Acks?

thanks,

Mimi

> ---
>  kernel/kexec_file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 072b6ee55e3f..b0c724e5d86c 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -198,9 +198,6 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  		return ret;
>  	image->kernel_buf_len = size;
>  
> -	/* IMA needs to pass the measurement list to the next kernel. */
> -	ima_add_kexec_buffer(image);
> -
>  	/* Call arch image probe handlers */
>  	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
>  					    image->kernel_buf_len);
> @@ -241,8 +238,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			ret = -EINVAL;
>  			goto out;
>  		}
> +
> +		ima_kexec_cmdline(image->cmdline_buf,
> +				  image->cmdline_buf_len - 1);
>  	}
>  
> +	/* IMA needs to pass the measurement list to the next kernel. */
> +	ima_add_kexec_buffer(image);
> +
>  	/* Call arch image load handlers */
>  	ldata = arch_kexec_kernel_image_load(image);
>  


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
