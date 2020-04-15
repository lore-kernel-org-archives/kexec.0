Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200326180730.4754-1-james.morse@arm.com>
Date: Wed, 15 Apr 2020 15:29:32 -0500
In-Reply-To: <20200326180730.4754-1-james.morse@arm.com> (James Morse's
 message of "Thu, 26 Mar 2020 18:07:27 +0000")
Message-ID: <87sgh4h4r7.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] kexec/memory_hotplug: Prevent removal and accidental
 use
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

> Hello!
>
> arm64 recently queued support for memory hotremove, which led to some
> new corner cases for kexec.
>
> If the kexec segments are loaded for a removable region, that region may
> be removed before kexec actually occurs. This causes the first kernel to
> lockup when applying the relocations. (I've triggered this on x86 too).
>
> The first patch adds a memory notifier for kexec so that it can refuse
> to allow in-use regions to be taken offline.
>
>
> This doesn't solve the problem for arm64, where the new kernel must
> initially rely on the data structures from the first boot to describe
> memory. These don't describe hotpluggable memory.
> If kexec places the kernel in one of these regions, it must also provide
> a DT that describes the region in which the kernel was mapped as memory.
> (and somehow ensure its always present in the future...)
>
> To prevent this from happening accidentally with unaware user-space,
> patches two and three allow arm64 to give these regions a different
> name.
>
> This is a change in behaviour for arm64 as memory hotadd and hotremove
> were added separately.
>
>
> I haven't tried kdump.
> Unaware kdump from user-space probably won't describe the hotplug
> regions if the name is different, which saves us from problems if
> the memory is no longer present at kdump time, but means the vmcore
> is incomplete.
>
>
> These patches are based on arm64's for-next/core branch, but can all
> be merged independently.

So I just looked through these quickly and I think there are real
problems here we can fix, and that are worth fixing.

However I am not thrilled with the fixes you propose.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
