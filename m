Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1agpKF-0002TX-Qv
 for kexec@lists.infradead.org; Fri, 18 Mar 2016 08:00:04 +0000
Date: Fri, 18 Mar 2016 16:59:39 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [ANNOUNCE] kexec-tools 2.0.12-rc1
Message-ID: <20160318075939.GA19880@verge.net.au>
References: <20160314003731.GA8772@verge.net.au> <56EBABD8.9040003@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56EBABD8.9040003@redhat.com>
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
To: Freeman Zhang <zhezhang@redhat.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>

On Fri, Mar 18, 2016 at 03:18:48PM +0800, Freeman Zhang wrote:
> On 03/14/2016 08:37 AM, Simon Horman wrote:
> >Hi all,
> >
> >I am happy to announce the release of kexec-tools 2.0.12-rc1.
> >
> >This is an incremental feature pre-release.
> >
> >So long as no serious problems arise I intend to release kexec-tools 2.0.12
> >in a weeks time. Testing of 2.0.12-rc1 would be greatly appreciated.
> >
> >I do not have any outstanding changes for 2.0.12 at this time.
> >And I would like to only accept bug fixes at this time and take take
> >features patches once 2.0.12 has been released.
> >
> >The pre-release can be downloaded from kernel.org:
> >
> >	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.12-rc1.tar.xz
> >	https://kernel.org/pub/linux/utils/kernel/kexec/
> >
> >I have also tagged it in git:
> >
> >	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> >
> >Thanks to everyone who has contributed to kexec.
> >
> >
> >For reference the changes since v2.0.11 are:
> >
> >93d3a61783ec kexec-tools 2.0.12-rc1
> >7c53754e5da8 kexec/fs2dt.c: wrong dt node fix
> >61cfab4e2ce0 vmcore-dmesg: Collect full dmesg regardless of logged_chars
> >35cb8a0761a0 ppc64: Add a flag to tell the kernel it's booting from kexec
> >eff306e8914c Revert "crashdump/x86: Add option to get crash kernel region size"
> >8a1aa35a1077 crashdump/x86: Add option to get crash kernel region size
> >6ba9e97c5b5f x86: Make sure E820_PM[AE]M are defined if needed
> >56a12abc1df1 kexec: fix mmap return code handling
> >0e1030b345b9 Improve device tree directory sorting
> >4bad06c3cd2a arm: use /sys/firmware/fdt in case without --atags and --dtb
> >4580c372000b kexec/fs2dt: check for /chosen/stdout-path first
> >68262155d8c6 kexec/fs2dt: cleanup pathname
> >65a15228b570 kexec/fs2dt: s/diabled/disabled/
> >e0e7a11783c1 kexex: arm: create ATAGS_MEM tag from devicetree memory node
> >084ed28061e1 uImage: fix pointer-sign warning
> >bc1d49d51dd1 kexec: determine size of block device
> >95741713e790 kexec/s390x: use mmap instead of read for slurp_file()
> >8d8c6bcee593 kexec-tools 2.0.12.git
> >
> >
> 
> Hi Simon!
> 
> I am confused about this: I got 'kexec/arch/ppc64/include/arch/ftb.h'  in
> the directory cloned with git, while 'ftb.h' is absent in the corresponding
> directory decompressed from the tar.gz you provided above.
> 
> All the best!

Hi Freeman,

thanks for reporting this problem. I have applied the following patch with
the intention of including it in v2.0.12. I believe it should resolve
the problem you see by including ftb.h in the tarball.


From 6508f8dbe82b7b0564df5b3f9f7be621ea1f37d8 Mon Sep 17 00:00:00 2001
From: Simon Horman <horms@verge.net.au>
Date: Fri, 18 Mar 2016 16:56:55 +0900
Subject: [PATCH] ppc64: include ftb.h in distribution

Reported-by: Freeman Zhang <zhezhang@redhat.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/ppc64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/arch/ppc64/Makefile b/kexec/arch/ppc64/Makefile
index 37cd233b63bc..9caf501d233b 100644
--- a/kexec/arch/ppc64/Makefile
+++ b/kexec/arch/ppc64/Makefile
@@ -21,5 +21,6 @@ ppc64_CPPFLAGS = -I$(srcdir)/kexec/libfdt
 
 dist += kexec/arch/ppc64/Makefile $(ppc64_KEXEC_SRCS)			\
 	kexec/arch/ppc64/kexec-ppc64.h kexec/arch/ppc64/crashdump-ppc64.h \
+	kexec/arch/ppc64/include/arch/fdt.h \
 	kexec/arch/ppc64/include/arch/options.h
 
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
