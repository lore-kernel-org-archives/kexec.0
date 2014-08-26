Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XM7N5-0006Ms-Gx
 for kexec@lists.infradead.org; Tue, 26 Aug 2014 03:24:36 +0000
Date: Tue, 26 Aug 2014 11:22:47 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [Patch v3 7/7] add a new interface to show the memory usage of
 1st kernel
Message-ID: <20140826032247.GA6230@dhcp-16-105.nay.redhat.com>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-8-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97246623@BPXM01GP.gisp.nec.co.jp>
 <20140821103126.GA6517@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9724F9CA@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9724F9CA@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 08/26/14 at 02:28am, Atsushi Kumagai wrote:
> >On 08/01/14 at 07:12am, Atsushi Kumagai wrote:
> >> >Page number of memory in different use
> >> >--------------------------------------------------
> >> >TYPE		PAGES			EXCLUDABLE	DESCRIPTION
> >> >ZERO		0               	yes		Pages filled with zero
> >>
> >> The number of zero pages is always 0 since it isn't counted during
> >> get_num_dumpable_cyclic(). To count it up, we have to read all of the
> >> pages like exclude_zero_pages(), so we need "exclude_zero_pages_cyclic()".
> >> My idea is to call it in get_num_dumpable_cyclic() like:
> >>
> >> 		for_each_cycle(0, info->max_mapnr, &cycle)
> >> 		{
> >> 				if (!exclude_unnecessary_pages_cyclic(&cycle))
> >> 					return FALSE;
> >>
> >> +				if (info->flag_mem_usage)
> >> +					exclude_zero_pages_cyclic(&cycle);
> >> +
> >> 				for(pfn=cycle.start_pfn; pfn<cycle.end_pfn; pfn++)
> >
> >
> >Hi Atsushi,
> >
> >I just introduced a new function exclude_zero_pages_cyclic as you
> >suggested. But it always exited with below message. I don't know what's
> >wrong with this function. Could you help have a look at it?
> >
> >"Program terminated with signal SIGKILL"
> 
> Umm, the code looks no problem and it works well at least on my
> machine (x86_64 on KVM), so I have no idea for now.
> 
> Can strace and audit help your investigation? They may provide
> some hints (e.g. Who send SIGKILL) for us.

It only happened on a AMD machine with Quad-Core AMD Opteron(tm)
Processor 1352. I tested on my other 2 intel machines, both of them are
OK.

Just now I used strace to check it, and found it's caused by a reading.
It's weird since that page should be inside the System RAM and can be
read. And before this handling hwpoison has been checked. I am wondering
why it happened.


[ ~]$ sudo readelf -l /proc/kcore                                                                                                                                        

Elf file type is CORE (Core file)
Entry point 0x0
There are 13 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
...

This is the load segment where the page reading error happened.
  LOAD           0x0000080080001000 0xffff880080000000
0x0000000000000000
                 0x000000004fee0000 0x000000004fee0000  RWE    1000
...

  LOAD           0x00006a0002001000 0xffffea0002000000
0x0000000000000000
                 0x00000000013fc000 0x00000000013fc000  RWE    1000
  LOAD           0x0000080100001000 0xffff880100000000
0x0000000000000000
                 0x0000000130000000 0x0000000130000000  RWE    1000

read(3,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
lseek(3, 8799351988224, SEEK_SET)       = 8799351988224
read(3,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
lseek(3, 8799351992320, SEEK_SET)       = 8799351992320
read(3,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
lseek(3, 8799351996416, SEEK_SET)       = 8799351996416
read(3,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
lseek(3, 8799365541888, SEEK_SET)       = 8799365541888
read(3,
"\340\216\274\226f\177\0\0PCD\224f\177\0\0\265\0\0\0\0\0\0\0p\217\274\226f\177\0\0"...,
4096) = 4096
-----------------------------------------
Here it use lseek to position, then try to read, and then reading failed
and raised a SIGKILL.

lseek(3, 8799381360640, SEEK_SET)       = 8799381360640
read(3,  <unfinished ...>
+++ killed by SIGKILL +++
Killed
> 
> 
> Thanks
> Atsushi Kumagai
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
