Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwLg5-00DiP5-Fy
 for kexec@lists.infradead.org; Thu, 24 Jun 2021 09:29:42 +0000
Date: Thu, 24 Jun 2021 17:29:30 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Message-ID: <20210624092930.GA802261@MiWiFi-R3L-srv>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNQ258KHlzlajqo/@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, rientjes@google.com, rppt@linux.ibm.com, thomas.lendacky@amd.com, brijesh.singh@amd.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, m.szyprowski@samsung.com, robin.murphy@arm.com

On 06/24/21 at 08:40am, Christoph Hellwig wrote:
> So reduce the amount allocated.  But the pool is needed for proper
> operation on systems with memory encryption.  And please add the right
> maintainer or at least mailing list for the code you're touching next
> time.

Oh, I thoutht it's memory issue only, should have run
./scripts/get_maintainer.pl. sorry.

About reducing the amount allocated, it may not help. Because on x86_64,
kdump kernel doesn't put any page of memory into buddy allocator of DMA
zone. Means it will defenitely OOM for atomic_pool_dma initialization.

Wondering in which case or on which device the atomic pool is needed on
AMD system with mem encrytion enabled. As we can see, the OOM will
happen too in kdump kernel on Intel system, even though it's not
necessary.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
