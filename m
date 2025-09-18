Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74CACAC5A7
	for <kexec@archiver.kernel.org>; Fri, 19 Sep 2025 07:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n7WMUyT5L/wA654bmEoUeQzuO+YeNxS6ichaQfAm4K0=; b=m8n1Hi0GtCO/jZcZKLOYPg9naQ
	HghWW4lcl07cDVnz9kIzF0rxti6oaz+RNkjY4VrCrw7sSA7NDLJzvotqiss3P2ZovlG2d7VEIykGz
	qtDj+lMS3BHJyGlq8wowH0PwQ7/gmXmYcO0PVCKY//lpabG/ptgAg4qghdqOy4GPWdaS9t1SqgzUP
	+xOKpBB0R6LMP0uOzNlujFTz3g11ejkgzuBGBQlHoWgxSkETxHN4uM49yK4eyAoB254sPpY1ZAH1o
	Ol1oToBd3xBrJfpn11vCe1irEAkHkdXegi+Tkl94BLNKp/wUTDvisUjqwq+tx1I2vVNru5L+N4U3z
	e6qMi0eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzVwr-00000002ABD-22PV;
	Fri, 19 Sep 2025 07:54:29 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzK3Q-00000000y28-0Gqr
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 19:12:29 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58IHFrYs3277934;
	Thu, 18 Sep 2025 12:11:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=n7WMUyT5L/wA654bmEoUeQzuO+YeNxS6ichaQfAm4K0=; b=e1PjzYEwP6rW
	SfUk5eeciJxn+YRaNAOwJfo0mF1M9af1ue6fOutyvFad79DSht413xYSjq60mDZn
	YfAeHI3teHoLHj2Ahw36GPsEKjr9nWC6XNFV5yDHpZFkBziHEg6+zY9tRtbFHZ7L
	euLc+3yKJdYsaDbCHeYUrokmz4OdnyNONXB/EoFpk84RGhgSRcJayfWUqspezpej
	t5GboU+18x4kwUz9VDEY546JJy77c6NrIDp7S3nspwxS3VyRR3cDcJUXjns/AlUx
	vHU6c1NA5Yk/53XX8iJhs34HuxkDG9lTlReCBuQkPbYQPU3FHSiVsk3ft4wTv6TT
	ArN8tU50uw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 498f7yccgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Sep 2025 12:11:41 -0700 (PDT)
Received: from devbig091.ldc1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 18 Sep 2025 19:11:36 +0000
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
Subject: Re: [PATCH v2 11/16] mm: update mem char driver to use mmap_prepare
Date: Thu, 18 Sep 2025 12:11:05 -0700
Message-ID: <20250918191119.3622358-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aeee6a4896304d6dc7515e79d74f8bc5ec424415.1757534913.git.lorenzo.stoakes@oracle.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c085:108::150d]
X-Authority-Analysis: v=2.4 cv=Wr8rMcfv c=1 sm=1 tr=0 ts=68cc596e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=QLIaiyCFZkuJlwHvl48A:9
X-Proofpoint-ORIG-GUID: yzU4eNHLhAUfSh4h33V6r2BXOldJckJZ
X-Proofpoint-GUID: yzU4eNHLhAUfSh4h33V6r2BXOldJckJZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDE3MCBTYWx0ZWRfX+OH6/CZXfYF1
 ZQZSd3MY5d1+huXM92tmUuaixGbvXh9eslNEM1bRcbWXduWBJkY9hM7pAwYK1UmVGB6+KtMLK3+
 5xu0OvXnTYTE5X3/j7r0YUT9jTEQIyg7vs2wzGv7et2oYHzPIQqFSONTUbrUfKZtQGE+5Ql2G/m
 FB+fFTcxSnJqueTYbtn/kFdO7ZXWcwZvUvPEHQAajQYNZXBbU5RIDDKbQMkKIDQGqkR8eZiO5xs
 q0uwGSCKiMwePOEm2hD3yphFf7LSfGFQnTUqyn0uufzwKaznKzrNA1c2BW91Ht07S88ASQbLxJd
 y3Z61QWwzOnbaToH1kdrhAuNayIEpInurTQIzwra/DJzb/lInqX9Bhz50sofEw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_121228_103498_CB18B7CB 
X-CRM114-Status: GOOD (  23.90  )
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

On Wed, 10 Sep 2025 21:22:06 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Update the mem char driver (backing /dev/mem and /dev/zero) to use
> f_op->mmap_prepare hook rather than the deprecated f_op->mmap.
> 
> The /dev/zero implementation has a very unique and rather concerning
> characteristic in that it converts MAP_PRIVATE mmap() mappings anonymous
> when they are, in fact, not.
> 
> The new f_op->mmap_prepare() can support this, but rather than introducing
> a helper function to perform this hack (and risk introducing other users),
> simply set desc->vm_op to NULL here and add a comment describing what's
> going on.
> 
> We also introduce shmem_zero_setup_desc() to allow for the shared mapping
> case via an f_op->mmap_prepare() hook, and generalise the code between this
> and shmem_zero_setup().
> 
> We also use the desc->action_error_hook to filter the remap error to
> -EAGAIN to keep behaviour consistent.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  drivers/char/mem.c       | 75 ++++++++++++++++++++++------------------
>  include/linux/shmem_fs.h |  3 +-
>  mm/shmem.c               | 40 ++++++++++++++++-----
>  3 files changed, 76 insertions(+), 42 deletions(-)
> 

[ ... ]

> diff --git a/mm/shmem.c b/mm/shmem.c
> index 990e33c6a776..cb6ff00eb4cb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c

[ ... ]

> @@ -5920,6 +5925,25 @@ int shmem_zero_setup(struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +/**
> + * shmem_zero_setup_desc - same as shmem_zero_setup, but determined by VMA
> + * descriptor for convenience.
> + * @desc: Describes VMA
> + * Returns: 0 on success, or error
> + */
> +int shmem_zero_setup_desc(struct vm_area_desc *desc)
> +{
> +	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
> +
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	desc->vm_file = file;
> +	desc->vm_ops = &shmem_anon_vm_ops;
> +
> +	return 0;
> +}
> +

Hi Lorenzo,

shmem_zero_setup() does a if (vma->vm_file) fput(vma->vm_file) dance.

It looks like we need one here too?

-chris

