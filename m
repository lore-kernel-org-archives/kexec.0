Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgmZc-0004tJ-DV
 for kexec@lists.infradead.org; Mon, 27 May 2013 01:50:09 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8B8893EE0C0
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:49:46 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7A65345DD78
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:49:46 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 58DF345DDCF
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:49:46 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id B8F111DB8044
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:49:45 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id F20FE1DB803A
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 10:49:44 +0900 (JST)
Message-ID: <51A2BBA7.50607@jp.fujitsu.com>
Date: Mon, 27 May 2013 10:49:27 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8 9/9] vmcore: support mmap() on /proc/vmcore
References: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
 <20130523052547.13864.83306.stgit@localhost6.localdomain6>
 <20130523152445.17549682ae45b5aab3f3cde0@linux-foundation.org>
 <CAJGZr0LwivLTH+E7WAR1B9_6B4e=jv04KgCUL_PdVpi9JjDpBw@mail.gmail.com>
In-Reply-To: <CAJGZr0LwivLTH+E7WAR1B9_6B4e=jv04KgCUL_PdVpi9JjDpBw@mail.gmail.com>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: riel@redhat.com, hughd@google.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, Vivek Goyal <vgoyal@redhat.com>, linux-mm@kvack.org, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "Eric W. Biederman" <ebiederm@xmission.com>, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, Andrew Morton <akpm@linux-foundation.org>, walken@google.com, Cliff Wickman <cpw@sgi.com>, jingbai.ma@hp.com

(2013/05/24 18:02), Maxim Uvarov wrote:
>
>
>
> 2013/5/24 Andrew Morton <akpm@linux-foundation.org <mailto:akpm@linux-foundation.org>>
>
>     On Thu, 23 May 2013 14:25:48 +0900 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com <mailto:d.hatayama@jp.fujitsu.com>> wrote:
>
>      > This patch introduces mmap_vmcore().
>      >
>      > Don't permit writable nor executable mapping even with mprotect()
>      > because this mmap() is aimed at reading crash dump memory.
>      > Non-writable mapping is also requirement of remap_pfn_range() when
>      > mapping linear pages on non-consecutive physical pages; see
>      > is_cow_mapping().
>      >
>      > Set VM_MIXEDMAP flag to remap memory by remap_pfn_range and by
>      > remap_vmalloc_range_pertial at the same time for a single
>      > vma. do_munmap() can correctly clean partially remapped vma with two
>      > functions in abnormal case. See zap_pte_range(), vm_normal_page() and
>      > their comments for details.
>      >
>      > On x86-32 PAE kernels, mmap() supports at most 16TB memory only. This
>      > limitation comes from the fact that the third argument of
>      > remap_pfn_range(), pfn, is of 32-bit length on x86-32: unsigned long.
>
>     More reviewing and testing, please.
>
>
> Do you have git pull for both kernel and userland changes? I would like to do some more testing on my machines.
>
> Maxim.

Thanks! That's very helpful.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
