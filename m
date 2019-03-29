Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9i8D-00068N-Eo
 for kexec@lists.infradead.org; Fri, 29 Mar 2019 03:24:39 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Date: Fri, 29 Mar 2019 03:05:52 +0000
Message-ID: <0263068e-f2d0-1101-0438-0f570f0b38e7@ce.jp.nec.com>
References: <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
In-Reply-To: <20190328155256.GP22720@zn.tnic>
Content-Language: ja-JP
Content-ID: <43DE5C6092BE1F4889EA2F790EF2A411@gisp.nec.co.jp>
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
Cc: "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>

On 3/29/19 12:52 AM, Borislav Petkov wrote:
> static acpi_physical_address
> __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
>                     int size, bool efi_64)
> 
> 
>>  {
>>  	acpi_physical_address rsdp_addr = 0;
> 
> You don't need that variable and can return "table" or 0 after the endif
> below.

I could do that but it will slightly change the current logic.

Existing code does this:

                if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
                        rsdp_addr = table;
                else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
                        return table;

I thought it was to return the table for ACPI_20_TABLE_GUID
if both tables exist.  If we remove rsdp_addr, the code will be:

                if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
                        return table;
                else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
                        return table;

So if there are 2 tables, we return the one that comes first.
Is it ok?

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
