Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TOvUu-0000oY-QT
 for kexec@lists.infradead.org; Thu, 18 Oct 2012 19:11:17 +0000
Date: Thu, 18 Oct 2012 15:11:07 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] kdump: pass acpi_rsdp= to 2nd kernel for efi booting
Message-ID: <20121018191107.GC18147@redhat.com>
References: <20121018031028.GA3850@localhost.localdomain>
 <1350572194.3894.14.camel@rhapsody>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1350572194.3894.14.camel@rhapsody>
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
To: Khalid Aziz <khalid@gonehiking.org>
Cc: khalid.aziz@hp.com, kexec@lists.infradead.org, horms@verge.net.au, Dave Young <dyoung@redhat.com>

On Thu, Oct 18, 2012 at 08:56:34AM -0600, Khalid Aziz wrote:
> On Thu, 2012-10-18 at 11:10 +0800, Dave Young wrote:
> > In case efi booting, kdump need kernel parameter acpi_rsdp= to retrieve
> > the acpi root table physical address.
> > 
> > Add a function cmdline_add_efi to get the address from /sys/firmware/efi/systab
> > If there's no such file or read fail the function will just do nothing.
> > 
> > Tested efi boot Fedora 17 on thinkpad T420.
> > 
> > Some background info for this issue:
> > http://lists.infradead.org/pipermail/kexec/2010-March/003889.html
> > 
> > [v1 -> v2]:
> > Address comments from Khalid and Simon
> > use fgets instead of read(2) to iterate the file
> > do not add 'noefi' because kexec does not construct EFI signature
> > in bootloader signature in boot_params, so kexec'd kernel will
> > disable EFI automatically even without noefi.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  kexec/arch/i386/crashdump-x86.c |   35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> 
> 
> Looks good.
> 
> Reviewed-by: Khalid Aziz <khalid@gonehiking.org>

Khalid/Dave,

Last time khalid mentioned that we are currently taking normal boot path
in second kernel and that's why things are working even without "noefi"?

If that's the case, then we don't need "acpi_rsdp" also? In normal boot
path we used to just pass acpi memmap ranges in e820 map and second
kernel could find those.

So now I am full confused that howcome we require acpi_rsdp but not
"noefi".

This UEFI thing is a mess. We need to sort it out. I am primarily
interested in making sure kdump works well with UEFI systems as more
and more systems are going to adopt UEFI. Also this UEFI secure boot
will make things very interesting. Now we can't trust the purgatory
code prepared in user space.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
