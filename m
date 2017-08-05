Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1de7lH-0006KC-Q8
 for kexec@lists.infradead.org; Sat, 05 Aug 2017 22:41:37 +0000
Received: by mail-yw0-x243.google.com with SMTP id t139so2981478ywg.1
 for <kexec@lists.infradead.org>; Sat, 05 Aug 2017 15:41:15 -0700 (PDT)
From: Bradley Bolen <bradleybolen@gmail.com>
Subject: [PATCH] makedumpfile: arm64: Fix page table walk of 1GB section
Date: Sat,  5 Aug 2017 18:41:06 -0400
Message-Id: <20170805224107.4966-1-bradleybolen@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: panand@redhat.com, Bradley Bolen <bradleybolen@gmail.com>


Using an arm64 board, 2GB of memory, makedumpfile 1.6.2, and the v4.11 kernel,
I ran into an issue where the dumpfile was not excluding any pages thus
creating a huge vmcore.

I found that my board had a 1GB mapping in the PGD of 0xffffffc040000000. This
isn't my area of expertise but I think I've pieced together how the kernel
handles page tables.

cat /proc/kallsyms |grep swapper_pg
ffffff8008a66000 B swapper_pg_dir

00a66800: 7fff9003 // pgd for virtual addr 0xffffffc000000000
00a66804: 00000000
00a66808: 40000711 // pgd for virtual addr 0xffffffc040000000
00a6680c: 00e80000

If I understand everything correctly then the pgd at 0xa66808 is a section and
not a pointer to a PMD, thus it should have been handled as a section instead
of trying to drill down to a PTE by the code in arch/arm64.c

Please find debug below and a proposed (probably not optimal) fix attached.

Thank you.

/usr/sbin/makedumpfile -F -c -d 31 --message-level=31 /proc/vmcore > /dev/null
sadump: unsupported architecture
LOAD (0)
phys_start : 80000
phys_end : a58000
virt_start : ffffff8008080000
virt_end : ffffff8008a58000
LOAD (1)
phys_start : 0
phys_end : 6000000
virt_start : ffffffc000000000
virt_end : ffffffc006000000
LOAD (2)
phys_start : 6800000
phys_end : 8000000
virt_start : ffffffc006800000
virt_end : ffffffc008000000
LOAD (3)
phys_start : a000000
phys_end : 80000000
virt_start : ffffffc00a000000
virt_end : ffffffc080000000
Linux kdump
page_size : 4096
phys_base : 0

max_mapnr : 80000
There is enough free memory to be done in one cycle.

Buffer size for the cyclic mode: 131072
kimage_voffset : ffffff8008000000
max_physmem_bits : 30
section_size_bits: 1e
page_offset : ffffffc000000000

num of NODEs : 1

Memory type : SPARSEMEM_EX

readmem: Can't convert a virtual address(ffffffc07fff6000) to physical address.
readmem: type_addr: 0, addr:ffffffc07fff6000, size:16
section_mem_map_addr: Can't get a struct mem_section(ffffffc07fff6000).
mem_map (0)
mem_map : 0
pfn_start : 0
pfn_end : 40000
readmem: Can't convert a virtual address(ffffffc07fff6010) to physical address.
readmem: type_addr: 0, addr:ffffffc07fff6010, size:16
section_mem_map_addr: Can't get a struct mem_section(ffffffc07fff6010).
mem_map (1)
mem_map : 0
pfn_start : 40000
pfn_end : 80000
mmap() is available on the kernel.
Checking for memory holes : [100.0 %] | STEP [Checking for memory holes ] :
0.017147 seconds
Excluding unnecessary pages : [100.0 %] \ STEP [Excluding unnecessary pages] :
0.000034 seconds

Bradley Bolen (1):
  makedumpfile: arm64: Fix page table walk of 1GB section

 arch/arm64.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
1.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
