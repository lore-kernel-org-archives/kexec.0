Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYEGx-0003F8-Su
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 11:03:20 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 0CCEB3EE0CD
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 20:03:11 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id DF4F445DE55
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 20:03:10 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id B9CA345DE4E
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 20:03:10 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id AA789E08003
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 20:03:10 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 570B61DB803C
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 20:03:10 +0900 (JST)
Message-ID: <50A2279F.60003@jp.fujitsu.com>
Date: Tue, 13 Nov 2012 19:57:35 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 1/5] x86, pci: add dummy pci device for early stage
References: <20121113090212.1180.12233.sendpatchset@indoh>
 <20121113090222.1180.36111.sendpatchset@indoh>
 <CAPcvp5FCDt5Sy9W7s4gsWuq7z9dATvk37hS_5XfrYepNiJN=nA@mail.gmail.com>
In-Reply-To: <CAPcvp5FCDt5Sy9W7s4gsWuq7z9dATvk37hS_5XfrYepNiJN=nA@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: amurray@embedded-bits.co.uk
Cc: tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, yinghai@kernel.org, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

(2012/11/13 19:01), Andrew Murray wrote:
> Hello,
>
> Some comments inline...
>
> On 13 November 2012 09:07, Takao Indoh <indou.takao@jp.fujitsu.com> wrote:
>> From: Yinghai Lu <yinghai@kernel.org>
>>
>> So we can pass pci_dev *dev to reuse some generic pci functions.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
>> ---
>>   arch/x86/include/asm/pci-direct.h |    2 +
>>   arch/x86/pci/early.c              |   75 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 77 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/pci-direct.h b/arch/x86/include/asm/pci-direct.h
>> index b1e7a45..b6360d3 100644
>> --- a/arch/x86/include/asm/pci-direct.h
>> +++ b/arch/x86/include/asm/pci-direct.h
>> @@ -18,4 +18,6 @@ extern int early_pci_allowed(void);
>>   extern unsigned int pci_early_dump_regs;
>>   extern void early_dump_pci_device(u8 bus, u8 slot, u8 func);
>>   extern void early_dump_pci_devices(void);
>> +
>> +struct pci_dev *get_early_pci_dev(int num, int slot, int func);
>>   #endif /* _ASM_X86_PCI_DIRECT_H */
>> diff --git a/arch/x86/pci/early.c b/arch/x86/pci/early.c
>> index d1067d5..aea6b2b 100644
>> --- a/arch/x86/pci/early.c
>> +++ b/arch/x86/pci/early.c
>> @@ -109,3 +109,78 @@ void early_dump_pci_devices(void)
>>                  }
>>          }
>>   }
>> +
>> +static __init int
>> +early_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
>> +                       int size, u32 *value)
>> +{
>> +       int num, slot, func;
>> +
>> +       num = bus->number;
>> +       slot = devfn >> 3;
>> +       func = devfn & 7;
>
> You may want to use the PCI_SLOT and PCI_FUNC macros in
> include/linux/pci.h to determine values for slot and func.
>
>> +       switch (size) {
>> +       case 1:
>> +               *value = read_pci_config_byte(num, slot, func, where);
>> +               break;
>> +       case 2:
>> +               *value = read_pci_config_16(num, slot, func, where);
>> +               break;
>> +       case 4:
>> +               *value = read_pci_config(num, slot, func, where);
>> +               break;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static __init int
>> +early_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
>> +                       int size, u32 value)
>> +{
>> +       int num, slot, func;
>> +
>> +       num = bus->number;
>> +       slot = devfn >> 3;
>> +       func = devfn & 7;
>
> As above.
>
>> +       switch (size) {
>> +       case 1:
>> +               write_pci_config_byte(num, slot, func, where, (u8)value);
>> +               break;
>> +       case 2:
>> +               write_pci_config_16(num, slot, func, where, (u16)value);
>> +               break;
>> +       case 4:
>> +               write_pci_config(num, slot, func, where, (u32)value);
>> +               break;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static __initdata struct pci_ops pci_early_ops = {
>> +       .read  = early_pci_read,
>> +       .write = early_pci_write,
>> +};
>> +static __initdata struct pci_bus pci_early_bus = {
>> +       .ops = &pci_early_ops,
>> +};
>> +static __initdata char pci_early_init_name[8];
>> +static __initdata struct pci_dev pci_early_dev = {
>> +       .bus = &pci_early_bus,
>> +       .dev = {
>> +               .init_name = pci_early_init_name,
>> +       },
>> +};
>> +
>> +__init struct pci_dev *get_early_pci_dev(int num, int slot, int func)
>> +{
>> +       struct pci_dev *pdev;
>> +
>> +       pdev = &pci_early_dev;
>> +       pdev->devfn = (slot<<3) | (func & 7);
>
> You can use PCI_DEVFN here.

Yeah, I forgot to use these macros. I'll fix them, thanks!

Thanks,
Takao Indoh

>
>> +       pdev->bus->number = num;
>> +       sprintf((char *)pdev->dev.init_name, "%02x:%02x.%01x", num, slot, func);
>> +
>> +       return pdev;
>> +}
>> --
>> 1.7.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Andrew Murray
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
