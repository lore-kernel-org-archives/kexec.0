Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx03.syneticon.net ([87.79.32.166])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K22xK-0003AS-Hw
	for kexec@lists.infradead.org; Fri, 30 May 2008 11:39:35 +0000
Message-ID: <483FE764.1090901@wpkg.org>
Date: Fri, 30 May 2008 13:39:16 +0200
From: Tomasz Chmielewski <mangoo@wpkg.org>
MIME-Version: 1.0
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org>
	<200805291347.05196.nschichan@freebox.fr>
	<483F0EF3.3060500@wpkg.org>
	<200805301327.11925.nschichan@freebox.fr>
In-Reply-To: <200805301327.11925.nschichan@freebox.fr>
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
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: linux-mips@linux-mips.org, openwrt-devel@lists.openwrt.org, Kexec Mailing List <kexec@lists.infradead.org>

Nicolas Schichan schrieb:
> On Thursday 29 May 2008 22:15:47 Tomasz Chmielewski wrote:
>> # kexec -e
>> b44: eth0: powering down PHY
>> Starting new kernel
>> Will call new kernel at 00305000
> 
> The calling address of the kernel looks quite wrong, it should clearly
> be inside the KSEG0 zone. could  you please indicate the output of the
> command "mips-linux-readelf -l vmlinux" ?

# uname -m
mips
# readelf -l vmlinux

Elf file type is EXEC (Executable file)
Entry point 0x80251b50
There are 2 program headers, starting at offset 52

Program Headers:
   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
   LOAD           0x001000 0x80001000 0x80001000 0x2dd07a 0x303250 RWE 
0x2000
   NOTE           0x000000 0x00000000 0x00000000 0x00000 0x00000 R   0x4

  Section to Segment mapping:
   Segment Sections...
    00     .text __ex_table __dbe_table .rodata .pci_fixup __ksymtab 
__ksymtab_gpl __ksymtab_strings __param .data .data.cacheline_aligned 
.init.text .init.data .init.setup .initcall.init .con_initcall.init 
.exit.text .init.ramfs .bss
    01

-- 
Tomasz Chmielewski
http://wpkg.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
