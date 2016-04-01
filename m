Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1am5cZ-0002oF-HK
 for kexec@lists.infradead.org; Fri, 01 Apr 2016 20:24:44 +0000
Date: Fri, 1 Apr 2016 13:24:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] kexec: update VMCOREINFO for compound_order/dtor
Message-Id: <20160401132421.7cadaeb967dc342f643d8c38@linux-foundation.org>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E25FCE@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701E25FCE@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 1 Mar 2016 06:14:32 +0000 Atsushi Kumagai <ats-kumagai@wm.jp.nec.com> wrote:

> makedumpfile refers page.lru.next to get the order of compound pages
> for page filtering. However, now the order is stored in page.compound_order,
> hence VMCOREINFO should be updated to export the offset of
> page.compound_order.
> 
> The fact is, page.compound_order was introduced already in kernel 4.0,
> but the offset of it was the same as page.lru.next until kernel 4.3,
> so this was not actual problem.
> 
> The above can be said also for page.lru.prev and page.compound_dtor,
> it's necessary to detect hugetlbfs pages. Further, the content was
> changed from direct address to the ID which means dtor.

It's unclear which kernels need the patch and why.  I *think* that the
patch is needed in 4.3.x, 4.4.x, 4.5.x and 4.6 in order to make
makedumpfile work correctly.  Is that right?

And it appears that [patch 2/2] is needed in 4.0+?

However in both cases I am uncertain - what are the end-user visible
effects of these regressions?  Why can bugs remain in place for so long
without having been observed?


Please make all these things clear when perparing changelogs for
bugfixes: which kernel versions need fixing and why (ie: what are the
end-user visible effects of the bug).


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
