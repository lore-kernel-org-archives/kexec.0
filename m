Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VobMf-0004wv-RP
 for kexec@lists.infradead.org; Thu, 05 Dec 2013 16:01:22 +0000
Message-ID: <1386258962.1791.268.camel@misato.fc.hp.com>
Subject: Re: [PATCH v4 07/12] efi: passing kexec necessary efi data via
 setup_data
From: Toshi Kani <toshi.kani@hp.com>
Date: Thu, 05 Dec 2013 08:56:02 -0700
In-Reply-To: <20131205115124.GC14407@pd.tnic>
References: <1385445477-9665-8-git-send-email-dyoung@redhat.com>
 <20131127140732.GD32267@pd.tnic>
 <20131129091415.GH4186@dhcp-16-126.nay.redhat.com>
 <1386023600.1791.201.camel@misato.fc.hp.com>
 <1386034289.1791.210.camel@misato.fc.hp.com>
 <20131203015613.GB3980@dhcp-16-126.nay.redhat.com>
 <1386085140.1791.218.camel@misato.fc.hp.com>
 <20131204024610.GA3764@dhcp-16-126.nay.redhat.com>
 <1386175428.1791.225.camel@misato.fc.hp.com>
 <20131205015615.GC3736@dhcp-16-126.nay.redhat.com>
 <20131205115124.GC14407@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Thu, 2013-12-05 at 12:51 +0100, Borislav Petkov wrote:
> On Thu, Dec 05, 2013 at 09:56:15AM +0800, Dave Young wrote:
> > > The z420 firmware is based on some UEFI core that may be used by other
> > > vendors as well.  Since this handling is totally harmless (just
> > > redundant), I'd suggest not to have a platform check on this handling.
> > 
> > I have same worry as well, so I agree with you.
> 
> Btw, why does kexec need the ->smbios table at all? I see it being
> passed in efi_setup_data.

Hi Boris,

The smbios in efi_setup_data is necessary for kexec to pass the physical
address of the SMBIOS table from the 1st kernel to the 2nd kernel.

The kernel boot sequence proceeds in the following order.  Step 2
requires efi.smbios to be the physical address.  However, Dave found
that EFI system table has a virtual address of SMBIOS in step 1.  Hence,
he sets it back to the physical address with the smbios in
efi_setup_data.  (When it is still the physical address, it simply sets
the same value.)

1. efi_init() - Set efi.smbios from EFI system table
2. dmi_scan_machine() - Temporary map efi.smbios to access SMBIOS table
3. efi_enter_virtual_mode() - Map EFI ranges

Thanks,
-Toshi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
