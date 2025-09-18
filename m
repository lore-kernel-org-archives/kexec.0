Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C377CAC5AF
	for <kexec@archiver.kernel.org>; Fri, 19 Sep 2025 07:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BNnQo0sMp5meQ8eMdhpYCpDIuJZVf4B2s9e5frOewII=; b=ls0Q62FOZFTHV4/4jc3womTENa
	sO+ga8IPW+deWaVOgFORUmvoqgodD8/+9/C3PkZ5+WFyakzUb3PzCYA08jYljGwBP3PWgq5213D07
	3s7VSfg4Gb0tP7BwQVvklPzfW48j+noKiZtk7UsGEVwEV1a4wkpP2ojVD/K1Dnm3xnn/fKJEP1MGH
	v9Czdijk3x2j6H78rtgyS6IsPi9cG4H4P3uIe26/i64mGsqX4FPVP6zBrc0HxQxNxWvPvABv2Jeby
	GqLeT2odkTW9NjTdCGrJ7pk7Vi6fX59K839shYSy/o7Bs1N6cLUvBH9ZxnL/FGRPvUMLCoHXpE9Du
	vQBf/QYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzVws-00000002ACA-0yAR;
	Fri, 19 Sep 2025 07:54:30 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzKag-000000011nU-0V0B
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 19:46:51 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58IEpiMR2943542;
	Thu, 18 Sep 2025 12:46:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=BNnQo0sMp5meQ8eMdhpYCpDIuJZVf4B2s9e5frOewII=; b=oUvgxHX4Zvag
	QvZfvT5qsSg7XUUNcEKSGHGxSpk1x6xVdjCczVBB0sDEs21e34wV0jIolvVbNYkN
	jTgvyrHUUYwV+lo6u++rCkGbO2ffVmXnU9nQyCKh24yMCSSEvr42Bh75J9IwX/o6
	ZAMcfYDTc7pK2dypZ8HhlzYDN64uYjUg4u+fxTFlpDoC/odFQWOZTvcKC4A4hp68
	PF1Pcn5X6fKmq6NSA1PbQHzCAk0OWb7eyHWUkOL09qiC+8w9o8+rBip4NJAIBH08
	tXqKtlvjXykOV5OBQ6V2VEvoNjk8ciX51kX75Dg+301sFyrxCmy9z2VXMMG5QHsq
	FEXUxCTt9w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 498m7fjkq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Sep 2025 12:46:16 -0700 (PDT)
Received: from devbig091.ldc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 18 Sep 2025 19:46:14 +0000
From: Chris Mason <clm@meta.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
        "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>,
        Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
	<agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann
	<arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dan
 Williams" <dan.j.williams@intel.com>,
        Vishal Verma
	<vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre
	<nico@fluxnic.net>,
        "Muchun Song" <muchun.song@linux.dev>,
        Oscar Salvador
	<osalvador@suse.de>,
        "David Hildenbrand" <david@redhat.com>,
        Konstantin
 Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He
	<bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young
	<dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre
	<reinette.chatre@intel.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        James Morse
	<james.morse@arm.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        Christian
 Brauner <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
        "Liam R . Howlett"
	<Liam.Howlett@oracle.com>,
        "Vlastimil Babka" <vbabka@suse.cz>, Mike Rapoport
	<rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko
	<mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Andrey Konovalov"
	<andreyknvl@gmail.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato
	<pfalcato@suse.de>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
        <ntfs3@lists.linux.dev>, <kexec@lists.infradead.org>,
        <kasan-dev@googlegroups.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 16/16] kcov: update kcov to use mmap_prepare
Date: Thu, 18 Sep 2025 12:45:38 -0700
Message-ID: <20250918194556.3814405-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5b1ab8ef7065093884fc9af15364b48c0a02599a.1757534913.git.lorenzo.stoakes@oracle.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c0a8:1b::30]
X-Proofpoint-ORIG-GUID: -nb3wVnAtqomihwZ5BzjAk2px7ex6dUi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDE3NiBTYWx0ZWRfX4Y8q+OJtcR0W
 +oYOau8ot7ilGTzu5PMGr/c3x1bedT9B3gqOZHC7hM/Xi6+uaY0+lHxn/Ka9lE213kL68CII/7K
 z3B5d+3wpbiSc/ygeHsIhiWDxHAwN+fGFwFsRE7UhGTUUvWkFkY05ELfd3kxwScqvazqt9rbonW
 bOXl1lczG5Z9G+teTpxDti5TNxhuajRiwYF0JOVA2rBw9NRviqGPh4HP+n9iXtIIMtm1GoToIaT
 Hu39ICr9dMFPAjamuD3EgvUaHLFY/4+APB4u9SBfeGw7HWZlMuLwY/AgydoBSK6opKQCrvQOWH5
 3JASKIaygraugixdHv8cWWJX9wRaKGzhstUShrgPXa9rw8BJZv52JiSljT0Adk=
X-Authority-Analysis: v=2.4 cv=G6AcE8k5 c=1 sm=1 tr=0 ts=68cc6188 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=auZRGODfdbgPxNsHCnAA:9
X-Proofpoint-GUID: -nb3wVnAtqomihwZ5BzjAk2px7ex6dUi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_124650_155789_BE28F4CB 
X-CRM114-Status: GOOD (  23.13  )
X-Mailman-Approved-At: Fri, 19 Sep 2025 00:54:15 -0700
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 10 Sep 2025 21:22:11 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> We can use the mmap insert pages functionality provided for use in
> mmap_prepare to insert the kcov pages as required.
> 
> This does necessitate an allocation, but since it's in the mmap path this
> doesn't seem egregious. The allocation/freeing of the pages array is
> handled automatically by vma_desc_set_mixedmap_pages() and the mapping
> logic.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  kernel/kcov.c | 42 ++++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 1d85597057e1..2bcf403e5f6f 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -484,31 +484,41 @@ void kcov_task_exit(struct task_struct *t)
>  	kcov_put(kcov);
>  }
>  
> -static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
> +static int kcov_mmap_error(int err)
> +{
> +	pr_warn_once("kcov: vm_insert_page() failed\n");
> +	return err;
> +}
> +
> +static int kcov_mmap_prepare(struct vm_area_desc *desc)
>  {
>  	int res = 0;
> -	struct kcov *kcov = vma->vm_file->private_data;
> -	unsigned long size, off;
> -	struct page *page;
> +	struct kcov *kcov = desc->file->private_data;
> +	unsigned long size, nr_pages, i;
> +	struct page **pages;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&kcov->lock, flags);
>  	size = kcov->size * sizeof(unsigned long);
> -	if (kcov->area == NULL || vma->vm_pgoff != 0 ||
> -	    vma->vm_end - vma->vm_start != size) {
> +	if (kcov->area == NULL || desc->pgoff != 0 ||
> +	    vma_desc_size(desc) != size) {
>  		res = -EINVAL;
>  		goto exit;
>  	}
>  	spin_unlock_irqrestore(&kcov->lock, flags);
> -	vm_flags_set(vma, VM_DONTEXPAND);
> -	for (off = 0; off < size; off += PAGE_SIZE) {
> -		page = vmalloc_to_page(kcov->area + off);
> -		res = vm_insert_page(vma, vma->vm_start + off, page);
> -		if (res) {
> -			pr_warn_once("kcov: vm_insert_page() failed\n");
> -			return res;
> -		}
> -	}
> +
> +	desc->vm_flags |= VM_DONTEXPAND;
> +	nr_pages = size >> PAGE_SHIFT;
> +
> +	pages = mmap_action_mixedmap_pages(&desc->action, desc->start,
> +					   nr_pages);

Hi Lorenzo,

Not sure if it belongs here before the EINVAL tests, but it looks like
kcov->size doesn't have any page alignment.  I think size could be
4000 bytes other unaligned values, so nr_pages should round up.

-chris

