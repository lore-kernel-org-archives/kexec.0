Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JjNXv-0004kb-Ow
	for kexec@lists.infradead.org; Tue, 08 Apr 2008 23:48:12 +0000
Date: Tue, 8 Apr 2008 19:48:01 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Bad IRQs & SATA ADMA failures
Message-ID: <20080408234801.GA6454@redhat.com>
References: <47FBC1F0.5030105@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47FBC1F0.5030105@hp.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Cc: kexec@lists.infradead.org

On Tue, Apr 08, 2008 at 03:05:20PM -0400, Alan D. Brunelle wrote:
> I'm new to the KEXEC/KDUMP world - just started out today. I believe
> that I have things set up right, but I'm running into two issues:
> 
> 1. A few seconds into the boot, I see:
> 
> [    3.400435] ata1: SATA max UDMA/133 cmd 0x28d0 ctl 0x28f8 bmdma
> 0x28b0 irq 5
> [    3.410435] ata2: SATA max UDMA/133 cmd 0x28d8 ctl 0x28fc bmdma
> 0x28b8 irq 5
> [    3.864522] irq 5: nobody cared (try booting with the "irqpoll" option)
> [    3.864522] Pid: 0, comm: swapper Not tainted 2.6.25-rc8-bannor-kexec #1
> [    3.864522
> [    3.864522] Call Trace:
> [    3.864522]  <IRQ> [<ffffffff8024da5e>] __report_bad_irq+0x1e/0x80
> [    3.864522] [<ffffffff8024dd2f>] note_interrupt+0x26f/0x2a0
> [    3.864522] [<ffffffff8024e2b1>] handle_fasteoi_irq+0x71/0xa0
> [    3.864522] [<ffffffff8020ed8c>] do_IRQ+0x5c/0xc0
> [    3.864522] [<ffffffff8020c471>] ret_from_intr+0x0/0xa
> [    3.864522]  <EOI> [<ffffffff803bc610>] nv_scr_read+0x0/0x30
> [    3.864522] [<ffffffff8020afbe>] default_idle+0x2e/0x60
> [    3.864522] [<ffffffff8020afb9>] default_idle+0x29/0x60
> [    3.864522] [<ffffffff8020af90>] default_idle+0x0/0x60
> [    3.864522] [<ffffffff8020b032>] cpu_idle+0x42/0x70
> [    3.864522] [<ffffffff80501aaa>] start_kernel+0x23a/0x280
> [    3.864522] [<ffffffff805011a5>] _sinittext+0x1a5/0x1f0
> [    3.864522]
> [    3.864522] handlers:
> [    3.864522] [<ffffffff803bd950>] (nv_adma_interrupt+0x0/0x4c0)
> [    3.864522] Disabling IRQ #5
> 
> 

This one just means that there is a device out there which has interrupt
line asserted and there is no associated driver to handle those. Hence 
kernel sees a flood of interrupts and disables interrupt line. That's
why we boot with paramter "irqpoll". In kdump situations, these things
are expected. You can ignore this error.

> 2. Very soon thereafter, I start seeing:
> 
> [    4.671112]  sda:<3>ata1: EH in ADMA mode, notifier 0x1
> notifier_error 0x0 g0
> [   34.681112] ata1: CPB 0: ctl_flags 0xd, resp_flags 0x1
> [   34.681112] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> frozen
> [   34.691112] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0
> dma 4096 n
> [   34.691112]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (time)
> [   34.701112] ata1.00: status: { DRDY }
> [   35.051112] ata1: soft resetting link
> [   35.211112] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   35.251112] ata1.00: configured for UDMA/100
> [   35.251112] ata1: EH complete
> 
> This goes on "forever" - and the system fails to boot.
> 

This is problem with SATA. It is not able to reset the device and recover
and re-initialize. I think we shall have to open a bug for this for the
SATA driver owner.


> This script is used to set up kexec:
> 
> root="root=/dev/sda1"
> gen_args="1 irqpoll maxcpus=1 reset_devices"
> bannor_args="acpi=off console=tty0 console=ttyS2,115200n8"
> 
> /usr/local/sbin/kexec -l /boot/vmlinuz-2.6.25-rc8-bannor-kexec \
>                       --append="${root} ${gen_args} ${bannor_args}"
> 
> Some other notes:
> 
> o  I have the kernel gen'd w/out an initrd
> 
> o  Kernel is gen'd w/out CONFIG_SMP
> 
> o  I added the 'acpi=off' as one site I google'd had that as a possible
> fix for a problem like this.
> 
> I do not know if the two problems mentioned above are related, but in
> any case, I'm wondering if there are any pointers out there to help get
> this going.
> 
> I have the output from 'lspci' and the console log during a failed boot
> up on : http://free.linux.hp.com/~adb/kexec/bootlog.txt
> 

In general, I think your procedure is fine.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
