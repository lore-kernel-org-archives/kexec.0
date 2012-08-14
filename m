Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T1FjX-0002Jb-UH
 for kexec@lists.infradead.org; Tue, 14 Aug 2012 11:56:29 +0000
Date: Tue, 14 Aug 2012 20:55:32 +0900 (JST)
Message-Id: <20120814.205532.509440957.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120810143655.GA5416@redhat.com>
References: <20120807.163120.106259238.d.hatayama@jp.fujitsu.com>
 <20120810.173938.37160718.d.hatayama@jp.fujitsu.com>
 <20120810143655.GA5416@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
Date: Fri, 10 Aug 2012 10:36:55 -0400

> On Fri, Aug 10, 2012 at 05:39:38PM +0900, HATAYAMA Daisuke wrote:
> 
> [..]
>> 
>> I finished benchmarking filtering time and demonstrate the result.
>> But I failed to collect amount of memory consumption by my mistake. If
>> they are necessary, I'll again try to collect them. But we have 9 days
>> vacation starting tommorow, so I'll do that after the vacation.
>> 
> 
> Thanks a lot for doing this benchmarking.
> 
>> The machine spec I used is as follows:
>> 
>>   Memory: 2TB
>>   CPU: Intel(R) Xeon(R) CPU E7- 8870  @ 2.40GHz
>>        (8 sockets, 10 cores, 2 threads)
>> 
>> In the first step, I chosed buffer size 10KB and it took about 3h 45m
>> 57s. So, next I changed the buffer size to 512KB and measured up to
>> 8MB.
> 
> What is this buffer size? Is user supposed to specify it? Is it some fixed
> size buffer which makedumpfile can use to read in memory and once we cross
> the buffer size we need to let some data from buffer go?
> 

The buffer size is just the size for a single bitmap. A single bitmap
has the given buffer size length. If passing 512kB as buffer size, two
512kB bitmaps, so 1MB in total, are allocated.

The next equation holds:

number_of_cycles == system_memory / ( bit_per_bytes * page_size * the_buf_size )

On this benchmarking,

  system_memory := 2TB
  bit_per_bytes := 8
  page_size := 4KB

The buffer size was fixed in Kumagai-san's version, but in this
benchmarking I added --bufsize command-line option for flexibility.

>> 
>> The result is as follows:
>> 
>> | buffer size | time       |
>> |-------------+------------|
>> | 8 MB        | 48.32 sec  |
>> | 4 MB        | 55.76 sec  |
>> | 2 MB        | 69.91 sec  |
>> | 1 MB        | 98.25 sec  |
>> | 512 KB      | 154.42 sec |
> 
> So, on a 2TB system, with 8MB buffer, we could filter and save vmcore in
> around 48 seconds? Or is it just filtering time.
> 

Just filtering time. I first tried with writing memory but it took
very long time over a few hours. There are several test cases for
several buffer size, I needed to reduce the time required.

> 48 seconds for 2TB system, sounds pretty decent to me.
> 

I think so too, because the time for writing data is by far larger
than this time.

> Are these results with existing free_list implementation or with your
> patches of walking through mem_map array?
> 
>> 
>> BTW, the existing free_list logic took about 48 sec for the same
>> vmcore as below.
> 
> I guess above results were with your patches of walking mem_map array.
> 

Yes, the above results are mem_map array case.

>> 
>> STEP [Excluding free pages       ] : 49.846321 seconds
>> STEP [Excluding unnecessary pages] : 6.339228 seconds
>> STEP [Excluding free pages       ] : 48.595884 seconds
>> STEP [Excluding unnecessary pages] : 6.530479 seconds
>> STEP [Excluding free pages       ] : 48.598879 seconds
>> STEP [Excluding unnecessary pages] : 6.527133 seconds
>> STEP [Excluding free pages       ] : 48.602401 seconds
>> STEP [Excluding unnecessary pages] : 6.502681 seconds
>> STEP [Excluding free pages       ] : 48.602010 seconds
>> STEP [Excluding unnecessary pages] : 6.469853 seconds
>> STEP [Excluding free pages       ] : 48.601637 seconds
>> STEP [Excluding unnecessary pages] : 6.431381 seconds
>> STEP [Excluding free pages       ] : 48.601195 seconds
>> STEP [Excluding unnecessary pages] : 6.416676 seconds
>> STEP [Excluding free pages       ] : 48.602221 seconds
>> STEP [Excluding unnecessary pages] : 6.387611 seconds
>> STEP [Excluding free pages       ] : 48.589972 seconds
>> STEP [Excluding unnecessary pages] : 0.816955 seconds
> 
> So what does above represent. Each step is taking 48 seconds or total
> time taken to filter vmcore is 48 seconds? What's the buffer size used
> here.
> 

The free_list logic always filteres a whole memory range even if the
range we need to filter is only a cerntain part, so it took about 48
seconds at each cycle.

> Does that mean that filtering time for both mem_map array approach and
> free_list approach are same?
> 

No.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
