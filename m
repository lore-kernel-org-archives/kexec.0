Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZoLiC-0007x2-QL
 for kexec@lists.infradead.org; Tue, 20 Oct 2015 01:27:37 +0000
Date: Tue, 20 Oct 2015 10:27:14 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: determine size of block device
Message-ID: <20151020012714.GE11217@verge.net.au>
References: <1444397238-14330-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
 <20151016013026.GA20667@verge.net.au>
 <CALtMJEDut5=vr6pDtEyuAK0yW09CX60KSfN8Ug7ZiPk5sEx0Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALtMJEDut5=vr6pDtEyuAK0yW09CX60KSfN8Ug7ZiPk5sEx0Sg@mail.gmail.com>
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
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>, kexec@lists.infradead.org

On Mon, Oct 19, 2015 at 11:32:58AM +0200, Andreas Fenkart wrote:
> Hi Simon,
> 
> 2015-10-16 3:30 GMT+02:00 Simon Horman <horms@verge.net.au>:
> > On Fri, Oct 09, 2015 at 03:27:18PM +0200, Andreas Fenkart wrote:
> >> starting 'kexec -l /dev/mmcblk0p1' fails since the size of
> >> a block device can not be determined with stat
> >
> > Could you provide some motivation for kexec reading a kernel image
> > from a block device as per the example above?
> 
> We plan to use it for our embedded system
> 
> We have an interim initramfs, that selects the kernel we want to boot
> our real system. Something like a n+1 stage boot loader,
> where n is the last stage of u-boot. The motivation is to do a safe
> kernel upgrade on the production rootfs through package management.
> The new kernel is dropped into a folder where the interim system will
> selects the kernel with the highest priority. No reconfiguration of
> u-boot/rescue system needed. In case no kernel has yet been installed,
> we fall back to the factory default, which is installed in a raw flash
> partition on eMMC without filesystem.
> 
> https://git.digitalstrom.org/bsp/dss-rescue-tools/blob/master/src/kernel-fallback-dss11-1gb-t1.config

Nice :)

> >> Signed-off-by: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>
> >> ---
> >>  kexec/kexec.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/kexec/kexec.c b/kexec/kexec.c
> >> index ff024f3..8b8846e 100644
> >> --- a/kexec/kexec.c
> >> +++ b/kexec/kexec.c
> >> @@ -26,7 +26,9 @@
> >>  #include <stdlib.h>
> >>  #include <errno.h>
> >>  #include <limits.h>
> >> +#include <sys/ioctl.h>
> >>  #include <sys/mman.h>
> >> +#include <sys/mount.h>
> >>  #include <sys/types.h>
> >>  #include <sys/stat.h>
> >>  #include <sys/reboot.h>
> >> @@ -554,6 +556,14 @@ char *slurp_file(const char *filename, off_t *r_size)
> >>                       die("Can not seek to the begin of file %s: %s\n",
> >>                                       filename, strerror(errno));
> >>               buf = slurp_fd(fd, filename, size, &nread);
> >> +    } else if (S_ISBLK(stats.st_mode)) {
> >> +             /* taken from blockdev */
> >
> > Is "blockdev" Linux kernel code?
> 
> It is a util-linux tool, which is GPL of course. I added the comment
> as a reference, since I couldn't find a man page for BLKGETSIZE64.
> Since it's a straight forward ioctl call, there is probably no
> copyright violation at all, and I could well remove it.

Understood. Could you repost with the blockdev comment removed?

> >> +             unsigned long long llu = -1;
> >> +             err = ioctl(fd, BLKGETSIZE64, &llu);
> >> +             if (err < 0)
> >> +                     die("Can't retrieve size of block device %s: %s\n",
> >> +                             filename, strerror(errno));
> >> +             size = llu;
> >>       } else {
> >>               size = nread = stats.st_size;
> >>               buf = mmap(NULL, size,
> >> --
> >> 2.5.1
> >>
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
> >>
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
