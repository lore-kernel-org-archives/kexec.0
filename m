Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Ol5ON-0007Q2-3U
	for kexec@lists.infradead.org; Mon, 16 Aug 2010 19:30:44 +0000
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: Re: [PATCH][EFI] Run EFI in physical mode
Date: Mon, 16 Aug 2010 15:30:03 -0400
MIME-Version: 1.0
In-Reply-To: <m1iq3ep33n.fsf@fess.ebiederm.org>
References: <F0CB3B1C601247indou.takao@jp.fujitsu.com>
	<m1iq3ep33n.fsf@fess.ebiederm.org>
Message-Id: <F4CB3D796CF475indou.takao@jp.fujitsu.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nhorman@tuxdriver.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

On Fri, 13 Aug 2010 15:19:56 -0700, "Eric W. Biederman" wrote:

>Takao Indoh <indou.takao@jp.fujitsu.com> writes:
>
>> Hi all,
>>
>> The attached patch enables EFI to run in physical mode.
>>
>> Basically EFI is in physical mode at first and it's switched to virtual
>> mode after calling SetVirtualAddressMap. By applying this patch, you can
>> run EFI always in physical mode. And you can also specify "virtefi" as
>> kernel boot parameter to run EFI in virtual mode as before. Note that
>> this patch supports only x86_64.
>>
>> This is needed to run kexec/kdump in EFI-booted system. The following is
>> an original discussion. In this thread, I explained that kdump does not
>> work because EFI system table is modified by SetVirtualAddressMap. And
>> the idea to run EFI in physical mode was proposed. This patch implements
>> it.
>>
>> http://marc.info/?l=linux-kernel&m=128018221820234&w=2
>>> When the 1st kernel boots, EFI system table(efi_system_table_t) is
>>> modified by SetVirtualAddressMap, which is one of EFI runtime service.
>>> This runtime changes physical address in EFI system table to virtual
>>> address.
>>> 
>>> When the 2nd kernel boots, it also receives the same EFI system table,
>>> and the address included in it is already virtual address(1st kernel
>>> rewrote it).  But 2nd kernel does not know that, 2nd kernel thinks it is
>>> a physical address. This causes problems.
>>
>> Basic idea of this patch is to create EFI own pagetable. This pagetable
>> maps physical address of EFI runtime to the virtual address which is the
>> same value so that we can call it directly. For example, physical 
>> address 0x800000 is mapped to virtual address 0x800000. Before calling
>> EFI runtime, cr3 register is switched to this pagetable, and restored
>> when we come back from EFI.
>>
>> Any comments would be appreciated.
>>
>> Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
>
>Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
>There is what appears to be unneeded redundancy (we need two
>implementations of physciall calls into efi?), but that is confined to
>the weird efi state.
>
>It is a shame you haven't done the little bit extra to get
>efi_pagetable_init working on x86_32.

Unfortunately I don't have a machine to test. The machine I'm using does 
not support EFI on x86_32:-( I'd appreciate it if anyone try it...

Thanks,
Takao Indoh

>
>Overall this seems sane and confined to the x86 efi, and it looks
>like further improvements could easily be layered on top of this one.
>
>Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
