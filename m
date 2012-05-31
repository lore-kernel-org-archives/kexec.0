Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SZxUp-0000PZ-Cv
 for kexec@lists.infradead.org; Thu, 31 May 2012 05:00:30 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.197])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4V50C3r029745
 for <kexec@lists.infradead.org>; Thu, 31 May 2012 14:00:12 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q4V50BC17409 for kexec@lists.infradead.org;
 Thu, 31 May 2012 14:00:11 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4V50B63012635
 for <kexec@lists.infradead.org>; Thu, 31 May 2012 14:00:11 +0900 (JST)
Date: Thu, 31 May 2012 13:53:58 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC PATCH 0/4] makedumpfile: cyclic processing to keep memory
 consumption.
Message-Id: <20120531135358.c1fc797f.kumagai-atsushi@mxc.nes.nec.co.jp>
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

I made the prototype of cyclic processing to keep memory consumption.
I attache the patch set based on v1.4.4, I would like to get your advice.

Introduction:

 - The basic idea of cyclic processing is represented as below.
 - cyclic processing doesn't use temporary bitmap file, store partial bitmap data
   in memory only for each cycle instead.
 - The prototype only support compressed kdump format.
 - The prototype worked for almost kernel version except some kernel disabled PAE 
   in my environment.

Basic idea (HATAYAMA-san wrote):

   +------------------------------------------+
   |    main header (struct disk_dump_header) |
   |------------------------------------------+
   |    sub header (struct kdump_sub_header)  |
   |------------------------------------------+
   |                                          | <-- 1st cycle
   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
   |            1st-bitmap                    | <-- 2nd cycle
   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
   |                                          | <-- 3rd cycle
   |------------------------------------------+
   |                                          | <-- 1st cycle
   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
   |            2nd-bitmap                    | <-- 2nd cycle
   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
   |                                          | <-- 3rd cycle
   |------------------------------------------+
   |                                          | <-- 1st cycle
   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
   |            page header                   | <-- 2nd cycle
   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
   |                                          | <-- 3rd cycle
   |------------------------------------------|
   |                                          |
   |            page data                     | <-- 1st cycle
   |                                          |
   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
   |            page data                     | <-- 2nd cycle
   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
   |                                          |
   |                                          |
   |            page data                     | <-- 3rd cycle
   |                                          |
   |                                          |
   +------------------------------------------+


How to use:
  
  Specify 'K' option, then makedumpfile works cyclically.

Example:

  a. normal processing:

    $ makedumpfile -cd31 vmcore testdump.cd31
    Copying data                       : [100 %]

    The dumpfile is saved to testdump.cd31.

    makedumpfile Completed.

  b. cyclic processing (too many messages will be displayed):

    $ makedumpfile -Kcd31 vmcore testdump.Kcd31
    Copying data                       : [  5 %]
    Excluding free pages               : [100 %]
    ...
    Excluding free pages               : [100 %]
    Copying data                       : [100 %]

    The dumpfile is saved to testdump.Kcd31.

    makedumpfile Completed.

  c. compare each dumpfiles:

    $ cmp testdump.cd31 testdump.Kcd31
    $

TODO:

 - Optimize code for performance.
   (e.g. initialize for compression is done every cycle, it's a waste.)
 - Support ELF format.
 - Consider suitable size of target region.
 - Fix some messages.
 - And something noticed by you.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
