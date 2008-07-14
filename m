Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIMD7-0007MB-TB
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 11:27:18 +0000
Date: Mon, 14 Jul 2008 21:27:15 +1000
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.0-rc1
Message-ID: <20080714112713.GA26256@verge.net.au>
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

I'm happy to announce the release of kexec-tools 2.0.0-rc1.
This marks the changing of the name of the tree that
I maintain from kexec-tools-testing to kexec-tools.

Please test this code so we can move towards releasing 2.0.0.


The release can be downloaded from kernel.org:

http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-2.0.0-rc1.tar.gz
http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/

I have also tagged it in git:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git
http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools.git

N.B: The git tee has been moved from kexec-tools-testing.git to kexec-tools.git


A summary of the changes since the previous release,
kexec-tools-testing 20080324, is below.

commit e43a3ed187b07c7a1dc5880bf936f9405440967d
Author: Simon Horman <horms@verge.net.au>

    kexec-tools 2.0.0-rc1

commit d4880a0821580dae5c6954945722629e324dbda7
Author: Simon Horman <horms@verge.net.au>

    Include firmware_memmap.h in the distribution tarball

commit 3c93d9ec83d476064cd3006741cc0af4da06e222
Author: Bernhard Walle <bwalle@suse.de>

    Use get_memory_ranges() on x86-64.

commit b062cf1f8b35b21d8d3b0dee36bdb344de63bf8c
Author: Bernhard Walle <bwalle@suse.de>

    Remove redundancy between get_memory_ranges_proc_iomem() and get_memory_ranges_sysfs()

commit 821179f84d7e5c1622b2798dc6085414b4187a6f
Author: Bernhard Walle <bwalle@suse.de>

    Parse /sys/firmware/memmap.

commit 1b33e8ec4c14bd244c7eb70fa4fa053d62f88b2d
Author: WANG Cong <xiyou.wangcong@gmail.com>

    kexec/crashdump.c: remove useless code

commit 82842420947678b886a4b9daed9756a86ce8eaee
Author: Bernhard Walle <bernhard.walle@gmx.de>

    Fix compiler warning in kexec-x86.c

commit bbf307e0060da005c379c8ca3aa4b9b8c53cc12b
Author: Bernhard Walle <bernhard.walle@gmx.de>

    Remove trailing whitespace

commit f63fe8aa4a22238768e28b59555d98d6b3b769f0
Author: Sachin P. Sant <sachinp@in.ibm.com>

    [ppc64] Allow 32 bit kexec binary to boot kdump kernel on ppc64 architecture

commit 5887072c6392c43e5139c8c94305708c212e333b
Author: WANG Cong <xiyou.wangcong@gmail.com>

    'make dist-clean' should clean more files

commit f3206ae630c71d3a0470a6f4c8b26681a8e0aefc
Author: WANG Cong <xiyou.wangcong@gmail.com>

    kexec/crashdump.c: remove file descriptor leaks; make kdump_info argument to get_vmcoreinfo() const

commit 7d982ee8d961c1fc03a914ae9508c997f2cfde9d
Author: Bernhard Walle <bwalle@suse.de>

    Fix wrong remove_parameter() calls

commit 0f0a2228f79106e8d003147cec71a7dd608d4f49
Author: Bernhard Walle <bwalle@suse.de>

    Fix implicit declaration of inb/outb

commit 1bcd04baaa3091410bf33758d1422ff172254da1
Author: Bernhard Walle <bwalle@suse.de>

    EDD fix

commit 58b6174928951d91cc6d23db6373ad40c2c978d8
Author: Bernhard Walle <bwalle@suse.de>

    Don't run libtoolize and automake in bootstrap.

commit 0232cd4d5bdd755393b061de8b9af846fb8a35be
Author: Bernhard Walle <bwalle@suse.de>

    Specify the arch on kexec_unload.

commit bf61432d40c2b2618f17735254090b7653319bb7
Author: Bernhard Walle <bwalle@suse.de>

    Use 'long long' for printf() format string and ELF64 numbers.

commit 3e2fd34a4c31f8fd7e0646dcd954fcb0ccc8296a
Author: Bernhard Walle <bwalle@suse.de>

    Fix build without cross compilation

commit 7ace39c1253d04e5c5ffa99e1959dce0d20aaa20
Author: Jamey Sharp <jamey@thetovacompany.com>

    Update KEXEC_ARCH_* constants from Linux kernel headers.

commit 7c3109cb6c5e1834bb3b6f788c9dcaa0ddbdf090
Author: Jamey Sharp <jamey@thetovacompany.com>

    Factor uname-based native architecture detection into a common function.

commit 01cc79edacf626472e3d505b60ac86f7150efa84
Author: Jamey Sharp <jamey@thetovacompany.com>

    Open slurped files in binary mode, on systems where that matters.

commit 8546d0c0046d79176f80a636ffddf53c4e8a338a
Author: Jamey Sharp <jamey@thetovacompany.com>

    Prototype ifdown() in kexec.h, not nested in main().

commit 6f95d707544ab3417673990e6a78b27b79737856
Author: Jamey Sharp <jamey@thetovacompany.com>

    Use target CC and LD to build kdump and kexec_test.

commit 3c5bb06948881b3e31c783c19edef74275794280
Author: Bernhard Walle <bwalle@suse.de>

    Add --reuse-cmdline

commit 3bf0213789d56054f601c5a06372f78567aacdd9
Author: Bernhard Walle <bwalle@suse.de>

    Implement EDD support for 32 bit boot

commit 1864bbbed1909d67420eb6bf45e46b651056936d
Author: Bernhard Walle <bwalle@suse.de>

    Update 32 bit boot protocol

commit eaf01a039a1e00e9da52329ac337b00bb9c7f95d
Author: Bernhard Walle <bwalle@suse.de>

    Add x86-bzImage to manpage

commit 6f65cb623cdb82f712144e438d9aa2f097376251
Author: Simon Horman <horms@verge.net.au>

    Add bootstrap file

commit 9d0c7cb57af8f02e916fdbcbfc80186a4e126da4
Author: Bernhard Walle <bwalle@suse.de>

    Document kexec without -e/-l/-f/-p and clarify -f

commit d20ac9e44925d1b0c31baa9a08e391b210873d6d
Author: Bernhard Walle <bwalle@suse.de>

    Remove the 'bzImage' warning from manpage

commit 633473383333272f9a79b69cd1401ccafcb4a43b
Author: Simon Horman <horms@verge.net.au>

    PPC64: Initialise modified_cmdline in elf_ppc64_load()

commit dad9f01c556c69c432f3b145e2947dcd5e7626ca
Author: Neil Horman <nhorman@tuxdriver.com>

    PPC64: ensure that extra rtas segment is a multiple of PAGE_SIZE

commit 595994920f19891f50b41d24cbd808beb0ae8ea9
Author: Tony Breeds <tony@bakeyournoodle.com>

    Allow building for ppc32 platforms.

commit 25334078f4fb7d617ba23a705360121749382cd1
Author: Jamey Sharp <jamey@thetovacompany.com>

    Die on early EOF in slurp_file, instead of infinite-looping.

commit d5123a084bf2ba11e440b7dd238a7413b7e59956
Author: Jamey Sharp <jamey@thetovacompany.com>

    Simplify initialization of argument list for `shutdown`.

commit eb5c1bab95722a56cc44beddd1eba8dd9470c82f
Author: Jamey Sharp <jamey@thetovacompany.com>

    Replace weak definitions with source filename overriding.

commit d1e7c0fa1f66c74c0f0de9673041a19a1eceb35b
Author: Simon Horman <horms@verge.net.au>

    <sys/mman.h> is not needed by any kexec/ source

commit f30c50cca91449460841c1e1bd9ea0e7de46853c
Author: Jamey Sharp <jamey@thetovacompany.com>

    <sys/mman.h> is not needed by any kexec/ source, at least on i386.

commit 7b325f8528d230e50a0c3841a3ac587dea2200e2
Author: Jamey Sharp <jamey@thetovacompany.com>

    Fix all gcc warnings for ARCH=i386 builds.

commit 23d14a85327252ee07332ca13b2b7973b410bf7d
Author: Jamey Sharp <jamey@thetovacompany.com>

    Fix "Warning: indirect jmp without `*'".

commit 27b1321a9b1f69cef5dabe968617a572e159f138
Author: Jamey Sharp <jamey@thetovacompany.com>

    Conform more closely to Documentation/i386/boot.txt for bzImages.

commit bb127e837117314d9c6365110089cded5642d818
Author: Jamey Sharp <jamey@thetovacompany.com>

    Fix copy-paste bug: entry16 does not start at entry16_debug.

commit b76efc860bce5649dcc5d3e0f791664f69123553
Author: Jamey Sharp <jamey@thetovacompany.com>

    Fix undefined symbol errors on readw/writew: arch/io.h, not sys/io.h.

commit 1e1ee02f95e69890fb98d71cb512261ac9283623
Author: Itsuro ODA <oda@valinux.co.jp>

    extract vmcoreinfo from /proc/vmcore for Xen

commit 9e959db12a671a71934a765d15aaf082f0a4f886
Author: Jeremy Kerr <jk@ozlabs.org>

    Give installed files user-writable permission

commit 6bb84c7169d5f621726a34a1def82b440937fb21
Author: Jeremy Kerr <jk@ozlabs.org>

    Use separate LDFLAGS for bin-to-hex

commit 7e6a90376d0c48753808befaa21b7851a7dcf274
Author: Jeremy Kerr <jk@ozlabs.org>

    Use separate CPPFLAGS and LDFLAGS for purgatory

commit 50c058f6ce074838ce9d23e25c527e5c1541e196
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20080324-git


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
