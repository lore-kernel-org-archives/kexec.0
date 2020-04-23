Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-2-james.morse@arm.com>
 <87d088h4k8.fsf@x220.int.ebiederm.org>
 <a694cea6-4449-c77a-98f7-bd7a49cf47fc@arm.com>
 <87y2qn1r18.fsf@x220.int.ebiederm.org>
 <a29beedb-750b-b838-6c2a-6e47ade2186a@redhat.com>
Date: Thu, 23 Apr 2020 11:29:21 -0500
In-Reply-To: <a29beedb-750b-b838-6c2a-6e47ade2186a@redhat.com> (David
 Hildenbrand's message of "Wed, 22 Apr 2020 18:40:22 +0200")
Message-ID: <87ftcuxj1a.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
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
To: David Hildenbrand <david@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, James Morse <james.morse@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

David Hildenbrand <david@redhat.com> writes:

>> The confusing part was talking about memory being still in use,
>> that is actually scheduled for use in the future.
>
> +1
>
>> 
>>>> Usually somewhere in the loaded image
>>>> is a copy of the memory map at the time the kexec kernel was loaded.
>>>> That will invalidate the memory map as well.
>>>
>>> Ah, unconditionally. Sure, x86 needs this.
>>> (arm64 re-discovers the memory map from firmware tables after kexec)
>
> Does this include hotplugged DIMMs e.g., under KVM?
> [...]

As far as I know.  If the memory map changes we need to drop the loaded
image.


Having thought about it a little more I suspect it would be the
other way and just block all hotplug actions after a kexec_load.
As all we expect to happen is running shutdown scripts.

If blocking the hotplug action uses printk to print a nice message
saying something like: "Hotplug blocked because of a loaded kexec image",
then people will be able to figure out what is going on and
call kexec -u if they haven't started the shutdown scripts yet.


Either way it is something simple and unconditional that will make
things work.

>>>> All of this should be for a very brief window of a few seconds, as
>>>> the loaded kexec image is quite short.
>>>
>>> It seems I'm the outlier anticipating anything could happen between
>>> those syscalls.
>> 
>> The design is:
>> 	sys_kexec_load()
>> 	shutdown scripts
>>         sys_reboot(LINUX_REBOOT_CMD_KEXEC);
>> 
>> There are two system call simply so that the shutdown scripts can run.
>> Now maybe someone somewhere does something different but that is not
>> expected.
>> 
>> Only the kexec on panic kernel is expected to persist somewhat
>> indefinitely.  But that should be in memory that is reserved from boot
>> time, and so the memory hotplug should have enough visibility to not
>> allow that memory to be given up.
>
> Yes, and AFAIK, memory blocks which hold the reserved crashkernel area
> can usually not get offlined and, therefore, the memory cannot get removed.
>
> Interestingly, s390x even has a hotplug notifier for that
>
> arch/s390/kernel/setup.c:kdump_mem_notifier()
>
> (offlining of memory on s390x can result in memory getting depopulated
> in the hypervisor, so after it would have been offlined, it would no
> longer be accessible. I somewhat doubt that this notifier is really
> needed - all pages in the crashkernel area should look like ordinary
> allocated pages when the area is reserved early during boot via the
> memblock allocator, and therefore offlining cannot succeed. But that's a
> different story - and I suspect this is a leftover from pre-memblock times.)

It might be worth seeing if that is true, or if we need to generalize the
s390x code.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
