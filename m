Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.66 #1 (Red Hat Linux))
	id 1ImlYP-0001vl-MB
	for kexec@lists.infradead.org; Tue, 30 Oct 2007 03:30:32 -0400
Date: Tue, 30 Oct 2007 16:29:40 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools-testing v20071030
Message-ID: <20071030072938.GF5361@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>

Hi all,

its been a long time between releases, so I thought that it be about
time to put out another release of kexec-tools. To this end I have
released kexec-tools-testing v20071030.

The release can be downloaded as a tarball:

http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools-testing-20071030.tar.gz
http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/

I have also tagged it in git:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.git
http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools-testing.git


A summary of the changes since v20070330 is below:

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

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
