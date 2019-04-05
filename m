Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hCGL4-0007dn-12
 for kexec@lists.infradead.org; Fri, 05 Apr 2019 04:20:27 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v3] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Date: Fri, 5 Apr 2019 04:19:50 +0000
Message-ID: <ddddba22-db88-0d1b-63e2-c70dc1346d0b@ce.jp.nec.com>
References: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190402102529.GA21698@jeru.linux.bs1.fc.nec.co.jp>
 <20190404073233.GC5708@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190404073233.GC5708@dhcp-128-65.nay.redhat.com>
Content-Language: ja-JP
Content-ID: <054A1887037BE0429EE23D2F37416DC1@gisp.nec.co.jp>
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
To: Dave Young <dyoung@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>

On 4/4/19 4:32 PM, Dave Young wrote:
> While we are still debuggin the bug I reproduced, but for this patch
> I have still some comments inline.
> 
> BTW, it would be good to start a new thread when you send V4 :)

Sure.

>> +	/* Get systab from boot params. */
>> +	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
>> +	if (!systab)
>> +		error("EFI system table not found in kexec boot_params.");
> 
> Instead of hang the system, return 0 should be better

OK. I'll make it something like:
	if (!systab) {
		debug_putstr(...);
		return 0;
	}

>>  	if (!pa)
>> +		pa = kexec_get_rsdp_addr();
>> +
>> +	if (!pa)
>>  		pa = efi_get_rsdp_addr();
> 
> In case kexec_get_rsdp_addr failed, above code will try efi_get.. again,
> but that will also fail for same issue this patch is fixing.  In case
> kexec we should avoid the efi_get_rsdp_addr.

Yeah, I'll set efi_kexec_booted to true in kexec_get_rsdp_addr() if it's
kexec booted so that efi_get_rsdp_addr() can exit early in such a case.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
