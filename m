Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBafB-00043K-5R
 for kexec@lists.infradead.org; Wed, 03 Apr 2019 07:50:26 +0000
Date: Wed, 3 Apr 2019 15:50:15 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190403075015.GQ7627@MiWiFi-R3L-srv>
References: <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
 <20190403053459.GD1555@localhost.localdomain>
 <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
 <20190403063911.GA2579@dhcp-128-65.nay.redhat.com>
 <20190403073023.GF1555@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190403073023.GF1555@localhost.localdomain>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: "kasong@redhat.com" <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Dave Young <dyoung@redhat.com>

On 04/03/19 at 03:30pm, Chao Fan wrote:
> On Wed, Apr 03, 2019 at 02:39:11PM +0800, Dave Young wrote:
> >> Actually I got some different kexec test results.
> >> 
> >> Yesterday, with my installed kernel (based on git head several weeks
> >> ago), kexec kernel panics.
> >> 
> >> Then I tried latest mainline with git pull, everything works, (with or
> >> without the patch, and can not reproduce the bug this patch is fixing)
> >> 
> >> Today, test again, kexec reboot hangs (with or without your patch), but
> >> kdump works always (with or without the patch)
> >> 
> >> It is weird to me. Probably I need find out why I can not reproduce the
> >> bug this patch is addressing first.
> >> 
> >> earlyprintk seems not working for me anymore, it is not easy to debug on
> >> laptop now.
> >> 
> >> But the patch itself is clear, I think it should be good.  There might be
> >> other things broken.
> >
> >Disable your immovable mem code then everything works for me.  There
> >might be something wrong in the code.  Also "nokaslr" does not help, it
> >should be another problem 
> 
> If "nokaslr" doesn't help, so I think
> >+      /*num_immovable_mem = count_immovable_mem_regions();*/
> also doesn't help. I think the problem is from get_rsdp_addr().

Yes, seems get_rsdp_addr() has issue in this case. I am wondering if we
can adjust the postion of get_rsdp_addr() calling. If nokaslr is
specified, no need to get rsdp?

> 
> You test it in your laptop, I only tested in Qemu guest.
> I have no laptop avaliable, so I will look for a physical machine
> to test it.
> 
> Thanks,
> Chao Fan
> 
> >
> >diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> >index 2e53c056ba20..e760c9159662 100644
> >--- a/arch/x86/boot/compressed/kaslr.c
> >+++ b/arch/x86/boot/compressed/kaslr.c
> >@@ -416,7 +416,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
> > 	handle_mem_options();
> > 
> > 	/* Enumerate the immovable memory regions */
> >-	num_immovable_mem = count_immovable_mem_regions();
> >+	/*num_immovable_mem = count_immovable_mem_regions();*/
> > 
> > #ifdef CONFIG_X86_VERBOSE_BOOTUP
> > 	/* Make sure video RAM can be used. */
> >diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> >index c0d6c560df69..1bc6f46d3aa7 100644
> >--- a/arch/x86/boot/compressed/misc.c
> >+++ b/arch/x86/boot/compressed/misc.c
> >@@ -352,7 +352,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> > 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
> > 
> > 	/* Save RSDP address for later use. */
> >-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
> >+/*	boot_params->acpi_rsdp_addr = get_rsdp_addr(); */
> > 
> > 	sanitize_boot_params(boot_params);
> > 
> >
> >
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
