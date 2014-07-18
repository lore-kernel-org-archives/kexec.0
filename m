Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X83qj-0004Hu-UB
 for kexec@lists.infradead.org; Fri, 18 Jul 2014 08:49:06 +0000
Date: Fri, 18 Jul 2014 16:47:26 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH v2] makedumpfile: Exclude unnecessary hugepages.
Message-ID: <20140718084726.GE11399@dhcp-16-105.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE9722301C@BPXM01GP.gisp.nec.co.jp>
 <20140714063018.GC1717@dhcp-17-102.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97241BA0@BPXM01GP.gisp.nec.co.jp>
 <20140718021616.GA7279@dhcp-16-105.nay.redhat.com>
 <20140718093814.3fd2897b@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140718093814.3fd2897b@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 07/18/14 at 09:38am, Petr Tesarik wrote:
> On Fri, 18 Jul 2014 10:16:16 +0800
> "bhe@redhat.com" <bhe@redhat.com> wrote:
> 
Thanks, Petr. This help. 

> I'm afraid you misunderstand the concept. Let me explain:
> 
> page:
>   The basic memory management block (usually 4K).
> 
> compound page:
>   The kernel may group adjacent pages into a larger object, and track
>   page flags, refcount, etc. at one place for the whole group. This is
>   called compound pages.
> 
>   Compound pages may be used for different things, either kernel
>   internal allocations or by applications.
> 
>   Note that compound pages may or may not correspond to fewer levels of
>   paging in hardware. Take x86_64 as an example. You can have compound
>   pages with order=1 (i.e. 8K). There is nothing in the hardware to
>   support such page size, so the page table just contains 2 consecutive
>   4K pages. Only if you have a compound page with order=9 (i.e. 2M), the
>   kernel can use 3-level paging, creating a 2M page in hardware.
> 
> hugetlbfs:
>   Some compound pages are available through a special filesystem. This
>   filesystem is used solely by user-space applications. However, these
>   pages are formally owned by the kernel (after all, they belong to a
>   filesystem, albeit a very special one). There is nothing in the page
>   flags to tell that they are in fact used by user-space.

I do have a confusion on this. Here it means user space benefits from
hugetlb only through hugetlbfs. If except of that, kernel may make use
of hugetlb to get large memory by merging continuous pages, doesn't it?

I checked Documentation/vm/hugetlbpage.txt and other documents, didn't
see kernel also use hugetlb memory. I don't mean the hugetlb management,
all physical memory is managed by kernel.  


> 
>   The primary intent was to let applications use less levels of paging
>   in hardware to improve performance. This mechanism requires special
>   support in the application.
> 
> transparent huge pages:
>   THP is a method to offer the performance benefits of hugetlbfs to
>   applications that don't use the special hugetlbfs API. To do that,
>   the kernel automatically merges adjacent physical pages into compound
>   pages. In this case, the page flags (stored in the "head page") can
>   be used to determine the use of that page.
> 
> Hope that helps,
> Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
