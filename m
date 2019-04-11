Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hEVIA-0000TT-2d
 for kexec@lists.infradead.org; Thu, 11 Apr 2019 08:42:43 +0000
Date: Thu, 11 Apr 2019 16:42:35 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190411084235.GJ3805@localhost.localdomain>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>

On 04/11/19 at 08:16am, Junichi Nomura wrote:
> On 4/11/19 5:09 PM, Borislav Petkov wrote:
> > On Wed, Apr 10, 2019 at 11:34:51PM +0000, Junichi Nomura wrote:
> >> But efi_get_rsdp_addr() needs to check whether the kernel was
> >> kexec booted to avoid accessing invalid EFI table address.
> >> efi_get_kexec_setup_data_addr() is the only method I know
> >> to check if it was kexec-booted.
> > 
> > Your v3 had the right approach - you first check if you can get the
> > address as a kexec-ed kernel. If you do, you use that one and continue
> > the normal path.
> > 
> > If you don't, you fall back to efi_get_rsdp_addr() and get it directly
> > from EFI.
> > 
> > And then carve out the functionality you need to call multiple times in
> > helper functions like __efi_get_rsdp_addr().
> > 
> > Why doesn't that work anymore?
> 
> kexec_get_rsdp_addr() might fail on kexec-booted kernel, e.g. if the
> setup_data was invalid. In such a case, falling back to efi_get_rsdp_addr()
> will hit the problem of accessing invalid table pointer again.

Seems you are trying to address Dave Young's comment in 
http://lkml.kernel.org/r/20190404073233.GC5708@dhcp-128-65.nay.redhat.com

We may need discuss and make clear if those are doable. E.g the first
comment, if not hang by below line of code, returning 0 for what? Can
kexec still be saved, or just reset to firmware?

	error("EFI system table not found in kexec boot_params.")

It may need be clarified firstly, then go further to rearrange patch.
That can ease the work, I guess.

Personal opinion.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
