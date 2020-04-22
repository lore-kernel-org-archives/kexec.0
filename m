Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 3/3] arm64: memory: Give hotplug memory a different
 resource name
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-4-james.morse@arm.com>
 <87v9m0fptf.fsf@x220.int.ebiederm.org>
From: James Morse <james.morse@arm.com>
Message-ID: <56c17c4e-fab4-5941-2239-e2aa77c8733d@arm.com>
Date: Wed, 22 Apr 2020 13:14:32 +0100
MIME-Version: 1.0
In-Reply-To: <87v9m0fptf.fsf@x220.int.ebiederm.org>
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

On 15/04/2020 21:37, Eric W. Biederman wrote:
> James Morse <james.morse@arm.com> writes:
> 
>> If kexec chooses to place the kernel in a memory region that was
>> added after boot, we fail to boot as the kernel is running from a
>> location that is not described as memory by the UEFI memory map or
>> the original DT.
>>
>> To prevent unaware user-space kexec from doing this accidentally,
>> give these regions a different name.
> 
> Please fix the problem and don't hack around it.

The problem is firmware didn't describe memory that wasn't present at boot.

arm64 relies on the firmware description of memory well before it can go poking around in
ACPI to find out where extra memory was added to the system.

We already need kexec to not overwrite in-memory structures left by firmware. (like, the
memory map). We do this by naming them reserved in /proc/iomem.

Doing the same for hotadded memory means existing kexec user-space can't do this
accidentally. The shape of /proc/iomem is the only trick in the book for arm64's kexec
userspace, as its the only thing it looks at.



Thanks,

James






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
