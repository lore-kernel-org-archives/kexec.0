Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 7 Oct 2014 15:06:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/7] arm64 kexec kernel patches V3
Message-ID: <20141007140623.GS24725@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <20140930202904.GB24153@redhat.com>
 <1412112476.6630.56.camel@smoke>
 <20141002190836.GA26882@redhat.com>
 <1412290795.32313.14.camel@smoke>
 <20141007134320.GD27464@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141007134320.GD27464@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Oct 07, 2014 at 02:43:20PM +0100, Vivek Goyal wrote:
> On Thu, Oct 02, 2014 at 03:59:55PM -0700, Geoff Levand wrote:
> > Hi Vivek,
> > 
> > On Thu, 2014-10-02 at 15:08 -0400, Vivek Goyal wrote:
> > > On Tue, Sep 30, 2014 at 02:27:56PM -0700, Geoff Levand wrote:
> > > > For a running system you can check the device tree:
> > > > 
> > > >   cat /proc/device-tree/cpus/cpu\@0/enable-method | hexdump -C
> > > > 
> > > 
> > > So system I have supports spin-table method for cpu bringup. How do I 
> > > test your patches with that system. Are there any patches on your
> > > spin-table branch which can make it working?
> > 
> > If possible, check if there is a firmware update that supports PSCI.
> > 
> > My spin-table patches are now out of date, and fixing those up is
> > now low priority.
> 
> So psci method for cpu bring up is more popular as comapred to 
> spin-table one? 

PSCI is the preferred method, and it is what we expect to see in server
machines featuring EL3. There are implementation in KVM and Xen, and on
physical machines (Juno so ar) with the ARM Trusted Firmware. The Linux
bootwrapper features a trivial (pre-v1) implementation, and there has
been work to implement PSCI in U-Boot.

The spin-table mechanism has no provision for returning CPUs to the
firmware, so it's not possible to hotplug CPUs. Vendors are using during
bringup so firmware and kernel can be developed in parallel, but I would
expect that for enterprise products PSCI should be available.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
