Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UxbBR-0006rD-8P
 for kexec@lists.infradead.org; Fri, 12 Jul 2013 11:06:42 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 5C9BD3EE0BB
 for <kexec@lists.infradead.org>; Fri, 12 Jul 2013 20:06:13 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4CF1445DE56
 for <kexec@lists.infradead.org>; Fri, 12 Jul 2013 20:06:13 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 368A845DE55
 for <kexec@lists.infradead.org>; Fri, 12 Jul 2013 20:06:13 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 27FBA1DB8032
 for <kexec@lists.infradead.org>; Fri, 12 Jul 2013 20:06:13 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id CCF571DB8046
 for <kexec@lists.infradead.org>; Fri, 12 Jul 2013 20:06:12 +0900 (JST)
Message-ID: <51DFE2FB.2000804@jp.fujitsu.com>
Date: Fri, 12 Jul 2013 20:05:31 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <51DA4ED9.60903@jp.fujitsu.com> <20130708112839.498ccfc6@holzheu>
 <20130708142826.GA9094@redhat.com> <51DBA47C.8090708@jp.fujitsu.com>
 <20130710104252.479a0f92@holzheu> <51DD2E5A.1030200@jp.fujitsu.com>
 <20130710143309.GD5819@redhat.com>
In-Reply-To: <20130710143309.GD5819@redhat.com>
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

(2013/07/10 23:33), Vivek Goyal wrote:
> On Wed, Jul 10, 2013 at 06:50:18PM +0900, HATAYAMA Daisuke wrote:
>
> [..]
>> If you want to avoid looking up vmcore_list that takes linear time w.r.t. the number
>> of the elements, you can still calculate the range of offsets in /proc/vmcore
>> corresponding to HSA during /proc/vmcore initialization.
>>
>> Also, could you tell me how often and how much the HSA region is during crash dumping?
>> I guess the read to HSA is done mainly during early part of crash dumping process only.
>> According to the code, it appears at most 64MiB only. Then, I feel performance is not
>> a big issue.
>>
>> Also, cost of WARN_ONCE() is one memory access only in the 2nd and later calls. I don't
>> think it too much overhead...
>
> Hi Hatayama,
>
> I think michael's proposal of just putting in WARN_ONCE for non s390 arch
> sounds reasonable. It is simple and meets your need of being able to
> detect that non s390 arch don't make use of mmap() path yet. Introducing
> in_valid_fault_range() kind of sounds overkill to me for this issue.
>
> Thanks
> Vivek
>

How about

static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
{
...
         char *buf;
         int rc;

#ifndef CONFIG_S390
         return VM_FAULT_SIGBUS;
#endif
         page = find_or_create_page(mapping, index, GFP_KERNEL);

Considering again, I don't think WARN_ONCE() is good now. The fact that fault occurs on
mmap() region indicates some kind of buggy situation occurs on the process. The process
should be killed as soon as possible. If user still wants to get crash dump, he should
try again in another process.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
