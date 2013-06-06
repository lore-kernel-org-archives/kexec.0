Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from moutng.kundenserver.de ([212.227.126.187])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ukhne-0003Nu-Ou
 for kexec@lists.infradead.org; Thu, 06 Jun 2013 21:32:51 +0000
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 9/9] vmcore: support mmap() on /proc/vmcore
Date: Thu, 06 Jun 2013 23:31:41 +0200
Message-ID: <10307835.fkACLi6FUD@wuerfel>
In-Reply-To: <20130523052547.13864.83306.stgit@localhost6.localdomain6>
References: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
 <20130523052547.13864.83306.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: riel@redhat.com, hughd@google.com, jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, walken@google.com, cpw@sgi.com, vgoyal@redhat.com

On Thursday 23 May 2013 14:25:48 HATAYAMA Daisuke wrote:
> This patch introduces mmap_vmcore().
> 
> Don't permit writable nor executable mapping even with mprotect()
> because this mmap() is aimed at reading crash dump memory.
> Non-writable mapping is also requirement of remap_pfn_range() when
> mapping linear pages on non-consecutive physical pages; see
> is_cow_mapping().
> 
> Set VM_MIXEDMAP flag to remap memory by remap_pfn_range and by
> remap_vmalloc_range_pertial at the same time for a single
> vma. do_munmap() can correctly clean partially remapped vma with two
> functions in abnormal case. See zap_pte_range(), vm_normal_page() and
> their comments for details.
> 
> On x86-32 PAE kernels, mmap() supports at most 16TB memory only. This
> limitation comes from the fact that the third argument of
> remap_pfn_range(), pfn, is of 32-bit length on x86-32: unsigned long.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

I get build errors on 'make randconfig' from this, when building
NOMMU kernels on ARM. I suppose the new feature should be hidden
in #ifdef CONFIG_MMU.

	Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
