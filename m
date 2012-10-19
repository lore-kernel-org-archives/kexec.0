Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TP1yu-0007RY-D6
 for kexec@lists.infradead.org; Fri, 19 Oct 2012 02:06:38 +0000
Date: Thu, 18 Oct 2012 22:06:31 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
Message-ID: <20121019020630.GA27052@redhat.com>
References: <20121018031028.GA3850@localhost.localdomain>
 <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874nlrv2ni.fsf@xmission.com>
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

On Thu, Oct 18, 2012 at 03:25:21PM -0700, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Thu, Oct 18, 2012 at 01:22:01PM -0600, Khalid Aziz wrote:
> >
> > [..]
> >> Yes, UEFI is a mess :) It does need to be sorted out. SecureBoot makes
> >> life even more difficult. Matthew Garret had earlier sent out patches to
> >> support SecureBoot on Linux and one of the things those patches did was
> >> to disable kexec completely. That is a drastic measure and ok as a short
> >> term solution but we need to come up with something better. If
> >> SecureBoot does not go away, we will have to do something in kexec-tools
> >> or even kernel to validate kernel code being loaded for kexec/kdump and
> >> the purgatory code as well. This will require interfacing with UEFI key
> >> checking mechanism. That is going to be ugly.
> >
> > CCing Eric and Matthew Garret and hpa.
> >
> > Ok, I will split this thread in two parts. Lets us quickly discuss
> > the UEFI secure boot also as it is happening soon. 
> 
> Any fimware secure boot solution fundamentally is about having the
> firmware not boot something that is not trusted.  This reduces the area
> of attack in your firmware to your executable loader, your signature
> verification code and the key itself.  Making your firmware and the
> early parts of the boot process less susceptible to attack.  UEFI secure
> boot seems to match that criteria.
> 
> I am happy to see a similar system implemented in the kernel for the
> kexec boot path.
> 
> I do not support limiting that solution to UEFI systems or making the
> jusficiation UEFI systems.  The code needs to make sense without any
> UEFI justifications.

Well, UEFI secure boot is just the driver for this discussion. But main
idea reamains that how to kexec signed images.

I think in general idea of using kernel itself a loader is generic. Any
certificate which has been used for signing the images, can be loaded
in kernel ring and image can be verified against that. That certificate
does not have to be in UEFI. In fact we should be able to use it
even without UEFI. Just boot kernel with secure boot enabled (by passing
kernel parameter) and kernel would try to do signature verify the
image being loaded.

> 
> > I was thinking that how about supporting in kernel bootloader. That is,
> > kernel acts as a boot loader. User passes the kernel, initrd and
> > commandline from user space using kexec system call and kernel parses
> > it and prepares appropriate memory areas ( ex. boot_params, kernel, initramfs,
> > backup region, elf header region etc). At the time of kexec -e, we just
> > follow th regular path and jump to second kernel.
> >
> > At the time of loading, kernel can verify the signature of incoming
> > bzImage and reject it if signatures don't match. Matthew mentioned that
> > kernel signing certificate will be available inside the running kernel,
> > so verifying PE/COFF bzImage should be easy.
> 
> Except that we don't pass the executable file to the kernel.  That
> approach was nixed in the early review of kexec.

Ok, this is the crux of this discussion. Why was passing executable image
to kernel was rejected. What's wrong with it? We can pass the executable
segments but not the executable image? Is it about keeping the file type
handling code in user space? 

>  So we either need to
> find a way to trust the /sbin/kexec binary

This would be the key. How do we trust /sbin/kexec. We don't have any
infrastrucutre to sign user space executables. Code for signing modules
got just in after a long battle. 
 
> and do the signature
> verification there on a per file type basis,

This will be possible only if we figure a way out to trust /sbin/kexec
otherwise trust chain is broken.

> or we need to pass an
> additional signature along with the code (the signature would be encoded
> with an extra kexec flag and a special purpose segment I expect).

We can possibly pass the signature in separate segment but part of the
verification process also involves calculating the digest of executable.
And how digest is calculated depends on file type. For PE/Coff there is
specific method regarding how to go about digest calculation and what
area to include and what fields to exclude.

That means for kernel to do signature verification, we shall have to
pass the full executable to kenrel as it is with PE/COFF headers and
we are back to original idea of passing executables to kernel.

> 
> If we pass the signature to the kernel for verification there are rough
> bits like how do file formats with relocation entries, the purgatory
> code, ramdisks, and kernel parameters.
> 
> > We don't have to worry about initramfs verification as it runs in 
> > user space.
> 
> Except that we need a way to distinguish the initramfs and other data
> the part that is signed.

If we are ok with the idea of passing executables and initramfs to
kernel, then kernel can do the placement. That means fields "mem and
memsz fields of kexec_segment will be free. We can possibly overload
memsz field and pass flags to represent segment type. This will happen
only if user chooses kernel as bootloader functionality.

> 
> > There is one side issue of acpi_rsdp. Because second kernel executes
> > the code specified by acpi_rsdp, it is unsafe to let user specify
> > that location. Matthew metioned that figure a way out to pass acpi_rsdp
> > using boot params and drop it from command line.
> 
> The acpi_rsdp option is really orthogonal to this issue.  Since
> everything comes from userspace the trust picture is essentially the
> same (unless we can find a way to trust /sbin/kexec).
> 
> But specifically for acpi_rdsp if we can figure out how to successfully
> use the EFI code path that should not be a problem.  For other code
> paths shrug, that is a detail we should look at when we get there.
> 
> > Looking for thoughts and ideas on how to support kdump with UEFI
> > secureboot. (This is assuming that kdump already works with UEFI with
> > parameters "noefi" and "acpi_rsdp" in non secure boot mode).
> 
> We don't support kdump with UEFI secure boot.  We support kexec loading
> signed images.  An important difference because it means that everyone
> can benefit or not as they choose.
> 
> This leaves us with a couple of important questions to answer.
> - How do we trust /sbin/kexec or how do we avoid the need to trust
>   /sbin/kexec.
> - Where is the root of trust located?

I think it is either in UEFI or in kernel.

> - How do we verify /sbin/kexec or do we verify /sbin/kexec.
> - How do we verify the images we load?
> - How do we separate code/data that needs trust from code/data that
>   doesn't need trust?

If we agree on passing executable to kernel, then we just need to
verify only kernel. And we could overload kexec_segment->mem for
this.

> - How does the design we pick reduce the amount of code we need to trust?
> 

I think if we loading in kernel, then we don't have to trust /sbin/kexec
and problem gets simplified a lot.

> None of this is particularly hard but it all needs going through
> carefully by someone who cares.

I think here crux of the matter is what's wrong with passing kernel
executable to kernel for loading and verification.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
