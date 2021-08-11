Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 11 Aug 2021 06:52:57 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Message-ID: <YRNluS1qt1YL2r7p@infradead.org>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org>
 <20210624092930.GA802261@MiWiFi-R3L-srv>
 <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
 <20210805065410.GA2051@MiWiFi-R3L-srv>
 <5df93c4e-ffdd-88c5-db4a-1a09826d047a@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5df93c4e-ffdd-88c5-db4a-1a09826d047a@amd.com>
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
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Baoquan He <bhe@redhat.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, brijesh.singh@amd.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rppt@linux.ibm.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, rientjes@google.com

On Tue, Aug 10, 2021 at 03:52:25PM -0500, Tom Lendacky via iommu wrote:
> I think the atomic pool is used by the NVMe driver. My understanding is
> that driver will do a dma_alloc_coherent() from interrupt context, so it
> needs to use GFP_ATOMIC. The pool was created because dma_alloc_coherent()
> would perform a set_memory_decrypted() call, which can sleep. The pool
> eliminates that issue (David can correct me if I got that wrong).

Not just the NVMe driver.  We have plenty of drivers doing that, just
do a quick grep for dma_alloc_* dma_poll_alloc, dma_pool_zalloc with
GFP_ATOMIC (and that won't even find multi-line strings).

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
