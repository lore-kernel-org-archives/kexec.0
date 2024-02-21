Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6C8C5478A
	for <kexec@archiver.kernel.org>; Wed, 21 Feb 2024 20:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qf7xf0bmK8LRBhZFzfz+7wzXLda90TPvUCT1ehUC7qk=; b=sB0SuBlbpNT4N+
	LKeMI3YfPDvcASuRqmoywq7tABp/6H3XvDoku1CSFfhCgV8CRtMJA/v0YX7oe2m47YdyUckDuXQoq
	lj58LZfSySf6HfFmBRkj+RNvEKZHPSiAsl7yV2WccZHWPNjAGXF2DBf1pBh2fxsLkb58JPoLsktzf
	o92bMspUepi78WfOfX8B48zlK7pogf1mrgKb6fJ5Ob4FrQVaht7uIZeI6fEixnxcmuCTdWw5TzWZR
	86sPdoknHAVjNzKHkFDaWyYOye68QhHSx2rn1o89lTDcR9oXIcYOwbcb0Ei2mQZ+cEssU3IqsXQHZ
	Bp3LvVGxNiVW32CounIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rctLy-00000002W8D-0THi;
	Wed, 21 Feb 2024 20:38:06 +0000
Received: from [2607:7c80:54:3::138] (helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rctLv-00000002W7k-03WC
	for kexec@lists.infradead.org;
	Wed, 21 Feb 2024 20:38:04 +0000
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 41LKbSZv4150814
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 21 Feb 2024 12:37:28 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 41LKbSZv4150814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1708547850;
	bh=wZe+pzvmKGW8dDc4NzUwS8b+P+8iJHoRmhS8844tchY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=S4GTQTNHxB+sljASMnNjXqY+w1ctwJCmRVSC4Fv0cmcDKI2n6x33I7WBfJkKvuf0d
	 pwbyJDK/EY/DM7C9BcPikhRplUIi5Rc0KPXf+IW4w+AUaszLrZ5XVcF4IobP6PBhUc
	 50R6Ico7S5fHeNBunqOw3yscrB61NHLvQ36cg4ORsc8JXCpD7jVZXUCnwGuL0vq9mM
	 EIUk5zseXyO6uLx8U/edkYY5gRrk4hLjDPwcd3KoGZsOVYnbHGLqLU0xNZBVvlXGRW
	 TxUfiX+TAEDdfpVDVNuGV24yzVhioDDhgw6Z+kR66utuOqcvzDqJC+ZtCFPaNeHKbM
	 O5Y9GBZj1Gyuw==
Date: Wed, 21 Feb 2024 12:37:25 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: ross.philipson@oracle.com, Ard Biesheuvel <ardb@kernel.org>
CC: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_15/15=5D_x86=3A_EFI_stub_D?= =?US-ASCII?Q?RTM_launch_support_for_Secure_Launch?=
User-Agent: K-9 Mail for Android
In-Reply-To: <dc53f100-062b-47ae-abc8-5414ce8d041c@oracle.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-16-ross.philipson@oracle.com> <CAMj1kXF3k_c4Wn9GU+NC_+_aYfDpAzAUnfR=A4L_T+re1H3G=w@mail.gmail.com> <dc53f100-062b-47ae-abc8-5414ce8d041c@oracle.com>
Message-ID: <C98F883A-31D5-4F67-97FF-4AEFAADDDC74@zytor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_123803_067281_F025157C 
X-CRM114-Status: GOOD (  19.03  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On February 21, 2024 12:17:30 PM PST, ross.philipson@oracle.com wrote:
>On 2/15/24 1:01 AM, Ard Biesheuvel wrote:
>> On Wed, 14 Feb 2024 at 23:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>>> 
>>> This support allows the DRTM launch to be initiated after an EFI stub
>>> launch of the Linux kernel is done. This is accomplished by providing
>>> a handler to jump to when a Secure Launch is in progress. This has to be
>>> called after the EFI stub does Exit Boot Services.
>>> 
>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>> ---
>>>   drivers/firmware/efi/libstub/x86-stub.c | 55 +++++++++++++++++++++++++
>>>   1 file changed, 55 insertions(+)
>>> 
>>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>>> index 0d510c9a06a4..4df2cf539194 100644
>>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>>> @@ -9,6 +9,7 @@
>>>   #include <linux/efi.h>
>>>   #include <linux/pci.h>
>>>   #include <linux/stddef.h>
>>> +#include <linux/slr_table.h>
>>> 
>>>   #include <asm/efi.h>
>>>   #include <asm/e820/types.h>
>>> @@ -810,6 +811,57 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>>>          return EFI_SUCCESS;
>>>   }
>>> 
>>> +static void efi_secure_launch(struct boot_params *boot_params)
>>> +{
>>> +       struct slr_entry_uefi_config *uefi_config;
>>> +       struct slr_uefi_cfg_entry *uefi_entry;
>>> +       struct slr_entry_dl_info *dlinfo;
>>> +       efi_guid_t guid = SLR_TABLE_GUID;
>>> +       struct slr_table *slrt;
>>> +       u64 memmap_hi;
>>> +       void *table;
>>> +       u8 buf[64] = {0};
>>> +
>> 
>> If you add a flex array to slr_entry_uefi_config as I suggested in
>> response to the other patch, we could simplify this substantially
>
>I feel like there is some reason why we did not use flex arrays. We were talking and we seem to remember we used to use them and someone asked us to remove them. We are still looking into it. But if we can go back to them, I will take all the changes you recommended here.
>
>Thanks
>Ross
>
>> 
>> static struct slr_entry_uefi_config cfg = {
>>          .hdr.tag        = SLR_ENTRY_UEFI_CONFIG,
>>          .hdr.size       = sizeof(cfg),
>>          .revision       = SLR_UEFI_CONFIG_REVISION,
>>          .nr_entries     = 1,
>>          .entries[0]     = {
>>                  .pcr    = 18,
>>                  .evt_info = "Measured UEFI memory map",
>>          },
>> };
>> 
>> cfg.entries[0].cfg  = boot_params->efi_info.efi_memmap |
>>                        (u64)boot_params->efi_info.efi_memmap_hi << 32;
>> cfg.entries[0].size = boot_params->efi_info.efi_memmap_size;
>> 
>> 
>> 
>>> +       table = get_efi_config_table(guid);
>>> +
>>> +       /*
>>> +        * The presence of this table indicated a Secure Launch
>>> +        * is being requested.
>>> +        */
>>> +       if (!table)
>>> +               return;
>>> +
>>> +       slrt = (struct slr_table *)table;
>>> +
>>> +       if (slrt->magic != SLR_TABLE_MAGIC)
>>> +               return;
>>> +
>> 
>> slrt = (struct slr_table *)get_efi_config_table(guid);
>> if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
>>          return;
>> 
>>> +       /* Add config information to measure the UEFI memory map */
>>> +       uefi_config = (struct slr_entry_uefi_config *)buf;
>>> +       uefi_config->hdr.tag = SLR_ENTRY_UEFI_CONFIG;
>>> +       uefi_config->hdr.size = sizeof(*uefi_config) + sizeof(*uefi_entry);
>>> +       uefi_config->revision = SLR_UEFI_CONFIG_REVISION;
>>> +       uefi_config->nr_entries = 1;
>>> +       uefi_entry = (struct slr_uefi_cfg_entry *)(buf + sizeof(*uefi_config));
>>> +       uefi_entry->pcr = 18;
>>> +       uefi_entry->cfg = boot_params->efi_info.efi_memmap;
>>> +       memmap_hi = boot_params->efi_info.efi_memmap_hi;
>>> +       uefi_entry->cfg |= memmap_hi << 32;
>>> +       uefi_entry->size = boot_params->efi_info.efi_memmap_size;
>>> +       memcpy(&uefi_entry->evt_info[0], "Measured UEFI memory map",
>>> +               strlen("Measured UEFI memory map"));
>>> +
>> 
>> Drop all of this
>> 
>>> +       if (slr_add_entry(slrt, (struct slr_entry_hdr *)uefi_config))
>> 
>> if (slr_add_entry(slrt, &uefi_config.hdr))
>> 
>> 
>>> +               return;
>>> +
>>> +       /* Jump through DL stub to initiate Secure Launch */
>>> +       dlinfo = (struct slr_entry_dl_info *)
>>> +               slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
>>> +
>>> +       asm volatile ("jmp *%%rax"
>>> +                     : : "a" (dlinfo->dl_handler), "D" (&dlinfo->bl_context));
>> 
>> Fix the prototype and just do
>> 
>> dlinfo->dl_handler(&dlinfo->bl_context);
>> unreachable();
>> 
>> 
>> So in summary, this becomes
>> 
>> static void efi_secure_launch(struct boot_params *boot_params)
>> {
>>          static struct slr_entry_uefi_config cfg = {
>>                  .hdr.tag        = SLR_ENTRY_UEFI_CONFIG,
>>                  .hdr.size       = sizeof(cfg),
>>                  .revision       = SLR_UEFI_CONFIG_REVISION,
>>                  .nr_entries     = 1,
>>                  .entries[0]     = {
>>                          .pcr    = 18,
>>                          .evt_info = "Measured UEFI memory map",
>>                  },
>>          };
>>          struct slr_entry_dl_info *dlinfo;
>>          efi_guid_t guid = SLR_TABLE_GUID;
>>          struct slr_table *slrt;
>> 
>>          /*
>>           * The presence of this table indicated a Secure Launch
>>           * is being requested.
>>           */
>>          slrt = (struct slr_table *)get_efi_config_table(guid);
>>          if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
>>                  return;
>> 
>>          cfg.entries[0].cfg  = boot_params->efi_info.efi_memmap |
>>                                (u64)boot_params->efi_info.efi_memmap_hi << 32;
>>          cfg.entries[0].size = boot_params->efi_info.efi_memmap_size;
>> 
>>          if (slr_add_entry(slrt, &cfg.hdr))
>>                  return;
>> 
>>          /* Jump through DL stub to initiate Secure Launch */
>>          dlinfo = (struct slr_entry_dl_info *)
>>                   slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
>> 
>>          dlinfo->dl_handler(&dlinfo->bl_context);
>> 
>>          unreachable();
>> }
>> 
>> 
>>> +}
>>> +
>>>   static void __noreturn enter_kernel(unsigned long kernel_addr,
>>>                                      struct boot_params *boot_params)
>>>   {
>>> @@ -934,6 +986,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>>>                  goto fail;
>>>          }
>>> 
>>> +       /* If a Secure Launch is in progress, this never returns */
>> 
>> if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
>> 
>>> +       efi_secure_launch(boot_params);
>>> +
>>>          /*
>>>           * Call the SEV init code while still running with the firmware's
>>>           * GDT/IDT, so #VC exceptions will be handled by EFI.
>>> --
>>> 2.39.3
>>> 
>> 
>

Linux kernel code doesn't use VLAs because of the limited stack size, and VLAs or alloca() makes stack size tracking impossible. Although this technically speaking runs in a different environment, it is easier to enforce the constraint globally.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
