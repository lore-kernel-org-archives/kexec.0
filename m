Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hFwJy-0003Gp-4Y
 for kexec@lists.infradead.org; Mon, 15 Apr 2019 07:46:32 +0000
Date: Mon, 15 Apr 2019 15:46:20 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190415074620.GA15224@dhcp-128-65.nay.redhat.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411084235.GJ3805@localhost.localdomain>
 <1bb7bccb-0270-d073-fa2f-43e1a1c73fbe@ce.jp.nec.com>
 <20190412002345.GA6356@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190412002345.GA6356@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>

On 04/12/19 at 08:23am, Baoquan He wrote:
> On 04/11/19 at 09:14am, Junichi Nomura wrote:
> > On 4/11/19 5:42 PM, Baoquan He wrote:
> > > On 04/11/19 at 08:16am, Junichi Nomura wrote:
> > >> kexec_get_rsdp_addr() might fail on kexec-booted kernel, e.g. if the
> > >> setup_data was invalid. In such a case, falling back to efi_get_rsdp_addr()
> > >> will hit the problem of accessing invalid table pointer again.
> > > 
> > > Seems you are trying to address Dave Young's comment in 
> > > http://lkml.kernel.org/r/20190404073233.GC5708@dhcp-128-65.nay.redhat.com
> > 
> > Right. His "In case kexec_get_rsdp_addr failed.." comment.
> > 
> > > We may need discuss and make clear if those are doable. E.g the first
> > > comment, if not hang by below line of code, returning 0 for what? Can
> > > kexec still be saved, or just reset to firmware?
> > > 
> > > 	error("EFI system table not found in kexec boot_params.")
> > 
> > If we return 0 and also don't hang in the rest of get_rsdp_addr(),
> > it just work as the same way as v5.0 and earlier kernel do.
> > 
> > Failure cases in kexec_get_rsdp_addr() are followings:
> > 1. efi_setup_data is invalid
> > 2. loader signature is invalid
> > 3. EFI systab is not found in boot_params
> > 4. RSDP is not found by parsing tables pointed to by efi_setup_data
> > 
> > I think all of them are critical for EFI boot, so one option could be
> > we never return failure in kexec_get_rsdp_addr() and just hang.
> > But hanging in this very early stage of boot may make the problem
> > harder to investigate once happens. Even earlyprintk is not working yet.
> > So the other option is returning 0 to defer the crash for later stage.
> 
> OK, I got the point, thanks. So it is deferred to the late stage, KASLR
> may not avoid those memory region which is marked as hotpluggable in
> SRAT. Kernel can boot up, but doesn't function well on hotplug stuff.
> In this case, people don't know why it happened. We are still blind.
> 
> Seems early console in efi is the problem, but not kexec or hotplug. I
> am fine to hang, or make it continue booting for now.
> 
> Hi Dave, 
> 
> Is it possible to fix the efi early console issue? I mean the
> feasibility, I believe it won't be easy. Ask this because not only this
> issue encountered, any other issue could be triggered during boot
> decompressing stage. If efi has this problem, we can't debug them
> either.

For normal boot, it maybe doable to use some boot services eg. some
graphic protocols efi firmware provided.

But for kexec, it is different because it become virtual mode, boot
services are not available, and kernel takes over the mode setting etc.
the early framebuffer maybe usable, maybe not, it is not reliable.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
