Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zvbk9-0008CJ-Td
 for kexec@lists.infradead.org; Mon, 09 Nov 2015 01:59:38 +0000
Date: Mon, 9 Nov 2015 10:59:15 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3] kexec/s390x: use mmap instead of read for slurp_file()
Message-ID: <20151109015915.GA7407@verge.net.au>
References: <20151026073139.GB2916@dhcp-128-73.nay.redhat.com>
 <20151027133520.30653ba3@holzheu>
 <20151028064623.GB30645@dhcp-128-73.nay.redhat.com>
 <20151028105721.4ada142d@holzheu>
 <20151029063710.GE21927@dhcp-129-115.nay.redhat.com>
 <20151029162612.14e68bdc@holzheu>
 <20151030020322.GA18800@dhcp-128-73.nay.redhat.com>
 <20151030111353.7fdf3762@holzheu>
 <20151030133904.GA18134@localhost.localdomain>
 <20151030160204.6cf76607@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151030160204.6cf76607@holzheu>
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
Cc: stefan.roscher@de.ibm.com, kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>

On Fri, Oct 30, 2015 at 04:02:04PM +0100, Michael Holzheu wrote:
> The slurp_fd() function allocates memory and uses the read() system call.
> This results in double memory consumption for image and initrd:
> 
>  1) Memory allocated in user space by the kexec tool
>  2) Memory allocated in kernel by the kexec() system call
> 
> The following illustrates the use case that we have on s390x:
> 
>  1) Boot a 4 GB Linux system
>  2) Copy kernel and 1,5 GB ramdisk from external source into tmpfs (ram)
>  3) Use kexec to boot kernel with ramdisk
> 
>  Therefore for kexec runtime we need:
> 
>  1,5 GB (tmpfs) + 1,5 GB (kexec malloc) + 1,5 GB (kernel memory) = 4,5 GB
> 
> This patch introduces slurp_file_mmap() which for "normal" files uses
> mmap() instead of malloc()/read(). This reduces the runtime memory
> consumption of the kexec tool as follows:
> 
>  1,5 GB (tmpfs) + 1,5 GB (kernel memory) = 3 GB
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
