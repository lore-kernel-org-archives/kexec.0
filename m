Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxSp8-000ezM-QH
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 11:51:56 +0000
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v3 5/5] mm/slub: do not create dma-kmalloc if no managed
 pages in DMA zone
Date: Wed, 15 Dec 2021 11:51:50 +0000
Message-ID: <67ff367b7a90452f8c009707a00e67b2@AcuMS.aculab.com>
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213122712.23805-6-bhe@redhat.com> <20211213134319.GA997240@odroid>
 <20211214053253.GB2216@MiWiFi-R3L-srv>
 <f5ff82eb-73b6-55b5-53d7-04ab73ce5035@suse.cz>
 <20211215044818.GB1097530@odroid> <20211215070335.GA1165926@odroid>
 <20211215072710.GA3010@lst.de> <f7c1f169-f9b3-6930-f933-d69ab0287069@suse.cz>
In-Reply-To: <f7c1f169-f9b3-6930-f933-d69ab0287069@suse.cz>
MIME-Version: 1.0
Content-Language: en-US
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
To: 'Vlastimil Babka' <vbabka@suse.cz>, Christoph Hellwig <hch@lst.de>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Baoquan He <bhe@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "cl@linux.com" <cl@linux.com>, "John.p.donnelly@oracle.com" <John.p.donnelly@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>

From: Vlastimil Babka
> Sent: 15 December 2021 10:34
> 
> On 12/15/21 08:27, Christoph Hellwig wrote:
> > On Wed, Dec 15, 2021 at 07:03:35AM +0000, Hyeonggon Yoo wrote:
> >> I'm not sure that allocating from ZONE_DMA32 instead of ZONE_DMA
> >> for kdump kernel is nice way to solve this problem.
> >
> > What is the problem with zones in kdump kernels?
> 
> My understanding is that kdump kernel can only use physical memory that it
> got reserved by the main kernel, and the main kernel will reserve some block
> of memory that doesn't include any pages from ZONE_DMA (first 16MB of
> physical memory or whatnot). 
...

Is there still any support for any of the very old hardware that could only
support 24bit DMA?

I think the AMD PCnet-ISA and PCnet-PCI ethernet (lance) were both 32bit masters.
(I don't remember ever having to worry about physical addresses.)
I'm sure I remember some old SCSI boards only being able to do 24bit DMA.
But I can't remember which bus interface they were.
Unlikely to be ISA because it has always been hard to get a motherboard
DMA channel into 'cascade mode'.

Might have been some EISA boards - anyone still use those?
So we are left with early PCI boards.

It really is worth looking at what actually needs it at all.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
