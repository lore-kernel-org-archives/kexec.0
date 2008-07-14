Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.247])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIIDr-0002JK-Nk
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 07:11:48 +0000
Received: by rv-out-0708.google.com with SMTP id b17so7589710rvf.42
	for <kexec@lists.infradead.org>; Mon, 14 Jul 2008 00:11:46 -0700 (PDT)
Message-ID: <86802c440807140011v728cc35fy2540b537ddca9844@mail.gmail.com>
Date: Mon, 14 Jul 2008 00:11:46 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] x86: Find offset for crashkernel reservation automatically
In-Reply-To: <20080627133256.GB5801@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<20080627133256.GB5801@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Fri, Jun 27, 2008 at 6:32 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Thu, Jun 26, 2008 at 09:54:08PM +0200, Bernhard Walle wrote:
>> This patch removes the need of the crashkernel=...@offset parameter to define
>> a fixed offset for crashkernel reservation. That feature can be used together
>> with a relocatable kernel where the kexec-tools relocate the kernel and
>> get the actual offset from /proc/iomem.
>>
>> The use case is a kernel where the .text+.data+.bss is after 16M physical
>> memory (debug kernel with lockdep on x86_64 can cause that) which caused a
>> major pain in autoconfiguration in our distribution.
>>
>> Also, that patch unifies crashdump architectures a bit since IA64 has
>> that semantics from the very beginning of the kdump port.
>>
>> Please provide feedback!
>>
>
> Hi Bernhard,
>
> This looks like a good idea. That means distributions don't have to
> hardcode the crashbase at 16MB and the decision to find a free memory
> can be left on kernel. Users will also find it easy that way.
>
>>
>> Signed-off-by: Bernhard Walle <bwalle@suse.de>
>> ---
>>  arch/x86/kernel/setup.c |   70 +++++++++++++++++++++++++++++++++++------------
>>  1 files changed, 52 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index a81d82c..c30bb7b 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -435,6 +435,34 @@ static inline unsigned long long get_total_mem(void)
>>  }
>>
>>  #ifdef CONFIG_KEXEC
>> +
>> +/**
>> + * Reserve @size bytes of crashkernel memory at any suitable offset.
>> + *
>> + * @size: Size of the crashkernel memory to reserve.
>> + * Returns the base address on success, and -1ULL on failure.
>> + */
>> +unsigned long long find_and_reserve_crashkernel(unsigned long long size)
>> +{
>> +     const unsigned long long alignment = 16<<20;    /* 16M */
>> +     unsigned long long start = 0LL;
>> +
>> +     while (1) {
>> +             int ret;
>> +
>> +             start = find_e820_area(start, ULONG_MAX, size, alignment);

should use min_t(u64, 1ULL<<32, max_low_pfn<<PAGE_SHIFT) replace ULONG_MAX

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
