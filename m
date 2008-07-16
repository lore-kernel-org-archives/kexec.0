Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KJCUe-0000Wr-Hm
	for kexec@lists.infradead.org; Wed, 16 Jul 2008 19:16:53 +0000
Message-ID: <487E4922.9050209@sgi.com>
Date: Wed, 16 Jul 2008 12:16:50 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: problems in kdump kernel if 'maxcpus=1' not specified?
References: <487D49DC.8040209@sgi.com>
	<20080716151240.GB711@redhat.com>	<20080716152544.GD10030@hmsendeavour.rdu.redhat.com>	<20080716162343.GC711@redhat.com>
	<20080716170338.GA11654@hmsendeavour.rdu.redhat.com>
In-Reply-To: <20080716170338.GA11654@hmsendeavour.rdu.redhat.com>
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
To: Neil Horman <nhorman@redhat.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

Neil Horman wrote:
> On Wed, Jul 16, 2008 at 12:23:43PM -0400, Vivek Goyal wrote:
>> On Wed, Jul 16, 2008 at 11:25:44AM -0400, Neil Horman wrote:
>>> On Wed, Jul 16, 2008 at 11:12:40AM -0400, Vivek Goyal wrote:
>>>> On Tue, Jul 15, 2008 at 06:07:40PM -0700, Jay Lan wrote:
>>>>> Are there known problems if you boot up kdump kernel with
>>>>> multipl cpus?
>>>>>
>>>> I had run into one issue and that was some system would get reset and 
>>>> jump to BIOS.
>>>>
>>>> The reason was that kdump kernel can boot on a non-boot cpu. When it
>>>> tries to bring up other cpus it sends INIT and a non-boot cpu sending
>>>> INIT to "boot" cpu was not acceptable (as per intel documentation) and 
>>>> it re-initialized the system.
>>>>
>>>> I am not sure how many systems are affected with this behavior. Hence
>>>> the reason for using maxcpus=1.
>>>>
>>> +1, there are a number of multi-cpu issues with kdump.  I've seen some systems
>>> where you simply can't re-inialize a halted cpu from software, which causes
>>> problems/hangs
>>>
>>>>> It takes unacceptably long time to run makedumpfile in
>>>>> saving dump at a huge memory system. In my testing it
>>>>> took 16hr25min to run create_dump_bitmap() on a 1TB system.
>>>>> Pfn's are processed sequentially with single cpu. We
>>>>> certainly can use multipl cpus here ;)
>>>> This is certainly very long time. How much memory have you reserved for
>>>> kdump kernel?
>>>>
>>>> I had run some tests on a x86_64 128GB RAM system and it took me 4 minutes
>>>> to filter and save the core (maximum filtering level of 31). I had
>>>> reserved 128MB of memory for kdump kernel.
>>>>
>>>> I think something else is seriously wrong here. 1 TB is almost 10 times of
>>>> 128GM and even if time scales linearly it should not take more than
>>>> 40mins.
>>>>
>>>> You need to dive deeper to find out what is taking so much of time.
>>>>
>>>> CCing kenichi.
>>>>
>>> You know, we might be able to get speedup's in makedumpfile without the use of
>>> additional cpu's.  One of the things that concerned me when I read this was the
>>> use of dump targets that need to be sequential.  i.e. multiple processes writing
>>> to a local disk make good sense, but not so much if you're dumping over an scp
>>> connection (don't want to re-order those writes).  The makedumpfile work cycle
>>> goes something from 30000 feet like:
>>>
>>> 1) Inspect a page
>>> 2) Decide to filter the page
>>> 3) if (2) goto 1
>>> 4) else compress page
>>> 5) write page to target
>> I thought that it first creates the bitmap. So in first pass it just
>> decides which are the pages to be dumped or filtered out and marks these
>> in bitmap.
>>
>> Then in second pass it starts dumping all the pages sequentially along
>> with metadata, if any..
>>
> It might, but I don't think thats overly relevant, as I expect the major cpu
> usage point comes in during compression and the major wall clock time loss
> occurs during I/O
> 
>>> I'm sure 4 is going to be the most cpu intensive task, but I bet we spend a lot
>>> of idle time waiting for I/O to complete (since I'm sure we'll fill up pagecache
>>> quickly).  What if makedumpfile used AIO to write out prepared pages to the dump
>>> target?  That way we could at least free up some cpu cycles to work more quickly
>>> on steps 2,3, and 4 
>>>
>> If above assumption if right, then probably AIO might not help as once we
>> marked the pages, we have no job but to wait for completion.
>>
> I assume that we interleave page compression with I/O (i.e. compress a page from
> the bitmap, write the page to disk, repeat).  If thats the case, then AIO would
> help because the kernel (or another thread) can wait on i/o completion while we
> continue and compress another page
> 
> It will also help if a single context is unable to fill the I/O pipeline.  IIRC
> multiple aio requests can be in flight at the same time, maximizing I/O
> bandwidth.  And we can decide at the application level if our dump target will
> allow parallel I/O
> 
>> DIO might help a bit because we need not to fill page cache as we are 
>> not going to need vmcore pages again.
>>
> We currently do something simmilar to this in RHEL.  The kdump initrd reduces
> dirty_ratio to almost zero, effectively creating a DIO environment.  Numbers
> from there would give us an idea of how that performs

Upon completion of saving dump, about 2G of memory in cache in my
case.

> 
>> In case of jay, it looks creating bitmaps itself took a long time. 
>>
> Do you have data for this?  I've not seen it.

I just posted detailed data. My initial post gave the amount of time
spent in create_dump_bitmap().

The processing rate of pfn inside create_dump_bitmap() is about
   184500-pfn/sec  on memory map that does not contain data needs to
                   be saved.
   213700-pfn/sec  on memory map that contain data to be saved.

Here is some memory mappend from /proc/iomem:
16003000000-16033dfffff : System RAM
16033e00000-160f7ffffff : System RAM
16800000000-168f7ffffff : System RAM

We do not spent time in scanning pfn between 160f8000000 and
16800000000. Do we? I did not try to track it down.

 - jay



> Neil
> 
>> Vivek
>>
>>> Thoughts?
>>>
>>> Neil
>>>
>>> -- 
>>> /***************************************************
>>>  *Neil Horman
>>>  *Senior Software Engineer
>>>  *Red Hat, Inc.
>>>  *nhorman@redhat.com
>>>  *gpg keyid: 1024D / 0x92A74FA1
>>>  *http://pgp.mit.edu
>>>  ***************************************************/
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
