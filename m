Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 2/3] mm/memory_hotplug: Allow arch override of non boot
 memory resource names
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-3-james.morse@arm.com>
 <20200402054946.GA97238@dhcp-128-65.nay.redhat.com>
 <9725d779-e0de-2d8d-8716-22df3e791820@redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <66b0cb1a-d63a-2720-19cf-3d8efcd02fde@arm.com>
Date: Tue, 14 Apr 2020 18:21:16 +0100
MIME-Version: 1.0
In-Reply-To: <9725d779-e0de-2d8d-8716-22df3e791820@redhat.com>
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
To: piliu <piliu@redhat.com>
Cc: Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, Eric Biederman <ebiederm@xmission.com>, Hari Bathini <hbathini@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

Hi Dave, Pingfan,

On 02/04/2020 07:12, piliu wrote:
> On 04/02/2020 01:49 PM, Dave Young wrote:
>> On 03/26/20 at 06:07pm, James Morse wrote:
>>> Memory added to the system by hotplug has a 'System RAM' resource created
>>> for it. This is exposed to user-space via /proc/iomem.
>>>
>>> This poses problems for kexec on arm64. If kexec decides to place the
>>> kernel in one of these newly onlined regions, the new kernel will find
>>> itself booting from a region not described as memory in the firmware
>>> tables.
>>>
>>> Arm64 doesn't have a structure like the e820 memory map that can be
>>> re-written when memory is brought online. Instead arm64 uses the UEFI
>>> memory map, or the memory node from the DT, sometimes both. We never
>>> rewrite these.
>>
>> Could arm64 use similar way to update DT, or a cooked UEFI maps?

>> Add pingfan in cc, he said ppc64 update the DT after a memremove thus it
>> would be good to just redo a kexec load.

> Yes, the memory changes will be observed through device-node under
> /proc/device-tree/ (which is for powerpc).
> 
> Later if running kexec -l/-p , it can build new dtb with the latest info
> from /proc/device-tree
For arm64, the device-tree is set in stone. We don't have the runtime parts of
open-firmware that powerpc does. (my knowledge in this area is extremely sparse)
arm64 platforms where stuff like this changes tend to use ACPI instead, and these all have
to boot with UEFI, which means its the UEFI memory map that has authority.

We don't cook a fake UEFI memory map when things change because we treat it like the
set-in-stone DT. This means we only have discrepancies in firmware to workaround, instead
of any we introduce ourselves.

One of the UEFI configuration tables describes addresses Linux programmed into hardware
that can't be reset. Newer versions of Linux know how to pick these up on kexec... but
older versions don't know how to parse/rewrite/move that table. Cooking up new versions of
these tables would prevent us doing stuff like this, which we need to workaround hardware
that didn't get the 'kexec exists' memo.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
