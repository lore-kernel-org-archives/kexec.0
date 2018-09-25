Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g4jBj-0000k1-6j
 for kexec@lists.infradead.org; Tue, 25 Sep 2018 08:59:24 +0000
Date: Tue, 25 Sep 2018 16:58:46 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 3/3] resource: Fix find_next_iomem_res() iteration issue
Message-ID: <20180925085846.GY2555@MiWiFi-R3L-srv>
References: <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153782730364.130337.17794279728329113665.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <153782730364.130337.17794279728329113665.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dan.j.williams@intel.com, brijesh.singh@amd.com, Lianbo Jiang <lijiang@redhat.com>, thomas.lendacky@amd.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, tglx@linutronix.de, bp@suse.de, dyoung@redhat.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Hi Bjorn,

On 09/24/18 at 05:15pm, Bjorn Helgaas wrote:
> @@ -359,32 +362,31 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
>  	read_unlock(&resource_lock);
>  	if (!p)
>  		return -1;
> +
>  	/* copy data */
> -	if (res->start < p->start)
> -		res->start = p->start;
> -	if (res->end > p->end)
> -		res->end = p->end;
> +	res->start = max(start, p->start);
> +	res->end = min(end, p->end);
>  	res->flags = p->flags;

I think this fix is good. However, is it OK to keep res->flags always,
never touch it in find_next_iomem_res()? We just iterate and update
region, its start and end. So just removing that "res->flags = p->flags;"
line might involve much less code changes.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
