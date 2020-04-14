Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-2-james.morse@arm.com>
 <321e6bf7-e898-7701-dd60-6c25237ff9cd@redhat.com>
 <a21d90ea-2566-a2bc-ad2f-6464a416c97f@arm.com>
 <9cb4ea0d-34c3-de42-4b3f-ee25a59c4835@redhat.com>
 <b0443908-e36f-9bc4-4a8a-4206cb782d4b@arm.com>
 <72672e2c-a57a-8df9-0cff-8035cbce7740@redhat.com>
 <34274b02-60ba-eb78-eacd-6dc1146ed3cd@arm.com>
 <80e4d1d7-f493-3f66-f700-86f18002d692@redhat.com>
 <dfacf85f-d79d-8742-7a13-1ac0a67bad04@arm.com>
 <ba481c82-c69e-043c-4b66-2d2c7732cf07@redhat.com>
 <20200410121013.03b609fd572504c03a666f4a@linux-foundation.org>
 <4ed2fa36-fcd8-7150-03d1-35f15e595ebb@redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <2e3419b2-d00c-51c3-9b45-9de114608cdf@arm.com>
Date: Tue, 14 Apr 2020 17:55:14 +0100
MIME-Version: 1.0
In-Reply-To: <4ed2fa36-fcd8-7150-03d1-35f15e595ebb@redhat.com>
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
To: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, Eric Biederman <ebiederm@xmission.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

Hi guys,

On 14/04/2020 08:05, David Hildenbrand wrote:
> On 10.04.20 21:10, Andrew Morton wrote:
>> It's unclear (to me) what is the status of this patchset.  But it does appear that
>> an new version can be expected?

> I'd suggest to unqueue the patches until we have a consensus.

Certainly!


> While there are a couple of ideas floating around here, my current
> suggestion would be either
> 
> 1. Indicate all hotplugged memory as "System RAM (hotplugged)" in
> /proc/iomem and the firmware memmap (on all architectures). This will
> require kexec changes,

> but I would have assume that kexec has to be
> updated in lock-step with the kernel

News to me: I was using the version I first built when arm64's support was new. I've only
had to update it once when we had to change user-space.

I don't think debian updates kexec-tools when it updates the kernel.


Making changes to /proc/iomem means updating user-space again, (for kdump). I'd like to
avoid that if its at all possible.


> just like e.g., makedumpfile.
> Modify kexec() to not place the kexec kernel on these areas (easy) but
> still consider them as crash regions to dump. When loading a kexec
> kernel, validate in the kernel that the memory is appropriate.


> 2. Make kexec() reload the the kernel whenever we e.g., get a udev event
> for removal of memory in /sys/devices/system/memory/.

I don't think we can rely on user-space to do something,


> On every remove_memory(), invalidate the loaded kernel in the kernel.

This is an option, ... but its a change of behaviour. If user-space asks for two
impossible things, the second request should fail. Having the first-one disappear is a bit
spooky...

Fortunately user-space checks the 'kexec -l' bit happened before it calls reboot() behind
'kexec -e'. So this works, but is not intuitive.

("Did I load it? What changed and when? oh, half a mile up in dmesg is a message saying
the kernel discarded the kexec kernel last wednesday.")


> As I mentioned somewhere, 1. will be interesting for virtio-mem, where
> we don't want any kexec kernel to be placed on virtio-mem-added memory.

Do these virtio-mem-added regions need to be accessible by kdump?
(do we already need a user-space change for that?)


A third option, along the line of what I posted:

Split the 'offline' and 'removed' ideas, which David mentioned somewhere. We'd end up with
(yet) another notifier chain, that prevents the memory being removed, but you can still
mark it as offline in /sys/. (...I'm not quite sure why you would do that...)

This would need hooking up for ACPI (which covers x86 and arm64), and other architectures
mechanisms for doing this...
arm64 can then switch is arch hook that prevents 'bootmem' being removed to this new
notifier chain, as the kernel can only boot from that was present at boot.


My preference is 3, then 2.

I think 1 is slightly less desirable than a message at kexec time that the memory layout
has changed since load, and this might not work...



Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
