Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e38.co.us.ibm.com ([32.97.110.159])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UUs8Z-0008MZ-Pv
 for kexec@lists.infradead.org; Wed, 24 Apr 2013 05:21:00 +0000
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Tue, 23 Apr 2013 23:20:48 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4575B1FF0044
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 23:15:44 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O5KkQi127714
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 23:20:46 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O5KkgQ018530
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 23:20:46 -0600
Message-ID: <51776BAB.5000705@in.ibm.com>
Date: Wed, 24 Apr 2013 10:50:43 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec/uImage: probe to identify a corrupted image
References: <20130417102022.6919.82083.stgit@suzukikp>
In-Reply-To: <20130417102022.6919.82083.stgit@suzukikp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: msm@freescale.com, bigeasy@linutronix.de, kexec@lists.infradead.org

On 04/17/2013 03:52 PM, Suzuki K. Poulose wrote:
> From: Suzuki K. Poulose <suzuki@in.ibm.com>
>
> Teach uImage_probe_xxx() to return the information about
> a corrupted image. This is required to prevent the loading
> of a corrupted ramdisk, where we don't have strict checking
> for the other formats, unlike the kernel. So, we should abort
> the operation than causing a problem with the new kernel.
>
> Without this patch, a corrupted uImage ramdisk is treated as
> a plain ramdisk where there is no format check involved.
>
> # kexec -l uImage --initrd romfs-initrd.corrupt
> The data CRC does not match. Computed: 867e73f7 expected 8f097cc0
> # echo $?
> 0
> # kexec -e
> Starting new kernel
> Bye!
> Reserving 55MB of memory at 70MB for crashkernel (System RAM: 256MB)
> Using Xilinx Virtex440 machine description
> Linux version 3.6.0-rc3 (root@suzukikp) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (GCC) ) #66 Tue Apr 16 06:36:56 UTC 2013
> Found initrd at 0xcf5f8000:0xcfff8040
> ...
>
> NET: Registered protocol family 17
> RAMDISK: Couldn't find valid RAM disk image starting at 0.
> List of all partitions:
> No filesystem could mount root, tried:  ext2 cramfs
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
>
>
> With this patch :
>
> # kexec -l uImage --initrd romfs-initrd.corrupt
> uImage: The data CRC does not match. Computed: 867e73f7 expected 8f097cc0
> uImage: Corrupted ramdisk file romfs-initrd
>
> With a corrupted kernel image(the behaviour remains the same) :
> # kexec -l uImage.corrupt --initrd romfs-initrd
> uImage: The data CRC does not match. Computed: 285787b7 expected e37f65ad
> Cannot determine the file type of uImage.corrupt
>
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>

Simon,

Looks like there are no concerns about the approach in this patch. Could 
you please pull this in ?

Thanks
Suzuki


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
