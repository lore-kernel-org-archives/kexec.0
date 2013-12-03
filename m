Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vns95-0007sC-Pm
 for kexec@lists.infradead.org; Tue, 03 Dec 2013 15:44:20 +0000
Message-ID: <1386085140.1791.218.camel@misato.fc.hp.com>
Subject: Re: [PATCH v4 07/12] efi: passing kexec necessary efi data via
 setup_data
From: Toshi Kani <toshi.kani@hp.com>
Date: Tue, 03 Dec 2013 08:39:00 -0700
In-Reply-To: <20131203015613.GB3980@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-8-git-send-email-dyoung@redhat.com>
 <20131127140732.GD32267@pd.tnic>
 <20131129091415.GH4186@dhcp-16-126.nay.redhat.com>
 <1386023600.1791.201.camel@misato.fc.hp.com>
 <1386034289.1791.210.camel@misato.fc.hp.com>
 <20131203015613.GB3980@dhcp-16-126.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, Borislav Petkov <bp@alien8.de>, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Tue, 2013-12-03 at 09:56 +0800, Dave Young wrote:
> On 12/02/13 at 06:31pm, Toshi Kani wrote:
> > On Mon, 2013-12-02 at 15:33 -0700, Toshi Kani wrote:
> > > On Fri, 2013-11-29 at 17:14 +0800, Dave Young wrote:
> > > > On 11/27/13 at 03:07pm, Borislav Petkov wrote:
> > > > > On Tue, Nov 26, 2013 at 01:57:52PM +0800, Dave Young wrote:
> > > > > > Add a new setup_data type SETUP_EFI for kexec use.
> > > > > > Passing the saved fw_vendor, runtime, config tables and
> > > > > > efi runtime mappings.
> > > > > > 
> > > > > > When entering virtual mode, directly mapping the efi
> > > > > > runtime ragions which we passed in previously. And skip
> > > > > > the step to call SetVirtualAddressMap.
> > > > > > 
> > > > > > Specially for HP z420 workstation it need another variable
> > > > > > saving,
> > > > > 
> > > > > Why the special handling? Does that mean, this is going to be the case
> > > > > for other HP UEFI implementations too?
> > > > 
> > > > I have only one HP machine for testing, Maybe Toshi can help to verify
> > > > on other machines. Just comment out the function efi_reuse_config to see
> > > > if kexec kernel panic.
> > > 
> > > My system (HP prototype server) did not need the special handling in
> > > efi_reuse_config().  I will check with firmware team to get more
> > > information on this.
> > 
> > I have one question.  I think this special handling assumes that
> > efi.smbios contains a virtual address on HP z420.  So, how does the 1st
> > kernel set a virtual address to efi.smbios in the first place?
> 
> Hi, Toshi,
> 
> It's originally a physical address, I think kernel does not change it.
> As the fw_vendor, runtime etc. are changed to virt addr by firmware, so I
> assume smbios on Hp z420 is also changed by firmware after becoming virtual mode.

Hi Dave,

Oh, I think I now understand what the issue was.  The z420 firmware
updates the SMBIOS table address in the EFI system table to a virtual
address after calling EFI SetVirtualAddressMap.  So, you are passing the
original physical address of the SMBIOS table from the 1st kernel to the
2nd kernel to put it back to physical.  Is that right? 

Thanks,
-Toshi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
