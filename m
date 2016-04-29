Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1awCqY-0005vB-1L
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 18:08:59 +0000
Date: Fri, 29 Apr 2016 19:08:28 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 11/12] kexec: allow architectures to override boot mapping
Message-ID: <20160429180828.GU19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviFU-0000jk-9q@rmk-PC.arm.linux.org.uk>
 <CAHB_GuoPDxqKbbfGHW8UEiuCxdMeEVBCMJpouaO--dbLomkzrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHB_GuoPDxqKbbfGHW8UEiuCxdMeEVBCMJpouaO--dbLomkzrQ@mail.gmail.com>
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

On Fri, Apr 29, 2016 at 08:44:29PM +0530, Pratyush Anand wrote:
> On Thu, Apr 28, 2016 at 2:58 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > kexec physical addresses are the boot-time view of the system.  For
> > certain ARM systems (such as Keystone 2), the boot view of the system
> > does not match the kernel's view of the system: the boot view uses a
> > special alias in the lower 4GB of the physical address space.
> >
> > To cater for these kinds of setups, we need to translate between the
> > boot view physical addresses and the normal kernel view physical
> > addresses.  This patch extracts the current transation points into
> > linux/kexec.h, and allows an architecture to override the functions.
> >
> > Due to the translations required, we unfortunately end up with six
> > translation functions, which are reduced down to four that the
> > architecture can override.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> I must be missing something when I am thinking that, had we passed
> arch_phys_to_idmap_offset to user space, this patch would not have
> been needed, and things would have been more simpler. Please help me
> to understand why passing arch_phys_to_idmap_offset to user space
> would not be a good idea.

Sorry, I disagree.

Even if we thought that passing the offset to userspace would be a
good idea, it does nothing to solve each site in this patch.  This
patch would still be necessary.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
