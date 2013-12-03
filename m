Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnrWH-0006j4-68
 for kexec@lists.infradead.org; Tue, 03 Dec 2013 15:04:14 +0000
Date: Tue, 3 Dec 2013 10:03:46 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] vmcore: call remap_pfn_range() separately for respective
 partial pages
Message-ID: <20131203150346.GC4251@redhat.com>
References: <52970342.8090302@jp.fujitsu.com>
 <20131202152754.GC18642@redhat.com>
 <529D3158.2080603@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <529D3158.2080603@jp.fujitsu.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Dec 03, 2013 at 10:18:16AM +0900, HATAYAMA Daisuke wrote:
> (2013/12/03 0:27), Vivek Goyal wrote:
> >On Thu, Nov 28, 2013 at 05:48:02PM +0900, HATAYAMA Daisuke wrote:
> >>Hello Vivek,
> >>
> >>Here is a patch set for mmap failure for /proc/vmcore.
> >>Could you try to use this on the problematic system?
> >>
> >>This patch doesn't copy partial pages to the 2nd kernel, only prepares
> >>vmcore objects for respective partial pages to invoke remap_pfn_range()
> >>for individual partial pages.
> >
> >Hi Hatayama,
> >
> >Thanks for the patch. Ok, I see that partial pages will be put in a separate
> >call to remap_oldmem_pfn_range() and this time it should succeed.
> >
> >I am wondering what do you think about your old approach of copying
> >only relevant old memory to a new kernel page in new kernel. I kind
> >of feel little uncomfortable with the idea of rounding down start
> >and roudning up end to page size boundaries and then accessing the
> >full page using oldmem interface. A safer approach might be to allocate
> >page in new kernel, read *only* those bytes as reported by elf header
> >and fill rest of the page with zeros.
> >
> >Thanks
> >Vivek
> >
> 
> Even if copying partial pages into the 2nd kernel, we need to use ioremap()
> once on them, and I think the ioremap() is exactly similar to
> remap_pfn_range() for a single page. There seems no difference on safeness
> between them.

Hmm.., that's a good point. So anyway we will map the full page and read
parts of it.

> 
> Also, current /proc/vmcore shows user-land tools a shape with holes not
> filled with zeros both in case of read() and in case of mmap(). If we adapt
> copying one without reading data in holes, shape of /proc/vmcore gets
> changed again.

I will not be worried about this as contents of those holes are undefined.
And if we replace undefined with zeros, it should not break any
application.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
