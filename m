Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uyt8L-0004iK-O4
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 00:28:51 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 5B7A13EE0BD
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 09:28:17 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4A8CF45DDCF
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 09:28:17 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3266445DE4E
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 09:28:17 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 20FD61DB803F
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 09:28:17 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CBB411DB803A
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 09:28:16 +0900 (JST)
Message-ID: <51E49383.9030308@jp.fujitsu.com>
Date: Tue, 16 Jul 2013 09:27:47 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <51DA4ED9.60903@jp.fujitsu.com> <20130708112839.498ccfc6@holzheu>
 <20130708142826.GA9094@redhat.com> <51DBA47C.8090708@jp.fujitsu.com>
 <20130710104252.479a0f92@holzheu> <51DD2E5A.1030200@jp.fujitsu.com>
 <20130710143309.GD5819@redhat.com> <51DFE2FB.2000804@jp.fujitsu.com>
 <20130715142059.GA23772@redhat.com>
In-Reply-To: <20130715142059.GA23772@redhat.com>
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

(2013/07/15 23:20), Vivek Goyal wrote:
> On Fri, Jul 12, 2013 at 08:05:31PM +0900, HATAYAMA Daisuke wrote:
>
> [..]
>> How about
>>
>> static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
>> {
>> ...
>>          char *buf;
>>          int rc;
>>
>> #ifndef CONFIG_S390
>>          return VM_FAULT_SIGBUS;
>> #endif
>>          page = find_or_create_page(mapping, index, GFP_KERNEL);
>>
>> Considering again, I don't think WARN_ONCE() is good now. The fact that fault occurs on
>> mmap() region indicates some kind of buggy situation occurs on the process. The process
>> should be killed as soon as possible. If user still wants to get crash dump, he should
>> try again in another process.
>
> I don't understand that. Process should be killed only if there was no
> mapping created for the region process is trying to access.
>
> If there is a mapping but we are trying to fault in the actual contents,
> then it is not a problem of process. Process is accessing a region of
> memory which it is supposed to access.
>
> Potential problem here is that remap_pfn_range() did not map everything
> it was expected to so we have to resort on page fault handler to read
> that in. So it is more of a kernel issue and not process issue and for
> that WARN_ONCE() sounds better?
>

On the current design, there's no page faults on memory mapped by remap_pfn_range().
They map a whole range in the current design. If there are page faults, page table of the process
is broken in their some page entries. This indicates the process's bahaviour is affected by
some software/hardware bugs. In theory, process could result in arbitrary behaviour. We cannot
detect the reason and recover the original sane state. The only thing we can do is to kill
the process and drop the possibility of the process to affect other system components and of
system to result in worse situation.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
