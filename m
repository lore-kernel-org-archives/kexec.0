Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ukl50-00073n-7S
 for kexec@lists.infradead.org; Fri, 07 Jun 2013 01:02:59 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 92CEF3EE0C0
 for <kexec@lists.infradead.org>; Fri,  7 Jun 2013 10:02:28 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7612D45DE5A
 for <kexec@lists.infradead.org>; Fri,  7 Jun 2013 10:02:28 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 438D145DE5C
 for <kexec@lists.infradead.org>; Fri,  7 Jun 2013 10:02:28 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 24D71E38003
 for <kexec@lists.infradead.org>; Fri,  7 Jun 2013 10:02:28 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 410661DB804B
 for <kexec@lists.infradead.org>; Fri,  7 Jun 2013 10:02:27 +0900 (JST)
Message-ID: <51B130F9.8070408@jp.fujitsu.com>
Date: Fri, 07 Jun 2013 10:01:45 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8 9/9] vmcore: support mmap() on /proc/vmcore
References: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
 <20130523052547.13864.83306.stgit@localhost6.localdomain6>
 <10307835.fkACLi6FUD@wuerfel>
In-Reply-To: <10307835.fkACLi6FUD@wuerfel>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: riel@redhat.com, hughd@google.com, jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, walken@google.com, cpw@sgi.com, vgoyal@redhat.com

(2013/06/07 6:31), Arnd Bergmann wrote:
> On Thursday 23 May 2013 14:25:48 HATAYAMA Daisuke wrote:
>> This patch introduces mmap_vmcore().
>>
>> Don't permit writable nor executable mapping even with mprotect()
>> because this mmap() is aimed at reading crash dump memory.
>> Non-writable mapping is also requirement of remap_pfn_range() when
>> mapping linear pages on non-consecutive physical pages; see
>> is_cow_mapping().
>>
>> Set VM_MIXEDMAP flag to remap memory by remap_pfn_range and by
>> remap_vmalloc_range_pertial at the same time for a single
>> vma. do_munmap() can correctly clean partially remapped vma with two
>> functions in abnormal case. See zap_pte_range(), vm_normal_page() and
>> their comments for details.
>>
>> On x86-32 PAE kernels, mmap() supports at most 16TB memory only. This
>> limitation comes from the fact that the third argument of
>> remap_pfn_range(), pfn, is of 32-bit length on x86-32: unsigned long.
>>
>> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> Acked-by: Vivek Goyal <vgoyal@redhat.com>
>
> I get build errors on 'make randconfig' from this, when building
> NOMMU kernels on ARM. I suppose the new feature should be hidden
> in #ifdef CONFIG_MMU.
>
> 	Arnd
>

Thanks for trying the build and your report!

OTOH, I don't have no-MMU architectures; x86 box only. I cannot reproduce this build error. Could you give me your build log? I want to use it to detect what part depends on CONFIG_MMU.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
