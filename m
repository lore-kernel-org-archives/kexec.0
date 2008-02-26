Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JTqRS-0005fF-TK
	for kexec@lists.infradead.org; Tue, 26 Feb 2008 03:25:22 +0000
Date: Tue, 26 Feb 2008 12:25:08 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools-testing v20080226-rc
Message-ID: <20080226032506.GA24839@verge.net.au>
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

Hi all,

Sorry for being slow in getting the proper release, but owing to
a minor build problem I've decided to spin another rc.

The release can be downloaded as a tarball:

http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-testing-20080226-rc.tar.gz
http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/

I have also tagged it in git:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.git
http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools-testing.git


A summary of the changes since 20071030 is below:

commit 0b011417a55ff57fcc648f56264f772766b82356
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

commit c87f78372ebdb4f1ef7a37fd5628e5e1dfd571d0
Author: Simon Horman <horms@verge.net.au>

    20071030-git

commit b7f9f0d1563afeeca14b8ba0c5e34440c5274bbd
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20071030 release

commit 61198670cc428626dc3a1d76eb7b2f0b11707eb6
Author: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

    Pass vmcoreinfo's address and size #2

commit 2e152ffba39a9234dfa984966deba273824e73c1
Author: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

    Pass vmcoreinfo's address and size

commit 6282f6f4e662ca7c8fa9c53d31f1e1057c3d6192
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20071017-rc

commit d955779f2aec43e9926866f2c9d2b1ba5b989c79
Author: Simon Horman <horms@verge.net.au>

    Set alternate location for /proc/iomem on ia64 xen

commit 6dfe4858e2db01b49d52a4cf2bb0dce18324d787
Author: Simon Horman <horms@verge.net.au>

    Allow architectures to specify the location of /proc/iomem

commit de12fd1c7133edfc4be1d94f63295e30ae1dc526
Author: Bernhard Walle <bwalle@suse.de>

    Use fclose() to close the file pointer

commit ddbc4830ad70598070e891e10508ca09567bca60
Author: Randy Dunlap <randy.dunlap@oracle.com>

    kexec-tools: fix typos

commit b9c3648e690ad0dad12389659673206213a09760
Author: Bernhard Walle <bwalle@suse.de>

    Determine ELF32/ELF64 automatically on i386

commit b84b87747a16f0afbef6f6802bb794a94f4961d9
Author: Michael Neuling <mikey@neuling.org>

    kexec ppc64: fix misaligned cmdline

commit 1a1dea172782db6b9ce20b3afe5ca046120a78bc
Author: Michael Neuling <mikey@neuling.org>

    minor cleanup in check_reuse_initrd

commit f76d598edc5050bc70902446294cb1522479bdfd
Author: Maneesh Soni <maneesh@in.ibm.com>

    fix kexec-tools options

commit 02f4088ffded3d6f99a0c9f835727943d102b3df
Author: Geoff Levand <geoffrey.levand@am.sony.com>

    kexec fix ppc64 device-tree mem node

commit 13ceb63c96c26e1964dea12576d7245853a83842
Author: Geoff Levand <geoffrey.levand@am.sony.com>

    kexec rename dprintf to dbgprintf

commit e6a23f7d355685f01f6a4ce7c9d37deb7458cf90
Author: Geoff Levand <geoffrey.levand@am.sony.com>

    kexec remove last remaining dfprintf

commit f7129ad11f75ef27416784c39c29b0e8906d8844
Author: Simon Horman <horms@verge.net.au>

    Handle maloc() failure in xen_get_nr_phys_cpus()

commit c58ed3b1b4f538bbd784ee3087e4d5e467637fcf
Author: Geoff Levand <geoffrey.levand@am.sony.com>

    kexec fix prototypes for ppc64

commit df5a80b73b34da3c8021608489400cb949e2f2e3
Author: Geoff Levand <geoffrey.levand@am.sony.com>

    kexec add strict-prototypes

commit ee2bd75816cb20c266ad27e417589e8e6ee7a39e
Author: Simon Horman <horms@verge.net.au>

    use dprintf

commit 17be877eabcad87dd93980da6375fdaba271204f
Author: Geoff Levand <geoffrey.levand@am.sony.com>

    kexec debug output improvments

commit 536dd73ce38cb68828d362b0cca1a8e8b377b97e
Author: Geoff Levand <geoffrey.levand@am.sony.com>

    kexec improve build for ppc64

commit 1f5e46311bc9f00449f1ffb4fef4901664d3061e
Author: Michael Neuling <mikey@neuling.org>

    kexec ppc64: cleanup get_devtree_details

commit e2dcef05eadaee65805178a775fa31aac18edc8c
Author: Michael Neuling <mikey@neuling.org>

    kexec ppc64: Add arch specific --reuseinitrd hooks

commit 8ec6347996ce83c369edeee4bed0498dedda6b41
Author: Michael Neuling <mikey@neuling.org>

    kexec: Added generic --reuseinitrd option

commit b42483a7f148456186212abed9d3c4b2535d1d60
Author: Michael Neuling <mikey@neuling.org>

    kexec-tools: remove initrd_found

commit 0ed5c286ef2d83a55d1b2aff2c153ac95f9744ea
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Add distclean and maintainerclean targets

commit c8d973a3eca741f036f0240fd9d67c1848cfc7f7
Author: Milton Miller <miltonm@bga.com>

    kexec-tools: ppc64: use kernels slave loop for purgatory

commit c89a1770572654ef01ea9b12519c7f9fe05514f1
Author: Milton Miller <miltonm@bga.com>

    kexec-tools: ppc64: correct @ha relocation

commit 1223d194299dbd43d583e094e71ebf5e79856e9e
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Add -git to version so it doesn't look like a release

commit 1f0a51945382941b665b17edffe9a535105563e5
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20070330 release

commit de2706db2f34ac16a9aa3191fa3368cda2ce6339
Author: Simon Horman <horms@verge.net.au>

    kexec-tools-testing 20070319-rc

commit a79df8a5597261fdbc7926b5406e163bb749ccbb
Author: Ian Campbell <ian.campbell@xensource.com>

    Fix a cut and paste error in the --without-zlib configure option help.

commit d73cc37554560b7f282d6a3f2472f6a92ec1458a
Author: Simon Horman <horms@verge.net.au>

    Default to --with_xen

commit cdbc9b011fe43407908632d842e3a39e495e48d9
Author: Ian Campbell <ian.campbell@xensource.com>

    Set crash dump ELF header e_machine field based on underlying hypervisor architecture.

commit efac1da616a211517a4b0eaae098db6ade3bdd26
Author: Ian Campbell <ian.campbell@xensource.com>

    Ignore PT_NOTE program headers with offset 0.

commit 78cd98999c9e00c2fe3347d4664c5bdc8dd91497
Author: Magnus Damm <magnus@valinux.co.jp>

    Move memory range variables

commit bc1eb4e071f864de82474bade25c0273a7fecb6b
Author: Horms <horms@verge.net.au>

    kexec-tools: arch_options seems to be unused on sh

commit d10e7735d93166fbfcc3263b1f77e7fc5de0a541
Author: Bernhard Walle <bwalle@suse.de>

    Fix wrong max_memory_ranges value

commit cd6091ebd1c0ebc608390996c1cb088fab13ec79
Author: Magnus Damm <magnus@valinux.co.jp>

    Remove duplicate MAX_LINE

commit 5d6f808c6468082b20f899114ef023fdaeb44615
Author: Magnus Damm <magnus@valinux.co.jp>

    Kdump is not supported on ppc, s390, sh

commit d6c231c6f341d839fbfb09ea0814dd9a5ccdb005
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_64 bzImage load purgatory below 2G

commit 924b985aaba1a3cc17f419e93b3a31568070df7a
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_64 Print correct info in reloc_name function

commit bcd72df212636eee645276a2409b0eef8c250dee
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Use EFI_LOADER_DATA for ELF core header (ia64)

commit 56595256907a3b31d2849dfe185d0d16b2ead471
Author: Michael Ellerman <michael@ellerman.id.au>

    kexec-tools: ppc64: Check return value of setup_memory_ranges()

commit 05abdb92a5f5c32659620ffdb2c6e48f0b2428ae
Author: Sachin P. Sant <sachinp@in.ibm.com>

    kexec-tools : fix compile time error on x86-64

commit d869eec86724069242679e458a0a24b8274d1cc4
Author: Magnus Damm <magnus@valinux.co.jp>

    Make sure max_memory_ranges are cleared before incremented

commit f09cb6fb977e58e77054107e1df908bb18b92e86
Author: Magnus Damm <magnus@valinux.co.jp>

    Keep alignment comment in elf code and use ELF_CORE_HEADER_ALIGN

commit 40f4b56e54c3e42ef32189682a85bcdc1bf240f1
Author: Zou Nan hai <nanhai.zou@intel.com>

    Kexec-tools: Fix physcal address value in vmcore ELF segment header

commit a62dba3262250b650abc84b42d7f95521b69a1c8
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: load_crashdump_segments(): size should really be an unsigned long

commit 3091b1398b6385186a7afaa60e303e84c0bc7bee
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Make cmdline_add_elfcorehdr() <= 80col

commit 38f3a78abeb98361c1c63a5d1b7031af542545e7
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Add alignment parameter to crash_create_XXX_headers

commit 5417f8ed03ab87fdcfeb78418ac066cc26598d58
Author: Bernhard Walle <bwalle@suse.de>

    Patch from Bernhard Walle to fix up the help message a bit.

commit c0c8232ff9385cb9abed468eebaef2cc0d6b1450
Author: Paul Mundt <lethal@linux-sh.org>

    Trivial change adding sh4a to the sh targets.

commit 49c5c5b662774e91ecebd95e4f7650e6567a6624
Author: Jay Lan <jlan@sgi.com>

    IA64 kexec-tools: memory_ranges arrays scalability issue

commit 02e6bd686d64abd747e17c268dc1b913e14b5c91
Author: Simon Horman <horms@verge.net.au>

    Use xmalloc instead of malloc in locate_hole() to standardise behaviour on error

commit 3d15dc049d5771d2e9b0e808ad3554fd1158b1ac
Author: Roman Kononov <kononov195-uclibc@yahoo.com>

    xmalloc; empty memory ranges

commit a6eee1488fd9a9fb3ca483eed92977dd9e4cacb6
Author: Roman Kononov <kononov195-uclibc@yahoo.com>

    kexec i386 real mode patch

commit 5299e8183dd984d485c5037cc717a0c0b04cd5be
Author: Simon Horman <horms@verge.net.au>

    Remove 9bc3f8f7df46d8253bccaede1ea5ad3f21678f80, which is bogus

commit 8323ed7b3119077cd6fef6ca3615ba1b5b24d2cd
Author: Horms <horms@verge.net.au>

    Clean up memory allocations in locate_hole()

commit 9bc3f8f7df46d8253bccaede1ea5ad3f21678f80
Author: Simon Horman <horms@verge.net.au>

    Missing portions of the sh code

commit e4656a54370d0b1b398e05217f6a43f3ef7dbeb7
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Upport for sh support

commit 11d346a8339771bc04708f1595d8ac76de4c661a
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Add sh support to configure.ac

commit 843c2d1ec1bbd2a1c46c99aa24eb1ae0b2109bd6
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Remove trailing whitespace in sh code

commit 35917b5e76e8aef49920cc9693c94863f4ae507b
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Add sh support

commit 17aef86b03edc9867f990434bc30be0ac498376d
Author: Simon Horman <horms@verge.net.au>

    Add maintainer information to AUTHORS file

commit acd0bdeab5b2932a48165efbf79a21e111e950ae
Author: Jay Lan <jlan@sgi.com>

    IA64 kexec-tools: efi_memmap overflow on large systems

commit 4b94de0aaa7b0fb911a7513f90e5b928799c7c2a
Author: Sachin P. Sant <sachinp@in.ibm.com>

    ppc64 kexec tools code cleanup.

commit f8afe9befb4918853b3002725e53ddbbd43cf719
Author: Sachin P. Sant <sachinp@in.ibm.com>

    cp /proc/vmcore fails on core generated using latest kexec tools.

commit 7792798a79b78a5d566f70c9f00237d050b01350
Author: Sachin P. Sant <sachinp@in.ibm.com>

    ppc64: Dynamic mem allocation kexec tools Cleanup update

commit 64d74e97fddefa8241fb493fa5b497625317342c
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Add -git to version so it doesn't look like a release

commit b26698511bd64550a1e439a4658d0d8706963016
Author: Sachin P. Sant <sachinp@in.ibm.com>

    kexec-tool: Use the appropriate format in debug print statements

commit cdab051ce335c98e265a7824280755368799bd7a
Author: Horms <horms@verge.net.au>

    kexec-tool: Use the appropriate format in debug print statements

commit 1f0c1b411631a4ae320a7b450adee8475a8a0e92
Author: Horms <horms@verge.net.au>

    kexec-tool: Use the appropriate format in debug print statements

commit 1e2050cf828181eb125dfdf6af99a4f5170c0462
Author: Sachin P. Sant <sachinp@in.ibm.com>

    fix ppc64 kexec tools build failure when DEBUG is enabled.

commit bbc9e730b4c407e8e9587dbe362513f0efb25156
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Make kexec/kexec.c 80col wide or less

commit 3634a1d19dc17d700cca1e7eae757a53778124db
Author: Horms <horms@verge.net.au>

    kexec-tools: fix spelling of address in help text

commit 41bf7ad6f448edba12cd774c898c823d5d6d265d
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Move defines to the top of kexec/arch/ia64/kexec-elf-ia64.c

commit e2ec8c694bea047458ec6d7460991939f87fd990
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Make kexec/arch/ia64/kexec-elf-ia64.c <= 80col wide

commit 554d26792d53e54a5d5331548134326046d620b9
Author: Horms <horms@verge.net.au>

    kexec-tools: ia64: fix bogus mem_max = ULONG_MAX

commit bac7bfac708e63f9e974b742aad79e08e43f7cb5
Author: Sachin P. Sant <sachinp@in.ibm.com>

    Dynamic memory allocation : ppc64 kexec tools Cleanup

commit d4bd5d52f7d1e702c11a9e8070d74de2aaead7af
Author: Simon Horman <horms@verge.net.au>

    Release kexec-tools-testing 20061214

commit ee4614d63649e10f80a4d8475721704a4c75f6b6
Author: Simon Horman <horms@verge.net.au>

    Put .spec file inside the release directory

commit 25d012d48862162f226a3235c21d5af2214bcbc1
Author: Simon Horman <horms@verge.net.au>

    Set package name in help text from Makefile

commit eb6c564a407310aa49b22f3a802445ccfea8d002
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Add a note about cmdline_add_elfcorehdr() allocating memory

commit 7b347834d35633578c60496a13d1e913926e50f2
Author: Horms <horms@verge.net.au>

    send slave cpus to SAL slave loop on crash (IA64)

commit 7f093bceb950d24d91359965d135c835c584c953
Author: Zou Nan hai <nanhai.zou@intel.com>

    send slave cpus to SAL slave loop on crash (IA64)

commit 6675c146d462deccaaa1c7541aaebd58ce08295c
Author: Horms <horms@verge.net.au>

    kexec-tools: Make sure base and end do not overflow

commit 488598cad71dbb349058a6f3886bf010309018be
Author: Sachin P. Sant <sachinp@in.ibm.com>

    kexec-tools: check for underun and only read required data

commit 08d770bf0232938f8ab186ebe99cfabdc89800ee
Author: Horms <horms@verge.net.au>

    kexec-tools: don't rely on errno to detect errors

commit e358b3ee211e0794cf5a6122b4db93198e0fdf40
Author: Horms <horms@verge.net.au>

    kexec-tools: Detect scandir errors

commit 6a33ef415ec36725eb307adc3666852155a0d7bf
Author: Horms <horms@verge.net.au>

    kexec-tools: ppc64: Check lseek return for errors

commit 1fd7cb01165e301789566e6a19344972e0595457
Author: Horms <horms@verge.net.au>

    kexec-tools: Use die() instead of err()

commit 713fa5718a9f75c32e39efa2026c2d33c39ea353
Author: Horms <horms@verge.net.au>

    kexec-tools: Remove useless variable end from checkprop()

commit b12f1ae30c05829bbf0fc023b2dbbac6bc671a16
Author: Horms <horms@verge.net.au>

    kexec-tools: Fix potential overrun of mem_rsrv

commit ed1a80e95d6297ac94efe6e9bab7170c7bcfd29c
Author: Horms <horms@verge.net.au>

    kexec-tools: ppc fix used of propnames

commit 8cf92f9b23920cb5040b371321767356ac7f2349
Author: Horms <horms@verge.net.au>

    kexec-tools: ppc64: Make functions and variables static

commit 40573cae78f308c8e7a5d24ce41e670feabace68
Author: Horms <horms@verge.net.au>

    kexec-tools: Don't typedef dvt

commit d3888a4abe883174b26bab9651151bae937b0871
Author: Horms <horms@verge.net.au>

    kexec-tools: ppc64: tidy up use of statbuf

commit f6c01a9f596961ddf7c07a741470153aafccff10
Author: Horms <horms@verge.net.au>

    kexec-tools: Make kexec/arch/ppc64/fs2dt.c <= 80 columns wide

commit b7e11ae11043339839b3b0dcd88821bb0b134149
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: 1k alignment comment

commit b5c22baac1a632363a91da666886bb0ae285bd67
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Remove commented-out variables from load_crashdump_segments()

commit 98a24e9dbeb2f1a8eee15ea2dc95b0e93d6632f8
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Initialis load_loc to keep gcc quiet

commit 0561bfc2fc6dccc706f12975f38cfb79fb5d63da
Author: Simon Horman <horms@verge.net.au>

    kexec-tool: i386: Only load known segments

commit acc3c486f3172d13d550a7c58b4e047182e94127
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: make sure written is initialised in write_all()

commit ccda0410c5bc151ca0ed8d9d0ead2bdbb2a52bc5
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: nc_cpus is no longer needed in load_crashdump_segments()

commit 63ac15b2cfb8d05762c0f4bff997e3cfd0c4efc5
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Allow load_crashdump_segments() to accept const char **

commit c41620b1d2717a6eb1969ad03758a1b707ba55ab
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Xen on x86_64 fix

commit 85d91aabcd06e9376d5bfb05ac0e80cba049daa2
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Get rid of unused variables on ppc

commit 9c279feaafcbd529cc60e255ace3b473b8b0a24d
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Include crashdump.h in crashdump-ia64.c

commit f7d547f412f0f0b363240c2261ed3ec89b828689
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Introduce crashdump-xen.c and Xen support V2

commit 5ce4f874087d0981479e841e9c366cf55e67d985
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Use generic /proc/iomem code (ia64) V2

commit e56c336fc291bec6031f806a4302f17d5dfd8f0d
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Use generic /proc/iomem code (x86_64) V2

commit d7e482d655b4d4dadd3c02189206f5daac996c09
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Use generic /proc/iomem code (i386) V2

commit 93d54f803f26c20172a21d57bfdb74c3ed9bdef0
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Introduce kexec-iomem.c and /proc/iomem parsing code V2

commit 8f9f43cee0efcfeecaae494740a6f31a8895f513
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Make use of crash_create_elf32/64_headers() (ppc64) V2

commit f038d30bff8510a1df1e72af08db1766581d1f2c
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Make use of crash_create_elf64_headers() (ia64) V2

commit 5800c9bd01ded5ddc7651a67d338d559c0681219
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Make use of crash_create_elf32/64_headers() (i386) V2

commit 38c40ae43bb07019e8cb70d255477d6da0acb31e
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Make use of crash_create_elf64_headers() (x86_64) V2

commit c80198e78ce26783e092645b9ac8587e1374f22f
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Introduce crashdump-elf.c and crash_create_elf32/64_headers() V2

commit f8b0123231e9ca2cb124aa290b9df7785ff135e0
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Continue instead of returning (i386)

commit fb8731448cbeedb0044b1293b1c778d5653f0dd5
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Use get_crash_notes_per_cpu() (ia64)

commit 93bd94e000e78e81982d03db0e1ce54a54dad859
Author: Magnus Damm <magnus@valinux.co.jp>

    kexec-tools: Add length parameter to get_crash_notes_per_cpu()

commit 920a98d04e4f97d0799a8e924e03a8a9721973aa
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: Remove spurious blank line (x86_64)

commit 37b8875625334156fc0a6e521d44c89d119d56dc
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: Drop hardcoding the kernel start addr to 2MB (x86_64)

commit 4e74957bef2f2cd3692b0c4f40deb589cecd673c
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: Don't create hardcoded PT_LOAD header (x86_64)

commit 93fa57c2b75b1bbfccf2e202c10e23a708c6c7e7
Author: Horms <horms@verge.net.au>

    kexec-tools: remove bogus stderr from die() call

commit 880d6f6a750defe4f8f8654bf4b078576b22f926
Author: Horms <horms@verge.net.au>

    kexec-tools: remove unneccessary includes in kexec/crashdump.c

commit 47a2c04bbb971337549360a4e2b3adf0217bea3e
Author: Horms <horms@verge.net.au>

    kexec-tools: fix various bugs in get_crash_notes_per_cpu

commit 7b4b9a4cbb3e0553b0b3da9c92c3f9a0d57445ac
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: brief documention on how to build and install

commit 883e80569953e004bf251ca1e73add7088aa2381
Author: Simon Horman <horms@verge.net.au>

    Help message for --noio option

commit 6e18330303b0dbe5e3470aad13a7dfa6f866bdf1
Author: Heiko Carstens <heiko.carstens@de.ibm.com>

    s390: set KEXEC_ARCH_S390 in arch_compat_trampoline

commit 24589ab035ffbb0140b9b05f542ded8bc931de95
Author: Jay Lan <jlan@sgi.com>

    kexec-tools: bug fix to --noio option

commit 785f8f7c4e71803cc1ec73f0660e28e14696d1cf
Author: Maneesh Soni <maneesh@in.ibm.com>

    Make sure that elf headers are created for all physical memory

commit b7d1e7aab0da6904986a12f2851dd6010c5f503f
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: Enable use of relocatable bzImage to capture crash kernel core dumps

commit 1ac7cb4dd95229495ba7d2d5f490565d843b2e58
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: Support loading relocatable bzImage

commit 94e4df27577d8a52dec41b1290365a64b4c4d1a2
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: Introduce dfprintf macro for debugging statements

commit 2e9b9aed5d7ddf6195fb3d7da9c62596df11e308
Author: Mohan Kumar M <mohan@in.ibm.com>

    Check for crashkernel reservation in x86_64

commit fcd1df8df66762b741a99319434405817e4c31ec
Author: Mohan Kumar M <mohan@in.ibm.com>

    Check for crashkernel reservation in i386

commit 7ba1a8074fa4010494a779f05f360f02058d76bc
Author: Simon Horman <horms@verge.net.au>

    Add headers for open()

commit 3976dc1ae31e08a33d2da8a5e5e02644b039e1e1
Author: Mohan Kumar M <mohan@in.ibm.com>

    Check for crashkernel reservation in PPC64

commit 878e1322daaa34e1b33825642a33d0a027a5d373
Author: Mohan Kumar M <mohan@in.ibm.com>

    Check for crashkernel memory reservation

commit 13882ab8fd1261c378de648bbcc1ed21822a2121
Author: Terry Loftin <terry.loftin@hp.com>

    kexec-tools: ia64: icache flush should align to 32-bytes

commit 16ec25bd77ba2c4ff1793bd588d5c87fc310485e
Author: Simon Horman <horms@verge.net.au>

    ia64-vmm

commit e90343c521b68237c17ea4e4ed376c4a726f0789
Author: Simon Horman <horms@verge.net.au>

    build-util_lib-optimisation-flags

commit ba686313d496ee25db69803ef7e5bfb1e07eb841
Author: Simon Horman <horms@verge.net.au>

    build-cpp-and-ld-flags

commit 103c946e39eb9dd57ccbda20ac12ccb01f883c17
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_64 read kernel vaddr and size from /proc/kcore

commit f11123aa03a7e8bfee165a56f7f1f6d8baa1d163
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: ia64 fix compilation issues due to new parameter

commit e55303a3c5dfea80e6a7543fac3fac36565912b0
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: ppc64 fix compilation issues due to new parameter

commit d5a0fa062b48973ebceacba02b7633533c1495e6
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_64 fix compilation issues due to new parameter

commit e787462138f92f7d2c8b694b1c27a9e68f88fdeb
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: ppc fix compilation issues due to new parameter

commit 11c261bd942ee34e95289a5226abb2e87122cb5d
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: i386 fix compilation issues due to new parameter

commit dd3f52d4668938b9b3ad91607d7df3cf337b0863
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: Add a new parameter to generic elf parsing functions

commit 46ecc6c6c77b1fab20b08286209631a00eb1049e
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Explain dummy set_virtual_address_map more clearly

commit f7c2909515bd0080d9adf3e7923874bbc0ecc033
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Use consistent comment style patch_efi_memmap()

commit c76818f11c0ffe6ca5d1053d4a330621d333ff8a
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Slightly less nested logic in patch_efi_memmap()

commit 74d022921ad3a06cbb14274214d53bf1102de437
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Use memdesc_size directly in patch_efi_memmap()

commit 9228bb45cab0efd0aa79ffab82d42dbc5b3e88a4
Author: Simon Horman <horms@verge.net.au>

    kexec-ktools: Use efi_memmap_size directly in patch_efi_memmap()

commit 75596fa8887fef6b3718cd6464fb4dbe46fa8981
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: less confusing variable names in patch_efi_memmap()

commit 623f842058e343204073849a5c0e8bff9c35e974
Author: Simon Horman <horms@verge.net.au>

    kexec-ktools: simplify segment walk logic in patch_efi_memmap()

commit c506e2859d2b890bd6ada04fa11e434ba5d87b1e
Author: Simon Horman <horms@verge.net.au>

    kexec-ktools: remove duplicated code in patch_efi_memmap()

commit ef14c5794bed504f83d2a0721a88993f0c64099b
Author: Simon Horman <horms@verge.net.au>

    kexec-ktools: somewhat less nested code in patch_efi_memmap()

commit b41b838100bd7ab01d802cb9e3ebe2c4ad210485
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Make purgatory code 80 columns wide

commit 4535790836ee0c8b9ea1cdf5d2baec5360bac458
Author: Simon Horman <horms@verge.net.au>

    kexec-tools: Remove .orig files

commit a9df6cb0ac92be0a87eb03ed28d398912915d2ed
Author: Simon Horman <horms@verge.net.au>

    build-no-partial-rebuild-on-clean

commit 80826bf7234184cef22756a11337657c65b89bf3
Author: Simon Horman <horms@verge.net.au>

    build-no-configure

commit efcdafa70ee525f71a38908571e870f09984efbf
Author: Sachin P. Sant <sachinp@in.ibm.com>

    kexec man page update for unload option.

commit 4160e1b01231b8393d11367c82690646368e251d
Author: Zou Nan hai <nanhai.zou@intel.com>

    kexec-tools: --noio option to disable I/O in purgatory code.

commit ad691d700dd06b80adab8cc404ce8113ccdd1622
Author: Zou Nan hai <nanhai.zou@intel.com>

    kexec-tools: Fix physcal address value in vmcore ELF segment header

commit 6256940a039cde5641e469d2e129c95d5196b7d3
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_64 move debugging code under #ifdef DEBUG

commit c1349002068bda5deab1d485b22eecfb8a41d2c1
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: cleanup DEBUG macro usage in code

commit 49e72cf7736ac4c219a8f106bff332f2691fabd2
Author: Vivek Goyal <vgoyal@in.ibm.com>

    x86_64: Load vmcore elf headers away from kernel

commit af07e52128dff6d25d6efd94c9e22c21e7b30cec
Author: Zou Nan hai <nanhai.zou@intel.com>

    ia64: kdump: patch clone ia64_boot_param area for crash

commit 9e741cbe256fa166d1e18b635cd55ae173eb0224
Author: Zou Nan hai <nanhai.zou@intel.com>

    ia64: kdump: reserve efi memmap and boot param region

commit 0d5e71fbcb114b5a67ef7277dbad206915a20df2
Author: Magnus Damm <magnus@valinux.co.jp>

    x86_64: Setup CS when booting vmlinux

commit 8251f7dd3fe02995f92dd0db6efdf34b0988e644
Author: Magnus Damm <magnus@valinux.co.jp>

    x86: fix triple underscore typo

commit 0c7eda010fe8122f340e470cfc8273a0975945a3
Author: Magnus Damm <magnus@valinux.co.jp>

    teach elf_rel_load() about section names

commit 64c27ee85138921a38a958f21478eb2aad5e7b75
Author: Magnus Damm <magnus@valinux.co.jp>

    make elf_rel_build_load() use buffer from argument

commit 32b12d965b19c72245ae195d98986a944b87f814
Author: Sachin Sant <sachinp@in.ibm.com>

    ppc: support 64k page size

commit 306543c2def0181b880608b24e0ffb04e5172bec
Author: Vivek Goyal <vgoyal@in.ibm.com>

    x86_64: kdump: remove elf32 core header support

commit 71d2424c8ac4f93a60c3eee5c95df269f584a9da
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: ppc64 fix for multiple backup region definiton

commit a4a67f32a0b6eca09c68cdd5a4cb6e0e0fbc6690
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_64 backup region naming convention fix

commit 2f2aa1af0325ee974ef2526cef1a2546a9923281
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: i386 backup region naming convention fix

commit b02d735bf252117b3c9f7d56b65072e64ce531c0
Author: Haren Myneni <haren@us.ibm.com>

    ppc64 kdump device_tree sort

commit 8e8a420da9b6027f1aac38f7484b0b789df8c734
Author: Haren Myneni <haren@us.ibm.com>

    ppc64 initrd option

commit 4fcca750c790b5e012c59fae0e241edd74ab307c
Author: Maneesh Soni <maneesh@in.ibm.com>

    kexec-tools in git...

commit 529ad18980e297efc6ac2839c82afc24eccdcd1f
Author: Gerd Hoffmann <kraxel@suse.de>

    kexec & vesafb

commit 6dcc69c0eb91b643f77c042db31ba23b4a67f1d6
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: Fix for loading files of type ET_DYN through kexec

commit 70543d23c5ddf2d91efa87847de061c1f964e38c
Author: Eric W. Biederman <ebiederm@xmission.com>

    Update TODO now that kexec on panic works

commit 6bd37921934682e6c308ea968bd051a6d8698d08
Author: Eric W. Biederman <ebiederm@xmission.com>

    Set the expected release date

commit bc006bcc37dd2f7d99b28db4e353dfe2736b2360
Author: Eric W. Biederman <ebiederm@xmission.com>

    Rebuild configure from configure.ac

commit 4f3d28645767e39c863fd78a790a207c1b2ee7bf
Author: Eric W. Biederman <ebiederm@xmission.com>

    s390: Fix the arguments to arch_compat_trampoline

commit e37e5982d97d45f7d85b3a89c7accc3cc9c1f637
Author: David Wilder <dwilder@us.ibm.com>

    ppc64 ignore args-linux

commit 3b38820ee8e4f4b81d213bd93f438a911eb5f3d6
Author: Eric W. Biederman <ebiederm@xmission.com>

    Do no shutdown if we know we do not have a kernel loaded

commit 61909815c74fa778c2787aa824dc2c5826d9769b
Author: Maneesh Soni <maneesh@in.ibm.com>

    ifdown check

commit 9241000f28eb6b86a06c0be2d6cf31498373bc1c
Author: Zou Nan hai <nanhai.zou@intel.com>

    kdump ia64

commit a59caf2ae4f2027c3644551b03d5474d4d634ec5
Author: Benjamin Romer <benjamin.romer@unisys.com>

    fix ACPI NVS reservation

commit 5f85389b619197d1274d8391ca9377384c85ef13
Author: Maneesh Soni <maneesh@in.ibm.com>

    ppc64 kdump tools ELF header fix

commit e1c58dba0db2e10c28b511bea772e46449c5ac12
Author: Michael Neuling <mikey@neuling.org>

    ppc64 add missing usage info

commit 6183c476f8203a18ee2dc35b4d611078bb5bbe12
Author: Michael Neuling <mikey@neuling.org>

    ppc64 fix segv when missing root option

commit 1387ae740abf3a86e5dded8c9c70f686e949409a
Author: David Wilder <dwilder@us.ibm.com>

    - kexec man page

commit 8889df7a1b19aebcc2a9d5f101b1b37aebc721c3
Author: Khalid Aziz <khalid.aziz@hp.com>

    ia64 use /proc/iomem

commit bad9296125c088cbeaf747c0d7d909274e22e0ab
Author: David Wilder <dwilder@us.ibm.com>

    ppc64 kexec-tools rm platform prop fix

commit 2f646b5c4f31e8d0cd3e504dff4d691f06859bbc
Author: Khalid Aziz <khalid.aziz@hp.com>

    ia64 support

commit 0a196ba1d11b449420b7817a84178a8bd2a1e9a5
Author: Vivek Goyal <vgolal@in.ibm.com>

    Fix kexec load for more than 4G

commit 742b147db61c45cc00db63eea7b23d0a462e56c8
Author: Mohan <mohan@in.ibm.com>

    Cleanup the warnings in gcc-4.1.0 compilation

commit ad0f10320e3393d7ca699ac5bcc81726994220c7
Author: Mohan <mohan@in.ibm.com>

    gcc 4.1.0 ppc64 fix

commit 10d673dfd32537f2d5e14c07d79b4c63a8bcd7a9
Author: Mohan Kumar M <mohan@in.ibm.com>

    patch for REL errors

commit bce59244e37901a9d1434c75d2eff2fd72884652
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_64 vmcore copy operation failure fix

commit 3d14d4d0ac791d1d180763806f610cdd06a95a94
Author: Haren Myneni <haren@us.ibm.com>

    Missing powerpc64 and s390 support in configure.ac script

commit 92aade5b19bfdd14dfa47ed1426bd90d2064cfe8
Author: R Sharada <sharada@in.ibm.com>

    ppc64 kdump purgatory backup support

commit 9768c7e89f1a5cb4933d2ea996321d8ec7e162bd
Author: R Sharada <sharada@in.ibm.com>

    ppc64 kdump elf hdr generation

commit 17fa73d36cfca33c7b287d7e354961bcff5fa170
Author: R Sharada <sharada@in.ibm.com>

    ppc64 kdump crash segments support

commit 089c003250471f636141cf8b3db2acd259c9331f
Author: R Sharada <sharada@in.ibm.com>

    ppc64 kdump crash memory support

commit 34d39f48bb5534a3f48b942ca53f57e1c5f8e48d
Author: R Sharada <sharada@in.ibm.com>

    ppc64 kdump prepare device tree

commit cf917def9fcb8bdc12e222b7751630669e59009e
Author: R Sharada <sharada@in.ibm.com>

    ppc64 fix function parameters

commit 920fca9abfba3f5b86b2f73b54ba6f45148847cf
Author: Vivek Goyal <vivek@in.ibm.com>

    kexec-tools: i386 sys interface changes compatibility

commit e2a925519d24e1aef1fd8d6e2f0d6f659d128ea7
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_84 pass acpi table map to second kernel

commit b5b9a27822e2adea6db7cfd96a796321b2d836bd
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: kexec increase max segments limit

commit 5b9b3cbab3432e54c5bb242e814e64440ba0c2b3
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: i386 dynamic crash notes memory allocation

commit 4023a9d123263a1de3bde0c42e1257d068d33a31
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_64 load crashdump segments

commit 4e2f70e3c75f2b81878c34c4f8b3c298ec1b1cd2
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_64 backup first 640k

commit 084a640be5c31ce2698ecc5c66c654460f93f53a
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_64 append command line options

commit 38be08689724f4679e1a267eee671991056374f6
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_64 elf header generation

commit 8be19e1a35aff9290ed142fae38a53243176309e
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kexec-tools: x86_64 read proc iomem

commit cd18217445dac97c298a9db43ad188ff14d63784
Author: Vivek Goyal <vgoyal@in.ibm.com>

    x86-64 compilation failure fix

commit 3f22360d1c6a9d8aca77a4f2973cdd54487cf0c3
Author: Eric W. Biederman <ebiederm@xmission.com>

    Update the s390 code to allow kexec_flags to be passed to get_memory_ranges

commit 1366c25d9cbcc14f32c4ffb393e365e27690f03e
Author: Vivek Goyal <vgoyal@in.ibm.com>

    kdump-kexec-tools: x86 elf32-core-header option fix

commit 7c4a2dc90f22ef8b821aa6a1f3d551facec47a48
Author: Michael Neuling <mikey@neuling.org>

    kexec tools: devicetreeblob option

commit 72df5597c20e9a02776b987226828f33141414c9
Author: Michael Neuling <mikey@neuling.org>

    kexec tools: device tree blob reserve

commit 2bff98d6415f6274666ab7d57faa464c1c9587ec
Author: Maneesh Soni <maneesh@in.ibm.com>

    ppc64 fix compiler flags

commit 80ec3db380dec6156a47f3b719929f730b9d7c98
Author: R Sharada <sharada@in.ibm.com>

    basic kexec tools for ppc64 (compile warning cleanups)

commit 4abf375a85c4ce439017b3873e0933c518a79334
Author: R Sharada <sharada@in.ibm.com>

    build v2wrap from purgatory

commit 0a6bd1c06f95feac368ffd9dd4a663807313e19c
Author: R Sharada <sharada@in.ibm.com>

    get memory ranges

commit 7fe30a2691ccb69f7af3aae89e6eed53af823d26
Author: R Sharada <sharada@in.ibm.com>

    create flat device-tree

commit 7d142115e31c566cd3b333c84834b4dbd100c43e
Author: Vivek Goyal <vgoyal@in.ibm.com>

    Hack to avoid kexec segment stomping

commit 71b37c87c709970c62924c58fe436857d569fe80
Author: Vivek Goyal <vgoyal@in.ibm.com>

    Align memsz before locate hole fix

commit e2ffd1d4de78a165c8b9a4540378d5783cc9109b
Author: Vivek Goyal <vgoyal@in.ibm.com>

    elf headers fill virtual address for linearly mapped region

commit 7193ca3c24f57f3f649d74832c1abf2c6640ebb9
Author: Vivek Goyal <vgoyal@in.ibm.com>

    crashdump elf core headers generation

commit 1ac3ddd1d4a3d8cb7af5fd02c1ffb85893c4ea50
Author: Vivek Goyal <vgoyal@in.ibm.com>

    crashdump backup region handling

commit dcb661fb3e778052d64b1b1557621856eade403a
Author: Eric W. Biederman <ebiederm@xmission.com>

    Revert "- First stab at letting the loaders know we have a panic kernel."

commit ed859637b1034d871a0196a033b647ae121cdd4d
Author: Vivek Goyal <ebiederm@xmission.com>

    Add explicit cast from unsigned long to void * in kexec-x86.c

commit caa2e42897cb8cb00c7040b9133e8b740809241c
Author: Eric W. Biederman <eric@frodo.(none)>

    - First stab at letting the loaders know we have a panic kernel.

commit 166f928bf42161fef0faf2b4ad4d27c57b90e61e
Author: Eric W. Biederman <eric@frodo.(none)>

    - Remember the vmlinux parameter area problem in the todo list

commit 281b71666597a20108a3e341375c401d8367ffa6
Author: Eric W. Biederman <eric@frodo.(none)>

    Move the configuration changes for s390 into configure

commit 481c68bae340cbb762d3ef63cb461ea1abd65dfa
Author: Eric W. Biederman <eric@frodo.(none)>

    Bump the date in the Makefile in preparation for making a release

commit 96dcc09dfad4f296dc9f8af71c563f1c94e0f220
Author: Eric W. Biederman <eric@frodo.(none)>

    Remove unneeded temporary ramdisk_buf variable

commit 47406fd61a7eb4694a6033edd5e1ce4eeb3a6a72
Author: Heiko Carstens <heiko.carstens@de.ibm.com>

    add s390 support to kexec-tools-1.101

commit 5cce75bdd6a154a7bee733bcce8f7fe1baf40adf
Author: Eric W. Biederman <ebiederm@xmission.com>

    Bump the version number in anticipation of a release

commit a2f13571b014ec3153997ba76ceb5da61265553c
Author: Eric W. Biederman <ebiederm@xmission.com>

    Fix the max_mem_ranges calculation

commit 2c6cf2b9d7360ccfb1f773feea39974cf513535f
Author: Eric W. Biederman <ebiederm@xmission.com>

    Fix arch option processing

commit af598f5e5570b431a5fff2434ecb9cbe61586383
Author: Eric W. Biederman <ebiederm@xmission.com>

    Fix the i386 old bios call compatibility.

commit 283261998a9846019d898bc454b363e4aaf3d181
Author: Eric W. Biederman <ebiederm@xmission.com>

    kexec-tools-1.101

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
