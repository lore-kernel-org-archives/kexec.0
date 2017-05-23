Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dCztB-0007K5-U8
 for kexec@lists.infradead.org; Tue, 23 May 2017 02:49:39 +0000
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local
 (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
 by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id E438DAC0143
 for <kexec@lists.infradead.org>; Tue, 23 May 2017 11:49:03 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 0/2] makedumpfile: Fix regression issues on sadump vmcores
Date: Tue, 23 May 2017 02:49:01 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20D205BC5@G01JPEXMBYT03>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "'ats-kumagai@wm.jp.nec.com'" <ats-kumagai@wm.jp.nec.com>
Cc: "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>

Kumagai-san,

I found regression issues on sadump vmcores.
These two patches fix them.
Could you review the patches?

HATAYAMA Daisuke (2):
      sadump: set info->page_size before cache_init()
      Revert "[PATCH V2 1/4] x86_64: Calculate page_offset from pt_load"

arch/x86_64.c  | 25 ++++---------------------
 makedumpfile.c |  6 +++---
 2 files changed, 7 insertions(+), 24 deletions(-)

--
Thanks.
HATAYAMA, Daisuke



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
