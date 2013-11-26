Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vl8m5-0006x2-MO
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 02:53:19 +0000
Date: Tue, 26 Nov 2013 10:52:21 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] makedumpfile: add parameters to update_cyclic_region
Message-ID: <20131126025221.GA22934@dhcp-16-252.nay.redhat.com>
References: <20131125023150.GB13197@dhcp-16-252.nay.redhat.com>
 <5292D30E.5070003@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5292D30E.5070003@jp.fujitsu.com>
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
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, chaowang@redhat.com

On 11/25/13 at 01:33pm, HATAYAMA Daisuke wrote:
> (2013/11/25 11:31), Baoquan He wrote:
> >Hi HATAYAMA and Atsushi,
> >
> >I think v2 is better than v1, since update_cyclic_region can be used
> >with a more flexible calling.
> >
> >What's your opinion about this?
> >
> >On 11/23/13 at 05:29pm, Baoquan He wrote:
> 
> Thanks for your patch. The bug is caused by my patch set for creating a
> whole part of 1st bitmap before entering cyclic process.
> 
> I think v1 is better than v2. The update_cyclic_range() call relevant
> to this regression is somewhat special compared to other calls; it is
> the almost only call that doesn't need to perform filtering processing.
> To fix this bug, please make the patch so as not to affect the other calls,
> in order to keep change as small as possible.

OK, if you think so. But I still think update_cyclic_region is a little
weird, its name doesn't match its functionality, this confuses code
reviewers. And it does something unnecessary somewhere. If it's
possible, I would rather take out the create_1st_bitmap_cyclic and
exclude_unnecessary_pages_cyclic, and call them explicitly where they
are really needed. Surely we can make a little change in both of them,
E.g add a parameter pfn to them, then we can also judge like
update_cyclic_region has done:

        if (is_cyclic_region(pfn))
                return TRUE;

If you insist on v1 is a better idea, I will repost based on it, but keep
my personal opinion.

Baoquan
Thanks

> 
> -- 
> Thanks.
> HATAYAMA, Daisuke
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
