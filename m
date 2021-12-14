Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxBHc-00F2k9-4y
 for kexec@lists.infradead.org; Tue, 14 Dec 2021 17:08:09 +0000
Message-ID: <dc648afe-6dbe-55c9-ebf6-9334d71706b4@oracle.com>
Date: Tue, 14 Dec 2021 11:07:34 -0600
Subject: Re: [PATCH v3 5/5] mm/slub: do not create dma-kmalloc if no managed
 pages in DMA zone
Content-Language: en-US
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213122712.23805-6-bhe@redhat.com> <20211214163124.GA21762@lst.de>
From: john.p.donnelly@oracle.com
In-Reply-To: <20211214163124.GA21762@lst.de>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, cl@linux.com, kexec@lists.infradead.org, stable@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>

On 12/14/21 10:31 AM, Christoph Hellwig wrote:
> On Mon, Dec 13, 2021 at 08:27:12PM +0800, Baoquan He wrote:
>> Dma-kmalloc will be created as long as CONFIG_ZONE_DMA is enabled.
>> However, it will fail if DMA zone has no managed pages. The failure
>> can be seen in kdump kernel of x86_64 as below:
> 
> Please just switch the sr allocation to use GFP_KERNEL without GFP_DMA.
> The block layer will do the proper bounce buffering underneath for the
> very unlikely case that we're actually using the single HBA driver that
> has ISA DMA addressing limitations.
> 
> Same for the ch drive, btw.

Hi,

Is CONFIG_ZONE_DMA even needed anymore in x86_64  ?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
