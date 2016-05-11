Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 11 May 2016 17:13:38 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 00/12] Fixing TI Keystone2 kexec
Message-ID: <20160511091338.GC10825@dhcp-128-65.nay.redhat.com>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <20160511082923.GC8995@dhcp-128-65.nay.redhat.com>
 <20160511085203.GN19428@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160511085203.GN19428@n2100.arm.linux.org.uk>
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On 05/11/16 at 09:52am, Russell King - ARM Linux wrote:
> On Wed, May 11, 2016 at 04:29:23PM +0800, Dave Young wrote:
> > Hi, Russell
> > 
> > On 04/28/16 at 10:26am, Russell King - ARM Linux wrote:
> > > These changes are required for TI Keystone2 kexec to be functional.  TI
> > > Keystone2 has the run-time view of physical memory above 4GiB, but with
> > > a boot time alias below 4GiB which can only be used during the early
> > > boot.
> > > 
> > > This means we need to translate run-time physical addresses (which the
> > > kernel uses) to boot-time physical addresses, which, having discussed
> > > with Eric, is what the kexec tools and kexec kernel API requires.
> > > 
> > > We publish a special set of boot time resources in /proc/iomem, which
> > > the (modified) kexec tools look for in preference to the normal resources.
> > > Hence, if these are found, the kexec tools make use of these resources,
> > > and thus kexec tools use the boot-time view of physical memory.
> > 
> > I think getting memory ranges from device tree will be better than
> > adding more stuff to /proc/iomem. Geoff's arm64 kexec patches is using dtb
> > you can refer to the patchset.
> 
> I think you're confusing things.  DT doesn't contain the boot alias
> memory ranges - it's not a separate chunk of memory.  It's an alias
> of the same physical address space found higher in the physical
> address range.

Hmm, if we forget about kexec how does the 1st kernel get boot memory?
not from DT?

> 
> If we put it in DT, then we need a way to also describe that it is an
> alias of some other bit of physical memory.

I may missed the background, I just want kexec to get infomation just like
the normal kernel.

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
