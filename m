Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com
 ([40.107.92.56] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDoYy-007N2f-Vu
 for kexec@lists.infradead.org; Wed, 11 Aug 2021 13:46:36 +0000
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org> <20210624092930.GA802261@MiWiFi-R3L-srv>
 <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
 <20210805065410.GA2051@MiWiFi-R3L-srv>
 <5df93c4e-ffdd-88c5-db4a-1a09826d047a@amd.com>
 <20210811022327.GF23322@MiWiFi-R3L-srv>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <615cfd68-b1c2-f2d0-0c03-1271a913cef2@amd.com>
Date: Wed, 11 Aug 2021 08:46:27 -0500
In-Reply-To: <20210811022327.GF23322@MiWiFi-R3L-srv>
Content-Language: en-US
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
To: Baoquan He <bhe@redhat.com>, rientjes@google.com
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, rppt@linux.ibm.com, brijesh.singh@amd.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, m.szyprowski@samsung.com

On 8/10/21 9:23 PM, Baoquan He wrote:
> On 08/10/21 at 03:52pm, Tom Lendacky wrote:
>> On 8/5/21 1:54 AM, Baoquan He wrote:
>>> On 06/24/21 at 11:47am, Robin Murphy wrote:
>>>> On 2021-06-24 10:29, Baoquan He wrote:
>>>>> On 06/24/21 at 08:40am, Christoph Hellwig wrote:

...

> Looking at the those related commits, the below one from David tells 
> that atomic dma pool is used when device require non-blocking and
> unencrypted buffer. When I checked the system I borrowed, it's AMD EYPC
> and SME is enabled. And it has many pci devices, as you can see, its 'ls
> pci' outputs 113 lines. But disabling the three atomic pools didn't
> trigger any error on that AMD system. Does it mean only specific devices
> need this atomic pool in SME/SEV enabling case? Should we add more
> details in document or code comment to make clear this? 

It very well could be just the devices being used. Under SME (bare metal),
if a device supports 64-bit DMA, then bounce buffers aren't used and the
DMA can be performed directly to encrypted memory, so there is no need to
issue a set_memory_decrypted() call, so I would assume it likely isn't
using the pool.

Under SEV, however, all DMA has to go through guest un-encrypted memory.
If you pass through a device that does dma_alloc_coherent() calls with
GFP_ATOMIC, then the pool will be needed.

Thanks,
Tom

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
