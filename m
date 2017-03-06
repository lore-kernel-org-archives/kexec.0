Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com
 ([104.47.32.85] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ckx0B-0005bF-6V
 for kexec@lists.infradead.org; Mon, 06 Mar 2017 18:04:57 +0000
Subject: Re: [RFC PATCH v4 26/28] x86: Allow kexec to be used with SME
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154755.19244.51276.stgit@tlendack-t1.amdoffice.net>
 <20170217155756.GJ30272@char.us.ORACLE.com>
 <d2f16b24-f2ef-a22b-3c72-2d8ad585553e@amd.com>
 <20170301092536.GB8353@dhcp-128-65.nay.redhat.com>
 <998eb58b-eefd-3093-093f-9ae25ddda472@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <87ecaf44-b5a0-61c6-30b1-a798cc535983@amd.com>
Date: Mon, 6 Mar 2017 12:04:28 -0600
MIME-Version: 1.0
In-Reply-To: <998eb58b-eefd-3093-093f-9ae25ddda472@amd.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

+kexec-list

On 3/6/2017 11:58 AM, Tom Lendacky wrote:
> On 3/1/2017 3:25 AM, Dave Young wrote:
>> Hi Tom,
>
> Hi Dave,
>
>>
>> On 02/17/17 at 10:43am, Tom Lendacky wrote:
>>> On 2/17/2017 9:57 AM, Konrad Rzeszutek Wilk wrote:
>>>> On Thu, Feb 16, 2017 at 09:47:55AM -0600, Tom Lendacky wrote:
>>>>> Provide support so that kexec can be used to boot a kernel when SME is
>>>>> enabled.
>>>>
>>>> Is the point of kexec and kdump to ehh, dump memory ? But if the
>>>> rest of the memory is encrypted you won't get much, will you?
>>>
>>> Kexec can be used to reboot a system without going back through BIOS.
>>> So you can use kexec without using kdump.
>>>
>>> For kdump, just taking a quick look, the option to enable memory
>>> encryption can be provided on the crash kernel command line and then
>>
>> Is there a simple way to get the SME status? Probably add some sysfs
>> file for this purpose.
>
> Currently there is not.  I can look at adding something, maybe just the
> sme_me_mask value, which if non-zero, would indicate SME is active.
>
>>
>>> crash kernel can would be able to copy the memory decrypted if the
>>> pagetable is set up properly. It looks like currently ioremap_cache()
>>> is used to map the old memory page.  That might be able to be changed
>>> to a memremap() so that the encryption bit is set in the mapping. That
>>> will mean that memory that is not marked encrypted (EFI tables, swiotlb
>>> memory, etc) would not be read correctly.
>>
>> Manage to store info about those ranges which are not encrypted so that
>> memremap can handle them?
>
> I can look into whether something can be done in this area. Any input
> you can provide as to what would be the best way/place to store the
> range info so kdump can make use of it, would be greatly appreciated.
>
>>
>>>
>>>>
>>>> Would it make sense to include some printk to the user if they
>>>> are setting up kdump that they won't get anything out of it?
>>>
>>> Probably a good idea to add something like that.
>>
>> It will break kdump functionality, it should be fixed instead of
>> just adding printk to warn user..
>
> I do want kdump to work. I'll investigate further what can be done in
> this area.
>
> Thanks,
> Tom
>
>>
>> Thanks
>> Dave
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
