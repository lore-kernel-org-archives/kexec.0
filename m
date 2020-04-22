Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRIQJ-0006VU-P5
 for kexec@lists.infradead.org; Wed, 22 Apr 2020 16:40:33 +0000
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-2-james.morse@arm.com>
 <87d088h4k8.fsf@x220.int.ebiederm.org>
 <a694cea6-4449-c77a-98f7-bd7a49cf47fc@arm.com>
 <87y2qn1r18.fsf@x220.int.ebiederm.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a29beedb-750b-b838-6c2a-6e47ade2186a@redhat.com>
Date: Wed, 22 Apr 2020 18:40:22 +0200
MIME-Version: 1.0
In-Reply-To: <87y2qn1r18.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, James Morse <james.morse@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org


> The confusing part was talking about memory being still in use,
> that is actually scheduled for use in the future.

+1

> 
>>> Usually somewhere in the loaded image
>>> is a copy of the memory map at the time the kexec kernel was loaded.
>>> That will invalidate the memory map as well.
>>
>> Ah, unconditionally. Sure, x86 needs this.
>> (arm64 re-discovers the memory map from firmware tables after kexec)

Does this include hotplugged DIMMs e.g., under KVM?
[...]

>>> All of this should be for a very brief window of a few seconds, as
>>> the loaded kexec image is quite short.
>>
>> It seems I'm the outlier anticipating anything could happen between
>> those syscalls.
> 
> The design is:
> 	sys_kexec_load()
> 	shutdown scripts
>         sys_reboot(LINUX_REBOOT_CMD_KEXEC);
> 
> There are two system call simply so that the shutdown scripts can run.
> Now maybe someone somewhere does something different but that is not
> expected.
> 
> Only the kexec on panic kernel is expected to persist somewhat
> indefinitely.  But that should be in memory that is reserved from boot
> time, and so the memory hotplug should have enough visibility to not
> allow that memory to be given up.

Yes, and AFAIK, memory blocks which hold the reserved crashkernel area
can usually not get offlined and, therefore, the memory cannot get removed.

Interestingly, s390x even has a hotplug notifier for that

arch/s390/kernel/setup.c:kdump_mem_notifier()

(offlining of memory on s390x can result in memory getting depopulated
in the hypervisor, so after it would have been offlined, it would no
longer be accessible. I somewhat doubt that this notifier is really
needed - all pages in the crashkernel area should look like ordinary
allocated pages when the area is reserved early during boot via the
memblock allocator, and therefore offlining cannot succeed. But that's a
different story - and I suspect this is a leftover from pre-memblock times.)

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
