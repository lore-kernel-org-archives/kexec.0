Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TdIbj-0000S9-Hj
 for kexec@lists.infradead.org; Tue, 27 Nov 2012 10:41:41 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id qARAfZe8015472
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 19:41:35 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id qARAfZO29514 for kexec@lists.infradead.org;
 Tue, 27 Nov 2012 19:41:35 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id qARAfUaF025700
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 19:41:34 +0900 (JST)
Date: Tue, 27 Nov 2012 19:37:27 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [ANNOUNCE] makedumpfile: Postpone the release of 1.5.1
Message-Id: <20121127193727.fbb54d248b75b5106570bdef@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

> If there is no problem, I will release v1.5.1 GA on Nov 28.

I did regression test for v1.5.1 in the last weekend and found some bugs.
So the release date will be delayed by few weeks, sorry.

However, I don't think there are big issues for almost all users, because:
 
  - #1 doesn't happen unless users specify -x option, and it's unnecessary
    for these kernels.
  - As for #2, I think there are few users.

So, I think v1.5.1-rc is enough for almost all users.


BUGS:

  #1. Fail to exclude free pages with page_is_buddy_v2() in some cases.
      I mentioned this issue in the post below:

        http://lists.infradead.org/pipermail/kexec/2012-November/007404.html

      Related kernel: v2.6.27 to v2.6.37

  #2. Fail to exclude free pages with page_is_buddy_v1() in some cases.
      I'm investigating this issue now.

      Related kernel: v2.6.15 to v2.6.17


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
