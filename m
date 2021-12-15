Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxOhY-00HCoI-0Z
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 07:27:50 +0000
Date: Wed, 15 Dec 2021 08:27:44 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 5/5] mm/slub: do not create dma-kmalloc if no
 managed pages in DMA zone
Message-ID: <20211215072744.GB3010@lst.de>
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213122712.23805-6-bhe@redhat.com> <20211214163124.GA21762@lst.de>
 <dc648afe-6dbe-55c9-ebf6-9334d71706b4@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dc648afe-6dbe-55c9-ebf6-9334d71706b4@oracle.com>
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
To: john.p.donnelly@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, cl@linux.com, kexec@lists.infradead.org, stable@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>

On Tue, Dec 14, 2021 at 11:07:34AM -0600, john.p.donnelly@oracle.com wrote:
> Is CONFIG_ZONE_DMA even needed anymore in x86_64  ?

Yes.  There are still plenty of addressing challenged devices, mostly
ISA-like but also a few PCI/PCIe ones.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
