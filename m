Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWikD-000344-Cp
 for kexec@lists.infradead.org; Fri, 09 Nov 2012 07:11:15 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id qA97B8h4003804
 for <kexec@lists.infradead.org>; Fri, 9 Nov 2012 16:11:08 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id qA97B6H26750 for kexec@lists.infradead.org;
 Fri, 9 Nov 2012 16:11:06 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id qA97B6II004315
 for <kexec@lists.infradead.org>; Fri, 9 Nov 2012 16:11:06 +0900 (JST)
Date: Fri, 9 Nov 2012 16:02:14 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 0/3] makedumpfile: calculate the size of cyclic buffer
 automatically.
Message-Id: <20121109160214.afe15ee1a047ff7354471ba0@mxc.nes.nec.co.jp>
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

I made the patch set based on v1.5.1-beta to calculate the size of cyclic 
buffer automatically.

In v1.5.0, users have to specify the buffer size depending on system memory
size with --cyclic-buffer option in order to get decent performance.

This patch set avoids the inconvenience above by choosing the lesser value
of the two below as the size of cyclic buffer automatically:

  a. the size enough for storing the 1st/2nd bitmap for the whole of vmcore
  b. 80% of free memory (as safety limit)

Additionally, this patch set remove --cyclic-buffer option because I think
it has been already unnecessary.

If there is no comments, I'll merge this patch set into v1.5.1-rc.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
