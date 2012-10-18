Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TOvvP-0001xu-MD
 for kexec@lists.infradead.org; Thu, 18 Oct 2012 19:38:36 +0000
Date: Thu, 18 Oct 2012 15:38:31 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
Message-ID: <20121018193831.GD18147@redhat.com>
References: <20121018031028.GA3850@localhost.localdomain>
 <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1350588121.30243.7.camel@rhapsody>
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
To: Khalid Aziz <khalid@gonehiking.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, Dave Young <dyoung@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Matthew Garrett <mjg@redhat.com>

On Thu, Oct 18, 2012 at 01:22:01PM -0600, Khalid Aziz wrote:

[..]
> Yes, UEFI is a mess :) It does need to be sorted out. SecureBoot makes
> life even more difficult. Matthew Garret had earlier sent out patches to
> support SecureBoot on Linux and one of the things those patches did was
> to disable kexec completely. That is a drastic measure and ok as a short
> term solution but we need to come up with something better. If
> SecureBoot does not go away, we will have to do something in kexec-tools
> or even kernel to validate kernel code being loaded for kexec/kdump and
> the purgatory code as well. This will require interfacing with UEFI key
> checking mechanism. That is going to be ugly.

CCing Eric and Matthew Garret and hpa.

Ok, I will split this thread in two parts. Lets us quickly discuss
the UEFI secure boot also as it is happening soon. 

I was thinking that how about supporting in kernel bootloader. That is,
kernel acts as a boot loader. User passes the kernel, initrd and
commandline from user space using kexec system call and kernel parses
it and prepares appropriate memory areas ( ex. boot_params, kernel, initramfs,
backup region, elf header region etc). At the time of kexec -e, we just
follow th regular path and jump to second kernel.

At the time of loading, kernel can verify the signature of incoming
bzImage and reject it if signatures don't match. Matthew mentioned that
kernel signing certificate will be available inside the running kernel,
so verifying PE/COFF bzImage should be easy.

We don't have to worry about initramfs verification as it runs in 
user space.

There is one side issue of acpi_rsdp. Because second kernel executes
the code specified by acpi_rsdp, it is unsafe to let user specify
that location. Matthew metioned that figure a way out to pass acpi_rsdp
using boot params and drop it from command line.

Looking for thoughts and ideas on how to support kdump with UEFI
secureboot. (This is assuming that kdump already works with UEFI with
parameters "noefi" and "acpi_rsdp" in non secure boot mode).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
