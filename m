Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JBxPR-00050O-0J
	for kexec@lists.infradead.org; Mon, 07 Jan 2008 19:13:24 +0000
Message-ID: <478278C9.8030006@zytor.com>
Date: Mon, 07 Jan 2008 11:08:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: crashing on lowmem-only config (was: kexec refuses to boot latest
	-mm)
References: <20071228124532.GB32643@linux.vnet.ibm.com>
	<478264CA.5090300@zytor.com>
	<20080107175303.GA9319@linux.vnet.ibm.com>
In-Reply-To: <20080107175303.GA9319@linux.vnet.ibm.com>
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
To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, hbabu@us.ibm.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, vgoyal@redhat.com

Dhaval Giani wrote:
> 
> .config
> 

This appears to be unrelated, but booting this configuration on a stock 
2.6.24-rc7 kernel crashes during bootup with no initrd if the memory 
size is 896 MB or less (i.e. lowmem only):

Bad page state in process 'swapper'
page:c1b59800 flags:0xdead4aad mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Pid: 0, comm: swapper Not tainted 2.6.24-rc7 #1
  [<c0105ff3>] show_trace_log_lvl+0x1a/0x2f
  [<c0106885>] show_trace+0x12/0x14
  [<c0106b7b>] dump_stack+0x6c/0x72
  [<c015c5c3>] bad_page+0x67/0x93
  [<c015d33e>] __free_pages_ok+0x63/0x2f3
  [<c015d5f2>] __free_pages+0x24/0x26
  [<c05c70ea>] __free_pages_bootmem+0x5f/0x63
  [<c05c57c9>] free_all_bootmem_core+0xcd/0x1a4
  [<c05c58ad>] free_all_bootmem+0xd/0xf
  [<c05c244c>] mem_init+0x81/0x31b
  [<c05b4639>] start_kernel+0x2af/0x335
  [<00000000>] 0x0
  =======================
Bad page state in process 'swapper'
[...]
  =======================
BUG: spinlock lockup on CPU#0, swapper/0, 00000e28
Pid: 0, comm: swapper Tainted: G    B   2.6.24-rc7 #1
  [<c0105ff3>] show_trace_log_lvl+0x1a/0x2f
  [<c0106885>] show_trace+0x12/0x14
  [<c0106b7b>] dump_stack+0x6c/0x72
  [<c024b9a9>] _raw_spin_lock+0xc1/0xe2
  [<c0411d08>] _spin_lock+0x32/0x38
  [<c015d3f9>] __free_pages_ok+0x11e/0x2f3
  [<c015d5f2>] __free_pages+0x24/0x26
  [<c05c70ea>] __free_pages_bootmem+0x5f/0x63
  [<c05c57c9>] free_all_bootmem_core+0xcd/0x1a4
  [<c05c58ad>] free_all_bootmem+0xd/0xf
  [<c05c244c>] mem_init+0x81/0x31b
  [<c05b4639>] start_kernel+0x2af/0x335
  [<00000000>] 0x0
  =======================
[hang]

Booting with > 896 MB works...

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
