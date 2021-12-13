Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwgVx-008GgK-8o
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 08:16:54 +0000
Date: Mon, 13 Dec 2021 16:16:41 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RESEND v2 2/5] dma-pool: allow user to disable atomic pool
Message-ID: <20211213081641.GB29905@MiWiFi-R3L-srv>
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-3-bhe@redhat.com>
 <20211213074404.GA20758@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213074404.GA20758@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, robin.murphy@arm.com, cl@linux.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org

On 12/13/21 at 08:44am, Christoph Hellwig wrote:
> On Tue, Dec 07, 2021 at 11:07:47AM +0800, Baoquan He wrote:
> > In the current code, three atomic memory pools are always created,
> > atomic_pool_kernel|dma|dma32, even though 'coherent_pool=0' is
> > specified in kernel command line. In fact, atomic pool is only
> > necessary when CONFIG_DMA_DIRECT_REMAP=y or mem_encrypt_active=y
> > which are needed on few ARCHes.
> 
> And only these select the atomic pool, so it won't get created otherwise.
> What problem are you trying to solve?

This tries to make "coherent_pool=0" behave normally. As you see,
'coherent_pool=0' will behave like no 'coherent_pool' being specified.
This is not consistent with other similar kernel parameter, e.g cma=.

At the beginning, I planned to add a knob to allow user to disable one
or all atomic pool. Later I changed. However I think this patch makes
sense on fixing the a little bizarre behaviour, 'coherent_pool=0' but
still get atomic pool created.

I can drop it if you think it's unnecessary.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
