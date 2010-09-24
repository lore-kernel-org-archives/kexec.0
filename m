Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cpoproxy2-pub.bluehost.com ([67.222.39.38])
	by bombadil.infradead.org with smtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OzBXP-0002Fo-A1
	for kexec@lists.infradead.org; Fri, 24 Sep 2010 16:54:20 +0000
Date: Fri, 24 Sep 2010 09:54:14 -0700
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] pci: add quirk for non-symmetric-mode irq routing to
	versions 0 and 4 of the MCP55 northbridge
Message-ID: <20100924095414.6947e8c7@jbarnes-desktop>
In-Reply-To: <20100921175439.GA21044@hmsreliant.think-freely.org>
References: <20100921175439.GA21044@hmsreliant.think-freely.org>
Mime-Version: 1.0
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-pci@vger.kernel.org, horms@verge.net.au, kexec@lists.infradead.org, vgoyal@redhat.com

On Tue, 21 Sep 2010 13:54:39 -0400
Neil Horman <nhorman@tuxdriver.com> wrote:

>     	A long time ago I worked on a RHEL5 bug in which kdump hung during boot
>     on a set of systems.  The systems hung because they never received timer
>     interrupts during calibrate_delay.  These systems also all had Opteron
>     processors on a hypertransport bus, bridged to a pci bus via an Nvidia MCP55
>     northbridge chip.  AFter much wrangling I managed to learn from Nvidia that they
>     have an undocumented register in some versions of that chip which control how
>     legacy interrupts are send to the cpu complex when the ioapic isn't active.
>     Nvidia defaults this register to only send legacy interrupts to the BSP, so if
>     kdump happens to boot on an AP, we never get timer interrupts and boom.  I had
>     initially used this quirk as a workaround, with my intent being to move apic
>     initalization to an earlier point in the boot process, so the setting of the
>     register would be irrelevant.  Given the work involved in doing that however,
>     the fragile nature of the apic initalization code, and the fact that, over the 2
>     years since we found this bug, the MCP55 is the only chip which seems to have
>     this issue, I've figure at this point its likely safer to just carry the quirk
>     around.  By setting the referenced bits in this hidden register, interrupts will
>     be broadcast to all cpus when the ioapic isn't active on the above described
>     systems.
>     
>     Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

Applied to my linux-next branch, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
