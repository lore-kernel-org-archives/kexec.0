Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TY7KO-0005UU-4w
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 03:38:22 +0000
Message-ID: <50A1C04F.3030704@redhat.com>
Date: Tue, 13 Nov 2012 11:36:47 +0800
From: Baoquan <bhe@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kexec: Limit the crash memory ranges according to
 first kernel's memory limit.
References: <20120829082201.19391.15191.stgit@mars.in.ibm.com>
 <50875E18.8010808@linux.vnet.ibm.com>
In-Reply-To: <50875E18.8010808@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Simon Horman <horms@verge.net.au>, Kexec-ml <kexec@lists.infradead.org>, Suzuki Poulose <suzuki@in.ibm.com>

Hi,

I have tested ppc64 part of this patchset, and it works.
Do you plan to merge this patchset?

On 10/24/2012 11:18 AM, Mahesh Jagannath Salgaonkar wrote:
> On 08/29/2012 01:54 PM, Mahesh J Salgaonkar wrote:
>> So far powerpc kernel never exported memory limit information which is
>> reflected by mem= kernel cmdline option. Hence, kexec-tools always use
>> to build ELF header for entire system RAM generating a dump bigger than
>> the actual memory used by the first kernel.
>>
>> The proposed upstream kernel patch at
>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-August/100500.html
>> now exports memory limit information through /proc/device-tree file.
>> The above patch is still in discussion.
> The above mentioned kernel patches are now upstream. Below are commit ids:
> 4bc77a5e - powerpc: Export memory limit via device tree
> a84fcd468 - powerpc: Change memory_limit from phys_addr_t to unsigned
> long long
>
>> This patch series now reads the memory limit information from
>> device-tree file if present and limits the crash memory ranges accordingly.
>>
>> Tested these patches on ppc32(ppc440) and ppc64 with a kernel patch by Suzuki.
>>
>> Signed-off-by: Mahesh Salgaonkar<mahesh@linux.vnet.ibm.com>
>> Tested-by: Suzuki K. Poulose<suzuki@in.ibm.com>
>>
>> ---
>>
>> Mahesh Salgaonkar (2):
>>        kexec: Respect memory limit while building crash memory ranges on ppc32.
>>        kexec: Respect memory limit while building crash memory ranges on ppc64
>>
>>
>>   kexec/arch/ppc/crashdump-powerpc.c |   14 ++++++++---
>>   kexec/arch/ppc/crashdump-powerpc.h |    1 +
>>   kexec/arch/ppc/kexec-ppc.c         |   48 ++++++++++++++++++++++++++++++++++++
>>   kexec/arch/ppc64/crashdump-ppc64.c |   11 ++++++++
>>   kexec/arch/ppc64/crashdump-ppc64.h |    1 +
>>   kexec/arch/ppc64/kexec-ppc64.c     |   28 +++++++++++++++++++++
>>   6 files changed, 99 insertions(+), 4 deletions(-)
>>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
