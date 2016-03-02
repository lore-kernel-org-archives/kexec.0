Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aauUn-00072S-8z
 for kexec@lists.infradead.org; Wed, 02 Mar 2016 00:18:30 +0000
Received: from reginn.isobedori.kobe.vergenet.net
 (p5023-ipbfp803kobeminato.hyogo.ocn.ne.jp [123.221.39.23])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 6369325B751
 for <kexec@lists.infradead.org>; Wed,  2 Mar 2016 11:18:08 +1100 (AEDT)
Date: Wed, 2 Mar 2016 09:18:06 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools v2.0.12 preparation
Message-ID: <20160302001806.GE17986@verge.net.au>
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

I am planning to release kexec-tools v2.0.12 around the time that
the v4.5 kernel is released.

As I estimate that the latter occur within the few weeks I
would like to ask interested parties to send any patches they would like
included in v2.0.12 within the next week so that I can make an rc release.

For reference the patches queued up since v2.0.12 are as follows:

7c53754e5da8 kexec/fs2dt.c: wrong dt node fix
61cfab4e2ce0 vmcore-dmesg: Collect full dmesg regardless of logged_chars
35cb8a0761a0 ppc64: Add a flag to tell the kernel it's booting from kexec
eff306e8914c Revert "crashdump/x86: Add option to get crash kernel region size"
8a1aa35a1077 crashdump/x86: Add option to get crash kernel region size
6ba9e97c5b5f x86: Make sure E820_PM[AE]M are defined if needed
56a12abc1df1 kexec: fix mmap return code handling
0e1030b345b9 Improve device tree directory sorting
4bad06c3cd2a arm: use /sys/firmware/fdt in case without --atags and --dtb
4580c372000b kexec/fs2dt: check for /chosen/stdout-path first
68262155d8c6 kexec/fs2dt: cleanup pathname
65a15228b570 kexec/fs2dt: s/diabled/disabled/
e0e7a11783c1 kexex: arm: create ATAGS_MEM tag from devicetree memory node
084ed28061e1 uImage: fix pointer-sign warning
bc1d49d51dd1 kexec: determine size of block device
95741713e790 kexec/s390x: use mmap instead of read for slurp_file()
8d8c6bcee593 kexec-tools 2.0.12.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
