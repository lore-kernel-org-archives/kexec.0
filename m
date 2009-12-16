Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sj-iport-1.cisco.com ([171.71.176.70])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NL1Tk-0005e2-1Z
	for kexec@lists.infradead.org; Wed, 16 Dec 2009 21:32:20 +0000
From: Roland Dreier <rdreier@cisco.com>
Subject: kexec reboot broken with ioatdma?
Date: Wed, 16 Dec 2009 13:32:11 -0800
Message-ID: <ada3a3a8v1g.fsf@roland-alpha.cisco.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, kexec@lists.infradead.org

I have a system with IOAT hardware, and rebooting with kexec fails with
the latest 2.6.32-git kernel.  I haven't really tried earlier kernels,
but I suspect the issue comes from the ioatdma driver being autoloaded now.

The reboot gets stuck at:

  ioatdma 0000:00:16.0: Self-test copy timed out, disabling
  ioatdma 0000:00:16.0: Freeing 2 in use descriptors!
  ioatdma 0000:00:16.0: Intel(R) I/OAT DMA Engine init failed

so presumably the IOAT hardware is left in a bad state that the ioatdma
driver in the kexec'ed new kernel can't handle.

I notice that long ago, there was a commit 428ed602 ("I/OAT: fix I/OAT
for kexec") that added a shutdown method to clean things up so kexec
worked, and then more recently there was 4fac7fa5 ("ioat: do not perform
removal actions at shutdown") that got rid of the shutdown hook.

I'm not sure what the correct fix is here: fix the shutdown order so
everyone drops all references to IOAT stuff before IOAT is shutdown, or
add some code to the ioatdma driver so it resets the hardware on startup
so the new kernel can deal with an unspecified state.

This is on a system with the following hardware:

00:16.0 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Devic
e [8086:3430] (rev 20)
00:16.1 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Devic
e [8086:3431] (rev 20)
00:16.2 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Devic
e [8086:3432] (rev 20)
00:16.3 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Devic
e [8086:3433] (rev 20)
00:16.4 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Devic
e [8086:3429] (rev 20)
00:16.5 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Devic
e [8086:342a] (rev 20)
00:16.6 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device [8086:342b] (rev 20)
00:16.7 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device [8086:342c] (rev 20)
80:16.0 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device [8086:3430] (rev 20)
80:16.1 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device [8086:3431] (rev 20)
80:16.2 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device [8086:3432] (rev 20)
80:16.3 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device [8086:3433] (rev 20)
80:16.4 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device [8086:3429] (rev 20)
80:16.5 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device [8086:342a] (rev 20)
80:16.6 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device [8086:342b] (rev 20)
80:16.7 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device [8086:342c] (rev 20)

Thanks,
  Roland

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
