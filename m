Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UZwSx-00013x-3v
 for kexec@lists.infradead.org; Wed, 08 May 2013 04:59:00 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id DE4803EE0C5
 for <kexec@lists.infradead.org>; Wed,  8 May 2013 13:58:32 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id CEDF945DE5D
 for <kexec@lists.infradead.org>; Wed,  8 May 2013 13:58:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id B2F1A45DE59
 for <kexec@lists.infradead.org>; Wed,  8 May 2013 13:58:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8B9ACE38005
 for <kexec@lists.infradead.org>; Wed,  8 May 2013 13:58:32 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 31DB21DB804F
 for <kexec@lists.infradead.org>; Wed,  8 May 2013 13:58:32 +0900 (JST)
Message-ID: <5189DB4A.8020902@jp.fujitsu.com>
Date: Wed, 08 May 2013 13:57:46 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/8] vmcore: copy ELF note segments in the 2nd kernel
 per page vmcore objects
References: <20130413002000.18245.21513.stgit@localhost6.localdomain6>
 <20130413002133.18245.91528.stgit@localhost6.localdomain6>
 <20130429193611.GQ8204@redhat.com> <5188B3BE.9040104@jp.fujitsu.com>
 <20130507150840.GA12965@redhat.com>
In-Reply-To: <20130507150840.GA12965@redhat.com>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com, jingbai.ma@hp.com

(2013/05/08 0:08), Vivek Goyal wrote:
> On Tue, May 07, 2013 at 04:56:46PM +0900, HATAYAMA Daisuke wrote:
>> (2013/04/30 4:36), Vivek Goyal wrote:
>>> On Sat, Apr 13, 2013 at 09:21:33AM +0900, HATAYAMA Daisuke wrote:
>>>
>>> [..]
>>>> ELF notes are per-cpu, so total size of ELF note segments increases
>>>> according to the number of CPUs. The current maximum number of CPUs on
>>>> x86_64 is 5192, and there's already system with 4192 CPUs in SGI,
>>>> where total size amounts to 1MB. This can be larger in the neare
>>>> futrue or possibly even now on another architecture. Thus, to avoid
>>>> the case where memory allocation for large block fails, we allocate
>>>> vmcore objects per pages.
>>>
>>> IIRC, eric had suggested using vmalloc() and remap_vmalloc_range(). What's
>>> wrong with that? That should keep your vc_list relatively smaller.
>>>
>>
>> Yes, it's handy if it's possible to remap them in vmalloc space, but
>> the problem here is that remap_vmalloc_range requires the first
>> argument vma to cover full range of the requested map. This becomes
>> problem when requested area for mmap() overlaps multiple objects,
>> for example, ELF headers and memory refered to by the first PT_LOAD
>> program header.
>>
>> To use remap_vmalloc_range, it's necessary to prepare a new variant
>> similar to remap_pfn_range by which we can remap different objects
>> separately to a single vma.
>
> Ok. Is it hard to prepare one such variant. If we can write one, it will
> simplify the vmcore code.

I'll try to write it. Although I avoided implementing it once, now it 
looks relatively easy to implement thanks to vm_insert_page, which does 
all essential thing. All I have to do should be consider sanity-check only.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
