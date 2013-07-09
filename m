Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UwQol-0006nX-Gm
 for kexec@lists.infradead.org; Tue, 09 Jul 2013 05:50:28 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id BA45E3EE081
 for <kexec@lists.infradead.org>; Tue,  9 Jul 2013 14:50:00 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id AB52245DE50
 for <kexec@lists.infradead.org>; Tue,  9 Jul 2013 14:50:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8C6ED45DDCF
 for <kexec@lists.infradead.org>; Tue,  9 Jul 2013 14:50:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7F26F1DB803E
 for <kexec@lists.infradead.org>; Tue,  9 Jul 2013 14:50:00 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 28ED41DB8038
 for <kexec@lists.infradead.org>; Tue,  9 Jul 2013 14:50:00 +0900 (JST)
Message-ID: <51DBA47C.8090708@jp.fujitsu.com>
Date: Tue, 09 Jul 2013 14:49:48 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <51DA4ED9.60903@jp.fujitsu.com> <20130708112839.498ccfc6@holzheu>
 <20130708142826.GA9094@redhat.com>
In-Reply-To: <20130708142826.GA9094@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

(2013/07/08 23:28), Vivek Goyal wrote:
> On Mon, Jul 08, 2013 at 11:28:39AM +0200, Michael Holzheu wrote:
>> On Mon, 08 Jul 2013 14:32:09 +0900
>> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>>
>>> (2013/07/02 4:32), Michael Holzheu wrote:
>>>> For zfcpdump we can't map the HSA storage because it is only available
>>>> via a read interface. Therefore, for the new vmcore mmap feature we have
>>>> introduce a new mechanism to create mappings on demand.
>>>>
>>>> This patch introduces a new architecture function remap_oldmem_pfn_range()
>>>> that should be used to create mappings with remap_pfn_range() for oldmem
>>>> areas that can be directly mapped. For zfcpdump this is everything besides
>>>> of the HSA memory. For the areas that are not mapped by remap_oldmem_pfn_range()
>>>> a generic vmcore a new generic vmcore fault handler mmap_vmcore_fault()
>>>> is called.
>>>>
>>>
>>> This fault handler is only for s390 specific issue. Other architectures don't need
>>> this for the time being.
>>>
>>> Also, from the same reason, I'm doing this review based on source code only.
>>> I cannot run the fault handler on meaningful system, which is currently s390 only.
>>
>> You can test the code on other architectures if you do not map anything in advance.
>> For example you could just "return 0" in remap_oldmem_pfn_range():
>>
>> /*
>>   * Architectures may override this function to map oldmem
>>   */
>> int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
>>                                    unsigned long from, unsigned long pfn,
>>                                    unsigned long size, pgprot_t prot)
>> {
>>          return 0;
>> }
>>
>> In that case for all pages the new mechanism would be used.
>>
>>>
>>> I'm also concerned about the fault handler covers a full range of vmcore, which
>>> could hide some kind of mmap() bug that results in page fault.
>>>
>>> So, the fault handler should be enclosed by ifdef CONFIG_S390 for the time being.
>>
>> I personally do not like that, but if Vivek and you prefer this, of course we
>> can do that.
>>
>> What about something like:
>>
>> #ifdef CONFIG_S390
>> static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
>> {
>> ...
>> }
>> #else
>> static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
>> {
>> 	BUG();
>> }
>> #endif
>
> I personally perfer not to special case it for s390 only and let the
> handler be generic.
>
> If there is a bug in remap_old_pfn_range(), only side affect is that
> we will fault in the page when it is accessed and that will be slow. BUG()
> sounds excessive. At max it could be WARN_ONCE().
>
> In regular cases for x86, this path should not even hit. So special casing
> it to detect issues with remap_old_pfn_range() does not sound very good
> to me. I would rather leave it as it is and if there are bugs and mmap()
> slows down, then somebody needs to debug it.
>

I agree to WARN_ONCE(). Then, we can notice bug at least if it occurs.

Interface is like this?

[generic]

bool __weak in_valid_fault_range(pgoff_t pgoff)
{
     return false;
}

[s390]

bool in_valid_fault_range(pgoff_t pgoff)
{
     loff_t offset = pgoff << PAGE_CACHE_SHIFT;
     u64 paddr = vmcore_offset_to_paddr(offset);

     return paddr < ZFCPDUMP_HSA_SIZE;
}

assuming vmcore_offset_to_paddr() that looks up vmcore_list and returns physical
address corresponding to given offset of vmcore. I guess this could return error
value if there's no entry corresponding to given offset in vmcore_list.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
