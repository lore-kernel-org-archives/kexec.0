Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TP0QM-0005Q4-3s
 for kexec@lists.infradead.org; Fri, 19 Oct 2012 00:26:50 +0000
Date: Fri, 19 Oct 2012 09:26:45 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kdump: pass acpi_rsdp= to 2nd kernel for efi booting
Message-ID: <20121019002645.GD5724@verge.net.au>
References: <20121018031608.GA3925@localhost.localdomain>
 <878vb332a9.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878vb332a9.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com, khalid@gonehiking.org

On Thu, Oct 18, 2012 at 02:20:46PM -0700, Eric W. Biederman wrote:
> Dave Young <dyoung@redhat.com> writes:
> 
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
> 
> I don't have any problems with this patch.
> 
> I have a question.  In the case where this fails are we successfully
> passing the ACPI sections in the e820 map?
> 
> If we are passing the acpi sections is that not enough for the kernel
> to find the rdsp area?  I'm just a bit surprised we need this patch
> is all.
> 
> Somehow it seems a bit ugly to pass information that could be conveyed
> in the memory map on the command line.
> 
> But I am all in favor of doing what works.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks, I have applied this patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
