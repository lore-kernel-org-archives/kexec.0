Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1awCiv-0002bu-S5
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 18:01:08 +0000
Date: Fri, 29 Apr 2016 19:00:24 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 06/12] ARM: kexec: advertise location of bootable RAM
Message-ID: <20160429180024.GS19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviF4-0000jG-MO@rmk-PC.arm.linux.org.uk>
 <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On Fri, Apr 29, 2016 at 08:26:00PM +0530, Pratyush Anand wrote:
> Hi Russell,
> 
> On Thu, Apr 28, 2016 at 2:58 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Advertise the location of bootable RAM to kexec-tools.  kexec needs to
> > know where it can place the kernel in RAM, and so be executable when
> > the system needs to jump into it.
> >
> > Advertise these areas in /proc/iomem with a "System RAM (boot alias)"
> > tag.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Can you please also share git tree path of corresponding kexec-tools changes?
> 
> Could it be a better idea (if things in user space become simpler)
> that in stead of patch 5 and 6, we pass arch_phys_to_idmap_offset to
> user space, and then user space manipulates existing "Crash kernel"
> and "System RAM" resources.

Given that it's only _one_ platform right now, I don't think that
additional complexity is worth it.  It means that we have to invent
some API to do it, and I don't see why userspace should even care
about having the delta exported - especially when the conversion
may not be as trivial.

The method I've implemented here keeps things completely independent
of whatever conversion between boot and running physical addresses
may be present on the kernel side as far as userspace is concerned.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
