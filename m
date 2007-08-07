Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 83-216-141-215.markhi700.adsl.metronet.co.uk ([83.216.141.215]
	helo=mx.hindley.org.uk)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IINHG-0004Oo-4n
	for kexec@lists.infradead.org; Tue, 07 Aug 2007 07:31:10 -0400
Date: Tue, 7 Aug 2007 12:30:48 +0100
Subject: Kexec from xterm -> uhci_hcd. irq 4: nobody cared   
Message-ID: <20070807113048.GE5065@hindley.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
From: Mark Hindley <mark@hindley.org.uk>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com, hbabu@us.ibm.com
Cc: kexec@lists.infradead.org

Hi,

I have just started using kexec. If I kexec from within an xterm I get
the following error on reboot. kexec from a console there is no error.

This is from 2.6.23-rc2, but I get something similar back to 2.6.16.

Aug  7 11:42:08 mercury kernel: irq 4: nobody cared (try booting with the "irqpoll" option)
Aug  7 11:42:08 mercury kernel:  [<c013beda>] __report_bad_irq+0x36/0x75
Aug  7 11:42:08 mercury kernel:  [<c013c119>] note_interrupt+0x200/0x23b
Aug  7 11:42:08 mercury kernel:  [<c013b628>] handle_IRQ_event+0x1a/0x3f
Aug  7 11:42:08 mercury kernel:  [<c013c917>] handle_level_irq+0xa7/0xec
Aug  7 11:42:08 mercury kernel:  [<c013c870>] handle_level_irq+0x0/0xec
Aug  7 11:42:08 mercury kernel:  [<c01062fc>] do_IRQ+0x81/0xad
Aug  7 11:42:08 mercury kernel:  [<c012bde3>] hrtimer_wakeup+0x15/0x18
Aug  7 11:42:08 mercury kernel:  [<c012c029>] hrtimer_run_queues+0x103/0x162
Aug  7 11:42:08 mercury kernel:  [<c01046fb>] common_interrupt+0x23/0x28
Aug  7 11:42:08 mercury kernel:  [<c011e935>] __do_softirq+0x2c/0x75
Aug  7 11:42:08 mercury kernel:  [<c0106030>] do_softirq+0x3e/0x8d
Aug  7 11:42:08 mercury kernel:  [<c013c870>] handle_level_irq+0x0/0xec
Aug  7 11:42:08 mercury kernel:  [<c011e8d0>] irq_exit+0x29/0x62
Aug  7 11:42:08 mercury kernel:  [<c010630f>] do_IRQ+0x94/0xad
Aug  7 11:42:08 mercury kernel:  [<c01046fb>] common_interrupt+0x23/0x28
Aug  7 11:42:08 mercury kernel:  [<c013bb08>] setup_irq+0x155/0x1bd
Aug  7 11:42:08 mercury kernel:  [<cc8c4565>] usb_hcd_irq+0x0/0x4d [usbcore]
Aug  7 11:42:08 mercury kernel:  [<c013bbea>] request_irq+0x7a/0x96
Aug  7 11:42:08 mercury kernel:  [<cc8c4aca>] usb_add_hcd+0x289/0x56f [usbcore]
Aug  7 11:42:08 mercury kernel:  [<cc8cd84b>] usb_hcd_pci_probe+0x1ea/0x283 [usbcore]
Aug  7 11:42:08 mercury kernel:  [<c01c2bd3>] pci_device_probe+0x36/0x57
Aug  7 11:42:08 mercury kernel:  [<c020ac86>] driver_probe_device+0xdd/0x15a
Aug  7 11:42:08 mercury kernel:  [<c027c562>] klist_next+0x50/0x82
Aug  7 11:42:08 mercury kernel:  [<c020ad93>] __driver_attach+0x0/0x75
Aug  7 11:42:08 mercury kernel:  [<c020add7>] __driver_attach+0x44/0x75
Aug  7 11:42:08 mercury kernel:  [<c020a274>] bus_for_each_dev+0x37/0x59
Aug  7 11:42:08 mercury kernel:  [<c020aaee>] driver_attach+0x16/0x18
Aug  7 11:42:08 mercury kernel:  [<c020ad93>] __driver_attach+0x0/0x75
Aug  7 11:42:08 mercury kernel:  [<c020a558>] bus_add_driver+0x6d/0x16d
Aug  7 11:42:08 mercury kernel:  [<c01c2d15>] __pci_register_driver+0x3e/0x6a
Aug  7 11:42:08 mercury kernel:  [<cc81c075>] uhci_hcd_init+0x75/0x95 [uhci_hcd]
Aug  7 11:42:08 mercury kernel:  [<c01355c4>] sys_init_module+0x12d0/0x1413
Aug  7 11:42:08 mercury kernel:  [<cc86f000>] bitrev32+0x0/0x48 [bitrev]
Aug  7 11:42:08 mercury kernel:  [<c0103cea>] sysenter_past_esp+0x5f/0x85
Aug  7 11:42:08 mercury kernel:  =======================
Aug  7 11:42:08 mercury kernel: handlers:
Aug  7 11:42:08 mercury kernel: [<cc8c4565>] (usb_hcd_irq+0x0/0x4d [usbcore])
Aug  7 11:42:08 mercury kernel: Disabling IRQ #4

Is running kexec from an xterm expected to work? Or is it just something
to avoid? I can't find that documented anywhere.

Thanks,

Mark

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
