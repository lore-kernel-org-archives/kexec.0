Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YwgZd-0002xE-Lw
 for kexec@lists.infradead.org; Mon, 25 May 2015 00:49:02 +0000
Received: from ayumi.isobedori.kobe.vergenet.net
 (p8130-ipbfp1005kobeminato.hyogo.ocn.ne.jp [118.10.149.130])
 by kirsty.vergenet.net (Postfix) with ESMTP id 5D3EE25BEE0
 for <kexec@lists.infradead.org>; Mon, 25 May 2015 10:48:32 +1000 (EST)
Date: Mon, 25 May 2015 09:48:28 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools v2.0.10 preparation
Message-ID: <20150525004828.GA22103@verge.net.au>
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

I am planning to release kexec-tools v2.0.10 around the time that
the v4.1 kernel is released.

As I estimate that the latter occur within the next three or four weeks I
would like to ask interested parties to send any patches they would like
included in v2.0.10 within the next two weeks so that I can make an rc release.

For reference the patches queued up since v2.0.9 are as follows:

5041d45b1c6b Revert "x86_64: Add support to build kexec-tools with x32 ABI"
4a837c9a19f9 purgatory: force PIC/PIE/SSP off
458e81576530 purgatory: Fix memcmp for src address increment
8da5dd2da475 kexec: remove ordering constraints from -x (--no-ifdown) and -y (--no-sync)
ca718aa5070b kexec: implement -y (--no-sync) option
6eb1c19a45bc configure.ac: Fix failure caused by x32 ABI test
5edcbfd1368e x86_64: Add support to build kexec-tools with x32 ABI
720d110389f2 x86: Remove unnecessary res variable from efi_map_added
23a806695fa7 purgatory: Add printf type checking
f9f98fd811fe purgatory: Generate map file
835620406833 purgatory: Generate symbol file
e42fc55e10fb purgatory: Add no-zero-initialized-in-bss flag
236e30b2b4dc kexec: iomem: fix callbacks params for sh and x86 archs
8e0722a93de0 i386: elf: Fix -Wunused-but-set-variable compilation warning
9116b5e0915d i386: bzImage: Fix -Wunused-but-set-variable compilation warning
e932fff3bfa2 kexec: Fix compiler format warning
5a7380559732 kexec: Fix compiler ambiguous else warning
fe781d9317e2 mips: remove unused variable.
c2ec15074a5d mips: fix warning about implicit type conversion.
f9dac450c212 mips: fix compiler warning on printing 64-bit integer.
58bbd468571b configure.ac: apply necessary quotes to result of macro expansion.
f5c40daed2ab multiboot: fix crash on NULL kernel command line
d606837b56d4 Fix zlib/lzma decompression.
5af63fb020d0 ppc64: erase unnecessary segment info printing
e716a4c9fda3 kexec-tools 2.0.10.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
