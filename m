Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1awLhw-0007Jd-Ao
 for kexec@lists.infradead.org; Sat, 30 Apr 2016 03:36:41 +0000
Received: by mail-oi0-f49.google.com with SMTP id x201so139316406oif.3
 for <kexec@lists.infradead.org>; Fri, 29 Apr 2016 20:36:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160429181008.GV19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviEp-0000ir-7s@rmk-PC.arm.linux.org.uk>
 <CAHB_GuqOvRof94QdHztPy2B2kKuyKzQ-9uxXHY_g+i5WxsexZg@mail.gmail.com>
 <20160429181008.GV19428@n2100.arm.linux.org.uk>
Date: Sat, 30 Apr 2016 09:06:19 +0530
Message-ID: <CAHB_GuoQM9dzgyd+67QPOReLW4HYNqyuzKGzB7Fzq=dpWYHf_w@mail.gmail.com>
Subject: Re: [PATCH 03/12] ARM: kexec: remove 512MB restriction on kexec
 crashdump
From: Pratyush Anand <panand@redhat.com>
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On Fri, Apr 29, 2016 at 11:40 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 29, 2016 at 07:49:45PM +0530, Pratyush Anand wrote:
>> On Thu, Apr 28, 2016 at 2:57 PM, Russell King
>> <rmk+kernel@arm.linux.org.uk> wrote:
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > ---
>> >  arch/arm/kernel/setup.c | 5 +----
>> >  1 file changed, 1 insertion(+), 4 deletions(-)
>> >
>> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>> > index 77b54c461c52..d9317eec1eba 100644
>> > --- a/arch/arm/kernel/setup.c
>> > +++ b/arch/arm/kernel/setup.c
>> > @@ -943,7 +943,6 @@ late_initcall(init_machine_late);
>> >   * zImage relocating below the reserved region.
>> >   */
>> >  #define CRASH_ALIGN    (128 << 20)
>> > -#define CRASH_ADDR_MAX (PHYS_OFFSET + (512 << 20))
>> >
>> >  static inline unsigned long long get_total_mem(void)
>> >  {
>> > @@ -973,9 +972,7 @@ static void __init reserve_crashkernel(void)
>> >                 return;
>> >
>> >         if (crash_base <= 0) {
>> > -               unsigned long long crash_max = CRASH_ADDR_MAX;
>> > -               if (crash_max > (u32)~0)
>> > -                       crash_max = (u32)~0;
>> > +               unsigned long long crash_max = idmap_to_phys((u32)~0);
>> >                 crash_base = memblock_find_in_range(CRASH_ALIGN, crash_max,
>> >                                                     crash_size, CRASH_ALIGN);
>> >                 if (!crash_base) {
>>
>> Reviewed-by: Pratyush Anand <panand@redhat.com>
>>
>> Unrelated to these modification:
>> In function arch/arm/mm/init.c: arm_memblock_steal() may be  following
>> would be more appropriate?
>> memblock_alloc_base(size, align, idmap_to_phys(MEMBLOCK_ALLOC_ANYWHERE));
>
> No, arm_memblock_steal() is totally unsuitable.  arm_memblock_steal()
> *removes* the memory range from memblock, including removing the
> mapping of that memory.  It will make the memory range inaccessible to
> the kernel.
>
> Since kexec wants to write directly to this memory, using
> arm_memblock_steal() will have the cause the kernel to OOPS when
> it hits the resulting hole.
>

Sorry, I was not trying to say that we should use arm_memblock_steal()
here. As I said, this comment is totally unrelated to this patch
series. In arm_memblock_steal() we pass MEMBLOCK_ALLOC_ANYWHERE as
max_addr. Probably,  it would be good to pass
idmap_to_phys(MEMBLOCK_ALLOC_ANYWHERE).

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
