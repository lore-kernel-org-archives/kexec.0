Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-2-james.morse@arm.com>
Date: Wed, 15 Apr 2020 15:33:43 -0500
In-Reply-To: <20200326180730.4754-2-james.morse@arm.com> (James Morse's
 message of "Thu, 26 Mar 2020 18:07:28 +0000")
Message-ID: <87d088h4k8.fsf@x220.int.ebiederm.org>
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

> An image loaded for kexec is not stored in place, instead its segments
> are scattered through memory, and are re-assembled when needed. In the
> meantime, the target memory may have been removed.
>
> Because mm is not aware that this memory is still in use, it allows it
> to be removed.
>
> Add a memory notifier to prevent the removal of memory regions that
> overlap with a loaded kexec image segment. e.g., when triggered from the
> Qemu console:
> | kexec_core: memory region in use
> | memory memory32: Offline failed.
>
> Signed-off-by: James Morse <james.morse@arm.com>

Given that we are talking about the destination pages for kexec
not where the loaded kernel is currently stored the description is
confusing.

Beyond that I think it would be better to simply unload the loaded
kernel at memory hotunplug time.  Usually somewhere in the loaded image
is a copy of the memory map at the time the kexec kernel was loaded.
That will invalidate the memory map as well.

All of this should be for a very brief window of a few seconds, as
the loaded kexec image is quite short.

So instead of failing in the notifier, if you could simply unload the
loaded image in the notifier I think that would be simpler and more
robust.  While still preventing the loaded image from falling over
when it starts executing.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
