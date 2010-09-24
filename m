Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OzCJX-0005XF-ME
	for kexec@lists.infradead.org; Fri, 24 Sep 2010 17:44:04 +0000
Date: Fri, 24 Sep 2010 13:40:41 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH] pci: add quirk for non-symmetric-mode irq routing to
	versions 0 and 4 of the MCP55 northbridge
Message-ID: <20100924174041.GF30441@hmsreliant.think-freely.org>
References: <20100921175439.GA21044@hmsreliant.think-freely.org>
	<20100924095414.6947e8c7@jbarnes-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100924095414.6947e8c7@jbarnes-desktop>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, horms@verge.net.au, kexec@lists.infradead.org, vgoyal@redhat.com, Neil Horman <nhorman@tuxdriver.com>

On Fri, Sep 24, 2010 at 09:54:14AM -0700, Jesse Barnes wrote:
> On Tue, 21 Sep 2010 13:54:39 -0400
> Neil Horman <nhorman@tuxdriver.com> wrote:
> 
> >     	A long time ago I worked on a RHEL5 bug in which kdump hung during boot
> >     on a set of systems.  The systems hung because they never received timer
> >     interrupts during calibrate_delay.  These systems also all had Opteron
> >     processors on a hypertransport bus, bridged to a pci bus via an Nvidia MCP55
> >     northbridge chip.  AFter much wrangling I managed to learn from Nvidia that they
> >     have an undocumented register in some versions of that chip which control how
> >     legacy interrupts are send to the cpu complex when the ioapic isn't active.
> >     Nvidia defaults this register to only send legacy interrupts to the BSP, so if
> >     kdump happens to boot on an AP, we never get timer interrupts and boom.  I had
> >     initially used this quirk as a workaround, with my intent being to move apic
> >     initalization to an earlier point in the boot process, so the setting of the
> >     register would be irrelevant.  Given the work involved in doing that however,
> >     the fragile nature of the apic initalization code, and the fact that, over the 2
> >     years since we found this bug, the MCP55 is the only chip which seems to have
> >     this issue, I've figure at this point its likely safer to just carry the quirk
> >     around.  By setting the referenced bits in this hidden register, interrupts will
> >     be broadcast to all cpus when the ioapic isn't active on the above described
> >     systems.
> >     
> >     Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
> Applied to my linux-next branch, thanks.
> 
Thanks!
Neil

> -- 
> Jesse Barnes, Intel Open Source Technology Center
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
