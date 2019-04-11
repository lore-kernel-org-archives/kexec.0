Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hEVnN-0007Mj-D4
 for kexec@lists.infradead.org; Thu, 11 Apr 2019 09:14:58 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Date: Thu, 11 Apr 2019 09:14:36 +0000
Message-ID: <1bb7bccb-0270-d073-fa2f-43e1a1c73fbe@ce.jp.nec.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411084235.GJ3805@localhost.localdomain>
In-Reply-To: <20190411084235.GJ3805@localhost.localdomain>
Content-Language: ja-JP
Content-ID: <AAFE3663B74F2A44B26E2A0C20DD4FE0@gisp.nec.co.jp>
MIME-Version: 1.0
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
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>

On 4/11/19 5:42 PM, Baoquan He wrote:
> On 04/11/19 at 08:16am, Junichi Nomura wrote:
>> kexec_get_rsdp_addr() might fail on kexec-booted kernel, e.g. if the
>> setup_data was invalid. In such a case, falling back to efi_get_rsdp_addr()
>> will hit the problem of accessing invalid table pointer again.
> 
> Seems you are trying to address Dave Young's comment in 
> http://lkml.kernel.org/r/20190404073233.GC5708@dhcp-128-65.nay.redhat.com

Right. His "In case kexec_get_rsdp_addr failed.." comment.

> We may need discuss and make clear if those are doable. E.g the first
> comment, if not hang by below line of code, returning 0 for what? Can
> kexec still be saved, or just reset to firmware?
> 
> 	error("EFI system table not found in kexec boot_params.")

If we return 0 and also don't hang in the rest of get_rsdp_addr(),
it just work as the same way as v5.0 and earlier kernel do.

Failure cases in kexec_get_rsdp_addr() are followings:
1. efi_setup_data is invalid
2. loader signature is invalid
3. EFI systab is not found in boot_params
4. RSDP is not found by parsing tables pointed to by efi_setup_data

I think all of them are critical for EFI boot, so one option could be
we never return failure in kexec_get_rsdp_addr() and just hang.
But hanging in this very early stage of boot may make the problem
harder to investigate once happens. Even earlyprintk is not working yet.
So the other option is returning 0 to defer the crash for later stage.

> It may need be clarified firstly, then go further to rearrange patch.
> That can ease the work, I guess.
> 
> Personal opinion.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
