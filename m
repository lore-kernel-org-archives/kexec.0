Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 2/3] mm/memory_hotplug: Allow arch override of non boot
 memory resource names
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-3-james.morse@arm.com>
 <873694h4g3.fsf@x220.int.ebiederm.org>
From: James Morse <james.morse@arm.com>
Message-ID: <f1678470-33a6-58c9-d7d3-16ac87d01714@arm.com>
Date: Wed, 22 Apr 2020 13:14:08 +0100
MIME-Version: 1.0
In-Reply-To: <873694h4g3.fsf@x220.int.ebiederm.org>
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

On 15/04/2020 21:36, Eric W. Biederman wrote:
> James Morse <james.morse@arm.com> writes:
> 
>> Memory added to the system by hotplug has a 'System RAM' resource created
>> for it. This is exposed to user-space via /proc/iomem.
>>
>> This poses problems for kexec on arm64. If kexec decides to place the
>> kernel in one of these newly onlined regions, the new kernel will find
>> itself booting from a region not described as memory in the firmware
>> tables.
>>
>> Arm64 doesn't have a structure like the e820 memory map that can be
>> re-written when memory is brought online. Instead arm64 uses the UEFI
>> memory map, or the memory node from the DT, sometimes both. We never
>> rewrite these.
>>
>> Allow an architecture to specify a different name for these hotplug
>> regions.
> 
> Gah.  No.
> 
> Please find a way to pass the current memory map to the loaded kexec'd
> kernel.

> Starting a kernel with no way for it to know what the current memory map
> is just plain scary.

We have one. Firmware tables are the source of all this information. We don't tamper with
them.

Firmware describes memory present at boot in the UEFI memory map or DT. On systems with
ACPI, regions that were added after booting are discovered by running AML methods. (for
which we need to allocate memory, so you can't describe boot memory like this)

This doesn't work if you kexec from a hot-added region. You've booted from memory that
wasn't present at boot.

I don't think this is fixable with the set of constraints.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
