Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-2-james.morse@arm.com>
 <87d088h4k8.fsf@x220.int.ebiederm.org>
 <a694cea6-4449-c77a-98f7-bd7a49cf47fc@arm.com>
Date: Wed, 22 Apr 2020 10:25:23 -0500
In-Reply-To: <a694cea6-4449-c77a-98f7-bd7a49cf47fc@arm.com> (James Morse's
 message of "Wed, 22 Apr 2020 13:28:59 +0100")
Message-ID: <87y2qn1r18.fsf@x220.int.ebiederm.org>
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
To: James Morse <james.morse@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

James Morse <james.morse@arm.com> writes:

> Hi Eric,
>
> On 15/04/2020 21:33, Eric W. Biederman wrote:
>> James Morse <james.morse@arm.com> writes:
>> 
>>> An image loaded for kexec is not stored in place, instead its segments
>>> are scattered through memory, and are re-assembled when needed. In the
>>> meantime, the target memory may have been removed.
>>>
>>> Because mm is not aware that this memory is still in use, it allows it
>>> to be removed.
>>>
>>> Add a memory notifier to prevent the removal of memory regions that
>>> overlap with a loaded kexec image segment. e.g., when triggered from the
>>> Qemu console:
>>> | kexec_core: memory region in use
>>> | memory memory32: Offline failed.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>> 
>> Given that we are talking about the destination pages for kexec
>> not where the loaded kernel is currently stored the description is
>> confusing.
>
> I think David has some better wording to cover this. I thought I had it with 'scattered
> and re-assembled'.

The confusing part was talking about memory being still in use,
that is actually scheduled for use in the future.

>> Usually somewhere in the loaded image
>> is a copy of the memory map at the time the kexec kernel was loaded.
>> That will invalidate the memory map as well.
>
> Ah, unconditionally. Sure, x86 needs this.
> (arm64 re-discovers the memory map from firmware tables after kexec)
>
> If that's an acceptable change in behaviour, sure, lets do that.

Yes.


>> All of this should be for a very brief window of a few seconds, as
>> the loaded kexec image is quite short.
>
> It seems I'm the outlier anticipating anything could happen between
> those syscalls.

The design is:
	sys_kexec_load()
	shutdown scripts
        sys_reboot(LINUX_REBOOT_CMD_KEXEC);

There are two system call simply so that the shutdown scripts can run.
Now maybe someone somewhere does something different but that is not
expected.

Only the kexec on panic kernel is expected to persist somewhat
indefinitely.  But that should be in memory that is reserved from boot
time, and so the memory hotplug should have enough visibility to not
allow that memory to be given up.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
