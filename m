Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YCzjk-0000kl-3L
 for kexec@lists.infradead.org; Sun, 18 Jan 2015 23:58:32 +0000
Received: from ayumi.isobedori.kobe.vergenet.net
 (p8130-ipbfp1005kobeminato.hyogo.ocn.ne.jp [118.10.149.130])
 by kirsty.vergenet.net (Postfix) with ESMTP id 838EE26719A
 for <kexec@lists.infradead.org>; Mon, 19 Jan 2015 10:58:08 +1100 (EST)
Date: Mon, 19 Jan 2015 08:58:01 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools v2.0.9 preparation
Message-ID: <20150118235800.GB2306@verge.net.au>
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

I am planning to release kexec-tools v2.0.9 around the time that
the v3.19 kernel is released.

As I estimate that the latter occur within the next three or four weeks I
would like to ask interested parties to send any patches they would like
included in v2.0.9 within the next two weeks so that I can make an rc release.

For reference, the (short) list of patches queued up since v2.0.8 is
as follows:

Revert "kexec, remove panic_on_warn kernel parameter from kdump situations"
kexec, remove panic_on_warn kernel parameter from kdump situations
kexec/fs2dt: Use slurp_file_len to avoid partial read of files
kexec: remove some re zero-assignment
kexec/fs2dt: Fix sorting of device tree
kexec: distribute kexec/arch/m68k/bootinfo.h
kexec-tools 2.0.8.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
