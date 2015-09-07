Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZYqBQ-0004wE-Q0
 for kexec@lists.infradead.org; Mon, 07 Sep 2015 06:45:41 +0000
Date: Mon, 7 Sep 2015 15:44:57 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: use mmap instead of read for slurp_file()
Message-ID: <20150907064457.GA12433@verge.net.au>
References: <1439914643-26484-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20150902010721.GE30886@verge.net.au>
 <20150902104839.17674456@holzheu>
 <20150904094541.GA30724@verge.net.au>
 <20150904141159.182c2f08@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150904141159.182c2f08@holzheu>
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
Cc: kexec@lists.infradead.org, stefan.roscher@de.ibm.com

On Fri, Sep 04, 2015 at 02:11:59PM +0200, Michael Holzheu wrote:
> The slurp_fd() function allocates memory and uses the read() system call.
> This results in double memory consumption for image and initrd:
> 
>  1) Memory allocated in user space by the kexec tool
>  2) Memory allocated in kernel by the kexec() system call
> 
> Therefore use mmap() for non-character devices to reduce the runtime
> memory consumption of the kexec tool.
> 
> The following use case illustrates the usefulness of this patch a bit more:
> 
>  1) Boot a 4 GB Linux system
>  2) Read kernel and 1,5 GB ramdisk from external source into local tmpfs (ram)
>  3) kexec the kernel and ramdisk
> 
>  Without this patch for the kexec runtime we need:
> 
>  1,5 GB (tmpfs) + 1,5 GB (kexec malloc) + 1,5 GB (kernel memory) = 4,5 GB
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
