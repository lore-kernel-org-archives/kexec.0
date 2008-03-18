Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JbTsO-00005a-1U
	for kexec@lists.infradead.org; Tue, 18 Mar 2008 04:56:42 +0000
Date: Tue, 18 Mar 2008 13:56:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools-testing v20080318-rc
Message-ID: <20080318045632.GA14139@verge.net.au>
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
Cc: Bernhard Walle <bwalle@suse.de>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "Sachin P. Sant" <sachinp@in.ibm.com>

Hi all,

it turns out that there were some x86_64 files missing from the tarball
distribution of the kexec-tools-testing 20080226 as well as some objects
missing from compiled purgatory code on the same architecture.  Thanks
to Sachin P. Sant and Bernhard Walle for fixing these problems.

Rather than make a point release that just fixes these problems,
I have decided to go ahead with a full release of what is
in the tree. If you feel strongly that a point release would be better,
please let me know.

I would like to move this rc release to a full release as soon as
possible. If have missed anything please let me know.

The release can be downloaded as a tarball:

http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-testing-20080318-rc.tar.gz
http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/

I have also tagged it in git:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.git
http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools-testing.git


A summary of the changes since v20080226 is below:

commit 34d0fc37cdece27b19a0484c3f3836e7be624455
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20080318-rc

commit c7dde08273de1e8aab10cdcf1da1120e7153adfb
Author: Simon Horman <horms@verge.net.au>

    Subject: distribute mips_PURGATORY_SRCS
    From: Simon Horman <horms@verge.net.au>

commit 8ade7cf4de94b3b9f032f287fb4f70eff888ba66
Author: Simon Horman <horms@verge.net.au>

    Fix comment in purgatory/arch/x86_64/Makefile

commit da0b760a0b27db0dfdf9a8a6c5a3c17ca7658d7c
Author: Bernhard Walle <bwalle@suse.de>

    Fix kexec-tools on x86_64

commit 4a820d4799a014c03d1a33e80d61588a4415a5da
Author: Simon Horman <horms@verge.net.au>

    Remove purgatory/arch/mips/include/limits.h from distribution

commit 3973e307e10c865712ad59b3f609e27f1e2bddfc
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: mips: support big-endian mips (repost)

commit bbe2590b0b03240ff54cb24b563e9a853b6dd4a2
Author: Sachin P. Sant <sachinp@in.ibm.com>

    x86_64 purgatory Makefile typo fix.

commit d8bc11881dda88d403dec17830e768d8c8fb99ce
Author: Simon Horman <horms@verge.net.au>

    ia64: Remove debug messages from get_memory_ranges()

commit d91bf9213a6423257c78e0006182a43a363cdc37
Author: Simon Horman <horms@verge.net.au>

    arm: invalid initialisation of iomem in get_memory_ranges()

commit 999a3f8138c89671f7fa775c8efee4eeeeb2d2f6
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: mipsel: Define OPT_APPEND outside of any function

commit 8cac3581e291c06834cf8cb7bfee8341f7da5eb2
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: mipsel: Fit elf_mipsel_load() into 80 columns

commit 26101e9dffd99144253fc42c85c13962cb955ecd
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: mipsel: Fit elf_mipsel_usage() into 80 columns

commit 844430d1f70a815ee9bf1a7ea27a8387d02b70d3
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: mipsel: Remove purgatory/arch/mipsel/include/limits.h

commit 66f307e2e1e85f8f9fb5895e52d27ccf85b110fc
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: mipsel: Remove unused arch_options global variable

commit 72afca05800d9a80863e472a553d0ff98388a468
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: mipsel: Remove unused variables in arch_process_options()

commit 968550e6de0513fc64fd1a888e6a1f90869f64bf
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: mipsel: Remove unused variables from elf_mipsel_load

commit 7513645154273c6e1a8678c17b37c5f3fad2b490
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: mipsel: Remove #ifdef __MIPSEL__ from kexec/kexec.c

commit 8eeb3f9cdab8ffc9c576f9258df9a74f218ba1dc
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: mipsel: Remove duplication declaration of BOOTLOADER_VERSION

commit 5561b00ad3e19f3e9a0c507a98a456fc8760f0e5
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: mipsel: Update mipsel port for recent build changes

commit ba08dad1bf4b4e0918f585b5e1bde47402ccaa93
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: mipsel: Remove purgatory/arch/mipsel/include/stdint.h

commit b5e636231886469fcd47fa4d236fa316c4e15251
Author: Francesco Chiechi <francesco.chiechi@colibre.it>

    kexec-tools: mipsel: mipsel port

commit eebc0569dc49693a77821ba716832e8bf833076e
Author: Scott D. Davilla <davilla@4pi.com>

    kexec: fix i386 EFI boot using efifb

commit 94afdd9f7ab2b07997f80a297741842f9cdbdc25
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: [ia64] redivide efi memory in purgatory

commit b1d9ab137fde1b5ab2b279ac739660e1789d8ced
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: [ia64] merge segments

commit 2b0088bb881680c5e8b062a9b0f0a6ef1b88d52c
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: [arm] use proc_iomem()

commit 91ce7876a6ec7e51532f3a2a949bd8d284f5aaad
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: no machine machine to proc_iomem()

commit 3f8791a7ed926363a882213886299cb65a4738d4
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: [ia64] always use /proc/iomem_machine on ia64 xen

commit 29b41380ebb1e4d1dbb2bb5bb26239e659a6b52b
Author: Simon Horman <horms@verge.net.au>

    ia64: make load_crashdump_segments 80col wide

commit f4bf231af8a8c29ba0908551ed7582b5dc33586d
Author: Jay Lan <jlan@sgi.com>

    ia64 kern_vaddr_start was calculated incorrectly

commit 8cfe9008523f7459aea9275e6c2f57e2948890e5
Author: Michael Neuling <mikey@neuling.org>

    fix valid_memory_range region merging

commit cc42aa5f2a579637d9126328b35c9920fbc86095
Author: Bernhard Walle <bwalle@suse.de>

    Fix compilation warning

commit 8687989188b9c6880234ab416eb8e5b1cee78c4e
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20080227-git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
