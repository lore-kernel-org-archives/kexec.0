Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132] helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9o4J-0007Qd-KO
 for kexec@lists.infradead.org; Fri, 29 Mar 2019 09:45:03 +0000
Date: Fri, 29 Mar 2019 17:44:09 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190329094409.GM4234@localhost.localdomain>
References: <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <0263068e-f2d0-1101-0438-0f570f0b38e7@ce.jp.nec.com>
 <20190329083920.GA21152@zn.tnic>
 <20190329090550.GI4234@localhost.localdomain>
 <20190329091605.GB21152@zn.tnic>
 <ee8045cf-5100-6bd6-1ccc-e9654da922b6@ce.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ee8045cf-5100-6bd6-1ccc-e9654da922b6@ce.jp.nec.com>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>

On Fri, Mar 29, 2019 at 09:37:00AM +0000, Junichi Nomura wrote:
>On 3/29/19 6:16 PM, Borislav Petkov wrote:
>> On Fri, Mar 29, 2019 at 05:05:50PM +0800, Chao Fan wrote:
>>> But in my code, I am not sure which version will be found firstly, so I
>>> write this logical, if ACPI20 found, return directly, then consider ACPI 1.0.
>> 
>> Thanks.
>> 
>> Junichi, please add a shorter version of that as a comment to the code,
>> above the function name so that it is clear why we're preferring the 2.0
>> version.
>
>Sure, I'll add this above __efi_get_rsdp_addr().
>
>/*
> * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
> * ACPI_TABLE_GUID are found, take the former, which has more features.
> */
>

I notice in my host machine, the two tables are the same:
[17:38:11] cfan@localhost /home/cfan (0)
> sudo cat /sys/firmware/efi/systab
[sudo] password for cfan:
MPS=0xfd420
ACPI20=0xdb807000
ACPI=0xdb807000
SMBIOS=0xf04c0

But in my qemu guest, they are different and the address of ACPI20 is
higher than ACPI 1.0:
[root@localhost ~]# cat /sys/firmware/efi/systab
ACPI20=0xbfbfa014
ACPI=0xbfbfa000
SMBIOS=0xbfbcc000

In this condition, ACPI 1.0 comes before ACPI 2.0. So I suggested you
to keep this logical.

Thanks,
Chao Fan

>-- 
>Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
