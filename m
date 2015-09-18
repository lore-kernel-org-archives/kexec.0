Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcwGA-0002Vp-F7
 for kexec@lists.infradead.org; Fri, 18 Sep 2015 14:03:30 +0000
Date: Fri, 18 Sep 2015 22:03:44 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH] Load crash kernel high on x86
Message-ID: <20150918140344.GA5310@dhcp-128-25.nay.redhat.com>
References: <20150918080324.69d7b9d5@hananiah.suse.cz>
 <20150918104013.6c3cc009@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150918104013.6c3cc009@hananiah.suse.cz>
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
Cc: Yinghai Lu <yinghai@kernel.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 09/18/15 at 10:40am, Petr Tesarik wrote:
> On Fri, 18 Sep 2015 08:03:24 +0200
> Petr Tesarik <ptesarik@suse.com> wrote:
> 
> > Hello,
> > 
> > There may be more than one crash kernel regions on x86. However, the kexec
> > syscall checks that target address is within crashk_res boundaries. Looking
> > at the logic in arch/x86/kernel/setup.c, there are only two possible layouts:
> > 
> >   1. crashk_res is below 4G, and there is only one region,
> >   2. crashk_res is above 4G, and crashk_low_res is below 4G
> > 
> > In either case, kexec-tools must pick the highest region.
> > 
> > Currently, kexec-tools picks the largest region. If high reservation is
> > smaller than low, kexec(2) returns -EADDRNOTAVAIL, and kexec prints out
> > this error message:
> > 
> > kexec_load failed: Cannot assign requested address
> 
> I have just re-checked with kexec_file(2), and it is also affected. At
> this point, you may think that it would be better to fix the check in
> sanity_check_segment_list() instead.
> 
> I don't think so.
> 
> Low memory reservation is intended for swiotlb and DMA buffers, i.e. it
> is somehow precious. The kernel can run above 4G, initrd can also be
> located above 4G, so why should I place it in the _precious_ low memory?
> 
> If you agree, I'll also post a kernel patch for kexec_file(2).

KEXEC always use a pair of crashk_res.start and crashk_res.end as crash
memory region in kernel. And this struct is assigned in function
reserve_crashkernel during booting. In order to solve low memory issue,
there is another struct crashk_low_res is used.

So, the code flow deals with the above case correctly.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
