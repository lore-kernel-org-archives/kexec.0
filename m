Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UEzGL-00080h-I7
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 09:43:22 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130307145808.29098.41592.stgit@k.asiapacific.hpqcorp.net>
 <20130307152108.GC2790@redhat.com> <87k3piri3e.fsf@xmission.com>
 <20130308155216.GB8219@redhat.com> <513D9338.20402@hp.com>
Date: Mon, 11 Mar 2013 02:42:48 -0700
In-Reply-To: <513D9338.20402@hp.com> (Jingbai Ma's message of "Mon, 11 Mar
 2013 16:18:00 +0800")
Message-ID: <87wqtenug7.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel to
 speedup kernel dump process
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
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, hpa@zytor.com, yinghai@kernel.org, Vivek Goyal <vgoyal@redhat.com>

Jingbai Ma <jingbai.ma@hp.com> writes:

> On 03/08/2013 11:52 PM, Vivek Goyal wrote:
>> On Thu, Mar 07, 2013 at 01:54:45PM -0800, Eric W. Biederman wrote:
>>> Vivek Goyal<vgoyal@redhat.com>  writes:
>>>
>>>> On Thu, Mar 07, 2013 at 10:58:18PM +0800, Jingbai Ma wrote:
>>>>> This patch intend to speedup the memory pages scanning process in
>>>>> selective dump mode.
>>>>>
>>>>> Test result (On HP ProLiant DL980 G7 with 1TB RAM, makedumpfile
>>>>> v1.5.3):
>>>>>
>>>>> 						Total scan Time
>>>>> Original kernel
>>>>> 	+ makedumpfile v1.5.3 cyclic mode	1958.05 seconds
>>>>> Original kernel
>>>>> 	+ makedumpfile v1.5.3 non-cyclic mode	1151.50 seconds
>>>>> Patched kernel
>>>>> 	+ patched makedumpfile v1.5.3		17.50 seconds
>>>>>
>>>>> Traditionally, to reduce the size of dump file, dumper scans all memory
>>>>> pages to exclude the unnecessary memory pages after capture kernel
>>>>> booted, and scan it in userspace code (makedumpfile).
>>>>
>>>> I think this is not a good idea. It has several issues.
>>>
>>> Actually it does not appear to be doing any work in the first kernel.
>>
>> Looks like patch3 in series is doing that.
>>
>>                          machine_crash_shutdown(&fixed_regs);
>> +                       generate_crash_dump_bitmap();
>>                          machine_kexec(kexec_crash_image);
>>
>> So this bitmap seems to be being set just before transitioning into
>> second kernel.
>>
>> I am sure you would not like this extra code in this path. :-)
>
> I was thought this function code is pretty simple, could be called
> here safely.
> If it's not proper for here, how about before the function
> machine_crash_shutdown(&fixed_regs)?
> Furthermore, could you explain the real risks to execute more codes here?

The kernel is known bad.  What is bad is unclear.
Executing any extra code is a bad idea.

The history here is that before kexec-on-panic there were lots of dump
routines that did all of the crashdump logic in the kernel before they
shutdown.  They all worked beautifully during development, and on
developers test machines and were absolutely worthless in real world
situations.

A piece of code that walks all of the page tables is most definitely
opening itself up to all kinds of failure situations I can't even
imagine.

The only way that it would be ok to do this would be to maintain the
bitmap in real time with the existing page table maintenance code,
and that would only be ok if it did not add a performance penalty.

Every once in a great while there is a new cpu architecture feature
we need to deal with, but otherwise the only thing that is ok to
do on that code path is to reduce it until it much more closely
resembles the glorified jump instruction that it really is.

Speaking of have you given this code any coverage testing with lkdtm?

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
