Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XSL23-0003rI-37
 for kexec@lists.infradead.org; Fri, 12 Sep 2014 07:12:35 +0000
Date: Fri, 12 Sep 2014 15:12:10 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH v4] makedumpfile: Exclude unnecessary hugepages.
Message-ID: <20140912071210.GA29800@dhcp-16-116.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE9724E000@BPXM01GP.gisp.nec.co.jp>
 <20140910073424.GD25867@dhcp-16-116.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97254CF9@BPXM01GP.gisp.nec.co.jp>
 <20140911092406.GB4411@dhcp-16-116.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97254E06@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97254E06@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 09/11/14 at 10:04am, Atsushi Kumagai wrote:
> >On 09/11/14 at 08:52am, Atsushi Kumagai wrote:
> >> >Hi Atsushi,
> >> >
> >> >Since huge pages are included in user pages, I can't think of a way to
> >> >make test cases for huge page exclusion. Could you give some suggestions
> >> >on this or how did you test it?
> >>
> >> Before I posted this patch, I tested as below.
> >> This idea came from the fact that old makedumpfile can't exclude
> >> huge pages except the first page(PG_head).
> >>
> >>    1. Get the number of hugepages from /proc/meminfo
> >>    2. Calculate the number of PG_tail pages
> >>    3. Capture the dumpfile without filtering
> >>    4. Run makedumpfile and compare the report message between v1.5.6
> >>       and v1.5.7(rc) to get how many user pages become excludable with
> >>       this patch.
> >>    5. The result of Step2's and Step4's must be same, confirm it.
> >>
> >> The way above is for THP but you can apply it also for hugetlbfs
> >> if you take care of the things that old makedumpfile can't exclude
> >> *any* hugetlbfs pages.
> >
> >But THP is also Anonymous pages, doesn't it do the same for THP between
> >1.5.6 and 1.5.7?
> 
> Only a PG_head page is marked as an anonymous page, makedumpfile doesn't
> distinguish PG_tail pages as anonymous pages. Please see below.
> 
>   do_huge_pmd_anonymous_page()
>     + __do_huge_pmd_anonymous_page()
>       + page_add_new_anon_rmap()
>         + __page_set_anon_rmap()


Yes, you are right. Thanks, Atsushi!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
