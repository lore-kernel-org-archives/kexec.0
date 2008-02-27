Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JUDD5-0001vd-NN
	for kexec@lists.infradead.org; Wed, 27 Feb 2008 03:44:00 +0000
Date: Wed, 27 Feb 2008 12:43:51 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools-testing v20080227
Message-ID: <20080227034349.GA16180@verge.net.au>
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
Cc: Bernhard Walle <bwalle@suse.de>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Neil Horman <nhorman@tuxdriver.com>, Jeremy Kerr <jk@ozlabs.org>

Hi,

apologies for a few false starts with getting this release out.
It is now there, and I think it looks pretty good.

There were no changes other than the version number since
yesterday's 20080226-rc release.

The release can be downloaded from kernel.org

http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools-testing-20080227.tar.gz
http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/

I have also tagged it in git:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.git
http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools-testing.git


A summary of the changes since 20071030 is below.
Apologies for the typo in the commit message, it should be
"kexec-tools-testing 20080227".

commit a2a6fa1cd733c46efe04e1104cbeb91e1e0af609
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20080226

Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20080226-rc

commit 7ea8cb1942253137986258bfe467327ac6cd75d5
Author: Simon Horman <horms@verge.net.au>

    build: include configure and include/config.h.in in dist tarball

commit 9fb8a578f2b136815c3a134b602df2f8cddd52d5
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20080221-git

commit 0825a890d39599f9f2ca11495317923aec540306
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20080221-rc

commit e959e493753c740eb7554bc2191c58b079761e11
Author: Simon Horman <horms@verge.net.au>

    Only include needed files in distribution tarball

commit d098d61ba4e32f3e5786cb8037e949c2ea5a5b64
Author: Simon Horman <horms@verge.net.au>

    Clean up whitespace in include/x86/x86-linux.h

commit b5c2ed5e02cfe862eded56be7f6c1106e84e6e6c
Author: Neil Horman <nhorman@tuxdriver.com>

    Kexec command line length

commit 162cecf91f6ac99d5af35ac6488415cdfa98ac58
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20080219-git

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

commit adf85cbc1756e56c1f52f56235a3c08b3c5b8e05
Author: Jeremy Kerr <jk@ozlabs.org>

    Build system simplification/standardisation

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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
