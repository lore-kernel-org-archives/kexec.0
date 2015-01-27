Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YFzaA-00026u-ES
 for kexec@lists.infradead.org; Tue, 27 Jan 2015 06:25:03 +0000
Date: Tue, 27 Jan 2015 14:24:34 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFD] efi assisted kdump
Message-ID: <20150127062433.GD2506@darkstar.redhat.com>
References: <20150124132637.GB2139@darkstar.redhat.com>
 <20150126140843.GA25559@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150126140843.GA25559@redhat.com>
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
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, matt.fleming@intel.com

On 01/26/15 at 09:08am, Vivek Goyal wrote:
> On Sat, Jan 24, 2015 at 09:26:37PM +0800, Dave Young wrote:
> > Hi,
> > 
> > Kdump has several limitations currently such as kdump kernel reboot will bypass
> > device shutdown path so device drivers should reset during initialization.
> > 
> > * One of such problem we encounter now is the iommu
> > issue, 1st kernel's on fly DMA requests cause 2nd kernel hang. There's some effort
> > on this area, Zhenhua Li posted patches to resolve the intel iommu issue which is
> > under review. But that is just one case there's other possible problems in the future.
> > 
> > * There's no serial console on most machines in the market especially for desktop
> > machines and laptops. kms enabled kernel need drm layer driver for framebuffer
> > console, after kernel crashing we need a console to see the 2nd kernel output
> > ideally a serial console because we can not switch back to VGA mode.
> > 
> > ppc64 has a feature "firmware assisted kdump", see below documentation:
> > Documentation/powerpc/firmware-assisted-dump.txt
> > 
> > In case UEFI machines I wonder if we can do similar things, basic idea is doing
> > minimum thing based on original kdump process.
> > 
> > kernel reserve crashkernel memory during early boot
> >  -> user (kdump service) save necessary informations in some way so that second
> >     kernel boot can access ie. efi runtime variables or in reserved memory
> >     * crashkernel memory ranges infomation
> >     * collect infomations and save elf notes for 2nd kernel vmcore initialization
> 
> I think anything related to vmcore initilization can be in memory
> somewhere and should not be a problem.
> 
> But we do have to think about anything which is passed in bootparams or
> command line to second kenrnel with current mechanism, how will it be
> passed to second kernel.

Hi, Vivek,

Since we are rebooting via efi maybe we can just choose another boot entry
in grub.cfg with the proper cmdline?

Thanks
Dave 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
