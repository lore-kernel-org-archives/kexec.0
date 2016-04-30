Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1awLZU-0002gm-UL
 for kexec@lists.infradead.org; Sat, 30 Apr 2016 03:27:58 +0000
Received: by mail-oi0-f48.google.com with SMTP id v145so105814510oie.0
 for <kexec@lists.infradead.org>; Fri, 29 Apr 2016 20:27:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160429180024.GS19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviF4-0000jG-MO@rmk-PC.arm.linux.org.uk>
 <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <20160429180024.GS19428@n2100.arm.linux.org.uk>
Date: Sat, 30 Apr 2016 08:57:34 +0530
Message-ID: <CAHB_GuqhPJ7J-MNbjxqeQnogW-J6=Bt2e1STKSG5kzJT+4PJpg@mail.gmail.com>
Subject: Re: [PATCH 06/12] ARM: kexec: advertise location of bootable RAM
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

On Fri, Apr 29, 2016 at 11:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 29, 2016 at 08:26:00PM +0530, Pratyush Anand wrote:
>> Hi Russell,
>>
>> On Thu, Apr 28, 2016 at 2:58 PM, Russell King
>> <rmk+kernel@arm.linux.org.uk> wrote:
>> > Advertise the location of bootable RAM to kexec-tools.  kexec needs to
>> > know where it can place the kernel in RAM, and so be executable when
>> > the system needs to jump into it.
>> >
>> > Advertise these areas in /proc/iomem with a "System RAM (boot alias)"
>> > tag.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>> Can you please also share git tree path of corresponding kexec-tools changes?
>>
>> Could it be a better idea (if things in user space become simpler)
>> that in stead of patch 5 and 6, we pass arch_phys_to_idmap_offset to
>> user space, and then user space manipulates existing "Crash kernel"
>> and "System RAM" resources.
>
> Given that it's only _one_ platform right now, I don't think that
> additional complexity is worth it.  It means that we have to invent

Probably, I could not communicate it well.  I was not trying  to have
*additional* complexity. Wanted to see if things could be simpler
rather. So this is what my understanding was:
-- We create one patch to pass arch_phys_to_idmap_offset to user space
(say in /sys/kernel/bootmem_idmap_offset)
-- We do not use patch 5,6,11 and 12 of this series. Probably few more
content of the series will go away.
--  In kexec-tools code , we read /sys/kernel/bootmem_idmap_offset and
add that value in "start" and "end" of "Crash Kernel" and "System RAM"
resources.

> some API to do it, and I don't see why userspace should even care
> about having the delta exported - especially when the conversion
> may not be as trivial.
>

Yes, I agree, if translation is not trivial like that of keystone,
then what I am proposing will not work.

Reviewed-by: Pratyush Anand <panand@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
