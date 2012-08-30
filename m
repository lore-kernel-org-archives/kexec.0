Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zVL-0001XI-8C
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 07:49:31 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7nTGf025176
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:49:29 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U7nSF29116 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 16:49:28 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7nSTJ003122
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:49:28 +0900 (JST)
Date: Thu, 30 Aug 2012 16:44:22 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 00/16] makedumpfile-1.5.0-rc: Introduce cyclic mode to fix
 memory usage.
Message-Id: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
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

I post this patchset as release candidate of v1.5.0.
If there are no comments, I will release them as official version in a week.

Explanation:

  This version introduces the "cyclic mode" as a default running mode.

  Before this version, makedumpfile uses the amount of memory depending 
  on physical memory size, because it saves the analytical data for whole
  memory at a time.

  On the other hand, cyclic mode uses fixed amount of memory regardless of
  physical memory size, because this mode analyzes only constant region of
  memory per cycle as below:

    [v1.4.7 or before]
      cycle                       1
                    +-----------------     -----+
      vmcore        |                  ...      | 
                    +-----------------     -----+

    [v1.5.0]
      cycle           1   2   3   4    ...    N
                    +-----------------     -----+
      vmcore        |   |   |   |   |  ...  |   | 
                    +-----------------     -----+

  And, the number of cycles is represented as:
     
    N = physical memory size / (page size * bit per byte(8) * BUFSIZE_CYCLIC)
   
  BUFSIZE_CYCLIC is the buffer size for analysis, default size is 1 Mbyte.

  BTW, in v1.5.0, cyclic mode may cause some slow down of filtering process
  when N is large. 
  I'm going to improve this issue with new filtering logic (called mem_map array logic)
  in a future version.

  At least in v1.5.0, if you feel cyclic mode is slow, you can try 2 workarounds:

    1. Use old running mode with "--non-cyclic" option.

    2. Decrease the number of cycles by increasing BUFSIZE_CYCLIC with 
       "--cyclic-buffer" option.

  Please refer to the manual page for how to use these options.


I am waiting for your comments.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
