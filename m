Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kmvv9-0002IL-RR
	for kexec@lists.infradead.org; Mon, 06 Oct 2008 19:39:08 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m96Jd7fc020455
	for <kexec@lists.infradead.org>; Mon, 6 Oct 2008 15:39:07 -0400
Date: Mon, 6 Oct 2008 15:39:05 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <2000408380.786281223321945939.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1077541243.786041223321889818.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
Subject: Re: [Crash-utility] "cannot access vmalloc'd module memory" when
	loading kdump'ed vmcore in crash
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
To: "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Cc: kexec-ml <kexec@lists.infradead.org>


----- "Kevin Worth" <kevin.worth@hp.com> wrote:

> Dave,
> 
> That does seem pretty strange that the physical address is coming out
> beyond the 4GB mark and that the read actually succeeds. Just checked
> on the Ubuntu patches to the 2.6.20 kernel (
> http://archive.ubuntu.com/ubuntu/pool/main/l/linux-source-2.6.20/linux-source-2.6.20_2.6.20-17.39.diff.gz
> ) and no mention of mem.c or either of those two functions.


Hmmm -- I do see one thing with the /dev/mem driver that could
be an explanation.  Maybe...

Prior to the read() call to /dev/mem, crash does an llseek() to
the target physical address, which gets stored in the open file
structure's file.f_pos member, which is a 64-bit loff_t.  Then when
the subsequent read() call is made, the file.f_pos member gets 
passed by reference to the /dev/mem driver's read_mem() function 
via the "ppos" argument: 
 
  static ssize_t read_mem(struct file * file, char __user * buf,
                          size_t count, loff_t *ppos)
  {
          unsigned long p = *ppos;
          ssize_t read, sz;
          char *ptr;
  
          if (!valid_phys_addr_range(p, count))
                  return -EFAULT;
  
But its value is then pulled from *ppos into a 32-bit unsigned long 
"p" variable, which is what gets used from then on.  So it looks like
the high 1-bit from a greater-than-4GB (0x100000000) physical address 
would get stripped, and therefore would erroneously bypass the 
valid_phys_addr_range() check.

So in your case, physical addresses from ~3GB-up-to-4GB would 
be rejected, but those at and above 4GB would be inadvertently
accepted.  However, if that were the case, the *wrong* physical address
would be accessed -- but your "module" reads seemingly return the correct
data!  So I still don't get it...

I haven't tinkered with the 32-bit /dev/mem driver in years, because 
Red Hat not only has the "high_memory" restriction, it also has a 
devmem_is_allowed() function that further restricts /dev/mem to the 
first 256 pages (1MB) of physical memory.  (I note that upstream kernels
have recently added a CONFIG_STRICT_DEVMEM config option to do the same 
thing.)  And, FYI, the Red Hat /dev/crash "replacement-for-/dev/mem" driver 
correctly reads *ppos into a u64.

So when you test this again on your live system, after printing the
module via "p <virtual-address-of-module>", do a vtop of the 
<virtual-address-of-module>, take the translated-to physical address
and dump it to verify the contents.  Like this:
  
  crash> p modules
  modules = $2 = {
    next = 0xf8bf5904, 
    prev = 0xf8836004
  }
  crash> module 0xf8bf5900
  struct module {
    state = MODULE_STATE_LIVE, 
    list = {
      next = 0xf8a60d84, 
      prev = 0xc06787b0
    }, 
    name = "crash"
    mkobj = {
      kobj = {
        k_name = 0xf8bf594c "crash", 
        name = "crash", 
        kref = {
          refcount = {
            counter = 2
          }
        }, 
    ...
  crash> vtop 0xf8bf5900
  VIRTUAL   PHYSICAL
  f8bf5900  2412c900
  ...
  crash> rd -p 2412c900 30
  2412c900:  00000000 f8a60d84 c06787b0 73617263   ..........g.cras
  2412c910:  00000068 00000000 00000000 00000000   h...............
  2412c920:  00000000 00000000 00000000 00000000   ................
  2412c930:  00000000 00000000 00000000 00000000   ................
  2412c940:  00000000 00000000 f8bf594c 73617263   ........LY..cras
  2412c950:  00000068 00000000 00000000 00000000   h...............
  2412c960:  00000002 c06783e8 f8a60de4 c06783f4   ......g.......g.
  2412c970:  c06783e0 00000000                     ..g.....
  crash>

Lastly, try this set of crash commands on your live system:
  
  rd -p 0
  rd -p 0x20000000
  rd -p 0x40000000
  rd -p 0x60000000
  rd -p 0x80000000
  rd -p 0xa0000000
  rd -p 0xb8000000
  rd -p 0xc0000000
  rd -p 0xe0000000
  rd -p 0x100000000
  rd -p 0x120000000
  rd -p 0x140000000
  
Theoretically, anything at and above 0xb8000000 should fail.  

> Let me try the kexec PAGE_OFFSET modification today or tomorrow and
> reply back on how it goes. If that produces no change I'll try do a
> re-run of the previous email's process with some more careful
> attention paid (that I get a vtop of everything and that my context
> examples are the same process).

OK fine...

Thanks,
  Dave

 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
