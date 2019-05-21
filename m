Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hT2IT-0006fm-1T
 for kexec@lists.infradead.org; Tue, 21 May 2019 10:47:06 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Date: Tue, 21 May 2019 10:43:30 +0000
Message-ID: <d9d9a627-d0e5-4ee6-7ce1-676db6cb60f4@ce.jp.nec.com>
References: <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv> <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv> <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv> <20190513075006.GB20105@zn.tnic>
 <20190513080210.GC16774@MiWiFi-R3L-srv>
 <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp>
 <20190515065843.GA24212@zn.tnic>
 <20190515070942.GA17154@jeru.linux.bs1.fc.nec.co.jp>
 <CACPcB9cyiPc8JYmt1QhYNipSsJ5z3wTOJ90LS5LTx4YqwaG8rA@mail.gmail.com>
In-Reply-To: <CACPcB9cyiPc8JYmt1QhYNipSsJ5z3wTOJ90LS5LTx4YqwaG8rA@mail.gmail.com>
Content-Language: ja-JP
Content-ID: <C8CB98E7593A254FA2F953E6D7F99473@gisp.nec.co.jp>
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
To: Kairui Song <kasong@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>

On 2019/05/21 18:02, Kairui Song wrote:
> On Wed, May 15, 2019 at 3:10 PM Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
>> On 5/15/19 3:58 PM, Borislav Petkov wrote:
>>> On Wed, May 15, 2019 at 05:17:19AM +0000, Junichi Nomura wrote:
>>>> I found kexec(1) fails to load kernel on a few machines if this patch
>>>> is applied.  Those machines don't have IORES_DESC_ACPI_TABLES region
>>>> and have ACPI tables in IORES_DESC_ACPI_NV_STORAGE region instead.
>>>
>>> Why? What kind of machines are those?
>>
>> I don't know.  They are just general purpose Xeon-based servers
>> and not some special purpose machines.  So I guess there are other
>> such machines in the wild.
> 
> Hi, I think it's reasonable to update the patch to include the
> NV_STORAGE regions as well, most likely the firmware only provided
> NV_STORAGE region? Can you help confirm if the e820 didn't contain
> ACPI data, and only ACPI NVS?

Yes, those machines only have ACPI NVS region as far as I see from kernel log.

> I had a try with this update patch, it worked and didn't break anything.
> 
> Hi Boris, would you prefer to just fold Junichi update patch into the
> previous one or I should send an updated patch?

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
