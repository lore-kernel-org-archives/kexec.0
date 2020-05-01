Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-2-james.morse@arm.com>
 <87d088h4k8.fsf@x220.int.ebiederm.org>
 <a694cea6-4449-c77a-98f7-bd7a49cf47fc@arm.com>
 <87y2qn1r18.fsf@x220.int.ebiederm.org>
 <a29beedb-750b-b838-6c2a-6e47ade2186a@redhat.com>
Message-ID: <b5642228-c95b-7aca-b454-a07dde3d1866@arm.com>
Date: Fri, 1 May 2020 17:55:19 +0100
MIME-Version: 1.0
In-Reply-To: <a29beedb-750b-b838-6c2a-6e47ade2186a@redhat.com>
Content-Language: en-GB
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
To: David Hildenbrand <david@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

Hi guys,

On 22/04/2020 17:40, David Hildenbrand wrote:
>>>> Usually somewhere in the loaded image
>>>> is a copy of the memory map at the time the kexec kernel was loaded.
>>>> That will invalidate the memory map as well.
>>>
>>> Ah, unconditionally. Sure, x86 needs this.
>>> (arm64 re-discovers the memory map from firmware tables after kexec)

> Does this include hotplugged DIMMs e.g., under KVM?

If you advertise hotplugged memory to the guest using ACPI, yes.

We don't have a practical mechanism to pass 'fact's about the platform between kernels,
instead we rely on those facts being discoverable, or described by firmware.


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

[...]

> Yes, and AFAIK, memory blocks which hold the reserved crashkernel area
> can usually not get offlined and, therefore, the memory cannot get removed.

The crashkernel area on arm64 will always land in un-removable memory. We set PG_Reserved
on it too.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
