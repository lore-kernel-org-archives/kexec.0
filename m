Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwmCA-00A06j-Pm
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 14:20:52 +0000
Message-ID: <05c0da33-f225-41a4-4310-9cc9b3348275@oracle.com>
Date: Mon, 13 Dec 2021 08:20:35 -0600
Subject: Re: [PATCH v3 1/5] docs: kernel-parameters: Update to reflect the
 current default size of atomic pool
Content-Language: en-US
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213122712.23805-2-bhe@redhat.com>
From: john.p.donnelly@oracle.com
In-Reply-To: <20211213122712.23805-2-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org

On 12/13/21 6:27 AM, Baoquan He wrote:
> Since commit 1d659236fb43("dma-pool: scale the default DMA coherent pool
> size with memory capacity"), the default size of atomic pool has been
> changed to take by scaling with system memory capacity. So update the
> document in kerenl-parameter.txt accordingly.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
 >
  Acked-by: John Donnelly <john.p.donnelly@oracle.com>
  Tested-by:  John Donnelly <john.p.donnelly@oracle.com>

> ---
>   Documentation/admin-guide/kernel-parameters.txt | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9725c546a0d4..ec4d25e854a8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -664,7 +664,9 @@
>   
>   	coherent_pool=nn[KMG]	[ARM,KNL]
>   			Sets the size of memory pool for coherent, atomic dma
> -			allocations, by default set to 256K.
> +			allocations. Otherwise the default size will be scaled
> +			with memory capacity, while clamped between 128K and
> +			1 << (PAGE_SHIFT + MAX_ORDER-1).
>   
>   	com20020=	[HW,NET] ARCnet - COM20020 chipset
>   			Format:


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
