Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JRNZj-0002c0-RG
	for kexec@lists.infradead.org; Tue, 19 Feb 2008 08:11:40 +0000
Date: Tue, 19 Feb 2008 17:11:31 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [ANNOUNCE] kexec-tools-testing v20071017-rc
Message-ID: <20080219081130.GA3919@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jeremy Kerr <jk@ozlabs.org>

Hi all,

Sorry for being a bit slow in attending to patches of late.
I think that I have got all of them now, if not, please just drop
me a line.

I have made an RC release which includes a moderate ammount of change
sice 20080219. If no alarm bells ring I'll make a full release shortly.

The RC release can be downloaded as a tarball:

http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-testing-20080219-rc.tar.gz
http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/

I have also tagged it in git:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.git
http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools-testing.git

A summary of the changes since v20071030 is below:

commit f797af18bf3d4b40d3b711b9f7620d37c25c96a8
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20080219-rc


commit 648fdfaa9977fc63ddb476bbd9a5cf67bc79d752
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20071019-rc


commit 9de031269fc0a2551bb4a3cb488bd8377cbece88
Author: Geoff Levand <geoffrey.levand@am.sony.com>

    kexec: Use target linker for purgatory


commit 28d4817dcd2bfc9eb9c8baf90888d9ba358bd58c
Author: Simon Horman <horms@verge.net.au>

    Remove some extraneous whitespace


commit 83a9d171329ce791d734117e6894cccc244893a2
Author: Richard Purdie <rpurdie@rpsys.net>

    Add ARM support to kexec

 create mode 100644 kexec/arch/arm/Makefile
 create mode 100644 kexec/arch/arm/include/arch/options.h
 create mode 100644 kexec/arch/arm/kexec-arm.c
 create mode 100644 kexec/arch/arm/kexec-arm.h
 create mode 100644 kexec/arch/arm/kexec-elf-rel-arm.c
 create mode 100644 kexec/arch/arm/kexec-zImage-arm.c
 create mode 100644 purgatory/arch/arm/Makefile

commit b5ee3392dc71c53f93716cb387abacb544d9cf9c
Author: Paul Mundt <lethal@linux-sh.org>

    sh: Remove hardcoded PAGE_SIZE in NetBSD loader


commit ab2df5cd479da9935e23cd7042d69a39f5cec3b0
Author: Stefan Assmann <sassmann@suse.de>

    kexec buffer overflow on ppc platform


commit ffde99f4920fe60798d527c2bcdf91d1d2385b86
Author: Simon Horman <horms@verge.net.au>

    Use zlib if present


commit 487794c3a650dac933e8aeaaf618b466cc306519
Author: Kevin Tegtmeier <kevint@lanl.gov>

    Log unknown reloc name instead of its number


commit 956e3295b400a5d1ea3535602ed25d7866412110
Author: Simon Horman <horms@verge.net.au>

    Subject: [doc] Add documentation on creating include/config.h.in to INSTALL


commit 34d679b268a9ce6d334197b69392f85f46a996b9
Author: Jeremy Kerr <jk@ozlabs.org>

    Don't assume we can re-make Makefile


commit 4b3340f33467aa1bebfa05791dc53bbaf1028381
Author: Jeremy Kerr <jk@ozlabs.org>

    make clean cleanup


commit 3f871456d4d350b5abdb2b7fdcfedec5743d6db2
Author: Jeremy Kerr <jk@ozlabs.org>

    Use general _SRCS and _OBJS, rather and _C_{SRCS, OBJS} and _S_{SRCS, OBJS}


commit d0a33ac6d578f5aa5378f02d8b7aa3a6b635cae4
Author: Simon Horman <horms@verge.net.au>

    removed partially duplicated system headers

 delete mode 100644 purgatory/arch/alpha/include/limits.h
 delete mode 100644 purgatory/arch/alpha/include/stdint.h
 delete mode 100644 purgatory/arch/i386/include/limits.h
 delete mode 100644 purgatory/arch/i386/include/stdint.h
 delete mode 100644 purgatory/arch/ia64/include/limits.h
 delete mode 100644 purgatory/arch/ia64/include/stdint.h
 delete mode 100644 purgatory/arch/ppc/include/limits.h
 delete mode 100644 purgatory/arch/ppc/include/stdint.h
 delete mode 100644 purgatory/arch/ppc64/include/limits.h
 delete mode 100644 purgatory/arch/ppc64/include/stdint.h
 delete mode 100644 purgatory/arch/s390/include/limits.h
 delete mode 100644 purgatory/arch/s390/include/stdint.h
 delete mode 100644 purgatory/arch/sh/include/limits.h
 delete mode 100644 purgatory/arch/sh/include/stdint.h
 delete mode 100644 purgatory/arch/x86_64/include/limits.h
 delete mode 100644 purgatory/arch/x86_64/include/stdint.h

commit adf85cbc1756e56c1f52f56235a3c08b3c5b8e05
Author: Jeremy Kerr <jk@ozlabs.org>

    Build system simplification/standardisation

 delete mode 100644 Makefile
 delete mode 100644 Makefile.conf.in
 create mode 100644 Makefile.in

commit ac12ceecf15f637e024e6be9a030497e732a74eb
Author: Jeremy Kerr <jk@ozlabs.org>

    Add gamecube to config.h defines


commit f5d08e9fa6464c876ab00c03fadc09a64edb5bb5
Author: Jeremy Kerr <jk@ozlabs.org>

    Use config.h for defines


commit 0151e38f0d87528c8856fcb0b4d53ed547c139b0
Author: Jeremy Kerr <jk@ozlabs.org>

    Consolidate BOOTLOADER defines


commit 1db6397fc7a335decfa7ed95a95225476a030390
Author: Jeremy Kerr <jk@ozlabs.org>

    Use --target for target architecture specification


commit 3b34f687a851f84216bc0bbd601b82c40b197a61
Author: David Woodhouse <dwmw2@infradead.org>

    Enable building a 32 bit binary for ppc64 platforms.


commit 7b429d23bca943dc5772ed80160c144930e8904c
Author: Simon Horman <horms@verge.net.au>

    Update mailing list contact to kexec@lists.infradead.org


commit b41eacb1069eeefd630d807b1587247e6d89628c
Author: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

    Fix the feature determining ELF32/ELF64 automatically


commit c87f78372ebdb4f1ef7a37fd5628e5e1dfd571d0
Author: Simon Horman <horms@verge.net.au>

    20071030-git


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
