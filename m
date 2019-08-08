Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr770048.outbound.protection.outlook.com
 ([40.107.77.48] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hvr2i-0002PZ-V4
 for kexec@lists.infradead.org; Thu, 08 Aug 2019 22:37:57 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: crash: `kmem -s` reported "kmem: dma-kmalloc-512: slab:
 ffffe192c0001000 invalid freepointer: e5ffef4e9a040b7e" on a dumped vmcore
Date: Thu, 8 Aug 2019 22:37:53 +0000
Message-ID: <5d91e856-01de-bc80-e4bc-497d57652072@amd.com>
References: <e640b50a-a962-8e56-33a2-2ba2eb76e813@redhat.com>
 <20190802010538.GA2202@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190802010538.GA2202@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
Content-ID: <90AF5D7FF1C0014A9F7C643F3BE5F454@namprd12.prod.outlook.com>
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
To: Dave Young <dyoung@redhat.com>, lijiang <lijiang@redhat.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Anderson <anderson@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 8/1/19 8:05 PM, Dave Young wrote:
> Add kexec cc list.
> On 08/01/19 at 11:02pm, lijiang wrote:
>> Hi, Tom
>>
>> Recently, i ran into a problem about SME and used crash tool to check the vmcore as follow:
>>
>> crash> kmem -s | grep -i invalid
>> kmem: dma-kmalloc-512: slab: ffffe192c0001000 invalid freepointer: e5ffef4e9a040b7e
>> kmem: dma-kmalloc-512: slab: ffffe192c0001000 invalid freepointer: e5ffef4e9a040b7e
>>
>> And the crash tool reported the above error, probably, the main reason is that kernel does not
>> correctly handle the first 640k region when SME is enabled.
>>
>> When SME is enabled, the kernel and initramfs images are loaded into the decrypted memory, and
>> the backup area(first 640k) is also mapped as decrypted, but the first 640k data is copied to
>> the backup area in purgatory(). Please refer to this file: arch/x86/purgatory/purgatory.c
>> ......
>> static int copy_backup_region(void)
>> {
>>          if (purgatory_backup_dest) {
>>                  memcpy((void *)purgatory_backup_dest,
>>                         (void *)purgatory_backup_src, purgatory_backup_sz);
>>          }
>>          return 0;
>> }
>> ......
>>
>> arch/x86/kernel/machine_kexec_64.c
>> ......
>> machine_kexec_prepare()->
>> arch_update_purgatory()->
>> .....
>>
>> Actually, the firs 640k area is encrypted in the first kernel when SME is enabled, here kernel
>> copies the first 640k data to the backup area in purgatory(), because the backup area is mapped
>> as decrypted, this copying operation makes that the first 640k data is decrypted(decoded) and
>> saved to the backup area, but probably kernel can not aware of SME in purgatory(), which causes
>> kernel mistakenly read out the first 640k.
>>
>> In addition, i hacked kernel code as follow:
>>
>> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
>> index 7bcc92add72c..a51631d36a7a 100644
>> --- a/fs/proc/vmcore.c
>> +++ b/fs/proc/vmcore.c
>> @@ -377,6 +378,16 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
>>                                              m->offset + m->size - *fpos,
>>                                              buflen);
>>                          start = m->paddr + *fpos - m->offset;
>> +                       if (m->paddr == 0x73f60000) {//the backup area's start address:0x73f60000
>> +                               tmp = read_from_oldmem(buffer, tsz, &start,
>> +                                               userbuf, false);
>> +                       } else
>>                                  tmp = read_from_oldmem(buffer, tsz, &start,
>>                                                 userbuf, mem_encrypt_active());
>>                          if (tmp < 0)
>>
>> Here, i used the crash tool to check the vmcore, i can see that the backup area is decrypted,
>> except for the dma-kmalloc-512. So i suspect that kernel did not correctly read out the first
>> 640k data to backup area. Do you happen to know how to deal with the first 640k area in purgatory()
>> when SME is enabled? Any idea?

I'm not all that familiar with kexec and purgatory, etc., but I think
that you want to setup the page table that is active when purgatory runs
so that the src and dest both have the SME encryption mask set in their
respective page table entries. This way, when the copy is performed,
everything is copied correctly.  Remember, encrypted data from one page
cannot be directly copied as unencrypted data and decrypted properly in
the new location (e.g. a page of zeroes encrypted at one address will not
appear the same as a page of zeroes encrypted at a different address).

Thanks,
Tom

>>
>> BTW: I' curious the reason why the address of dma-kmalloc-512k always falls into the first 640k
>> region, and i did not see the same issue on another machine.
>>
>> Machine:
>> Serial Number 	diesel-sys9079-0001
>> Model           AMD Diesel (A0C)
>> CPU             AMD EPYC 7601 32-Core Processor
>>
>>
>> Background:
>> On x86_64, the first 640k region is special because of some historical reasons. And kdump kernel will
>> reuse the first 640k region, so kernel will back up(copy) the first 640k region to a backup area in
>> purgatory(), in order not to rewrite the old region(640k) in kdump kernel, which makes sure that kdump
>> can read out the old memory from vmcore.
>>
>>
>> Thanks.
>> Lianbo
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
