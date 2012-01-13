Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RlYQ0-0006hj-UZ
 for kexec@lists.infradead.org; Fri, 13 Jan 2012 04:07:11 +0000
Subject: Re: [Crash-utility] x86 remap allocator in kernel 3.0
In-reply-to: <201201121140.09221.ptesarik@suse.cz>
References: <201201121140.09221.ptesarik@suse.cz>
Message-Id: <20120113122250tachibana@mail.jp.nec.com>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Fri, 13 Jan 2012 12:22:50 +0900
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec@lists.infradead.org, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, crash-utility@redhat.com

Hi Petr,

On 2012/01/12 11:40:08 +0100, Petr Tesarik <ptesarik@suse.cz> wrote:
> Dne ?t 12. ledna 2012 09:16:06 Atsushi Kumagai napsal(a):
> > Hello Petr,
> > 
> > On Tue, 10 Jan 2012 19:14:32 +0100
> > 
> > Petr Tesarik <ptesarik@suse.cz> wrote:
> > > Ken'ichi Ohmichi, please note that makedumpfile is also affected by this
> > > deficiency. On my test system, it will fail to produce any output if I
> > > set dump level to anything greater than zero:
> > > 
> > > makedumpfile -c -d 31 -x vmlinux-3.0.13-0.5-pae.debug vmcore kdump.31
> > > readmem: Can't convert a physical address(34a012b4) to offset.
> > > readmem: type_addr: 0, addr:f4a012b4, size:4
> > > get_mm_discontigmem: Can't get node_start_pfn.
> > > 
> > > makedumpfile Failed.
> > > 
> > > However, fixing this for makedumpfile is harder, and it will most likely
> > > require a few more lines in VMCOREINFO, because debug symbols may not be
> > > available at dump time, and I can't see any alternative method to locate
> > > the remapped regions.
> > 
> > Thank you for your indication.
> > 
> > Could you send me your kernel configuration so that I can reproduce the
> > issue ?
> 
> Attached. The most important settings are:
> 
> CONFIG_X86_32=y
> CONFIG_DISCONTIGMEM_MANUAL=y
> 
> This also depends on CONFIG_NUMA=y
> 
> FYI my test system runs 3.0.15 (because that's used for SLES11 SP2), but the 
> same issue also exists in any later version.
> 
> Petr Tesarik
> SUSE Linux

Thank you for the config. I will fix makedumpfile. However it will take time 
to solve various issues because I've never run makedumpfile on 3.0.X.

Thanks.
tachibana

---------------------------------------------------------------------

> --
> Crash-utility mailing list
> Crash-utility@redhat.com
> https://www.redhat.com/mailman/listinfo/crash-utility
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
