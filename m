Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muRXk-006t0V-TY
 for kexec@lists.infradead.org; Tue, 07 Dec 2021 03:53:30 +0000
Message-ID: <31e002fd-e796-06a0-4a21-1dc02411d8b7@oracle.com>
Date: Mon, 6 Dec 2021 21:53:03 -0600
Subject: Re: [PATCH RESEND v2 1/5] docs: kernel-parameters: Update to reflect
 the current default size of atomic pool
Content-Language: en-US
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-2-bhe@redhat.com>
From: John Donnelly <John.p.donnelly@oracle.com>
In-Reply-To: <20211207030750.30824-2-bhe@redhat.com>
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
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com, cl@linux.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com, kexec@lists.infradead.org

On 12/6/21 9:07 PM, Baoquan He wrote:
> Since commit 1d659236fb43("dma-pool: scale the default DMA coherent pool
> size with memory capacity"), the default size of atomic pool has been
> changed to take by scaling with system memory capacity. So update the
> document in kerenl-parameter.txt accordingly.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
  Reviewed-by: John Donnelly <john.p.donnelly@oracle.com>
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
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
