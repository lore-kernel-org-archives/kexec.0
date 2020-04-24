Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRsxs-0003is-SJ
 for kexec@lists.infradead.org; Fri, 24 Apr 2020 07:41:38 +0000
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
From: David Hildenbrand <david@redhat.com>
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-2-james.morse@arm.com>
 <87d088h4k8.fsf@x220.int.ebiederm.org>
 <a694cea6-4449-c77a-98f7-bd7a49cf47fc@arm.com>
 <87y2qn1r18.fsf@x220.int.ebiederm.org>
 <a29beedb-750b-b838-6c2a-6e47ade2186a@redhat.com>
 <87ftcuxj1a.fsf@x220.int.ebiederm.org>
 <4ca41c5f-4cbf-342c-528a-d274c4e2ca10@redhat.com>
Message-ID: <d18cfd1e-bff2-47b6-cf4d-52d0de92002e@redhat.com>
Date: Fri, 24 Apr 2020 09:41:28 +0200
MIME-Version: 1.0
In-Reply-To: <4ca41c5f-4cbf-342c-528a-d274c4e2ca10@redhat.com>
Content-Language: en-US
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, James Morse <james.morse@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

On 24.04.20 09:39, David Hildenbrand wrote:
> On 23.04.20 18:29, Eric W. Biederman wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>
>>>> The confusing part was talking about memory being still in use,
>>>> that is actually scheduled for use in the future.
>>>
>>> +1
>>>
>>>>
>>>>>> Usually somewhere in the loaded image
>>>>>> is a copy of the memory map at the time the kexec kernel was loaded.
>>>>>> That will invalidate the memory map as well.
>>>>>
>>>>> Ah, unconditionally. Sure, x86 needs this.
>>>>> (arm64 re-discovers the memory map from firmware tables after kexec)
>>>
>>> Does this include hotplugged DIMMs e.g., under KVM?
>>> [...]
>>
>> As far as I know.  If the memory map changes we need to drop the loaded
>> image.
>>
>>
>> Having thought about it a little more I suspect it would be the
>> other way and just block all hotplug actions after a kexec_load.
>> As all we expect to happen is running shutdown scripts.
>>
>> If blocking the hotplug action uses printk to print a nice message
>> saying something like: "Hotplug blocked because of a loaded kexec image",
>> then people will be able to figure out what is going on and
>> call kexec -u if they haven't started the shutdown scripts yet.
>>
>>
>> Either way it is something simple and unconditional that will make
>> things work.
>>
> 
> Personally, I consider memory hotplug more important than keeping loaded
> kexec data alive (just because somebody once decided to do a "kexec -l"
> and never did a "kexec -e" we should not block any memory hot(un)plug -
> especially in virtualized environments - for all eternity).
> 
> So IMHO we would invalidate loaded kexec data (not the crashkernel, of
> course) on memory hot(un)plug and print a warning. In addition, we can
> let kexec-tools try to reload whatever they loaded after getting
> notified that something changed.
> 
> The "something changed" is visible to user space e.g., via udev events
> for /sys/devices/memory/memoryX/

/sys/devices/system/memory/memoryX/ ...


-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
