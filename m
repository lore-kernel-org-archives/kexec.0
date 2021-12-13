Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwg5N-0089o3-6h
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 07:49:26 +0000
Date: Mon, 13 Dec 2021 08:49:19 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-ID: <20211213074919.GC20758@lst.de>
References: <20211207030750.30824-1-bhe@redhat.com>
 <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de>
 <20211209080540.GA3050@MiWiFi-R3L-srv>
 <alpine.DEB.2.22.394.2112091355510.270348@gentwo.de>
 <20211213073925.GA29905@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213073925.GA29905@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: Christoph Lameter <cl@gentwo.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org

On Mon, Dec 13, 2021 at 03:39:25PM +0800, Baoquan He wrote:
> > > As said at above, ia64 and riscv don't have ZONE_DMA at all, they just
> > > cover low 4G with ZONE_DMA32 alone.
> > 
> > If you do not have devices that are crap and cannot address the full
> > memory then you dont need these special zones.
> 
> I am not a DMA expert, with my understanding, on x86_64 and arm64, we
> have PCIe devices which dma mask is 32bit

Yes, way to many, and they keep getting newly introduce as well.  Also
weirdo masks like 40, 44 or 48 bits.

> , means they can only address
> ZONE_DMA32.

Yes and no.  Offset between cpu physical and device address make this
complicated, even ignoring iommus.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
