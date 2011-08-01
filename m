Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1Qnz9Q-0001fj-T2
	for kexec@lists.infradead.org; Mon, 01 Aug 2011 20:31:49 +0000
Date: Mon, 1 Aug 2011 16:31:43 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch v2 02/10] kdump: Make kimage_load_crash_segment() weak
Message-ID: <20110801203143.GH3805@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	<20110727125807.695225427@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110727125807.695225427@linux.vnet.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

On Wed, Jul 27, 2011 at 02:55:06PM +0200, Michael Holzheu wrote:
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> On s390 we do not create page tables at all for the crashkernel memory.
> This requires a s390 specific version for kimage_load_crash_segment().
> Therefore this patch declares this function as "__weak". The s390 version is
> very simple. It just copies the kexec segment to real memory without using
> page tables:
> 
> int kimage_load_crash_segment(struct kimage *image,
>                               struct kexec_segment *segment)
> {
>         return copy_from_user_real((void *) segment->mem, segment->buf,
>                                    segment->bufsz);
> }
> 
> There are two main advantages of not creating page tables for the
> crashkernel memory:
> 
> a) It saves memory. We have scenarios in mind, where crashkernel
>    memory can be very large and saving page table space is important.
> b) We protect the crashkernel memory from being overwritten.
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> ---
>  kernel/kexec.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -842,8 +842,8 @@ out:
>  	return result;
>  }
>  
> -static int kimage_load_crash_segment(struct kimage *image,
> -					struct kexec_segment *segment)
> +int __weak kimage_load_crash_segment(struct kimage *image,
> +				     struct kexec_segment *segment)

A comment here why we are making it weak should help in increasing
the code readability.

Thanks
Vivek

>  {
>  	/* For crash dumps kernels we simply copy the data from
>  	 * user space to it's destination.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
