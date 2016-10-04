Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1brSAB-0001PM-0D
 for kexec@lists.infradead.org; Tue, 04 Oct 2016 16:01:52 +0000
Message-ID: <57F3D254.20806@redhat.com>
Date: Tue, 04 Oct 2016 12:01:24 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] arch/x86: Fix kdump on x86 with physically hotadded CPUs
References: <1475514432-27682-1-git-send-email-prarit@redhat.com>
 <alpine.DEB.2.20.1610041241160.7712@nanos> <57F39C09.10001@redhat.com>
 <alpine.DEB.2.20.1610041628120.5049@nanos>
In-Reply-To: <alpine.DEB.2.20.1610041628120.5049@nanos>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, dyoung@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Jiri Olsa <jolsa@redhat.com>



On 10/04/2016 10:38 AM, Thomas Gleixner wrote:
> On Tue, 4 Oct 2016, Prarit Bhargava wrote:
>> On 10/04/2016 06:58 AM, Thomas Gleixner wrote:
>>> While it is the right thing to initialize the package map in that case, it
>>> still papers over a robustness issue in the uncore code, which needs to be
>>> fixed first.
>>
>> I will include a separate patch with an error check for pkg == 0xffff in the
>> uncore code.
> 
> 0xffff? That won't help. The id returned is -1 if the entry is not
> initialized. And aside of that just patching that particular place is not
> helping as the uncore code and also rapl is relying on the package map
> being populated.

Yes, I noticed that after I started digging into it this morning.  Not only what
you pointed out but there's init that occurs in the uncore code that would have
to be undone.

There is a similar issue in the rapl code, but that code inadvertently protects
itself with for loops that end up never running (and that's why the rapl code
doesn't panic).

> 
> So we need a sanity check in the initialization code which prevents any of
> this being executed.

Ok, should this be done only for logical_proc_id or for logical_proc_id,
phys_proc_id, and cpu_core_id?  What do you think of adding that to the end of
smp_init_package_map() or smp_store_cpu_info()?

>  
>>>> +		if (!num_processors) {
>>>> +			pr_warn("CPU 0 not enumerated in mptable or ACPI MADT\n");
>>>> +			num_processors = 1;
>>>
>>> And in this case we end up with the same problem, right?
>>
>> It occurs to me that I over thought this: I was thinking that there might exist
>> a pre-ACPI (or at least a system without an MADT) x86 system that wold boot such
>> that num_processors = 0.  But in that case, the cpu should be listed in the
>> mptables so the above should not happen.  I'll change that to a BUG().
> 
> No. That's the wrong thing to do. Think SMP kernel on UP machines ...
> 

Sorry Thomas, but my history with real UP hardware is limited.  I think you
might be saying I should call generic_processor_info(0, apic_version[0]) to
populate cpu 0 but I'm not sure.

P.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
