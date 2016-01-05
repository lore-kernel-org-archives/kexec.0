Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aGK31-0005G3-NV
 for kexec@lists.infradead.org; Tue, 05 Jan 2016 05:20:44 +0000
Date: Tue, 5 Jan 2016 13:20:03 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 14/16] x86, nvdimm, kexec: Use walk_iomem_res_desc()
 for iomem search
Message-ID: <20160105052003.GB3692@dhcp-128-65.nay.redhat.com>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
 <20151226103804.GB21988@pd.tnic> <567F315B.8080005@hpe.com>
 <20151227021257.GA13560@dhcp-128-25.nay.redhat.com>
 <20151227102406.GB19398@nazgul.tnic>
 <20160104092937.GB7033@dhcp-128-65.nay.redhat.com>
 <20160104122619.GH22941@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160104122619.GH22941@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>, Minfei Huang <mhuang@redhat.com>, linux-nvdimm@ml01.01.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>

On 01/04/16 at 01:26pm, Borislav Petkov wrote:
> On Mon, Jan 04, 2016 at 05:29:37PM +0800, Dave Young wrote:
> > Replied to Toshi old kernel will export the "GART" region for amd cards.
> > So for old kernel and new kexec-tools we will have problem.
> > 
> > I think add the GART desc for compitibility purpose is doable, no?
> 
> Just read your other mails too. If I see it correctly, there's only one
> place which has "GART":
> 
> $ git grep -e \"GART\"
> arch/x86/kernel/crash.c:235:    walk_iomem_res("GART", IORESOURCE_MEM, 0, -1,
> 
> So crash.c only excludes this region but the kernel doesn't create it.
> Right?

Right.

> 
> So we can kill that walk_iomem_res(), as you say. Which would be even
> nicer...

Yes, I think it is ok to kill walk_iomem_res()

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
