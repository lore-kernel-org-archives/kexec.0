Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1awLcX-00059c-2O
 for kexec@lists.infradead.org; Sat, 30 Apr 2016 03:31:05 +0000
Received: by mail-oi0-f46.google.com with SMTP id x201so139243512oif.3
 for <kexec@lists.infradead.org>; Fri, 29 Apr 2016 20:30:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160429180619.GT19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviFP-0000je-5t@rmk-PC.arm.linux.org.uk>
 <CAHB_Gur-6oyEheN-Pom7OwivdvrQpCBaXvM1V2H0JPFRCFZthA@mail.gmail.com>
 <20160429180619.GT19428@n2100.arm.linux.org.uk>
Date: Sat, 30 Apr 2016 09:00:44 +0530
Message-ID: <CAHB_Gup5EMF36qECiWUP+_6D+4+DCQ5JyKkiK_88+n-sJ0BriQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] kexec: arrange for paddr_vmcoreinfo_note() to
 return phys_addr_t
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

On Fri, Apr 29, 2016 at 11:36 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 29, 2016 at 08:36:43PM +0530, Pratyush Anand wrote:
>> On Thu, Apr 28, 2016 at 2:58 PM, Russell King
>> <rmk+kernel@arm.linux.org.uk> wrote:
>> > diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
>> > index 152da4a48867..9f1920d2d0c6 100644
>> > --- a/kernel/ksysfs.c
>> > +++ b/kernel/ksysfs.c
>> > @@ -128,8 +128,8 @@ KERNEL_ATTR_RW(kexec_crash_size);
>> >  static ssize_t vmcoreinfo_show(struct kobject *kobj,
>> >                                struct kobj_attribute *attr, char *buf)
>> >  {
>> > -       return sprintf(buf, "%lx %x\n",
>> > -                      paddr_vmcoreinfo_note(),
>> > +       phys_addr_t vmcore_base = paddr_vmcoreinfo_note();
>> > +       return sprintf(buf, "%pa %x\n", &vmcore_base,
>>
>> Why do we pass &vmcore_base? Shouldn't it be vmcore_base?
>
> You seem to not know what the "%pa" format string means.

Apologies, Yes, yes.. it was my negligence.

>
> %p always takes a _pointer_ as per C standard, so the printf argument
> must be a pointer.  However, the kernel format strings are extended
> with additional suffixes - in this case 'a', which means that we want
> to print the contents of a _pointer_ to a phys_addr_t.
>
> Full details in Documentation/printk-formats.txt in the kernel.

Thanks for explaining :-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
