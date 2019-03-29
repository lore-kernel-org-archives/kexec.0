Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132] helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9nTK-0000ur-8k
 for kexec@lists.infradead.org; Fri, 29 Mar 2019 09:06:47 +0000
Date: Fri, 29 Mar 2019 17:05:50 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190329090550.GI4234@localhost.localdomain>
References: <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <0263068e-f2d0-1101-0438-0f570f0b38e7@ce.jp.nec.com>
 <20190329083920.GA21152@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190329083920.GA21152@zn.tnic>
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
Cc: "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Dave Young <dyoung@redhat.com>

On Fri, Mar 29, 2019 at 09:39:20AM +0100, Borislav Petkov wrote:
>On Fri, Mar 29, 2019 at 03:05:52AM +0000, Junichi Nomura wrote:
>> > You don't need that variable and can return "table" or 0 after the endif
>> > below.
>> 
>> I could do that but it will slightly change the current logic.
>> 
>> Existing code does this:
>> 
>>                 if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
>>                         rsdp_addr = table;
>>                 else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
>>                         return table;
>> 
>> I thought it was to return the table for ACPI_20_TABLE_GUID
>> if both tables exist.  If we remove rsdp_addr, the code will be:
>> 
>>                 if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
>>                         return table;
>>                 else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
>>                         return table;
>> 
>> So if there are 2 tables, we return the one that comes first.
>> Is it ok?
>
>That's a good question.
>
>Chao, what was the intention there, ACPI_20_TABLE_GUID is the preferred
>table to return? If so, why?

Yes, ACPI_20_TABLE_GUID is preferred.

ACPI_20 means version 2.0 and later versions, ACPI_TABLE_GUID is version 1.0
which is earlier than 2003, it's too old. Version 2.0 has more features than 1.0.
Sure the new version is preferred.

So many codes prefers ACPI20, such as in drivers/acpi/osl.c where kernel
parses RSDP ACPI20 firstly. Documentation/ABI/testing/sysfs-firmware-efi says in
/sys/firmware/efi/systab, ACPI20 comes before ACPI. So that kexec-tools
code kexec/arch/i386/crashdump-x86.c can easily get ACPI_20(if there is
ACPI_20) before ACPI 1.0.
But in my code, I am not sure which version will be found firstly, so I
write this logical, if ACPI20 found, return directly, then consider ACPI 1.0.

Thanks,
Chao Fan

>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
