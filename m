Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KoNik-0000e9-5H
	for kexec@lists.infradead.org; Fri, 10 Oct 2008 19:32:18 +0000
From: "Worth, Kevin" <kevin.worth@hp.com>
Date: Fri, 10 Oct 2008 19:31:24 +0000
Subject: RE: [Crash-utility] "cannot access vmalloc'd module memory" when
	loading kdump'ed vmcore in crash
Message-ID: <28113A0489833849A1CF9EC16F4215434649BCD05A@GVW1097EXB.americas.hpqcorp.net>
References: <1077541243.786041223321889818.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
	<2000408380.786281223321945939.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2000408380.786281223321945939.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
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
To: "Discussion list for crash utility usage,	maintenance and development" <crash-utility@redhat.com>
Cc: kexec-ml <kexec@lists.infradead.org>

Hi Dave,

I tried changing the PAGE_OFFSET definition in kexec-tools. Didn't seem to affect it- crash still fails to load the vmalloc'ed memory. If that seems like it absolves kexec-tools of any sins then perhaps we can drop the kexec-ml off the CC list.

Your statement "Theoretically, anything at and above 0xb8000000 should fail." was accurate, which I saw on my live system (with no dump involved). Hoping this provides some insight.

-Kevin


crash> p modules
modules = $2 = {
  next = 0xf9102284,
  prev = 0xf8842104
}

crash> module 0xf9102280
struct module {
  state = MODULE_STATE_LIVE,
  list = {
    next = 0xf9073d84,
    prev = 0x403c63a4
  },
  name = "custom_lkm\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00
0\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00
0\000\000\000\000\000\000\000\000\000\000\000\000\000",
  mkobj = {
    kobj = {
      k_name = 0xf91022cc "custom_lkm",
      name = "custom_lkm\000\000\000\000\000\000\000\000",
      kref = {
        refcount = {
          counter = 3
        }
      },
      entry = {
        next = 0x403c6068,
        prev = 0xf9073de4
      },
      parent = 0x403c6074,
 -- MORE --  forward: <SPACE>, <ENTER> or j  backward: b or k  quit: q

crash> vtop 0xf9102280
VIRTUAL   PHYSICAL
f9102280  119b76280

PAGE DIRECTORY: 4044b000
  PGD: 4044b018 => 6001
  PMD:     6e40 => 1d515067
  PTE: 1d515810 => 119b76163
 PAGE: 119b76000

   PTE     PHYSICAL   FLAGS
119b76163  119b76000  (PRESENT|RW|ACCESSED|DIRTY|GLOBAL)

crash> rd -p 119b76000 30
rd: read error: physical address: 119b76000  type: "32-bit PHYSADDR"

crash> rd -p 0
       0:  00000001                              ....

crash> rd -p 0x20000000
20000000:  00000000                              ....

crash> rd -p 0x40000000
40000000:  00000000                              ....

crash> rd -p 0x60000000
60000000:  00000000                              ....

crash> rd -p 0x80000000
80000000:  00000000                              ....

crash> rd -p 0xa0000000
a0000000:  00000000                              ....

crash> rd -p 0xb0000000
b0000000:  00000000                              ....

crash> rd -p 0xc0000000
rd: read error: physical address: c0000000  type: "32-bit PHYSADDR"

crash> rd -p 0xb8000000
rd: read error: physical address: b8000000  type: "32-bit PHYSADDR"

...snip out some incremental testing to find the exact point where it fails...

crash> rd -p 0xb7fffffc
b7fffffc:  00000000                              ....

crash> rd -p 0xb7fffffd
rd: read error: physical address: b8000000  type: "32-bit PHYSADDR"



-----Original Message-----
From: crash-utility-bounces@redhat.com [mailto:crash-utility-bounces@redhat.com] On Behalf Of Dave Anderson
Sent: Monday, October 06, 2008 12:39 PM
To: Discussion list for crash utility usage, maintenance and development
Cc: kexec-ml
Subject: Re: [Crash-utility] "cannot access vmalloc'd module memory" when loading kdump'ed vmcore in crash


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



--
Crash-utility mailing list
Crash-utility@redhat.com
https://www.redhat.com/mailman/listinfo/crash-utility
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
