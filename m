Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RlG1P-00035o-NS
 for kexec@lists.infradead.org; Thu, 12 Jan 2012 08:28:35 +0000
Date: Thu, 12 Jan 2012 17:16:06 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [Crash-utility] x86 remap allocator in kernel 3.0
Message-Id: <20120112171606.c8959bfb.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <201201101914.33226.ptesarik@suse.cz>
References: <201201101914.33226.ptesarik@suse.cz>
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
To: ptesarik@suse.cz
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

Hello Petr,

On Tue, 10 Jan 2012 19:14:32 +0100
Petr Tesarik <ptesarik@suse.cz> wrote:

> Ken'ichi Ohmichi, please note that makedumpfile is also affected by this 
> deficiency. On my test system, it will fail to produce any output if I set 
> dump level to anything greater than zero:
> 
> makedumpfile -c -d 31 -x vmlinux-3.0.13-0.5-pae.debug vmcore kdump.31
> readmem: Can't convert a physical address(34a012b4) to offset.
> readmem: type_addr: 0, addr:f4a012b4, size:4
> get_mm_discontigmem: Can't get node_start_pfn.
> 
> makedumpfile Failed.
> 
> However, fixing this for makedumpfile is harder, and it will most likely 
> require a few more lines in VMCOREINFO, because debug symbols may not be 
> available at dump time, and I can't see any alternative method to locate the 
> remapped regions.

Thank you for your indication.

Could you send me your kernel configuration so that I can reproduce the issue ?

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
