Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1444867552.3929.7.camel@infradead.org>
Subject: Re: [PATCH] kexec: use mmap instead of read for slurp_file()
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 14 Oct 2015 17:05:52 -0700
In-Reply-To: <20150904141159.182c2f08@holzheu>
References: <1439914643-26484-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20150902010721.GE30886@verge.net.au> <20150902104839.17674456@holzheu>
 <20150904094541.GA30724@verge.net.au> <20150904141159.182c2f08@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>, Simon Horman <horms@verge.net.au>
Cc: stefan.roscher@de.ibm.com, kexec@lists.infradead.org

Hi,

On Fri, 2015-09-04 at 14:11 +0200, Michael Holzheu wrote:
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
> ---
>  kexec/kexec.c | 8 +++++---
> 

>  		if (err < 0)
>  > 	> 	> 	> die("Can not seek to the begin of file %s: %s\n",
>  > 	> 	> 	> 	> 	> filename, strerror(errno));
> +> 	> 	> buf = slurp_fd(fd, filename, size, &nread);
>  > 	> } else {
> -> 	> 	> size = stats.st_size;
> +> 	> 	> size = nread = stats.st_size;
> +> 	> 	> buf = mmap(NULL, size,

With this change the caller can't tell if buf was malloc'ed or mmaped.  The
only safe thing it can do is to not call free() on the returned buf, this will
lead to memory leakage for malloc'ed buffers.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
