Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZVKcr-0006NT-Ap
 for kexec@lists.infradead.org; Fri, 28 Aug 2015 14:27:30 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 28 Aug 2015 15:27:02 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 373E71B0805F
 for <kexec@lists.infradead.org>; Fri, 28 Aug 2015 15:28:29 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7SEQrAM21889214
 for <kexec@lists.infradead.org>; Fri, 28 Aug 2015 14:26:56 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7SEQhkO018688
 for <kexec@lists.infradead.org>; Fri, 28 Aug 2015 08:26:43 -0600
Date: Fri, 28 Aug 2015 16:26:33 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: PING: [RFC PATCH] kexec: use mmap instead of read for slurp_file()
Message-ID: <20150828162633.6dab0070@holzheu>
In-Reply-To: <1439914643-26484-1-git-send-email-holzheu@linux.vnet.ibm.com>
References: <1439914643-26484-1-git-send-email-holzheu@linux.vnet.ibm.com>
Mime-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, stefan.roscher@de.ibm.com

Hello Simon,

Did you have time to look at my patch?

Regards,
Michael

On Tue, 18 Aug 2015 18:17:23 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> The slurp_fd() function allocates memory and uses the read() system call.
> This results in double memory consumption for image and initrd:
> 
>  1) Memory allocated in user space by the kexec tool
>  2) Memory allocated in kernel by the kexec() system call
> 
> Therefore use mmap() for non-character devices to reduce the memory
> consumption of the kexec tool.
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> ---
>  kexec/kexec.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 8ce6885..fecf061 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -26,6 +26,7 @@
>  #include <stdlib.h>
>  #include <errno.h>
>  #include <limits.h>
> +#include <sys/mman.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/reboot.h>
> @@ -552,11 +553,12 @@ char *slurp_file(const char *filename, off_t *r_size)
>  		if (err < 0)
>  			die("Can not seek to the begin of file %s: %s\n",
>  					filename, strerror(errno));
> +		buf = slurp_fd(fd, filename, size, &nread);
>  	} else {
> -		size = stats.st_size;
> +		size = nread = stats.st_size;
> +		buf = mmap(NULL, size,
> +			   PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
>  	}
> -
> -	buf = slurp_fd(fd, filename, size, &nread);
>  	if (!buf)
>  		die("Cannot read %s", filename);
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
