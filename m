Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1nan-0002Ho-3q
 for kexec@lists.infradead.org; Fri, 30 Mar 2018 06:32:54 +0000
Received: from penelope.horms.nl (52D9BC73.cm-11-1c.dynamic.ziggo.nl
 [82.217.188.115])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 2347A25B77E
 for <kexec@lists.infradead.org>; Fri, 30 Mar 2018 17:32:42 +1100 (AEDT)
Date: Fri, 30 Mar 2018 08:32:39 +0200
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools v2.0.17 preparation
Message-ID: <20180330063239.c7noamd2h7mbbrrd@verge.net.au>
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

I am planning to release kexec-tools v2.0.17 in the next two weeks
to roughly coincide with the release of the v4.16 kernel.

I would like to ask interested parties to send any patches they would like
included in v2.0.17 within one week so that I can make an rc release.

For reference the patches queued up since v2.0.16 are as follows:

3720b743ae3c kexec/ppc64: leverage kexec_file_load support
b10924a7da3c kexec/ppc64: add support to parse ibm, dynamic-memory-v2 property
c740fdb20482 kexec: add a helper function to add ranges
060eee589dd1 x86: use old screen_info if needed
282ff2a5e613 kexec-tools: Make xc_dlhandle static
58c225a6d762 kexec-tools: Call dlclose() from within __xc_interface_close()
894bea9335f5 kexec-tools: Perform run-time linking of libxenctrl.so
401e096166ce kexec-tools 2.0.16.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
