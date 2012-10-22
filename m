Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQ7SJ-0007Jr-M3
 for kexec@lists.infradead.org; Mon, 22 Oct 2012 02:09:29 +0000
Message-ID: <5084A9FA.1090403@redhat.com>
Date: Mon, 22 Oct 2012 10:05:46 +0800
From: Dave Young <dyoung@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
References: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
 <5047DBA9.8030000@hp.com> <504815EB.9000701@redhat.com>
 <5048E40E.7040003@hp.com> <5049B6AD.9000304@redhat.com>
 <504FF4DB.6030601@redhat.com> <507F7394.5020501@redhat.com>
 <1350572394.3894.18.camel@rhapsody>
In-Reply-To: <1350572394.3894.18.camel@rhapsody>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Khalid Aziz <khalid@gonehiking.org>
Cc: horms@verge.net.au, kexec@lists.infradead.org, vgoyal@redhat.com

On 10/18/2012 10:59 PM, Khalid Aziz wrote:

> On Thu, 2012-10-18 at 11:12 +0800, Dave Young wrote:
>> On 09/12/2012 10:35 AM, Dave Young wrote:
>>
>>> On 09/07/2012 04:56 PM, Dave Young wrote:
>>>>
>>>> I did some digging about the efi boot kdump in slackware with kernel
>>>> from latest linus tree. I'm surprise that kdump works even without these
>>>> "noefi" and "acpi_rsdp="
>>>>
>>>> With fedora 17 3.4.3 kernel passing "acpi_rsdp=" is enough for kdump
>>>> kernel booting.
>>>>
>>>> Actually in x86 setup code if bootloader do not pass correct efi_info in
>>>> boot_params efi_enabled will be set to 0 automaticlly.
>>>>
>>>> So as for this patch 'noefi' is not needed.
>>>>
>>>> I will do more testing to see why linus tree works without "acpi_rsdp="
>>>>
>>>
>>> There's probably some efi changes between 3.4.3 - 3.6.0-rc4 cause this
>>> works. I have not got time to bisect it.
>>
>>
>> During recent test, I found I mistakenly used wrong kernel config
>> without CONFIG_EFI in 1st kernel for testing. acpi_rsdp= is still needed.
>>
>> Just resent the v2 patch, please help to review.
>>
> 
> Hi Dave,
> 
> I suspect EFI based systems with Compatibility Support Module (CSM) are
> still not going to need this, but I can see native EFI systems with no
> CSM needing this. I have reviewed your patch.


Good to know, I have no CSM machine to test. Since Simon has applied the
patch, I think I can improve this issue later If I can find a machine
with CSM.

> 
> BTW, I am no longer at HP, so <khalid.aziz@hp.com> is no longer valid.
> <khalid@gonehiking.org> is my permanent personal email address.


Thanks for reminding.

> 
> --
> Khalid
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



-- 
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
