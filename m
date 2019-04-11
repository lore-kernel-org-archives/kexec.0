Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hEUub-0008Go-3p
 for kexec@lists.infradead.org; Thu, 11 Apr 2019 08:18:22 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Date: Thu, 11 Apr 2019 08:16:45 +0000
Message-ID: <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
In-Reply-To: <20190411080927.GA30080@zn.tnic>
Content-Language: ja-JP
Content-ID: <C0BA2FCD5BBA63458B0F49155501E2A7@gisp.nec.co.jp>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>

On 4/11/19 5:09 PM, Borislav Petkov wrote:
> On Wed, Apr 10, 2019 at 11:34:51PM +0000, Junichi Nomura wrote:
>> But efi_get_rsdp_addr() needs to check whether the kernel was
>> kexec booted to avoid accessing invalid EFI table address.
>> efi_get_kexec_setup_data_addr() is the only method I know
>> to check if it was kexec-booted.
> 
> Your v3 had the right approach - you first check if you can get the
> address as a kexec-ed kernel. If you do, you use that one and continue
> the normal path.
> 
> If you don't, you fall back to efi_get_rsdp_addr() and get it directly
> from EFI.
> 
> And then carve out the functionality you need to call multiple times in
> helper functions like __efi_get_rsdp_addr().
> 
> Why doesn't that work anymore?

kexec_get_rsdp_addr() might fail on kexec-booted kernel, e.g. if the
setup_data was invalid. In such a case, falling back to efi_get_rsdp_addr()
will hit the problem of accessing invalid table pointer again.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
