Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TOwCG-0000QC-2e
 for kexec@lists.infradead.org; Thu, 18 Oct 2012 19:56:01 +0000
Date: Thu, 18 Oct 2012 20:55:30 +0100
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
Message-ID: <20121018195530.GA32428@srcf.ucam.org>
References: <20121018031028.GA3850@localhost.localdomain>
 <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121018193831.GD18147@redhat.com>
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Thu, Oct 18, 2012 at 03:38:31PM -0400, Vivek Goyal wrote:

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

That all sounds fine to me.

> There is one side issue of acpi_rsdp. Because second kernel executes
> the code specified by acpi_rsdp, it is unsafe to let user specify
> that location. Matthew metioned that figure a way out to pass acpi_rsdp
> using boot params and drop it from command line.

That would just be a matter of adding it to the structure and modifying 
drivers/acpi/osl.c.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
