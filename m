Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WedmD-0000aX-GN
 for kexec@lists.infradead.org; Mon, 28 Apr 2014 05:06:50 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Date: Mon, 28 Apr 2014 05:04:46 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9720DE38@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE97201A0F@BPXM01GP.gisp.nec.co.jp>
 <585335973.3025244.1397211578378.JavaMail.zimbra@redhat.com>
 <20140414080239.GA8084@dhcp-16-105.nay.redhat.com>
 <20140416064445.GC8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972048E6@BPXM01GP.gisp.nec.co.jp>
 <20140417045208.GE8084@dhcp-16-105.nay.redhat.com>
 <20140417050219.GF8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720542E@BPXM01GP.gisp.nec.co.jp>
 <20140421151240.GB4367@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720CBBE@BPXM01GP.gisp.nec.co.jp>
 <20140423170818.GE24651@redhat.com>
In-Reply-To: <20140423170818.GE24651@redhat.com>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "vgoyal@redhat.com" <vgoyal@redhat.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>

>> >> >> It definitely will cause OOM. On my test machine, it has 100G memory. So
>> >> >> per old code, its needed_size is 3200K*2 == 6.4M, if currently free
>> >> >> memory is only 15M left, the free_size will be 15M*0.4 which is 6M. So
>> >> >> info->bufsize_cyclic is assigned to be 6M. and only 3M is left for other
>> >> >> use, e.g page cache, dynamic allocation. OOM will happen.
>> >> >>
>> >> >
>> >> >BTW, in our case, there's about 30M free memory when we started saving
>> >> >dump. It should be caused by my coarse estimation above.
>> >>
>> >> Thanks for your description, I understand that situation and
>> >> the nature of the problem.
>> >>
>> >> That is, the assumption that 20% of free memory is enough for
>> >> makedumpfile can be broken if free memory is too small.
>> >> If your machine has 200GB memory, OOM will happen even after fix
>> >> the too allocation bug.
>> >
>> >Why? In cyclic mode, shouldn't makedumpfile's memory usage be fixed
>> >and should not be dependent on amount of RAM present in the system?
>>
>> Strictly speaking, it's not fixed but just restricted by the safe
>> limit(80% of free memory) like below:
>>
>
>What I meant was memory allocation is of the order O(1) and not O(N).
>
>>  - bitmap size: used for 1st and 2nd bitmaps
>>  - remains: can be used for the other works of makedumpfile (e.g. I/O buffer)
>>
>>                  pattern                      |  bitmap size  |   remains
>> ----------------------------------------------+---------------+-------------
>>   A. 100G memory with the too allocation bug  |    12.8 MB    |   17.2 MB
>>   B. 100G memory with fixed makedumpfile      |     6.4 MB    |   23.6 MB
>>   C. 200G memory with fixed makedumpfile      |    12.8 MB    |   17.2 MB
>>   D. 300G memory with fixed makedumpfile      |    19.2 MB    |   10.8 MB
>>   E. 400G memory with fixed makedumpfile      |    24.0 MB    |    6.0 MB
>>   F. 500G memory with fixed makedumpfile      |    24.0 MB    |    6.0 MB
>>   ...
>>
>> Baoquan got OOM in A pattern and didn't get it in B, so C must also
>> fail due to OOM. This is just what I wanted to say.
>
>ok, So here bitmap size is growing because we have not hit the 80% of
>available memory limit yet. But it gets limited at 24MB once we hit
>80% limit. I think that's fine. That's what I was looking for.
>
>Now key question will remain is that is using 80% of free memory by
>bitmaps too much. Are other things happening in system which consume
>memory and because memory is not available OOM hits. If that's the
>case we probably need to lower the amount of memory allocated to
>bit maps. Say 70% or 60% or may be 50%. But this should be data driven.
>
>
>>
>> >Also, so even 30MB is not sufficient to run makedumpfile. That looks
>> >like a lot of free memory to me.
>>
>> According to the table above and Baoquan's report, 23.6MB was enough
>> but 17.2 MB was short for the other works, it sounds too much requirement
>> also to me.
>>
>> >> I don't think this is a problem, it's natural that a lack of memory
>> >> causes OOM. However, there is a thing we can do for improvement.
>> >>
>> >> What I think is:
>> >>
>> >>   1. Use a constant value as safe limit to calculate bufsize_cyclic
>> >>      instead of 80% of free memory. This value must be enough for
>> >>      makedumpfile's work except bitmap.
>> >>
>> >>   2. If free memory is smaller than the value, makedumpfile gives up
>> >>      to work early.
>> >
>> >What do we gain by makedumpfile giving up. System will reboot. System
>> >will reboot anyway after OOM.
>>
>> Oh, you got a point.
>>
>> >>
>> >> This change may reduce the possibility of lack of memory, but the
>> >> required memory size will be changing every version, so maintaining
>> >> it sounds tough to me.
>> >
>> >I think we need to dive deeper to figure out why 30MB of free memory
>> >is not sufficient. To me something looks wrong here.
>>
>> I agree. I'm trying to get the peak size of memory footprint except
>> cyclic_buffer with memory cgroup (memory.max_usage_in_bytes), but
>> I don't make it yet.
>
>That sounds like a good idea.
>
>I am wondering if we are doing anything which requires kernel to allocate
>memory and that leads to OOM.

max_usage_in_bytes seems to include page cache, so I used simpler way
like the patch at the bottom of this mail instead.

Here is the result:

            parameter                  |      result
 dump_lv | buffer[KiB] |  mmap (=4MiB) |    VmHWM [KiB]
 --------+-------------+---------------+------------------
    d31	 |	1	|	 on	|	5872
   Ed31	 |	1	|	 on	|	5804
    d31	 |	1	|	off	|	1784
   Ed31	 |	1	|	off	|	1720
    d31	 |   1000	|	 on	|	8884  (*1)
   Ed31  |   1000	|	 on	|	7812
    d31	 |   1000	|	off	|	4788  (*1)
   Ed31  |   1000	|	off	|	3720

  *1. 2nd bitmap is allocated twice by the bug found by Arthur Zou.

According to this result and the estimation below produced from the
design of makedumpfile,

  base size + (buffer size * 2) + (for mmap size) = VmHWM

the base size may be about 2 MB, so about 6MB (base + mmap) will
be the deadline. If 20% of the available memory is less than 6MB,
OOM will happen.
As for Baoquan's case, remained 17.2MB sounds enough even if
makedumpfile consumes 6MB as for the other works. 
So I don't know why OOM happened yet, but the current safety
limit looks still reasonable to me at least.

By the way, I noticed it's better to remove 4MB(for mmap)
from the available memory before calculate the bitmap buffer
size. I'll do this anyway.


Thanks
Atsushi Kumagai

diff --git a/makedumpfile.c b/makedumpfile.c
index 0b31932..4b565f1 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -37,6 +37,14 @@ struct DumpInfo		*info = NULL;
 
 char filename_stdout[] = FILENAME_STDOUT;
 
+void
+print_VmHWM(void)
+{
+	char cmd[64];
+	sprintf(cmd, "grep VmHWM /proc/%d/status", getpid());
+	system(cmd);
+}
+
 static void first_cycle(mdf_pfn_t start, mdf_pfn_t max, struct cycle *cycle)
 {
 	cycle->start_pfn = round(start, info->pfn_cyclic);
@@ -9357,5 +9365,7 @@ out:
 	}
 	free_elf_info();
 
+	print_VmHWM();
+
 	return retcd;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
