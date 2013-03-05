Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e24smtp02.br.ibm.com ([32.104.18.86])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCwKs-00014P-Ku
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 18:11:35 +0000
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <leosilva@linux.vnet.ibm.com>;
 Tue, 5 Mar 2013 15:11:27 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 9EC8B3520060
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 13:11:24 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r25IAiKR20971664
 for <kexec@lists.infradead.org>; Tue, 5 Mar 2013 15:10:44 -0300
Received: from d24av04.br.ibm.com (loopback [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r25GBAlB031107
 for <kexec@lists.infradead.org>; Tue, 5 Mar 2013 13:11:10 -0300
Received: from [9.18.235.119] (lain-ibm.br.ibm.com [9.18.235.119])
 by d24av04.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r25GBAcO031101
 for <kexec@lists.infradead.org>; Tue, 5 Mar 2013 13:11:10 -0300
Message-ID: <1362507083.14158.32.camel@lain-ibm>
Subject: kernel image start, kernel load address/entry point
From: leosilva <leosilva@linux.vnet.ibm.com>
Date: Tue, 05 Mar 2013 15:11:23 -0300
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

I'm studying the kexec code and try to figure out where is the best
place to grab these informations: kernel image start address, kernel
load address/kernel entry point.

I've read the kexec-tools code, most precisely  do_bzImage_load function
and purgatory/entry64.S, entry64-32.S and setup-x86_64.S. I found some
informations there as this regs32.eip = kernel32_load_address assign
where I'm assuming it's the kernel entry point that I'm looking for. But
I'm also staring in this code on entry64-32.S to understand what it
does:
ljmp    *%cs:entry32_addr - entry32


As I'm not good in asm I don't understand what it does. I saw that
assign regs32.eip = 0x1000000 /* kernel32_load_address */ first in
do_bzImage_load  so in .S file I saw it moves eip to %eax does that asm
mentioned, and in the end jump to what it calls  loaded image. 
I'm assuming it as the new kernel entry point, the address that I'm
looking to grab, but not sure if it is the the whole *%cs:entry32_addr -
entry32 or just the first assign (0x1000000).


Beyond that I have this real_mode->kernel_start, that to me seems be the
start point in the kernel image, but is just set up if kernel will run
in real mode. So is there no way to grab start image address except it
runs in real mode?

Regardless entry point address I also read this thread 
 http://lists.infradead.org/pipermail/kexec/2012-June/006394.html,
I noticed that this kernel32_load_address seems be just the first
address to where the purgatory jumps to then new kernel starts and in
some moment relocate itself. (guesses). 

My whole point is if my guesses here is correct, if this address are
related to what I want or I'm misunderstanding everything. 


Thanks in advance
Leonidas
-- 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
