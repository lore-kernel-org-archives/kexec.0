Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WuE6r-0003nQ-0k
 for kexec@lists.infradead.org; Tue, 10 Jun 2014 04:56:34 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s5A4u4pW013711
 for <kexec@lists.infradead.org>; Tue, 10 Jun 2014 13:56:04 +0900 (JST)
Received: from mailsv4.nec.co.jp (imss63.nec.co.jp [10.7.69.158]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id s5A4u4405490 for <kexec@lists.infradead.org>;
 Tue, 10 Jun 2014 13:56:04 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id s5A4tIKQ005950
 for <kexec@lists.infradead.org>; Tue, 10 Jun 2014 13:56:03 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 0/3] makedumpfile: Reduce the risk of OOM.
Date: Tue, 10 Jun 2014 04:51:33 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE972196B4@BPXM01GP.gisp.nec.co.jp>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

makedumpfile tries maximizing the bitmap buffer size to get the
best performance, but it occasionally cause OOM because the safe
limit is variable and it can be too aggressive depending on the
situation.

I think reliability is more important than performance for dump
tools, so I decided to remove the maximization. I don't worry
about performance degradation, please see [PATCH 3/3].

If there is no objection, I'll merge this patch into v1.5.7.

BTW, an expert user still can try to maximize the bitmap buffer with
--cyclic-buffer option.

Atsushi Kumagai (3):
      Remove the 1st bitmap buffer from the ELF path in cyclic mode.
      Move counting pfn_memhole for cyclic mode.
      Stop maximizing the bitmap buffer to reduce the risk of OOM.

 makedumpfile.8 |   1 -
 makedumpfile.c | 117 ++++++++++++++++++++------------------------------------------------------------------------------
 print_info.c   |   1 -
 3 files changed, 24 insertions(+), 95 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
