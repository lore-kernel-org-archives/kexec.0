Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9n5L-000190-LI
 for kexec@lists.infradead.org; Fri, 29 Mar 2019 08:42:01 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Date: Fri, 29 Mar 2019 08:39:45 +0000
Message-ID: <5dba5878-4bc7-e9cd-134d-ce88e8b6a766@ce.jp.nec.com>
References: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190329072037.GA5840@jeru.linux.bs1.fc.nec.co.jp>
 <20190329082929.GH4234@localhost.localdomain>
In-Reply-To: <20190329082929.GH4234@localhost.localdomain>
Content-Language: ja-JP
Content-ID: <CB82848D49C08A4D966AE2E0D113EFA0@gisp.nec.co.jp>
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
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>

On 3/29/19 5:29 PM, Chao Fan wrote:
> On Fri, Mar 29, 2019 at 07:20:38AM +0000, Junichi Nomura wrote:
>> +	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
>> +#else
>> +	return 0;
>> #endif
>> -	return rsdp_addr;
> 
> I remeber the rsdp_addr is defined before #ifdef CONFIG_EFI
> If so, you don't need
> #else
> 	return 0;

I moved the whole __efi_get_rsdp_addr() to the inside of #ifdef CONFIG_EFI
and both kexec_get_rsdp_addr() and efi_get_rsdp_addr() just return 0 if
CONFIG_EFI is not defined.

> BY the way, what's your patch based on? I like add patch on my local
> branch and then review code, but failed.
> I try to use 'patch -p1 <' your patch to the latest tip master branch,
> but failed.

The patch is based on Linus's v5.1-rc2.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
