Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KclVg-0001kD-Ag
	for kexec@lists.infradead.org; Mon, 08 Sep 2008 18:30:49 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by relay1.corp.sgi.com (Postfix) with ESMTP id A75C78F809C
	for <kexec@lists.infradead.org>; Mon,  8 Sep 2008 11:30:46 -0700 (PDT)
Received: from kluge.engr.sgi.com (kluge.engr.sgi.com [192.102.96.102])
	by cthulhu.engr.sgi.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id
	m88IUkVw031280
	for <kexec@lists.infradead.org>; Mon, 8 Sep 2008 11:30:46 -0700
Message-ID: <48C56F55.5000503@sgi.com>
Date: Mon, 08 Sep 2008 11:30:45 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: IA64: copying /proc/vmcore caused kernel MCA'ed
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
To: kexec@lists.infradead.org

When trying to do 'cp /proc/vmcore ...', the kdump kernel MCA'ed.

KDB showed me this backtrace: (it is really nice to have kdb working
with kdump :))

Entering kdb (current=0xe000003032570000, pid 3519) on processor 0 due
to KDB_ENTER()
[0]kdb> bt
Stack traceback for pid 3519
0xe000003032570000     3519     3502  0    0   R  0xe0000030325703a0 *cp
0xa00000010000c720 ia64_native_leave_kernel
0xa00000010047d770 __copy_user+0x570
        args (0x600fffffff9f4fb4, 0xe000003000080000, 0xb04c)
0xa000000100061b70 copy_oldmem_page+0xb0
        args (0xe000003000080000, 0x600fffffff9f4fb4, 0xb04c, 0x0, 0x1,
0xa00000010021c1c0, 0x50f, 0x3)
0xa00000010021c1c0 read_from_oldmem+0xe0
        args (0x600fffffffa00000, 0x0, 0xe00000303257fe20, 0x1, 0xb04c,
0x300009, 0xb04c, 0xa00000010021c480, 0x50e)
0xa00000010021c480 read_vmcore+0x260
        args (0xe0000030350de500, 0x600fffffffa00000, 0xb04c,
0xe00000303257fe38, 0xe000003037fa4e80, 0x0, 0x10000,
0xa00000010020a000, 0x48d)
0xa00000010020a000 proc_reg_read+0x120
        args (0xe0000030350de500, 0x600fffffff9f0000, 0x10000,
0xe00000303257fe38, 0xfffffffffffffffb, 0xe0000030194f1440,
0xa00000010017f6f0, 0x50f, 0xa000000100fcc510)
0xa00000010017f6f0 vfs_read+0x1b0
        args (0xe0000030350de500, 0x600fffffff9f0000, 0x10000,
0xe00000303257fe38, 0x0, 0x3, 0x0, 0xa00000010017fcf0, 0x793)
0xa00000010017fcf0 sys_read+0x70
        args (0x3, 0x600fffffff9f0000, 0x10000, 0x10000,
0x4000000000007a80, 0xc000000000000916, 0x600000000000b370, 0x4,
0xe0000030350de538)
0xa00000010000c580 ia64_ret_from_syscall
        args (0x3, 0x600fffffff9f0000, 0x10000, 0x10000)
0xa000000000010720 __kernel_syscall_via_break
        args (0x3, 0x600fffffff9f0000, 0x10000, 0x10000)
[0]kdb>


The instruction that MCA'ed the system was trying to read from
vmcore at address 0x3000080000. The address comes from the
vmcore_list:
<4>vmcore_init: elfcorehdr_addr=3037fc0000
<4>Printing vmcore_list...
<4>     paddr=307b8b0800, size=48c
<4>     paddr=307b8b1000, size=48c
<4>     paddr=30151da898, size=4bc
<4>     paddr=3014000000, size=825d90
<4>     paddr=3000080000, size=380000       <===== this one
<4>     paddr=3003000000, size=3000000
<4>     paddr=3006000000, size=e000000
<4>     paddr=3014000000, size=1295000
<4>     paddr=3015295000, size=2d6b000
<4>     paddr=3038000000, size=41ef8000
<4>     paddr=3079ef8000, size=4fc000
<4>     paddr=307a3f4000, size=5e000
<4>     paddr=307a452000, size=3ac000
<4>     paddr=307b800000, size=1000
<4>     paddr=307b801000, size=135000
<4>     paddr=307b936000, size=6000
<4>     paddr=307b93c000, size=2000
<4>     paddr=307b93e000, size=6000
<4>     paddr=307b944000, size=1000
<4>     paddr=307b945000, size=b9000
<4>     paddr=307b9fe000, size=35a000
<4>     paddr=307bd92000, size=6c000
<4>     paddr=307bdfe000, size=12000
<4>     paddr=307be7e000, size=4000
<4>End of vmcore_list...

However, memmap from efi indicated that memory region is
not accessible (attribute is 1).

Shell> memmap

Type       Start            End               # Pages          Attributes
PAL_code   0000000001000000-0000000001FFFFFF  0000000000001000
8000000000000009
MemMapIO   00000000FF800000-00000000FFFFFFFF  0000000000000800
8000000000000001
MemMapIO   0000000800000000-0000000FFFFFFFFF  0000000000800000
8000000000000001
Unusable   0000003000000000-000000300000FFFF  0000000000000010
0000000000000009
RT_data    0000003000010000-000000300007FFFF  0000000000000070
8000000000001001
BS_data    0000003000080000-00000030003FFFFF  0000000000000380
0000000000000001
RT_data    0000003000400000-0000003001FFFFFF  0000000000001C00
8000000000001009
RT_data    0000003002000000-0000003002FFFFFF  0000000000001000
8000000000000009
BS_data    0000003003000000-0000003005FFFFFF  0000000000003000
0000000000000009
available  0000003006000000-000000307A451FFF  0000000000074452
0000000000000009
BS_data    000000307A452000-000000307A7FDFFF  00000000000003AC
0000000000000009
RT_data    000000307A7FE000-000000307B7FFFFF  0000000000001002
8000000000000009
BS_data    000000307B800000-000000307B800FFF  0000000000000001
0000000000000009
available  000000307B801000-000000307B92BFFF  000000000000012B
0000000000000009
BS_data    000000307B92C000-000000307B943FFF  0000000000000018
0000000000000009
available  000000307B944000-000000307B944FFF  0000000000000001
0000000000000009
BS_data    000000307B945000-000000307B9FDFFF  00000000000000B9
0000000000000009
available  000000307B9FE000-000000307BD57FFF  000000000000035A
0000000000000009
RT_code    000000307BD58000-000000307BD91FFF  000000000000003A
8000000000000009
BS_code    000000307BD92000-000000307BDFDFFF  000000000000006C
0000000000000009
available  000000307BDFE000-000000307BE0FFFF  0000000000000012
0000000000000009
RT_code    000000307BE10000-000000307BE7DFFF  000000000000006E
8000000000000009
available  000000307BE7E000-000000307BE83FFF  0000000000000006
0000000000000009
RT_data    000000307BE84000-000000307BFFFFFF  000000000000017C
8000000000000009
MemPortIO  1FFFFFFFFC000000-1FFFFFFFFFFFFFFF  0000000000004000
8000000000000001

  BS_code   :     108 Pages (442,368)
  BS_data   :  14,334 Pages (58,712,064)
  RT_code   :     168 Pages (688,128)
  RT_data   :  15,854 Pages (64,937,984)
  available : 477,424 Pages (1,955,528,704)
  Unusable  :      16 Pages (65,536)
  MemMapIO  : 8,390,656 Pages (34,368,126,976)
  MemPortIO :  16,384 Pages (67,108,864)
  PAL_code  :   4,096 Pages (16,777,216)
Total Memory: 1,999 MB (2,097,086,464) Bytes

Shell>


Again, the vmcore_list prints: (i added the debugging at the end of
parse_crash_elf64_headers() routine in fs/proc/vmcore.c):
<4>Printing vmcore_list...
<4>     paddr=307b8b0800, size=48c
<4>     paddr=307b8b1000, size=48c
<4>     paddr=30151da898, size=4bc
<4>     paddr=3014000000, size=825d90
<4>     paddr=3000080000, size=380000       <===== this one
...



Any input helping me speed up debugging is appreciated.

Thanks.
 - jay


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
