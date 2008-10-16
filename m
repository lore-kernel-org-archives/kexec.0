Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kqcjs-0007wZ-Lk
	for kexec@lists.infradead.org; Thu, 16 Oct 2008 23:58:45 +0000
Received: from G6W0641.americas.hpqcorp.net (g6w0641.atlanta.hp.com
	[16.230.34.77]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by g4t0014.houston.hp.com (Postfix) with ESMTPS id 5A96C2425B
	for <kexec@lists.infradead.org>; Thu, 16 Oct 2008 23:58:41 +0000 (UTC)
From: "Worth, Kevin" <kevin.worth@hp.com>
Date: Thu, 16 Oct 2008 23:57:31 +0000
Subject: kexec/kdump produces incomplete dump files with kernel 2.6.20 +
	CONFIG_HIGHMEM64G
Message-ID: <28113A0489833849A1CF9EC16F421543464A62812E@GVW1097EXB.americas.hpqcorp.net>
References: <28113A0489833849A1CF9EC16F421543464A6279DA@GVW1097EXB.americas.hpqcorp.net>
	<1440009088.1218741224162685092.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: kexec-ml <kexec@lists.infradead.org>

Moving this back to the kexec mailing list because I think I now have more detail on this and Dave Anderson has confirmed that this doesn't really look like an issue with the program "crash", but rather an issue with the data inside the dump file (specifically the vmalloc'ed memory).

A quick recap- I have a kernel based on Ubuntu's 2.6.20-17-generic (http://packages.ubuntu.com/feisty/linux-source-2.6.20) with only a couple things changed- the VMSPLIT is changed so that there is 1G userspace / 3G kernelspace, and HIGHMEM64G is set to y (CONFIG_RESOURCES_64BIT is set to y as a side-effect, and note that it was experimental as of 2.6.20). When I go to analyze a dump in crash, I get "WARNING: cannot access vmalloc'd module memory". My original email to this list before I took it to the crash mailing list for a while is at http://lists.infradead.org/pipermail/kexec/2008-October/002664.html .

After doing a little variable elimination, it appears that it's the HIGHMEM64G that is causing my troubles... I compiled a kernel with VMSPLIT (and thus PAGE_OFFSET) unmodified from the default. All along I was looking suspiciously at that (since it is much more non-standard) while I ignored the fact that my HIGHMEM setting was also changed from the Ubuntu "generic" kernel (though I believe the Ubuntu "server" kernel uses HIGHMEM64G).

I have tried this with Ubuntu's packaged kexec-tools (20070330), and yesterday I tried kexec-tools 2.0, and also built from the current GIT repository. No changes in results. At this point my understanding is that it's probably either an issue with the 2.6.20 kernel or it is an undiscovered issue with kexec-tools.

I guess one question this leads me to is "I have 4GB of memory, but with HIGHMEM4G set, /dev/meminfo and free only report 3GB. Am I sacrificing 1GB of memory if I run without HIGHMEM64G?" From what /proc/meminfo and free tell me, yes. If that is the case, I need to keep chasing this issue.

On a related note, Ken'ichi recently made some changes to makedumpfile to account for the way vmalloc'ed memory is handled. I don't know enough about the kernel memory system to have a clue whether this could indicate that kexec-tools need some sort of update as well. http://makedumpfile.cvs.sourceforge.net/viewvc/makedumpfile/makedumpfile/makedumpfile.c?revision=1.128&view=markup has Ken'ichi's description of the change he made. Note that I'm not actually using makedumpfile at the moment in my capture script. To eliminate that as a possible variable, I'm simply doing a "cp /proc/vmcore /var/crash/vmcore".

As something that's possibly a side-note, when trying to use the HIGHMEM64G kernel as my "dump capture" kernel, when it's loading the kernel, it gives a ton of errors and appears to be stuck in an infinite loop of errors, the main one of which is:

[   77.695105] bad: scheduling from the idle thread!
[   77.751391]  [<c110495a>] show_trace_log_lvl+0x1a/0x30
[   77.813113]  [<c1105012>] show_trace+0x12/0x20
[   77.866523]  [<c11050c6>] dump_stack+0x16/0x20
[   77.919934]  [<c12fdfa5>] __sched_text_start+0x935/0xa90
[   77.983735]  [<c12fe91a>] schedule_timeout+0x4a/0xc0
[   78.043379]  [<c12fe2c3>] io_schedule_timeout+0x23/0x30
[   78.106140]  [<c1162d71>] congestion_wait+0x71/0x90
[   78.164747]  [<c1161d82>] try_to_free_pages+0x1f2/0x270
[   78.227508]  [<c115d0c9>] __alloc_pages+0x129/0x320
[   78.286114]  [<c11596ef>] generic_file_buffered_write+0x14f/0x620
[   78.359270]  [<c1159e7c>] __generic_file_aio_write_nolock+0x2bc/0x5a0
[   78.436578]  [<c115a1b3>] generic_file_aio_write+0x53/0xc0
[   78.502457]  [<c1177fcd>] do_sync_write+0xcd/0x110
[   78.560023]  [<c11788a1>] vfs_write+0xb1/0x180
[   78.613431]  [<c1178fdd>] sys_write+0x3d/0x70
[   78.665797]  [<c13fd8da>] do_copy+0x8a/0xc0
[   78.716086]  [<c13fad1d>] write_buffer+0x1d/0x30
[   78.771575]  [<c13fadca>] flush_window+0x8a/0xe0
[   78.827061]  [<c13fb333>] inflate_codes+0x513/0x560
[   78.885665]  [<c13fc572>] inflate_dynamic+0x662/0x8d0
[   78.946349]  [<c13fd0a4>] unpack_to_rootfs+0x784/0x940
[   79.008071]  [<c13fd2ad>] early_populate_rootfs+0x4d/0x60
[   79.072906]  [<c13f7985>] start_kernel+0x375/0x440
[   79.130471]  [<00000000>] 0x0
...

Since that didn't work, I used the Ubuntu 2.6.20-17-generic for my "dump capture" kernel as I had previously.


Live system w/ HIGHMEM64G + normal VMSPLIT. Shows that there IS data there to be read.

      KERNEL: vmlinux-normalvmsplit
    DUMPFILE: /dev/crash
        CPUS: 2
        DATE: Thu Oct 16 16:14:35 2008
      UPTIME: 00:02:10
LOAD AVERAGE: 0.16, 0.06, 0.01
       TASKS: 58
    NODENAME: test-machine
     RELEASE: 2.6.20-17.39-custom2
     VERSION: #5 SMP Thu Oct 16 14:39:15 PDT 2008
     MACHINE: i686  (2200 Mhz)
      MEMORY: 5 GB
         PID: 4302
     COMMAND: "crash"
        TASK: dd481560  [THREAD_INFO: dfb4a000]
         CPU: 1
       STATE: TASK_RUNNING (ACTIVE)

crash> p modules
modules = $2 = {
  next = 0xf8c3ea04,
  prev = 0xf8842104
}
crash> module 0xf8c3ea00
struct module {
  state = MODULE_STATE_LIVE,
  list = {
    next = 0xf8ca8704,
    prev = 0xc03c63a4
  },
  name = "crash\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000",
  mkobj = {
    kobj = {
      k_name = 0xf8c3ea4c "crash",
      name = "crash\000\000\000\000\000\000\000\000\000\000\000\000\000\000",
      kref = {
        refcount = {
          counter = 3
        }
      },
      entry = {
        next = 0xc03c6068,
        prev = 0xf8ca8764
      },
      parent = 0xc03c6074,
crash> vtop 0xf8c3ea00
VIRTUAL   PHYSICAL
f8c3ea00  13e31ea00

PAGE DIRECTORY: c044b000
  PGD: c044b018 => 4001
  PMD:     4e30 => 1d53c067
  PTE: 1d53c1f0 => 13e31e163
 PAGE: 13e31e000

   PTE     PHYSICAL   FLAGS
13e31e163  13e31e000  (PRESENT|RW|ACCESSED|DIRTY|GLOBAL)

  PAGE     PHYSICAL   MAPPING    INDEX CNT FLAGS
c77c63c0  13e31e000         0    753585  1 80000000
crash> read -p 13e31e163 30
crash: command not found: read
crash> rd -p 13e31e163 30
13e31e163:  e9c74e92 ffffff29 e8e8458b c74e004d   .N..)....E..M.N.
13e31e173:  ffff1ce9 000000ff 00000000 60b85500   .............U.`
13e31e183:  89f8c3e9 7f13e8e5 c35dc760 3e333c00   ........`.]..<3>
13e31e193:  73617263 656d2068 79726f6d 69726420   crash memory dri
13e31e1a3:  3a726576 6e616320 20746f6e 6373696d   ver: cannot misc
13e31e1b3:  6765725f 65747369 4d282072 5f435349   _register (MISC_
13e31e1c3:  414e5944 5f43494d 4f4e494d 000a2952   DYNAMIC_MINOR)..
13e31e1d3:  3e363c00 73617263                     .<6>cras
crash>



Dump file captured using kexec/kdump:


WARNING: cannot access vmalloc'd module memory

      KERNEL: vmlinux-normalvmsplit
    DUMPFILE: /var/crash/vmcore-normalvmsplit
        CPUS: 2
        DATE: Thu Oct 16 16:15:46 2008
      UPTIME: 00:03:20
LOAD AVERAGE: 0.05, 0.04, 0.01
       TASKS: 58
    NODENAME: test-machine
     RELEASE: 2.6.20-17.39-custom2
     VERSION: #5 SMP Thu Oct 16 14:39:15 PDT 2008
     MACHINE: i686  (2200 Mhz)
      MEMORY: 5 GB
       PANIC: "[  200.496000] SysRq : Trigger a crashdump"
         PID: 0
     COMMAND: "swapper"
        TASK: c03c0440  (1 of 2)  [THREAD_INFO: c03f2000]
         CPU: 0
       STATE: TASK_RUNNING (SYSRQ)

crash> p modules
modules = $2 = {
  next = 0xf8c3ea04,
  prev = 0xf8842104
}
crash> module 0xf8c3ea00
struct module {
  state = MODULE_STATE_LIVE,
  list = {
    next = 0x0,
    prev = 0x0
  },
  name = "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0
00\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0
00\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0
00\000",
  mkobj = {
    kobj = {
      k_name = 0x0,
      name = "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0
00\000\000",
      kref = {
        refcount = {
          counter = 0
        }
      },
      entry = {
        next = 0x0,
        prev = 0x0
crash> vtop 0xf8c3ea00
VIRTUAL   PHYSICAL
f8c3ea00  13e31ea00

PAGE DIRECTORY: c044b000
  PGD: c044b018 => 4001
  PMD:     4e30 => 1d53c067
  PTE: 1d53c1f0 => 13e31e163
 PAGE: 13e31e000

   PTE     PHYSICAL   FLAGS
13e31e163  13e31e000  (PRESENT|RW|ACCESSED|DIRTY|GLOBAL)

  PAGE     PHYSICAL   MAPPING    INDEX CNT FLAGS
c77c63c0  13e31e000         0    753585  1 80000000
crash> rd -p 13e31e163
13e31e163:  00000000                              ....
crash> rd -p 13e31e163 30
13e31e163:  00000000 00000000 00000000 00000000   ................
13e31e173:  00000000 00000000 00000000 00000000   ................
13e31e183:  00000000 00000000 00000000 00000000   ................
13e31e193:  00000000 00000000 00000000 00000000   ................
13e31e1a3:  00000000 00000000 00000000 00000000   ................
13e31e1b3:  00000000 00000000 00000000 00000000   ................
13e31e1c3:  00000000 00000000 00000000 00000000   ................
13e31e1d3:  00000000 00000000                     ........
crash>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
