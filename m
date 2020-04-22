Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-2-james.morse@arm.com>
 <87d088h4k8.fsf@x220.int.ebiederm.org>
From: James Morse <james.morse@arm.com>
Message-ID: <a694cea6-4449-c77a-98f7-bd7a49cf47fc@arm.com>
Date: Wed, 22 Apr 2020 13:28:59 +0100
MIME-Version: 1.0
In-Reply-To: <87d088h4k8.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

Hi Eric,

On 15/04/2020 21:33, Eric W. Biederman wrote:
> James Morse <james.morse@arm.com> writes:
> 
>> An image loaded for kexec is not stored in place, instead its segments
>> are scattered through memory, and are re-assembled when needed. In the
>> meantime, the target memory may have been removed.
>>
>> Because mm is not aware that this memory is still in use, it allows it
>> to be removed.
>>
>> Add a memory notifier to prevent the removal of memory regions that
>> overlap with a loaded kexec image segment. e.g., when triggered from the
>> Qemu console:
>> | kexec_core: memory region in use
>> | memory memory32: Offline failed.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Given that we are talking about the destination pages for kexec
> not where the loaded kernel is currently stored the description is
> confusing.

I think David has some better wording to cover this. I thought I had it with 'scattered
and re-assembled'.


> Beyond that I think it would be better to simply unload the loaded
> kernel at memory hotunplug time.

Unconditionally, or if it aliases the removed region?

I don't particular like it. User-space has asked for two impossible things, we are
changing the answer to the first when we see the second. Its a bit spooky. (maybe no one
will notice)


> Usually somewhere in the loaded image
> is a copy of the memory map at the time the kexec kernel was loaded.
> That will invalidate the memory map as well.

Ah, unconditionally. Sure, x86 needs this.
(arm64 re-discovers the memory map from firmware tables after kexec)

If that's an acceptable change in behaviour, sure, lets do that.


> All of this should be for a very brief window of a few seconds, as
> the loaded kexec image is quite short.

It seems I'm the outlier anticipating anything could happen between those syscalls.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
