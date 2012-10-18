Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from qmta01.emeryville.ca.mail.comcast.net
 ([2001:558:fe2d:43:76:96:30:16])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TOrWa-0004Yr-8d
 for kexec@lists.infradead.org; Thu, 18 Oct 2012 14:56:42 +0000
Message-ID: <1350572194.3894.14.camel@rhapsody>
Subject: Re: [PATCH v2] kdump: pass acpi_rsdp= to 2nd kernel for efi booting
From: Khalid Aziz <khalid@gonehiking.org>
Date: Thu, 18 Oct 2012 08:56:34 -0600
In-Reply-To: <20121018031028.GA3850@localhost.localdomain>
References: <20121018031028.GA3850@localhost.localdomain>
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
To: Dave Young <dyoung@redhat.com>
Cc: khalid.aziz@hp.com, horms@verge.net.au, kexec@lists.infradead.org, vgoyal@redhat.com

On Thu, 2012-10-18 at 11:10 +0800, Dave Young wrote:
> In case efi booting, kdump need kernel parameter acpi_rsdp= to retrieve
> the acpi root table physical address.
> 
> Add a function cmdline_add_efi to get the address from /sys/firmware/efi/systab
> If there's no such file or read fail the function will just do nothing.
> 
> Tested efi boot Fedora 17 on thinkpad T420.
> 
> Some background info for this issue:
> http://lists.infradead.org/pipermail/kexec/2010-March/003889.html
> 
> [v1 -> v2]:
> Address comments from Khalid and Simon
> use fgets instead of read(2) to iterate the file
> do not add 'noefi' because kexec does not construct EFI signature
> in bootloader signature in boot_params, so kexec'd kernel will
> disable EFI automatically even without noefi.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c |   35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)


Looks good.

Reviewed-by: Khalid Aziz <khalid@gonehiking.org>




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
