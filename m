Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 3 May 2016 12:24:41 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 10/12] kexec: arrange for paddr_vmcoreinfo_note() to
 return phys_addr_t
Message-ID: <20160503042441.GA2518@x1.redhat.com>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviFP-0000je-5t@rmk-PC.arm.linux.org.uk>
 <CAHB_Gur-6oyEheN-Pom7OwivdvrQpCBaXvM1V2H0JPFRCFZthA@mail.gmail.com>
 <20160429151639.GC23726@leverpostej>
 <CAHB_GurwYqPbccLU9UHppLxbBr4Cfs47myKAer-RJicT=T7uBw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHB_GurwYqPbccLU9UHppLxbBr4Cfs47myKAer-RJicT=T7uBw@mail.gmail.com>
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
To: Pratyush Anand <panand@redhat.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>, linux-arm-kernel@lists.infradead.org

This patch is clearly related to kdump. The prefix of subject should be
changed to kdump. Kexec doesn't need to handle vmcore things. 

And patches realted to kexec/kdump should be CCed to Andrew, he usually
picks up and add them into akpm tree.

Hi Pratyush,

Could you please help tell why arm PAE kernel can be put above 4G?
Since the change is related to common code, I am curious about how
it's so different with other ARCHs.

Thanks
Baoquan


On 04/29/16 at 09:17pm, Pratyush Anand wrote:
> On Fri, Apr 29, 2016 at 8:46 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Apr 29, 2016 at 08:36:43PM +0530, Pratyush Anand wrote:
> >> > +       phys_addr_t vmcore_base = paddr_vmcoreinfo_note();
> >> > +       return sprintf(buf, "%pa %x\n", &vmcore_base,
> >>
> >> Why do we pass &vmcore_base? Shouldn't it be vmcore_base?
> >
> > The %pa* printk format specifiers take the value by reference (as
> > phys_addr_t and friends are not necessarily the same width as a
> > pointer). Per Documentation/printk-formats.txt:
> >
> > Physical addresses types phys_addr_t:
> >
> >         %pa[p]  0x01234567 or 0x0123456789abcdef
> >
> >         For printing a phys_addr_t type (and its derivatives, such as
> >         resource_size_t) which can vary based on build options, regardless of
> >         the width of the CPU data path. Passed by reference.
> >
> > So the above prints the value of vmcore_base as expected.
> 
> Thanks a lot Mark for explaining :-)
> 
> Reviewed-by: Pratyush Anand <panand@redhat.com>
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
