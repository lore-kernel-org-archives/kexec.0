Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hEVmE-0005Bm-Fa
 for kexec@lists.infradead.org; Thu, 11 Apr 2019 09:13:48 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Date: Thu, 11 Apr 2019 09:13:03 +0000
Message-ID: <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411083738.GC30080@zn.tnic>
In-Reply-To: <20190411083738.GC30080@zn.tnic>
Content-Language: ja-JP
Content-ID: <50D1F48D00732841994A423F797DD49D@gisp.nec.co.jp>
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

On 4/11/19 5:37 PM, Borislav Petkov wrote:
> On Thu, Apr 11, 2019 at 08:16:45AM +0000, Junichi Nomura wrote:
>> kexec_get_rsdp_addr() might fail on kexec-booted kernel, e.g. if the
>> setup_data was invalid. In such a case, falling back to efi_get_rsdp_addr()
>> will hit the problem of accessing invalid table pointer again.
> 
> Then you need to do this:
> 
> 	if (kexeced kernel) {
> 		addr = kexec_get_rsdp_addr();
> 		if (!addr) {
> 			/* cannot get address */
> 			return -1;
> 		}
> 
> 		return addr;
> 	}
> 
> and the calling function get_rsdp_addr() must check the return value and
> if it is not 0, return immediately.

Do you mean making get_rsdp_addr() like this?

acpi_physical_address get_rsdp_addr(void)
{
        acpi_physical_address pa;
+       struct efi_setup_data *esd;

        pa = get_acpi_rsdp();

        if (!pa)
                pa = boot_params->acpi_rsdp_addr;

+       esd = (struct efi_setup_data *) efi_get_kexec_setup_data_addr();
+       if (esd)
+		return kexec_get_rsdp_addr(esd);

        if (!pa)
                pa = efi_get_rsdp_addr();



-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
