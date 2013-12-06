Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VokHd-0002cS-5u
 for kexec@lists.infradead.org; Fri, 06 Dec 2013 01:32:46 +0000
Date: Fri, 6 Dec 2013 09:31:44 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 07/12] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131206013143.GA3792@dhcp-16-126.nay.redhat.com>
References: <1386023600.1791.201.camel@misato.fc.hp.com>
 <1386034289.1791.210.camel@misato.fc.hp.com>
 <20131203015613.GB3980@dhcp-16-126.nay.redhat.com>
 <1386085140.1791.218.camel@misato.fc.hp.com>
 <20131204024610.GA3764@dhcp-16-126.nay.redhat.com>
 <1386175428.1791.225.camel@misato.fc.hp.com>
 <20131205015615.GC3736@dhcp-16-126.nay.redhat.com>
 <20131205115124.GC14407@pd.tnic>
 <1386258962.1791.268.camel@misato.fc.hp.com>
 <20131205205250.GF14407@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131205205250.GF14407@pd.tnic>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 12/05/13 at 09:52pm, Borislav Petkov wrote:
> On Thu, Dec 05, 2013 at 08:56:02AM -0700, Toshi Kani wrote:
> > The smbios in efi_setup_data is necessary for kexec to pass the physical
> > address of the SMBIOS table from the 1st kernel to the 2nd kernel.
> > 
> > The kernel boot sequence proceeds in the following order.  Step 2
> > requires efi.smbios to be the physical address.  However, Dave found
> > that EFI system table has a virtual address of SMBIOS in step 1.  Hence,
> > he sets it back to the physical address with the smbios in
> > efi_setup_data.  (When it is still the physical address, it simply sets
> > the same value.)
> > 
> > 1. efi_init() - Set efi.smbios from EFI system table
> > 2. dmi_scan_machine() - Temporary map efi.smbios to access SMBIOS table
> > 3. efi_enter_virtual_mode() - Map EFI ranges
> 
> Thanks Toshi, it is all clear now.
> 
> @Dave: you might want to put Toshi's explanation in the commit message
> of your patch so that we know *why* the change is needed.

Ok, will do.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
