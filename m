Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USSnE-0005CZ-8n
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 13:53:01 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: reserved crash memory above #define DEFAULT_BZIMAGE_ADDR_MAX
 0x37FFFFFF
Date: Wed, 17 Apr 2013 15:52:13 +0200
Message-ID: <3354091.h1CDj18vOb@skinner.arch.suse.de>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com, yinghai@kernel.org

Hi,

while trying to switch to kvm setup with a latest kernel I realized that
blank:
crashkernel=64M
param will reserve this memory area:
7b000000-7effffff : Crash kernel

and kexec does not successfully load the kernel due to (hole_max output
added myself):
Could not find a free area of memory of 4c1000 bytes, hole_max: 0x37ffffff...
locate_hole failed

Defining the place where to set crashmemory area:
crashkernel=64M@32M
02000000-05ffffff : Crash kernel

works.

I finally found out that in kexec-tools include/x86/x86-linux.h:
#define DEFAULT_BZIMAGE_ADDR_MAX 0x37FFFFFF
is defined and it looks like new kernels try to place the crashmemory
area too high.

So the kexec-tools max physical address seem to be 0x37FFFFFF
while the kernel seem to search a free region for crash kernel reservation
up to MAX_MEM.
Damn, after doing a git pull, I run into an other unrelated bug and I could
not quickly test below which I think could fix this (copy and pasted):

--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -511,7 +511,8 @@ static void __init 
memblock_x86_reserve_range_setup_data(void)
 #ifdef CONFIG_X86_32
 # define CRASH_KERNEL_ADDR_MAX (512 << 20)
 #else
-# define CRASH_KERNEL_ADDR_MAX MAXMEM
+# define KEXEC_BZIMAGE_MAX_ADDR 0x37FFFFFF
+# define CRASH_KERNEL_ADDR_MAX KEXEC_BZIMAGE_MAX_ADDR
 #endif
 

So I see no error/warning when crashkernel area is reserved in dmesg:
Reserving 64MB of memory at 1968MB for crashkernel (System RAM: 2047MB)
but it won't work.

         Thomas

kexec backtrace from the error message in add_buffer.
(gdb) bt
#0  locate_hole (info=0x7fffffffe0b0, hole_size=4984832, hole_align=16777216, 
    hole_min=1048576, hole_max=939524095, hole_end=1) at kexec/kexec.c:290
#1  0x0000000000402d40 in add_buffer_phys_virt (info=0x7fffffffe0b0, 
    buf=0x7ffff6a19410, bufsz=4982070, memsz=4984832, buf_align=16777216, 
    buf_min=1048576, buf_max=939524095, buf_end=1, phys=0) at 
kexec/kexec.c:372
#2  0x0000000000402dee in add_buffer_virt (info=0x7fffffffe0b0, 
    buf=0x7ffff6a19410, bufsz=4982070, memsz=4982070, buf_align=16777216, 
    buf_min=1048576, buf_max=939524095, buf_end=1) at kexec/kexec.c:386
#3  0x000000000040ae7d in add_buffer (info=0x7fffffffe0b0, buf=0x7ffff6a19410, 
    bufsz=4982070, memsz=4982070, buf_align=16777216, buf_min=1048576, 
    buf_max=939524095, buf_end=1) at kexec/add_buffer.c:12
#4  0x000000000040bfb8 in do_bzImage_load (info=0x7fffffffe0b0, 
    kernel=0x7ffff6a15010 "MZ\352\a", kernel_len=4999478, 
    command_line=0x63d120 " root=UUID=f998139a-57d9-422d-af05-159d4e1187ab 
sysrq_always_enabled panic=10 console=ttyS0,115200 resume=/dev/vda1  quiet  
rd_NO_PLYMOUTH transparent_hugepage=never elevator=deadline sysrq=1 
reset_de"..., 
    command_line_len=276, initrd=0x7ffff4b34010 "\037\213\b", 
    initrd_len=32374921, real_mode_entry=0)
    at kexec/arch/i386/kexec-bzImage.c:286
#5  0x000000000040c5ca in bzImage_load (argc=6, argv=0x7fffffffe318, 
    buf=0x7ffff6a15010 "MZ\352\a", len=4999478, info=0x7fffffffe0b0)
    at kexec/arch/i386/kexec-bzImage.c:447
#6  0x0000000000403cf1 in my_load (type=0x0, fileind=5, argc=6, 
    argv=0x7fffffffe318, kexec_flags=1, entry=0x0) at kexec/kexec.c:725
#7  0x0000000000404b7a in main (argc=6, argv=0x7fffffffe318)
    at kexec/kexec.c:1223

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
