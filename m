Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UVMCN-0000qa-3S
 for kexec@lists.infradead.org; Thu, 25 Apr 2013 13:26:56 +0000
Date: Thu, 25 Apr 2013 22:26:47 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/uImage: probe to identify a corrupted image
Message-ID: <20130425132647.GA10898@verge.net.au>
References: <20130417102022.6919.82083.stgit@suzukikp>
 <51776BAB.5000705@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51776BAB.5000705@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: msm@freescale.com, bigeasy@linutronix.de, kexec@lists.infradead.org

On Wed, Apr 24, 2013 at 10:50:43AM +0530, Suzuki K. Poulose wrote:
> On 04/17/2013 03:52 PM, Suzuki K. Poulose wrote:
> >From: Suzuki K. Poulose <suzuki@in.ibm.com>
> >
> >Teach uImage_probe_xxx() to return the information about
> >a corrupted image. This is required to prevent the loading
> >of a corrupted ramdisk, where we don't have strict checking
> >for the other formats, unlike the kernel. So, we should abort
> >the operation than causing a problem with the new kernel.
> >
> >Without this patch, a corrupted uImage ramdisk is treated as
> >a plain ramdisk where there is no format check involved.
> >
> ># kexec -l uImage --initrd romfs-initrd.corrupt
> >The data CRC does not match. Computed: 867e73f7 expected 8f097cc0
> ># echo $?
> >0
> ># kexec -e
> >Starting new kernel
> >Bye!
> >Reserving 55MB of memory at 70MB for crashkernel (System RAM: 256MB)
> >Using Xilinx Virtex440 machine description
> >Linux version 3.6.0-rc3 (root@suzukikp) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (GCC) ) #66 Tue Apr 16 06:36:56 UTC 2013
> >Found initrd at 0xcf5f8000:0xcfff8040
> >...
> >
> >NET: Registered protocol family 17
> >RAMDISK: Couldn't find valid RAM disk image starting at 0.
> >List of all partitions:
> >No filesystem could mount root, tried:  ext2 cramfs
> >Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
> >
> >
> >With this patch :
> >
> ># kexec -l uImage --initrd romfs-initrd.corrupt
> >uImage: The data CRC does not match. Computed: 867e73f7 expected 8f097cc0
> >uImage: Corrupted ramdisk file romfs-initrd
> >
> >With a corrupted kernel image(the behaviour remains the same) :
> ># kexec -l uImage.corrupt --initrd romfs-initrd
> >uImage: The data CRC does not match. Computed: 285787b7 expected e37f65ad
> >Cannot determine the file type of uImage.corrupt
> >
> >Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> 
> Simon,
> 
> Looks like there are no concerns about the approach in this patch.
> Could you please pull this in ?

Done.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
