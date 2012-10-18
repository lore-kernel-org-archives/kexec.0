Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TOyXA-0004u6-T1
 for kexec@lists.infradead.org; Thu, 18 Oct 2012 22:25:46 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20121018031028.GA3850@localhost.localdomain>
 <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com>
Date: Thu, 18 Oct 2012 15:25:21 -0700
In-Reply-To: <20121018193831.GD18147@redhat.com> (Vivek Goyal's message of
 "Thu, 18 Oct 2012 15:38:31 -0400")
Message-ID: <874nlrv2ni.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

Vivek Goyal <vgoyal@redhat.com> writes:

> On Thu, Oct 18, 2012 at 01:22:01PM -0600, Khalid Aziz wrote:
>
> [..]
>> Yes, UEFI is a mess :) It does need to be sorted out. SecureBoot makes
>> life even more difficult. Matthew Garret had earlier sent out patches to
>> support SecureBoot on Linux and one of the things those patches did was
>> to disable kexec completely. That is a drastic measure and ok as a short
>> term solution but we need to come up with something better. If
>> SecureBoot does not go away, we will have to do something in kexec-tools
>> or even kernel to validate kernel code being loaded for kexec/kdump and
>> the purgatory code as well. This will require interfacing with UEFI key
>> checking mechanism. That is going to be ugly.
>
> CCing Eric and Matthew Garret and hpa.
>
> Ok, I will split this thread in two parts. Lets us quickly discuss
> the UEFI secure boot also as it is happening soon. 

Any fimware secure boot solution fundamentally is about having the
firmware not boot something that is not trusted.  This reduces the area
of attack in your firmware to your executable loader, your signature
verification code and the key itself.  Making your firmware and the
early parts of the boot process less susceptible to attack.  UEFI secure
boot seems to match that criteria.

I am happy to see a similar system implemented in the kernel for the
kexec boot path.

I do not support limiting that solution to UEFI systems or making the
jusficiation UEFI systems.  The code needs to make sense without any
UEFI justifications.

> I was thinking that how about supporting in kernel bootloader. That is,
> kernel acts as a boot loader. User passes the kernel, initrd and
> commandline from user space using kexec system call and kernel parses
> it and prepares appropriate memory areas ( ex. boot_params, kernel, initramfs,
> backup region, elf header region etc). At the time of kexec -e, we just
> follow th regular path and jump to second kernel.
>
> At the time of loading, kernel can verify the signature of incoming
> bzImage and reject it if signatures don't match. Matthew mentioned that
> kernel signing certificate will be available inside the running kernel,
> so verifying PE/COFF bzImage should be easy.

Except that we don't pass the executable file to the kernel.  That
approach was nixed in the early review of kexec.  So we either need to
find a way to trust the /sbin/kexec binary and do the signature
verification there on a per file type basis, or we need to pass an
additional signature along with the code (the signature would be encoded
with an extra kexec flag and a special purpose segment I expect).

If we pass the signature to the kernel for verification there are rough
bits like how do file formats with relocation entries, the purgatory
code, ramdisks, and kernel parameters.

> We don't have to worry about initramfs verification as it runs in 
> user space.

Except that we need a way to distinguish the initramfs and other data
the part that is signed.

> There is one side issue of acpi_rsdp. Because second kernel executes
> the code specified by acpi_rsdp, it is unsafe to let user specify
> that location. Matthew metioned that figure a way out to pass acpi_rsdp
> using boot params and drop it from command line.

The acpi_rsdp option is really orthogonal to this issue.  Since
everything comes from userspace the trust picture is essentially the
same (unless we can find a way to trust /sbin/kexec).

But specifically for acpi_rdsp if we can figure out how to successfully
use the EFI code path that should not be a problem.  For other code
paths shrug, that is a detail we should look at when we get there.

> Looking for thoughts and ideas on how to support kdump with UEFI
> secureboot. (This is assuming that kdump already works with UEFI with
> parameters "noefi" and "acpi_rsdp" in non secure boot mode).

We don't support kdump with UEFI secure boot.  We support kexec loading
signed images.  An important difference because it means that everyone
can benefit or not as they choose.

This leaves us with a couple of important questions to answer.
- How do we trust /sbin/kexec or how do we avoid the need to trust
  /sbin/kexec.
- Where is the root of trust located?
- How do we verify /sbin/kexec or do we verify /sbin/kexec.
- How do we verify the images we load?
- How do we separate code/data that needs trust from code/data that
  doesn't need trust?
- How does the design we pick reduce the amount of code we need to trust?

None of this is particularly hard but it all needs going through
carefully by someone who cares.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
