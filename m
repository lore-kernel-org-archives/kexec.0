Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QQuoC-0005CS-N5
	for kexec@lists.infradead.org; Mon, 30 May 2011 05:14:33 +0000
Subject: Re: [PATCH] makedumpfile: s390x: Fix dump refiltering for s390x.
In-reply-to: <20110525074907.17025.26375.stgit@mars.in.ibm.com>
References: <20110525074907.17025.26375.stgit@mars.in.ibm.com>
Message-Id: <20110530141222tachibana@mail.jp.nec.com>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Mon, 30 May 2011 14:12:22 +0900
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, kexec@lists.infradead.org, Tachibana-san <tachibana@mxn.nes.nec.co.jp>, Reinhard <BUENDGEN@de.ibm.com>

Hi Mahesh,

Thank you for the patch.
I will take it into a next makedumpfile.


Thanks
tachibana

On 2011/05/25 13:19:08 +0530, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> On s390x, dump refiltering fails in get_machdep_info_s390x() function while
> reading vmlist kernel symbol data. It fails in vaddr_to_paddr_s390x()
> function while resolving vmlist kernel symbol address. Since the vmlist
> kernel symbol address is not a vmalloc address, the function returns failure.
> 
> Fix the vaddr_to_paddr_s390x() function to translate non-vmalloc'ed
> address into physical adddress.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  s390x.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/s390x.c b/s390x.c
> index 128e5f0..49658d0 100644
> --- a/s390x.c
> +++ b/s390x.c
> @@ -269,9 +269,7 @@ vaddr_to_paddr_s390x(unsigned long vaddr)
>  		paddr = vtop_s390x(vaddr);
>  	}
>  	else {
> -		ERRMSG("Can't convert a virtual address(%lx) to " \
> -		    "physical address.\n", vaddr);
> -		return NOT_PADDR;
> +		paddr = vaddr - KVBASE;
>  	}
>  
>  	return paddr;
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
