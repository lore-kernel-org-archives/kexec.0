Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1N3BPY-0001e1-Jf
	for kexec@lists.infradead.org; Wed, 28 Oct 2009 16:30:16 +0000
Received: by yxe40 with SMTP id 40so844613yxe.28
	for <kexec@lists.infradead.org>; Wed, 28 Oct 2009 09:30:11 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 29 Oct 2009 00:30:11 +0800
Message-ID: <e997b7420910280930p40e3c02cw1ab5a7813a4b5147@mail.gmail.com>
Subject: mips64 SMP patch of kexec
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
To: msyrchin@ru.mvista.com
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, kexec@lists.infradead.org, nschichan@freebox.fr

Hi, Maxim Syrchin

I've just  found your  kernel patch for mips64 SMP kexec:

http://lists.infradead.org/pipermail/kexec/2008-June/001909.html

 I was porting  your kexec part  code(excluding crash_dump )  on
xlr408 ,which is of  8 cores SMP mips64 .

I found that in machine_kexec.c ,
flush_icache_range(reboot_code_buffer,  reboot_code_buffer +
KEXEC_CONTROL_CODE_SIZE);

caused an error, so I delete this line directly,although I don't know
if it would bring problem after I del it...


 It is strange that , in relocate_kernel.S, the operator 'REG_L	s5,
(s2)' caused an  invalid access on kernel space.

If I change REG_L to ld , everything went well.   So I change all the
macro such as  REG_L to  ld ,REG_S to sd , PTR_ADD to dadd

LONG_SUB to dsub, and SZREG to 8


At the same time ,  I changed the kexec_smp_wait function to a simple
loop, without checking the kexec_flag:


.globl kexec_smp_wait
kexec_smp_wait:
3: b 3b

at last , the a0,a1,a3,a4 were set to address of fw_arg0,
fw_arg1,fw_arg2,fw_arg3 respectively.


As you see, I just let one of the cpus jumps into new kernel,while the
others be  in an infinite loop.

After jumped into second kernel , the code seemed to be crazy.


Firstly,  the code seemd to stop before calling 'start_kernel--->
calibrate_delay ' .


 However,  if I added a 'printk' in any 'if  branches'  in
'calibrate_delay '  function  , the code would stop before calling

'j  start_kernel'  in head.S. (This time, because printk seemed
unavailable, I  wrote directlly to serial address to trace the
kernel).


I thougt it might be the problem of irq , so I added 'disable_irq(17)'
 in machine_kexec before invoking reboot_code_buffer();



However, the problem was still there.

I don't know why this happedn can you give me some advice on how to
solve this , or if there were some mistake in my code ?


Thank you

regards,

wilbur

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
