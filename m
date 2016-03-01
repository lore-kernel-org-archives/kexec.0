Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aadam-0001S6-Rh
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 06:15:34 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 0/2] Export new VMCOREINFO about compound page
Date: Tue, 1 Mar 2016 06:14:23 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E25FC7@BPXM01GP.gisp.nec.co.jp>
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
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

This patch set is to follow up modifications of struct page for 
makedumpfile which filters dump file.
It's necessary to filter unnecessary compound pages in newer kernel
as usual.

Incidentally, [PATCH 1/2] was post in:

  https://lkml.org/lkml/2016/1/27/92

but it didn't get any response, I repost it here.

Atsushi Kumagai (2):
      kexec: update VMCOREINFO for compound_order/dtor
      kexec: export OFFSET(page.compound_head) to check anonymous page

kernel/kexec_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)


Thanks,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
