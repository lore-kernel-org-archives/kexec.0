Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KkNDg-0003YF-67
	for kexec@lists.infradead.org; Mon, 29 Sep 2008 18:11:40 +0000
From: "Worth, Kevin" <kevin.worth@hp.com>
Date: Mon, 29 Sep 2008 18:11:12 +0000
Subject: RE: Problems writing ELF dumps with makedumpfile 1.2.9
Message-ID: <28113A0489833849A1CF9EC16F4215434049D3F31F@GVW1097EXB.americas.hpqcorp.net>
References: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>
	<48D72B2B.3000406@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F4215434049544C88@GVW1097EXB.americas.hpqcorp.net>
	<48D9EDDC.1070600@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F421543404958892C@GVW1097EXB.americas.hpqcorp.net>
	<48DB29A6.3070608@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F4215434049588E80@GVW1097EXB.americas.hpqcorp.net>,
	<48DC6C23.1040704@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F4215434049EAF1D2@GVW1097EXB.americas.hpqcorp.net>
	<28113A0489833849A1CF9EC16F4215434049D3EDB5@GVW1097EXB.americas.hpqcorp.net>
	<48E05748.6020706@mxs.nes.nec.co.jp>
In-Reply-To: <48E05748.6020706@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

Of course the issues seemed to have regressed... I took the makedumpfile 1.2.9 source, then tested applying the patch with "--dry-run" but forgot to actually apply it!  :X

I now get the following result (still a failure but hopefully provides some additional info). As I mentioned before, I have another system with identical hardware but only 2GB of memory instead of 4GB and I don't encounter this, not sure what kind of system you're testing on, but it may not reproduce with <4GB of memory, despite having a matching config.

-Kevin

Excluding zero pages               : [ 38 %] readmem: Can't seek the dump memory(/proc/vmcore). (offset:800002d8) Invalid argument
readmem: addr:84060000, size:4096
exclude_zero_pages: Can't get the page data(pfn:84060, max_mapnr:140000).
create_2nd_bitmap: Can't exclude pages filled with zero for creating an ELF dumpfile.
LOAD (0)
  phys_start : 0
  phys_end   : a0000
  virt_start : c0000000
  virt_end   : c00a0000
LOAD (1)
  phys_start : 100000
  phys_end   : 1000000
  virt_start : c0100000
  virt_end   : c1000000
LOAD (2)
  phys_start : 5000000
  phys_end   : 38000000
  virt_start : c5000000
  virt_end   : f8000000
LOAD (3)
  phys_start : 38000000
  phys_end   : bf790000
  virt_start : ffffffffffffffff
  virt_end   : 8778ffff
LOAD (4)
  phys_start : 100000000
  phys_end   : 140000000
  virt_start : ffffffffffffffff
  virt_end   : 3fffffff
Linux kdump

max_mapnr    : 140000
mem_map (0)
  mem_map    : 0
  pfn_start  : 0
  pfn_end    : 140000

makedumpfile Failed.

-----Original Message-----
From: Ken'ichi Ohmichi [mailto:oomichi@mxs.nes.nec.co.jp]
Sent: Sunday, September 28, 2008 9:19 PM
To: Worth, Kevin
Cc: Masaki Tachibana; kexec-ml
Subject: Re: Problems writing ELF dumps with makedumpfile 1.2.9


Hi Kevin,

Worth, Kevin wrote:
>> Could the fact that my kernel's page offset is different from the
>> defaut be the cause of the address being beyond the maximum?
>> (from the kernel config diff I sent before, changing the VMSPLIT
>> parameter, which gives the kernel 3GB of memory, causes the PAGE_OFFSET value to shift)

I have tried reproducing the problem by using your .config file on my
system just after you sent me it, but I cannot do it.


> worthk:~/makedumpfile-1.2.9$ patch -l -p1 --dry-run <v1.3.0-rc01.patch
> patching file Makefile
> Hunk #1 succeeded at 1 with fuzz 1.
> patching file ia64.c
> patching file makedumpfile-R.pl
> patching file makedumpfile.c
> patching file makedumpfile.h
> patching file x86.c
> patching file x86_64.c
>
> The fuzz messages is because I'm patching against a makefile that was
> modified by Ubuntu to use "-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE"
> rather than "-D_FILE_OFFSET_BITS=64". Perhaps the difference between
> the Ubuntu version and this upstream setting should be resolved...
> Ubuntu changelog at https://launchpad.net/ubuntu/+source/makedumpfile
>  with note "Use _LARGEFILE_SOURCE and _LARGEFILE64_SOURCE instead of
> _FILE_OFFSET_BITS=64 for correct compilation." Could this have negative
> effects or is it just a different way to tell the compiler to support
> large files?
>
> CFLAGS = -g -O2 -Wall -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE \
>           -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
> CFLAGS_ARCH     = -g -O2 -Wall -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE

I will consider it.


> On to the actual testing- I wonder if I am worse off than before applying this patch...
>
> With command line "makedumpfile -D -E -d 31 -I $rootmnt/boot/vmcoreinfo /proc/vmcore $rootmnt/var/crash/vmcore"
> I get what appears to be a regression in check_release:
>
> readmem: Can't convert a virtual address(403c1364) to physical address.
> check_release: Can't get the address of system_utsname.
> LOAD (0)
>   phys_start : 0
>   phys_end   : a0000
>   virt_start : c0000000
>   virt_end   : c00a0000
> LOAD (1)
>   phys_start : 100000
>   phys_end   : 1000000
>   virt_start : c0100000
>   virt_end   : c1000000
> LOAD (2)
>   phys_start : 5000000
>   phys_end   : 38000000
>   virt_start : c5000000
>   virt_end   : f8000000
> LOAD (3)
>   phys_start : 38000000
>   phys_end   : bf790000
>   virt_start : ffffffffffffffff
>   virt_end   : 8778ffff
> LOAD (4)
>   phys_start : 100000000
>   phys_end   : 140000000
>   virt_start : ffffffffffffffff
>   virt_end   : 3fffffff
> Linux kdump
>
> max_mapnr    : 140000
>
> PAE          : ON
>
> makedumpfile Failed.
>
>
> If I change the command line to "makedumpfile -D -E -d 1 -I $rootmnt/boot/vmcoreinfo /proc/vmcore $rootmnt/var/crash/vmcore" (simply turn "-d" down to 1) I get
>
> Excluding zero pages               : [ 33 %] readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> create_2nd_bitmap: Can't exclude pages filled with zerocreate_2nd_bitmap: for creating an ELF dumpfile.

I guess that you don't apply v1.3.0-rc01.patch, because new error messages
of v1.3.0-rc01.patch are not printed in the above log.
If applying it, the below ~~~ messages should be printed.

readmem: Can't seek the dump memory(/proc/vmcore). (offset:XXX) Invalid argument
                                                   ~~~~~~~~~~~~
exclude_zero_pages: Can't get the page data(pfn:YYY, max_mapnr:ZZZ)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can confirm makedumpfile's version by `makedumpfile -v` like
the following:
  # makedumpfile -v
  makedumpfile: version 1.3.0-rc01 (released on 26 September 2008)

  #


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
