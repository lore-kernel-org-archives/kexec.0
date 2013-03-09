Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UEBRO-0006NR-17
 for kexec@lists.infradead.org; Sat, 09 Mar 2013 04:31:27 +0000
Date: Sat, 09 Mar 2013 13:31:18 +0900 (JST)
Message-Id: <20130309.133118.214580151.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel
 to speedup kernel dump process
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <5139B827.3050500@hp.com>
References: <20130307145808.29098.41592.stgit@k.asiapacific.hpqcorp.net>
 <20130307152108.GC2790@redhat.com> <5139B827.3050500@hp.com>
Mime-Version: 1.0
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
To: jingbai.ma@hp.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, hpa@zytor.com, yinghai@kernel.org, vgoyal@redhat.com

From: Jingbai Ma <jingbai.ma@hp.com>
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel to speedup kernel dump process
Date: Fri, 8 Mar 2013 18:06:31 +0800

> On 03/07/2013 11:21 PM, Vivek Goyal wrote:
>> On Thu, Mar 07, 2013 at 10:58:18PM +0800, Jingbai Ma wrote:
...
>> First of all 64MB per TB should not be a huge deal. And makedumpfile
>> also has this cyclic mode where you process a map, discard it and then
>> move on to next section. So memory usage remains constant at the
>> expense
>> of processing time.
> 
> Yes, that's true. But in cyclic mode, makedumpfile will have to
> write/read bitmap from storage, it will also impact the performance.
> I have measured the penalty for cyclic mode is about 70%
> slowdown. Maybe could be faster after mmap implemented.

I guess the slowdown came from the issue that enough VMCOREINFO was
not provided from the kernel, and unnecessary filtering processing for
free pages is done multiple times.

For example, confirm how filtering is done in your environment like
this:

$ makedumpfile --message-level 16      # 16 is report message
makedumpfile: map_size = 4
sadump: does not have partition header
...
  pfn_end    : 880000
Can't select page_is_buddy handler; follow free lists instead of mem_map array.
STEP [Excluding free pages       ] : 0.431724 seconds
STEP [Excluding unnecessary pages] : 1.052160 seconds

Here STEP [..] colum occurs the number of cycles in cyclic-mode. If
STEP [Excluding free pages ] column occurs multiple times in log, it
causes the slowdown on your environment. (free_list doesn't sort its
elements in pfn's order, so we have only to iterate a whole part of
free_list in each cycle...; it could amount to be close to a whole
memory size in worst case just after system boot)

To use mem_map array logic, VMCOREINFO nees to have the corresponding
information to refer to related data structures. The patch is 

commit 8d67091ec6ae98ca67f77990ef9e9ec21337f077
Author: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date:   Wed Feb 27 17:03:25 2013 -0800

    kexec: add the values related to buddy system for filtering free pages.

and it has been merged in 3.9-rc1.

$ git describe 8d67091ec6ae98ca67f77990ef9e9ec21337f077
v3.8-9443-g8d67091

Or you can edit VMCOREINFO manually and specify it to makedumpfile as:

1. generate vmcoreinfo from vmlinux

  makedumpfile -x vmlinux -g vmcoreinfo.txt

2. Add the following values in the generated vmcoreinfo.txt

- 3.1, 3.4, 3.8.x
NUMBER(PG_slab)=7
SIZE(pageflags)=4
OFFSET(page._mapcount)=24
OFFSET(page.private)=48
NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)=-128

- 2.6.38
SIZE(pageflags)=4
OFFSET(page._mapcount)=12
OFFSET(page.private)=16
NUMBER(PG_slab)=7
NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)=-2

- 2.6.32
NUMBER(PG_slab)=7
NUMBER(PG_buddy)=19
OFFSET(page._mapcount)=12
OFFSET(page.private)=16
SIZE(pageflags)=4

- 2.6.18
NUMBER(PG_slab)=7
NUMBER(PG_buddy)=19
OFFSET(page._mapcount)=12
OFFSET(page.private)=16

3. Specify the vmcoreinfo.txt to makedumpfile via -i option

  makedumpfile -i vmcoreinfo.txt [-c|-l|-p] -d 31 /proc/vmcore dumpfile

Anyway, please help benchmark. I'll send CC to you too.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
