Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Xoy-0002TF-SW
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 11:24:29 +0000
Date: Fri, 14 Aug 2020 19:24:13 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/2] kexec: Add quick kexec support for kernel
Message-ID: <20200814112413.GA8097@dhcp-128-65.nay.redhat.com>
References: <20200814055239.47348-1-sangyan@huawei.com>
 <20200814065845.GA18234@dhcp-128-65.nay.redhat.com>
 <ad098e21-d689-f655-1e32-c93adcf0cb2d@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad098e21-d689-f655-1e32-c93adcf0cb2d@huawei.com>
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
To: Sang Yan <sangyan@huawei.com>
Cc: luanjianhai@huawei.com, pasha.tatashin@soleen.com, xiexiuqi@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, luchunhua@huawei.com, ebiederm@xmission.com, guohanjun@huawei.com, zhuling8@huawei.com

Hi,

On 08/14/20 at 04:21pm, Sang Yan wrote:
> 
> 
> On 08/14/20 14:58, Dave Young wrote:
> > On 08/14/20 at 01:52am, Sang Yan wrote:
> >> In normal kexec, relocating kernel may cost 5 ~ 10 seconds, to
> >> copy all segments from vmalloced memory to kernel boot memory,
> >> because of disabled mmu.
> > 
> > It is not the case on all archs, I assume your case is arm64, please
> > describe it in patch log :)
> > 
> Yes, it's particularly obvious on arm64. I will add it to the patch log,
> and test how long it takes on x86 and other arch.
> 
> > About the arm64 problem, I know Pavel Tatashin is working on a patchset
> > to improve the performance with enabling mmu.
> > 
> > I added Pavel in cc, can you try his patches?
> > 
> Thanks for your tips, I will try these patches. @Pavel.
> Disable mmu after finishing copying pages?
> >>
> >> We introduce quick kexec to save time of copying memory as above,
> >> just like kdump(kexec on crash), by using reserved memory
> >> "Quick Kexec".
> > 
> > This approach may have gain, but it also introduce extra requirements to
> > pre-reserve a memory region.  I wonder how Eric thinks about the idea.
> > 
> > Anyway the "quick" name sounds not very good, I would suggest do not
> > introduce a new param, and the code can check if pre-reserved region
> > exist then use it, if not then fallback to old way.
> > 
> aha. I agree with it, but I thought it may change the old behaviors of
> kexec_load.
> 
> I will update a new patch without introducing new flags and new params.

Frankly I'm still not sure it is worth to introduce a new interface if the
improvement can be done in arch code like Pavel is doing.  Can you try
that first?

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
