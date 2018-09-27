Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5Li8-0004iF-IQ
 for kexec@lists.infradead.org; Thu, 27 Sep 2018 02:07:25 +0000
Date: Thu, 27 Sep 2018 10:06:47 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/4 v8] x86/ioremap: add a function ioremap_encrypted()
 to remap kdump old memory
Message-ID: <20180927020647.GH2555@MiWiFi-R3L-srv>
References: <20180907081805.368-1-lijiang@redhat.com>
 <20180907081805.368-2-lijiang@redhat.com>
 <20180926022123.GA2555@MiWiFi-R3L-srv>
 <e6cd5448-b314-e142-1169-9e3e907faf16@redhat.com>
 <e7634c77-1657-4665-3bc4-bd00196f28e4@redhat.com>
 <c076568c-aaf8-9b83-40bd-55c406bd88d0@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c076568c-aaf8-9b83-40bd-55c406bd88d0@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: lijiang <lijiang@redhat.com>
Cc: "Lendacky, Thomas" <thomas.lendacky@amd.com>, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>

Hi Lianbo,

On 09/26/18 at 05:34pm, lijiang wrote:
> When SME is enabled on AMD machine, the memory is encrypted in the first
> kernel. In this case, SME also needs to be enabled in kdump kernel, and
> we have to remap the old memory with the memory encryption mask.
> 
> Here we only talk about the case that SME is active in the first kernel,
> and only care it's active too in kdump kernel. there are four cases we
> need considered.
> 
> a. dump vmcore
>    It is encrypted in the first kernel, and needs be read out in kdump
>    kernel.
> 
> b. crash notes
>    When dumping vmcore, the people usually need to read the useful
>    information from notes, and the notes is also encrypted.
> 
> c. iommu device table
>    It is allocated by kernel, need fill its pointer into mmio of amd iommu.
>    It's encrypted in the first kernel, need read the old content to analyze
>    and get useful information.
> 
> d. mmio of amd iommu
>    Register reported by amd firmware, it's not RAM, we don't encrypt in
>    both the first kernel and kdump kernel.
> 
> To achieve the goal, the solution is:
> 1. add a new bool parameter "encrypted" to __ioremap_caller()
>    It is a low level function, and check the newly added parameter, if it's
>    true and in kdump kernel, will remap the memory with sme mask.
> 
> 2. add a new function ioremap_encrypted() to explicitly passed in a "true"
>    value for "encrypted".
>    For above a, b, c, we will call ioremap_encrypted();
> 
> 3. adjust all existed ioremap wrapper functions, passed in "false" for
>    encrypted to make them an before.
> 
>    ioremap_encrypted()\
>    ioremap_cache()     |
>    ioremap_prot()      |
>    ioremap_wt()        |->__ioremap_caller()
>    ioremap_wc()        |
>    ioremap_uc()        |
>    ioremap_nocache()  /

Thanks, I think it's better. Since no code change, just patch log
improvement, maybe you can repost a series and carry both Tom and
Joerg's ACK.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
