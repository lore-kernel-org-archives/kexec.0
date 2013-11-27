Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlVGu-0007AK-9L
 for kexec@lists.infradead.org; Wed, 27 Nov 2013 02:55:11 +0000
Date: Wed, 27 Nov 2013 10:53:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 05/12] efi: export more efi table variable to sysfs
Message-ID: <20131127025345.GA11852@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-6-git-send-email-dyoung@redhat.com>
 <20131126155731.GM11521@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131126155731.GM11521@console-pimps.org>
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
To: Matt Fleming <matt@console-pimps.org>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/26/13 at 03:57pm, Matt Fleming wrote:
> On Tue, 26 Nov, at 01:57:50PM, Dave Young wrote:
> > Export fw_vendor, runtime and config tables physical
> > addresses to /sys/firmware/efi/systab becaue kexec
> > kernel will need them.
>  
> This commit log needs updating.

Will update

> 
> > From EFI spec these 3 variables will be updated to
> > virtual address after entering virtual mode. But
> > kernel startup code will need the physical address.
> > 
> > changelog:
> > Greg: add standalone sysfs files instead of add lines to systab
> > Document them as testing ABI
> > Greg: use group attrs and is_visible
> > Boris: align comments lines
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  Documentation/ABI/testing/sysfs-firmware-efi | 26 ++++++++++++++++
> >  arch/x86/platform/efi/efi.c                  |  4 +++
> >  drivers/firmware/efi/efi.c                   | 44 ++++++++++++++++++++++++++++
> >  include/linux/efi.h                          |  3 ++
> >  4 files changed, 77 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-firmware-efi
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/ABI/testing/sysfs-firmware-efi
> > new file mode 100644
> > index 0000000..9252a24
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-firmware-efi
> > @@ -0,0 +1,26 @@
> > +What:		/sys/firmware/efi/fw_vendor
> > +Date:		Nov 2013
> > +Contact:	Dave Young <dyoung@redhat.org>
> 
> redhat.org eh? Typo or legit?

It's typo, will fix

> 
> > +Description:
> > +		Shows the physical address of firmware vendor in the EFI
> > +		system table.
> 
> It shows the physical address of the firmware vendor "entry" or "field"
> in the EFI system table.

Will update

> 
> > +Users:
> > +		Kexec Mailing List <kexec@lists.infradead.org>
> 
> The "Kexec mailing list" isn't a user, kexec is.

Ok, will change to "Kexec"

Thanks for review
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
