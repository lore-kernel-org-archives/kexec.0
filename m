Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpbUd-0007vl-OT
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 13:35:20 +0000
Received: by mail-wm0-x22b.google.com with SMTP id w84so298724884wmg.1
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 06:34:57 -0700 (PDT)
Subject: Re: makedumpfile issues many readpage_elf: Attempt to read
 non-existent page
References: <57E3DCDB.5020308@canonical.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E6B42E@BPXM01GP.gisp.nec.co.jp>
From: Louis Bouchard <louis.bouchard@canonical.com>
Message-ID: <57ED187D.3040007@canonical.com>
Date: Thu, 29 Sep 2016 15:34:53 +0200
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E6B42E@BPXM01GP.gisp.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

Le 23/09/2016 14:04, Atsushi Kumagai a =E9crit :
>> Does someone have an idea of where this could come from ?
> =

> Thanks for your report, but I'm afraid that I'm going on
> vacation till Oct 2.
> I hope someone helps you until I'm back.
> =

> =

> Regards,
> Atsushi Kumagai
> =


As a follow up to my question, I've been investigating the issue. The sourc=
e of
the problem seems to come from readpage_elf() which tries to read to an
inexistant page :

readpage_elf: Attempt to read non-existent page at 0x1a7b7fff5000.

The error happens when readpage_elf() is called from section_mem_map_addr w=
ith
pgaddr, which is derived from paddr. This one comes from :

   paddr =3D vaddr_to_paddr(addr)

When tracing vaddr_to_paddr, I see a difference in the calculation. on a 4.4
kernel :

  info->phys_base =3D 0

On 4.8 :
  info->phys_base =3D 0xffffffffe3800000

So the paddr values used to define pgaddr are :

for 4.4 kernels : 0x3fff4000
for 4.8 kernels : 0x1a7b7fff5000

Running makedumpfile --dump-dmesg in debug mode leads to :

4.4 kernel :

sadump: does not have partition header
sadump: read dump device as unknown format
sadump: unknown format
LOAD (0)
  phys_start : 1000000
  phys_end   : 2224000
  virt_start : ffffffff81000000
  virt_end   : ffffffff82224000
LOAD (1)
  phys_start : 1000
  phys_end   : 9fc00
  virt_start : ffff880000001000
  virt_end   : ffff88000009fc00
LOAD (2)
  phys_start : 100000
  phys_end   : 2b000000
  virt_start : ffff880000100000
  virt_end   : ffff88002b000000
LOAD (3)
  phys_start : 33000000
  phys_end   : 3fffe000
  virt_start : ffff880033000000
  virt_end   : ffff88003fffe000
Linux kdump
page_size    : 4096

max_mapnr    : 3fffe

Buffer size for the cyclic mode: 65535

num of NODEs : 1


Memory type  : SPARSEMEM_EX

mem_map (0)
  mem_map    : ffffea0000000000
  pfn_start  : 0
  pfn_end    : 8000
mem_map (1)
  mem_map    : ffffea0000200000
  pfn_start  : 8000
  pfn_end    : 10000
mem_map (2)
  mem_map    : ffffea0000400000
  pfn_start  : 10000
  pfn_end    : 18000
mem_map (3)
  mem_map    : ffffea0000600000
  pfn_start  : 18000
  pfn_end    : 20000
mem_map (4)
  mem_map    : ffffea0000800000
  pfn_start  : 20000
  pfn_end    : 28000
mem_map (5)
  mem_map    : ffffea0000a00000
  pfn_start  : 28000
  pfn_end    : 30000
mem_map (6)
  mem_map    : ffffea0000c00000
  pfn_start  : 30000
  pfn_end    : 38000
mem_map (7)
  mem_map    : ffffea0000e00000
  pfn_start  : 38000
  pfn_end    : 3fffe
mmap() is available on the kernel.

log_buf       : ffffffff8210521c
log_end       : 0
log_buf_len   : 262144
log_first_idx : 0
log_next_idx  : 141176

The dmesg log is saved to /tmp/titi.

makedumpfile Completed.


For 4.8 kernels :
sadump: does not have partition header
sadump: read dump device as unknown format
sadump: unknown format
LOAD (0)
  phys_start : 7200000
  phys_end   : 847d000
  virt_start : ffffffffa3a00000
  virt_end   : ffffffffa4c7d000
LOAD (1)
  phys_start : 1000
  phys_end   : 9fc00
  virt_start : ffff880000001000
  virt_end   : ffff88000009fc00
LOAD (2)
  phys_start : 100000
  phys_end   : 2b000000
  virt_start : ffff880000100000
  virt_end   : ffff88002b000000
LOAD (3)
  phys_start : 33000000
  phys_end   : 3fffe000
  virt_start : ffff880033000000
  virt_end   : ffff88003fffe000
Linux kdump
page_size    : 4096

max_mapnr    : 3fffe

Buffer size for the cyclic mode: 65535
The kernel version is not supported.
The makedumpfile operation may be incomplete.

num of NODEs : 1


Memory type  : SPARSEMEM_EX

mem_map (0)
  mem_map    : 0
  pfn_start  : 0
  pfn_end    : 8000
mem_map (1)
  mem_map    : 0
  pfn_start  : 8000
  pfn_end    : 10000
mem_map (2)
  mem_map    : 0
  pfn_start  : 10000
  pfn_end    : 18000
mem_map (3)
  mem_map    : 0
  pfn_start  : 18000
  pfn_end    : 20000
mem_map (4)
  mem_map    : 0
  pfn_start  : 20000
  pfn_end    : 28000
mem_map (5)
  mem_map    : 0
  pfn_start  : 28000
  pfn_end    : 30000
mem_map (6)
  mem_map    : 0
  pfn_start  : 30000
  pfn_end    : 38000
mem_map (7)
  mem_map    : 0
  pfn_start  : 38000
  pfn_end    : 3fffe
mmap() is available on the kernel.

log_buf       : ffffffffa4b3c19c
log_end       : 0
log_buf_len   : 262144
log_first_idx : 0
log_next_idx  : 43160

The dmesg log is saved to /tmp/toto.

makedumpfile Completed.


I don't know if it is to be expected with kernels 4.8 to have all mem_map
addresses set to 0, unlike with k4.4 :

mem_map (0)
mem_map : 0
pfn_start : 0
pfn_end : 8000

Any comment appreciated while I continue to investigate.

Kind regards,

...Louis

-- =

Louis Bouchard
Software engineer, Cloud & Sustaining eng.
Canonical Ltd
Ubuntu developer                       Debian Maintainer
GPG : 429D 7A3B DD05 B6F8 AF63  B9C4 8B3D 867C 823E 7A61

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
