Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UjQgJ-0001Bg-Tj
 for kexec@lists.infradead.org; Mon, 03 Jun 2013 09:04:11 +0000
Date: Mon, 3 Jun 2013 17:43:51 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v8 9/9] vmcore: support mmap() on /proc/vmcore
Message-Id: <20130603174351.d04b2ac71d1bab0df242e0ba@mxc.nes.nec.co.jp>
In-Reply-To: <CAJGZr0Ld6Q4a4f-VObAbvqCp=+fTFNEc6M-Fdnhh28GTcSm1=w@mail.gmail.com>
References: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
 <20130523052547.13864.83306.stgit@localhost6.localdomain6>
 <20130523152445.17549682ae45b5aab3f3cde0@linux-foundation.org>
 <CAJGZr0LwivLTH+E7WAR1B9_6B4e=jv04KgCUL_PdVpi9JjDpBw@mail.gmail.com>
 <51A2BBA7.50607@jp.fujitsu.com>
 <CAJGZr0LmsFXEgb3UXVb+rqo1aq5KJyNxyNAD+DG+3KnJm_ZncQ@mail.gmail.com>
 <51A71B49.3070003@cn.fujitsu.com>
 <CAJGZr0Ld6Q4a4f-VObAbvqCp=+fTFNEc6M-Fdnhh28GTcSm1=w@mail.gmail.com>
Mime-Version: 1.0
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
To: muvarov@gmail.com
Cc: riel@redhat.com, kexec@lists.infradead.org, hughd@google.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, vgoyal@redhat.com, linux-mm@kvack.org, d.hatayama@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, ebiederm@xmission.com, kosaki.motohiro@jp.fujitsu.com, akpm@linux-foundation.org, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

Hello Maxim,

On Thu, 30 May 2013 14:30:01 +0400
Maxim Uvarov <muvarov@gmail.com> wrote:

> 2013/5/30 Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> > On 05/30/2013 05:14 PM, Maxim Uvarov wrote:
> > >
> > >
> > >
> > > 2013/5/27 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com <mailto:
> > d.hatayama@jp.fujitsu.com>>
> > >
> > >     (2013/05/24 18:02), Maxim Uvarov wrote:
> > >
> > >
> > >
> > >
> > >         2013/5/24 Andrew Morton <akpm@linux-foundation.org <mailto:
> > akpm@linux-foundation.org> <mailto:akpm@linux-foundation.__org <mailto:
> > akpm@linux-foundation.org>>>
> > >
> > >
> > >             On Thu, 23 May 2013 14:25:48 +0900 HATAYAMA Daisuke <
> > d.hatayama@jp.fujitsu.com <mailto:d.hatayama@jp.fujitsu.com> <mailto:
> > d.hatayama@jp.fujitsu.__com <mailto:d.hatayama@jp.fujitsu.com>>> wrote:
> > >
> > >              > This patch introduces mmap_vmcore().
> > >              >
> > >              > Don't permit writable nor executable mapping even with
> > mprotect()
> > >              > because this mmap() is aimed at reading crash dump memory.
> > >              > Non-writable mapping is also requirement of
> > remap_pfn_range() when
> > >              > mapping linear pages on non-consecutive physical pages;
> > see
> > >              > is_cow_mapping().
> > >              >
> > >              > Set VM_MIXEDMAP flag to remap memory by remap_pfn_range
> > and by
> > >              > remap_vmalloc_range_pertial at the same time for a single
> > >              > vma. do_munmap() can correctly clean partially remapped
> > vma with two
> > >              > functions in abnormal case. See zap_pte_range(),
> > vm_normal_page() and
> > >              > their comments for details.
> > >              >
> > >              > On x86-32 PAE kernels, mmap() supports at most 16TB
> > memory only. This
> > >              > limitation comes from the fact that the third argument of
> > >              > remap_pfn_range(), pfn, is of 32-bit length on x86-32:
> > unsigned long.
> > >
> > >             More reviewing and testing, please.
> > >
> > >
> > >         Do you have git pull for both kernel and userland changes? I
> > would like to do some more testing on my machines.
> > >
> > >         Maxim.
> > >
> > >
> > >     Thanks! That's very helpful.
> > >
> > >     --
> > >     Thanks.
> > >     HATAYAMA, Daisuke
> > >
> > > Any update for this? Where can I checkout all sources?
> >
> > This series is now in Andrew Morton's -mm tree.
> >
> > Ok, and what about makedumpfile changes? Is it possible to fetch them from
> somewhere?

You can fetch them from here, "mmap" branch is the change:

  git://git.code.sf.net/p/makedumpfile/code

And they will be merged into v1.5.4.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
