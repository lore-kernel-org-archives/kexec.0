Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f204.google.com ([209.85.211.204])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1N56PC-0005aL-WD
	for kexec@lists.infradead.org; Mon, 02 Nov 2009 23:33:51 +0000
Received: by ywh42 with SMTP id 42so5157714ywh.28
	for <kexec@lists.infradead.org>; Mon, 02 Nov 2009 15:33:45 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 3 Nov 2009 07:33:44 +0800
Message-ID: <e997b7420911021533t58dd2b1dr61218a67952dae97@mail.gmail.com>
Subject: mips64 smp kexec failed booting at timer interrupt
From: "wilbur.chan" <wilbur512@gmail.com>
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
To: kexec@lists.infradead.org, Linux MIPS Mailing List <linux-mips@linux-mips.org>

I '  m using kexec on a mips64 smp board.

http://lists.infradead.org/pipermail/kexec/2008-June/001909.html

By now , the second kernel has halt at start_kernel --> calibrate_delay,

and I found that it was because of jiffies was not changing.

So  it might be the failure of installation for timer interrupt , or
timer interrupt did not trigger.



Before jumped into second kernel, local_irq_disable was called at each
CPU , and only one of CPU


was enable to jump into second kernel, while the others loop at
relocate_kernel all the time.




After I got dump_stack log of the firts kernel, I found that, do_timer
was invoked right after

console_init -->release_console_sem , it seemed that , timer interrupt
would be triggered

by release_console_sem .

here is the dump_stack info of do_timer of first kernel:


0:Call Trace:
0:[ <834243cc>]0: dump_stack+0x8/0x34
0:[ <83451ee0>]0: do_timer+0x70/0xa8
0:[ <8342333c>]0: timer_interrupt+0x64/0x160
0:[ <834234b4>]0: ll_timer_interrupt+0x7c/0xd8
0:[ <8341d220>]0: ret_from_irq+0x0/0x4
0:[ <83443a64>]0: release_console_sem+0x1e0/0x328
0:[ <8377cf88>]0: serial8250_console_init+0x1c/0x2c
0:[ <8377ae58>]0: console_init+0x4c/0x6c
0:[ <83762dd8>]0: start_kernel+0x3e0/0x75c



Any one know how to fix it?  or how to enable the timer interrupt  in
second kernel?

Thx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
