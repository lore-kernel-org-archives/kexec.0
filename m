Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from heinz.dinsnail.net ([81.169.187.250])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icyhs-0003LY-Jw
 for kexec@lists.infradead.org; Thu, 05 Dec 2019 21:30:46 +0000
Date: Thu, 5 Dec 2019 22:15:32 +0100
From: Michael Weiser <michael@weiser.dinsnail.net>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
Message-ID: <20191205211532.GA10177@weiser.dinsnail.net>
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <20191204075917.GA10587@dhcp-128-65.nay.redhat.com>
 <20191204101412.GD114697@gmail.com>
 <20191205105545.GA6710@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191205105545.GA6710@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>

On Thu, Dec 05, 2019 at 06:55:45PM +0800, Dave Young wrote:

> >    esrt: Unsupported ESRT version 2904149718861218184.
> > 
> >  The ESRT memory stays in EFI boot services data, and it was reserved
> >  in kernel via efi_mem_reserve().  The initial purpose of the reservation
> >  is to reuse the EFI boot services data across kexec reboot. For example
> >  the BGRT image data and some ESRT memory like Michael reported.
> > 
> >  But although the memory is reserved it is not updated in the X86 E820 table,
> >  and kexec_file_load() iterates system RAM in the IO resource list to find places
> >  for kernel, initramfs and other stuff. In Michael's case the kexec loaded
> >  initramfs overwrote the ESRT memory and then the failure happened.
> > 
> >  Since kexec_file_load() depends on the E820 table being updated, just fix this
> >  by updating the reserved EFI boot services memory as reserved type in E820.
> Thanks for the amending, also thank all for the review and test.

Same from me, particularly everyone's patience with my haphazard
guesswork around an area I clearly know nothing about. :)
-- 
Thanks,
Michael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
