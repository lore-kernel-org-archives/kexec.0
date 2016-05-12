Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b0lu6-0006Fz-Jo
 for kexec@lists.infradead.org; Thu, 12 May 2016 08:23:33 +0000
Date: Thu, 12 May 2016 09:22:42 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 11/12] kexec: allow architectures to override boot mapping
Message-ID: <20160512082242.GQ19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviFU-0000jk-9q@rmk-PC.arm.linux.org.uk>
 <20160512062627.GB2711@x1.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160512062627.GB2711@x1.redhat.com>
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
To: Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>

On Thu, May 12, 2016 at 02:26:27PM +0800, Baoquan He wrote:
> On 04/28/16 at 10:28am, Russell King wrote:
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 52a3a221bcb2..99cb9dac7909 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -318,6 +318,44 @@ int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
> >  int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> >  					unsigned int relsec);
> >  
> > +#ifndef page_to_boot_pfn
> > +static inline unsigned long page_to_boot_pfn(struct page *page)
> > +{
> > +	return page_to_pfn(page);
> > +}
> > +#endif
> 
> I am thinking if it's appropriate to introduce a new concept which only
> exists in a certain system of a certain ARCH. Is it unavoidable? If have
> to can we name it as kexec_page_to_pfn/kexec_pfn_to_page, etc? People
> might not need to know about boot view physical address and kernel view
> physical address things when they just want to understand kexec
> implementation related to one ARCH except of ARM, even related to ARM
> but not Keystone 2.

Well, what do you suggest we do instead?

Eric, please get involved in this discussion, as this was your idea.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
