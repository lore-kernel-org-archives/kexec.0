Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WekxY-0006jN-Ju
 for kexec@lists.infradead.org; Mon, 28 Apr 2014 12:47:01 +0000
Date: Mon, 28 Apr 2014 20:46:35 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: About the status of hugepage filtering!
Message-ID: <20140428124635.GA1546@dhcp-17-102.nay.redhat.com>
References: <20140428075605.GA9405@dhcp-16-105.nay.redhat.com>
 <20140428122153.1563f7d3@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140428122153.1563f7d3@hananiah.suse.cz>
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
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

On 04/28/14 at 12:21pm, Petr Tesarik wrote:
> On Mon, 28 Apr 2014 15:56:05 +0800
> Baoquan He <bhe@redhat.com> wrote:
> 
> > Hi Astushi,
> > 
> > I remember earlier Jingbai posted a patchset on hugepage filtering,
> > later you pasted your hugepage filtering prototype patch, and people
> > thought yours is better. So now may I know the status and what's your
> > plan?
> > 
> > Because in makedumpfile 1.5.6, this is not delivered. Your plan can help
> > us much.
> 
> Hi Baoquan,
> 
> I followed up on Atsushi's prototype, and there's a patch series
> sitting on my disk which just came too late for 1.5.6, so I held it
> back. It was also suggested that the mdf_pfn cleanup patch be applied
> first. That one is now in, and I'll send an updated series shortly.
> 
> The first part of the change is the "Generic handling of multi-page
> exclusions", that is a method which can be used for excluding both free
> pages and compound pages (and without adding even more complexity to
> the calculation of the cycle size).
> 
> The second part is handling of hugepages. This simply extends the
> algorithm so that all pages in a compound page are treated as one
> object. To make it work, additional info must be exported from the
> kernel. This is where I got stuck with my previous attempt. For now,
> this patch is already in the mm tree:
> 
> http://ozlabs.org/~akpm/mmotm/broken-out/kexec-save-pg_head_mask-in-vmcoreinfo.patch

Hi Petr,

Good to know this progress. And it's awesome that kernel patch exporting
PG_head_mask has been in mm tree.

I saw people had discussed heatedly about the generic handling of
multi-page exclusions. So as long as the first part passes through and
merged in, hugepage filtering adding will be supported very smoothly, is
that right? I didn't follow up that thread very closely, if yes, it's a
great news. And thanks for your effort.

Thanks
Baoquan

> 
> Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
