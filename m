Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gA9Od-00062T-Pm
 for kexec@lists.infradead.org; Wed, 10 Oct 2018 07:59:15 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id CA1E025B80D
 for <kexec@lists.infradead.org>; Wed, 10 Oct 2018 18:58:52 +1100 (AEDT)
Date: Wed, 10 Oct 2018 09:58:49 +0200
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.18-rc1
Message-ID: <20181010075848.hye7rtjdcabtu4bw@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org

Hi all,

I am happy to announce the release of kexec-tools 2.0.18-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.18
in a weeks time. Testing of 2.0.18-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.18 at this time.
And I would like to only accept bug fixes at this time and take take
features patches once 2.0.18 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.18-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.17 are:

94159bc3c264 kexec-tools 2.0.18-rc1
1ac3e4a57000 kdump: fix an error that can not parse the e820 reserved region
b9de21ef51a7 kexec: fix for "Unhandled rela relocation: R_X86_64_PLT32" error
ca4823aa2fc2 arm64: error out if kernel command line is too long
7198e899ddab arm64: increase command line size to 2048
c3f043241a86 arm64: Add support to supply 'kaslr-seed' to secondary kernel
7acd257ae67b Remove obsolete kdump tool
674b9b45876c Makefile.in: Add uninstall rule
e277fa9ec702 vmcore-dmesg: fix infinite loop if log buffer wraps around
d4a948c26827 kexec/s390: Add support for kexec_file_load
0481e9ed61ef kexec: Add --no-checks option
72c146c20588 purgatory/ppc64: Fix uninitialized warning
3f276f71f14d kexec-elf-rel-ppc64: Fix cast from pointer warning
7be89276db19 crashdump-ppc64: Fix integer truncation warning
798317c134b2 kexec: Fix printf warning
b43960c20dd2 kexec-tools 2.0.17.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
