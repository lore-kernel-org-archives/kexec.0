Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IV6Gd-0002iU-Hz
	for kexec@lists.infradead.org; Tue, 11 Sep 2007 09:59:06 -0400
Message-ID: <46E6A03F.4010208@redhat.com>
Date: Tue, 11 Sep 2007 10:03:43 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: [Crash-utility] Re: [PATCH 0/2] vmcoreinfo support for
	dump	filtering #2
References: <20070907175746oomichi@mail.jp.nec.com>	<20070910113521.755d0433.rdunlap@xenotime.net>
	<20070911035250.GA5053@in.ibm.com>
In-Reply-To: <20070911035250.GA5053@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com, "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, kexec-ml <kexec@lists.infradead.org>

Vivek Goyal wrote:
> On Mon, Sep 10, 2007 at 11:35:21AM -0700, Randy Dunlap wrote:
> 
>>On Fri, 7 Sep 2007 17:57:46 +0900 Ken'ichi Ohmichi wrote:
>>
>>
>>>Hi,
>>
>>>I released a new makedumpfile (version 1.2.0) with vmcoreinfo support.
>>>I updated the patches for linux and kexec-tools.
>>>
>>>PATCH SET:
>>>[1/2] [linux-2.6.22] Add vmcoreinfo
>>>  The patch is for linux-2.6.22.
>>>  The patch adds the vmcoreinfo data. Its address and size are output
>>>  to /sys/kernel/vmcoreinfo.
>>>
>>>[2/2] [kexec-tools] Pass vmcoreinfo's address and size
>>>  The patch is for kexec-tools-testing-20070330.
>>>  (http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/)
>>>  kexec command gets the address and size of the vmcoreinfo data from
>>>  /sys/kernel/vmcoreinfo, and passes them to the second kernel through
>>>  ELF header of /proc/vmcore. When the second kernel is booting, the
>>>  kernel gets them from the ELF header and creates vmcoreinfo's PT_NOTE
>>>  segment into /proc/vmcore.
>>
>>Hi,
>>When using the vmcoreinfo patches, what tool(s) are available for
>>analyzing the vmcore (dump) file?  E.g., lkcd or crash or just gdb?
>>
>>gdb works for me, but I tried to use crash (4.0-4.6 from
>>http://people.redhat.com/anderson/) and crash complained:
>>
>>crash: invalid kernel virtual address: 0  type: "cpu_pda entry"
>>
>>Should crash work, or does it need to be modified?
>>
> 
> 
> Hi Randy,
> 
> Crash should just work. It might broken on latest kernel. Copying it
> to crash-utility mailing list. Dave will be able to tell us better.
> 
> 
>>This is on a 2.6.23-rc3 kernel with vmcoreinfo patches and a dump file
>>with -l 31 (dump level 31, omitting all possible pages).

There's always the possibility that something crucial (to the crash
utility) has changed in the upstream kernel; that's just the nature
of the beast.

In this case, crash is reading this set of per-cpu pointers:

   struct x8664_pda *_cpu_pda[NR_CPUS] __read_mostly;

and for each one, it then reads the x8664_pda data structure
that it points to -- but finds a NULL.  It's possible that it
has incorrectly determined the number of x8664_pda structures
(cpus) that exist.  Or less likely, the array contents were read
as zeroes from the dumpfile.

Anyway, with any initialization-time failure, it's usually helpful
to invoke crash with the "-d7" (debug level) argument, as in:

  $ crash -d7 vmlinux vmcore

That will display information re: every read made to the dumpfile.
In this case, normally you would see, for each cpu, a read of the
individual 8-byte address from the array, and then based upon what
it read, the subsequent read of the whole 128-byte data structure:

<readmem: ffffffff8042d9c0, KVADDR, "_cpu_pda addr", 8, (FOE), 7fbffff210>
<readmem: ffffffff80406000, KVADDR, "cpu_pda entry", 128, (FOE), 937680>
CPU0: level4_pgt: 200000010 data_offset: ffff8100899c1000
<readmem: ffffffff8042d9c8, KVADDR, "_cpu_pda addr", 8, (FOE), 7fbffff210>
<readmem: ffff81003ff027c0, KVADDR, "cpu_pda entry", 128, (FOE), 937680>
CPU1: level4_pgt: 200000010 data_offset: ffff8100899c9000
<readmem: ffffffff8042d9d0, KVADDR, "_cpu_pda addr", 8, (FOE), 7fbffff210>
<readmem: ffff81003ff19e40, KVADDR, "cpu_pda entry", 128, (FOE), 937680>
CPU2: level4_pgt: 200000010 data_offset: ffff8100899d1000
<readmem: ffffffff8042d9d8, KVADDR, "_cpu_pda addr", 8, (FOE), 7fbffff210>
<readmem: ffff81003ff19640, KVADDR, "cpu_pda entry", 128, (FOE), 937680>
CPU3: level4_pgt: 200000010 data_offset: ffff8100899d9000
<readmem: ffffffff8042d9e0, KVADDR, "_cpu_pda addr", 8, (FOE), 7fbffff210>
<readmem: ffffffff80406200, KVADDR, "cpu_pda entry", 128, (FOE), 937680>

 From that data structure it grabs the level4_pgt and data_offset
fields for subsequent use.  So in your case, it should show how
many (if any) of the x8664_pda structures it read before encountering
a NULL pointer in one of the array entries.

Dave







_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
