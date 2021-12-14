Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gentwo.de ([2a02:c206:2048:5042::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mx52U-00DT3n-GM
 for kexec@lists.infradead.org; Tue, 14 Dec 2021 10:28:08 +0000
Date: Tue, 14 Dec 2021 11:28:01 +0100 (CET)
From: Christoph Lameter <cl@gentwo.org>
Subject: Re: [PATCH v3 5/5] mm/slub: do not create dma-kmalloc if no managed
 pages in DMA zone
In-Reply-To: <f5ff82eb-73b6-55b5-53d7-04ab73ce5035@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2112141125290.370323@gentwo.de>
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213122712.23805-6-bhe@redhat.com> <20211213134319.GA997240@odroid>
 <20211214053253.GB2216@MiWiFi-R3L-srv>
 <f5ff82eb-73b6-55b5-53d7-04ab73ce5035@suse.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Baoquan He <bhe@redhat.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, John.p.donnelly@oracle.com, kexec@lists.infradead.org, stable@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>

On Tue, 14 Dec 2021, Vlastimil Babka wrote:

> If doesn't feel right to me to fix (or rather workaround) this on the level
> of kmalloc caches just because the current reports come from there. If we
> decide it's acceptable for kdump kernel to return !ZONE_DMA memory for
> GFP_DMA requests, then it should apply at the page allocator level for all
> allocations, not just kmalloc().
>
> Also you mention above you'd prefer ZONE_DMA32 memory, while chances are
> this approach of using KMALLOC_NORMAL caches will end up giving you
> ZONE_NORMAL. On the page allocator level it would be much easier to
> implement a fallback from non-populated ZONE_DMA to ZONE_DMA32 specifically.

Well this only works if the restrictions on the physical memory addresses
of each platform make that possible.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
