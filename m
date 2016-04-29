Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1awAeA-0002J9-Ik
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 15:48:03 +0000
Received: by mail-ob0-f172.google.com with SMTP id x1so34455597obt.0
 for <kexec@lists.infradead.org>; Fri, 29 Apr 2016 08:47:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160429151639.GC23726@leverpostej>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviFP-0000je-5t@rmk-PC.arm.linux.org.uk>
 <CAHB_Gur-6oyEheN-Pom7OwivdvrQpCBaXvM1V2H0JPFRCFZthA@mail.gmail.com>
 <20160429151639.GC23726@leverpostej>
Date: Fri, 29 Apr 2016 21:17:40 +0530
Message-ID: <CAHB_GurwYqPbccLU9UHppLxbBr4Cfs47myKAer-RJicT=T7uBw@mail.gmail.com>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On Fri, Apr 29, 2016 at 8:46 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Apr 29, 2016 at 08:36:43PM +0530, Pratyush Anand wrote:
>> > +       phys_addr_t vmcore_base = paddr_vmcoreinfo_note();
>> > +       return sprintf(buf, "%pa %x\n", &vmcore_base,
>>
>> Why do we pass &vmcore_base? Shouldn't it be vmcore_base?
>
> The %pa* printk format specifiers take the value by reference (as
> phys_addr_t and friends are not necessarily the same width as a
> pointer). Per Documentation/printk-formats.txt:
>
> Physical addresses types phys_addr_t:
>
>         %pa[p]  0x01234567 or 0x0123456789abcdef
>
>         For printing a phys_addr_t type (and its derivatives, such as
>         resource_size_t) which can vary based on build options, regardless of
>         the width of the CPU data path. Passed by reference.
>
> So the above prints the value of vmcore_base as expected.

Thanks a lot Mark for explaining :-)

Reviewed-by: Pratyush Anand <panand@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
