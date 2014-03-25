Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSU3J-0000z3-NG
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 16:18:14 +0000
Date: Tue, 25 Mar 2014 09:17:37 -0700
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: handle 64bit efi memmap address correctly
Message-ID: <20140325161737.GA19907@verge.net.au>
References: <20140320015824.GA3497@dhcp-16-126.nay.redhat.com>
 <20140324014720.GA2320@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140324014720.GA2320@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: matt.fleming@intel.com, toshi.kani@hp.com, kexec@lists.infradead.org, vgoyal@redhat.com, linn@hp.com, bp@suse.de, trenn@suse.de, chaowang@redhat.com

On Mon, Mar 24, 2014 at 09:47:20AM +0800, Dave Young wrote:
> On 03/20/14 at 09:58am, Dave Young wrote:
> > In case using crashkernel=xM,high crashkernel memory will be allocated from top to down
> > Thus the usable memory for kdump kernel could be bigger than 4G. The efi memmap value
> > is two 32 bit values efi_memmap and efi_memmap_hi, previously I only passed the efi_memmap
> > so for the high memory address there will be below kernel panic: 
> > 
> > [    0.000000] efi: EFI v2.31 by American Megatrends
> > [    0.000000] efi:  ACPI 2.0=0xdb752000  SMBIOS=0xdbab4b98  ACPI=0xdb752000  MPS=0xf4bd0 
> > [    0.000000] efi: mem00: type=4294967295, attr=0xffffffffffffffff, range=[0xffffffffffffffff-0xffffffffffffefff) (72057594037927935)
> > [    0.000000] efi: mem01: type=4294967295, attr=0xffffffffffffffff, range=[0xffffffffffffffff-0xffffffffffffefff) (72057594037927935)
> > [    0.000000] efi: mem02: type=4294967295, attr=0xffffffffffffffff, range=[0xffffffffffffffff-0xffffffffffffefff) (72057594037927935)
> > [    0.000000] efi: mem03: type=4294967295, attr=0xffffffffffffffff, range=[0xffffffffffffffff-0xffffffffffffefff) (72057594037927935)
> > [    0.000000] efi: mem04: type=4294967295, attr=0xffffffffffffffff, range=[0xffffffffffffffff-0xffffffffffffefff) (72057594037927935)
> > [    0.000000] SMBIOS 2.7 present.
> > 
> > [snip]
> > 
> > [    0.082451] BUG: unable to handle kernel paging request at ffffa3d0f0000000
> > [    0.089467] IP: [<ffffffff810513d1>] native_set_pte+0x1/0x10
> > [    0.095157] PGD 0 
> > [    0.097197] Oops: 0002 [#1] SMP 
> > [    0.100466] Modules linked in:
> > [    0.103554] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.14.0-rc7 #157
> > [    0.110001] Hardware name: Hewlett-Packard HP Z420 Workstation/1589, BIOS J61 v03.15 05/09/2013
> > [    0.118697] task: ffffffff818e1460 ti: ffffffff818ce000 task.ti: ffffffff818ce000
> > [    0.126181] RIP: 0010:[<ffffffff810513d1>]  [<ffffffff810513d1>] native_set_pte+0x1/0x10
> > [    0.134296] RSP: 0000:ffffffff818cfc80  EFLAGS: 00010287
> > [    0.139609] RAX: 0000000000000000 RBX: ffffa3d0f0000000 RCX: 00003ffffffff000
> > [    0.146744] RDX: ffff880000000000 RSI: 0000000000000000 RDI: ffffa3d0f0000000
> > [    0.153879] RBP: ffffffff818cfcb8 R08: ffffea0010745d20 R09: 0000000000000000
> > [    0.161013] R10: ffff88041f731fc0 R11: 000000000000001e R12: 0000000000200000
> > [    0.168148] R13: 0000000000000000 R14: 0000000000400000 R15: ffff880000000008
> > [    0.175288] FS:  0000000000000000(0000) GS:ffff88041f200000(0000) knlGS:0000000000000000
> > [    0.183377] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.189125] CR2: ffffa3d0f0000000 CR3: 000000041e8da000 CR4: 00000000000406b0
> > [    0.196264] Stack:
> > [    0.198283]  ffffffff818cfcb8 ffffffff810561d7 ffff880000000008 0000000000400000
> > [    0.205746]  ffff880000001000 00000000000001ff ffff88041e8de000 ffffffff818cfd00
> > [    0.213210]  ffffffff8105644e 0000000000200000 0000000040000000 00000000ffffffff
> > [    0.220676] Call Trace:
> > [    0.223130]  [<ffffffff810561d7>] ? unmap_pte_range+0x77/0x110
> > [    0.228966]  [<ffffffff8105644e>] unmap_pmd_range+0xde/0x210
> > [    0.234630]  [<ffffffff81056c6b>] __cpa_process_fault+0x48b/0x5e0
> > [    0.240730]  [<ffffffff81057276>] __change_page_attr_set_clr+0x4b6/0xb10
> > [    0.247437]  [<ffffffff810557c7>] ? __ioremap_caller+0x277/0x360
> > [    0.253454]  [<ffffffff810589f1>] kernel_map_pages_in_pgd+0x71/0xa0
> > [    0.259736]  [<ffffffff81a53361>] __map_region+0x45/0x63
> > [    0.265051]  [<ffffffff81a535cc>] efi_map_region_fixed+0xd/0xf
> > [    0.270886]  [<ffffffff81a52f19>] efi_enter_virtual_mode+0x5a/0x3d9
> > [    0.277162]  [<ffffffff81a77516>] ? acpi_enable_subsystem+0x37/0x90
> > [    0.283440]  [<ffffffff81a36eb9>] start_kernel+0x386/0x41c
> > [    0.288931]  [<ffffffff81a3693c>] ? repair_env_string+0x5c/0x5c
> > [    0.294852]  [<ffffffff81a36120>] ? early_idt_handlers+0x120/0x120
> > [    0.301035]  [<ffffffff81a365ee>] x86_64_start_reservations+0x2a/0x2c
> > [    0.307479]  [<ffffffff81a3672e>] x86_64_start_kernel+0x13e/0x14d
> > [    0.313572] Code: 66 2e 0f 1f 84 00 00 00 00 00 48 8b 46 18 55 48 89 e5 48 89 47 04 5d c3 66 90 55 48 89 e5 0f 01 f8 5d c3 0f 1f 8 
> > [    0.333545] RIP  [<ffffffff810513d1>] native_set_pte+0x1/0x10
> > [    0.339312]  RSP <ffffffff818cfc80>
> > [    0.342807] CR2: ffffa3d0f0000000
> > [    0.346141] ---[ end trace 86088f739725b8c6 ]---
> > [    0.350760] Kernel panic - not syncing: Fatal exception
> > 
> > Fix this by passing both efi_memmap and efi_memmap_hi to 2nd kernel.
> > 
> > Reported-by: Linn Crosetto <linn@hp.com>
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > Tested-by: Linn Crosetto <linn@hp.com>
> > ---
> >  kexec/arch/i386/x86-linux-setup.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Index: kexec-tools/kexec/arch/i386/x86-linux-setup.c
> > ===================================================================
> > --- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
> > +++ kexec-tools/kexec/arch/i386/x86-linux-setup.c
> > @@ -656,7 +656,8 @@ static int setup_efi_data(struct kexec_i
> >  	size = nr_maps * sizeof(struct efi_mem_descriptor);
> >  	memmap_paddr = add_buffer(info, maps, size, size, getpagesize(),
> >  					0x100000, ULONG_MAX, INT_MAX);
> > -	ei->efi_memmap = memmap_paddr;
> > +	ei->efi_memmap = memmap_paddr & 0xffffffff;
> > +	ei->efi_memmap_hi = memmap_paddr >> 32;
> >  	ei->efi_memmap_size = size;
> >  	ei->efi_memdesc_size = sizeof(struct efi_mem_descriptor);
> >  
> > 
> 
> Hi, Simon
> 
> Seems there's no objections, it's a obvious code fix, could you review it?

Thanks, Applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
