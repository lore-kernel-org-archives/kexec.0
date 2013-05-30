Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhzBL-0002eP-PV
 for kexec@lists.infradead.org; Thu, 30 May 2013 09:30:04 +0000
Message-ID: <51A71B49.3070003@cn.fujitsu.com>
Date: Thu, 30 May 2013 17:26:33 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8 9/9] vmcore: support mmap() on /proc/vmcore
References: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
 <20130523052547.13864.83306.stgit@localhost6.localdomain6>
 <20130523152445.17549682ae45b5aab3f3cde0@linux-foundation.org>
 <CAJGZr0LwivLTH+E7WAR1B9_6B4e=jv04KgCUL_PdVpi9JjDpBw@mail.gmail.com>
 <51A2BBA7.50607@jp.fujitsu.com>
 <CAJGZr0LmsFXEgb3UXVb+rqo1aq5KJyNxyNAD+DG+3KnJm_ZncQ@mail.gmail.com>
In-Reply-To: <CAJGZr0LmsFXEgb3UXVb+rqo1aq5KJyNxyNAD+DG+3KnJm_ZncQ@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Maxim Uvarov <muvarov@gmail.com>
Cc: riel@redhat.com, hughd@google.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, Vivek Goyal <vgoyal@redhat.com>, linux-mm@kvack.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "Eric W. Biederman" <ebiederm@xmission.com>, kosaki.motohiro@jp.fujitsu.com, Andrew Morton <akpm@linux-foundation.org>, walken@google.com, Cliff Wickman <cpw@sgi.com>, jingbai.ma@hp.com

On 05/30/2013 05:14 PM, Maxim Uvarov wrote:
> 
> 
> 
> 2013/5/27 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com <mailto:d.hatayama@jp.fujitsu.com>>
> 
>     (2013/05/24 18:02), Maxim Uvarov wrote:
> 
> 
> 
> 
>         2013/5/24 Andrew Morton <akpm@linux-foundation.org <mailto:akpm@linux-foundation.org> <mailto:akpm@linux-foundation.__org <mailto:akpm@linux-foundation.org>>>
> 
> 
>             On Thu, 23 May 2013 14:25:48 +0900 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com <mailto:d.hatayama@jp.fujitsu.com> <mailto:d.hatayama@jp.fujitsu.__com <mailto:d.hatayama@jp.fujitsu.com>>> wrote:
> 
>              > This patch introduces mmap_vmcore().
>              >
>              > Don't permit writable nor executable mapping even with mprotect()
>              > because this mmap() is aimed at reading crash dump memory.
>              > Non-writable mapping is also requirement of remap_pfn_range() when
>              > mapping linear pages on non-consecutive physical pages; see
>              > is_cow_mapping().
>              >
>              > Set VM_MIXEDMAP flag to remap memory by remap_pfn_range and by
>              > remap_vmalloc_range_pertial at the same time for a single
>              > vma. do_munmap() can correctly clean partially remapped vma with two
>              > functions in abnormal case. See zap_pte_range(), vm_normal_page() and
>              > their comments for details.
>              >
>              > On x86-32 PAE kernels, mmap() supports at most 16TB memory only. This
>              > limitation comes from the fact that the third argument of
>              > remap_pfn_range(), pfn, is of 32-bit length on x86-32: unsigned long.
> 
>             More reviewing and testing, please.
> 
> 
>         Do you have git pull for both kernel and userland changes? I would like to do some more testing on my machines.
> 
>         Maxim.
> 
> 
>     Thanks! That's very helpful.
> 
>     -- 
>     Thanks.
>     HATAYAMA, Daisuke
> 
> Any update for this? Where can I checkout all sources?

This series is now in Andrew Morton's -mm tree.

-- 
Thanks.
Zhang Yanfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
