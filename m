Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZWwWx-0008BN-2H
 for kexec@lists.infradead.org; Wed, 02 Sep 2015 01:08:03 +0000
Date: Wed, 2 Sep 2015 10:07:21 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH] kexec: use mmap instead of read for slurp_file()
Message-ID: <20150902010721.GE30886@verge.net.au>
References: <1439914643-26484-1-git-send-email-holzheu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1439914643-26484-1-git-send-email-holzheu@linux.vnet.ibm.com>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: stefan.roscher@de.ibm.com, kexec@lists.infradead.org

Hi Michael,

sorry for the delay in responding to your patch.

On Tue, Aug 18, 2015 at 06:17:23PM +0200, Michael Holzheu wrote:
> The slurp_fd() function allocates memory and uses the read() system call.
> This results in double memory consumption for image and initrd:
> 
>  1) Memory allocated in user space by the kexec tool
>  2) Memory allocated in kernel by the kexec() system call
> 
> Therefore use mmap() for non-character devices to reduce the memory
> consumption of the kexec tool.

I'm not opposed to this change but I also don't see a strong motivation for
it.  I would imagine that the memory saving is not that large. And that the
memory consumption disappears when the presumably short-lived kexec process
exits.

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
> -- 
> 2.3.0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
