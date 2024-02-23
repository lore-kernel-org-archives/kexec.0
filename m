Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF955C48BC4
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 08:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GZX4+0nOM40HR3Hdjh2Ig0XK/RGNJuQ786E+s9BARbc=; b=XlR/Esz5FtFHxZ
	FcsKf/yCDvQ1m92GNJc0N5Shk404bc0iYk30/KXia5ZqY3PHvhThemOd3Vd+Nm4pXeDNIMWMpRLnC
	yAELuRE0qgTT90mY2QtO6VniMD9HkneUrjRxwTv/B0w2FpIanNaXt5+C1Ru3LflnfRPkRPSNN83MF
	LtyJAqPS10QKxcT0DlyxCwz9Kx93opJi0mheZqWrB5NmnAn/eSvfPp/HLmt1WxdUmwjKpDyHUnjwX
	l0Noorsqihw/pEtRM+kvBEmakZu2+wileWVI737+Cotor4o8r1jKYDLItq0CyaQucAOgGG6XokK3k
	fAdDZ8+376hOZQ7cc30A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdR3q-00000008WyK-2ERv;
	Fri, 23 Feb 2024 08:37:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdR3n-00000008Wrv-07Jr
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 08:37:36 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41N8RaT5006783;
	Fri, 23 Feb 2024 08:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=pEAENjjJi1QSKNFlCDPZkpJXcYz3YwJUyPvohl0DKqo=;
 b=hmg4SmkEDrRolzteKsOUC+jO6z1YPnt5JdKSpLpgGj8QwbrrDyYlcRMELaDzBqYC6caz
 AXJbScXfHirq05QnEhfoEc0PY3l4jxKuewidLgPpgPUcb8pMCCwwzaZF5QGISs1Mf+OM
 NF3NzjiZsYxxg0EUnFGQQQhPo8zDy9iaoRF+1U8iT11vChbM4knZgTsn/jWcKBi1Cpsw
 oQmAKW07MGt1QK02LPxhCT86ajWN5gnX0MReP2/FeL1V4SW9s5OMxltUAgH56Lg7mJxR
 IIWTDCiWE1jkwCLgg7JX/CHMFNbCZtx/QOUC4Hao4wgUPMj6EP3Ka/MkYfek3n0lvvVJ eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weqv309cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 08:37:32 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41N8SSrl010036;
	Fri, 23 Feb 2024 08:37:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weqv309c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 08:37:32 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41N7WJ05013472;
	Fri, 23 Feb 2024 08:37:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0vbw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 08:37:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41N8bPZ313632130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 08:37:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A84F2004E;
	Fri, 23 Feb 2024 08:37:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B09C020040;
	Fri, 23 Feb 2024 08:37:23 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 Feb 2024 08:37:23 +0000 (GMT)
Date: Fri, 23 Feb 2024 14:07:21 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: k-hagio-ab@nec.com, kexec@lists.infradead.org,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH] makedumpfile: ppc64: read cur_mmu_type from vmcoreinfo
Message-ID: <dzjnckicvqtflbtwh3omaccwcq5zw3i7ebyumtmnyd3quffwij@ircw5am7wrjr>
References: <20240223055306.34466-1-adityag@linux.ibm.com>
 <ZdhPJKGd7wqbesVp@MiWiFi-R3L-srv>
Content-Disposition: inline
In-Reply-To: <ZdhPJKGd7wqbesVp@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 93ABomVrmk83up4MBorq6CxtHvMZEfja
X-Proofpoint-ORIG-GUID: kdxKt38HK0COI6e4uOwt6d61yb2tXvIe
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=961 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_003735_300071_125C7BBF 
X-CRM114-Status: GOOD (  39.42  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Feb 23, 2024 at 03:54:12PM +0800, Baoquan He wrote:
> Add maintainer Kazu to CC.

Thanks, I missed him, will resend this patch with him in CC.

Thanks,
Aditya Gupta

> 
> On 02/23/24 at 11:23am, Aditya Gupta wrote:
> > Currently makedumpfile depends on reading the 'cur_cpu_spec' kernel
> > symbol to get the current MMU type on PowerPC64.
> > 
> > The disadvantage with this approach was that it depends on bit '0x40'
> > ('MMU_FTR_TYPE_RADIX') being set in 'cur_cpu_spec->mmu_features',
> > which implies kernel developers have to be careful of modifying
> > MMU_FTR_* defines
> > 
> > Instead a more stable approach was suggested by contributors in
> > https://lore.kernel.org/linuxppc-dev/87v8c3m70t.fsf@mail.lhotse/, to
> > pass information about the MMU type in vmcoreinfo itself, instead of
> > depending on the MMU_FTR_* defines
> > 
> > This was implemented in linux kernel in:
> >     commit 36e826b568e4 ("powerpc/vmcore: Add MMU information to vmcoreinfo")
> > 
> > With this commit, if RADIX_MMU is there in the vmcoreinfo, we prefer it
> > to get current mmu type, instead of 'cur_cpu_spec'.
> > On older kernels, where RADIX_MMU number is not there, makedumpfile will
> > simply fall back to using 'cur_cpu_spec'.
> > 
> > The earlier defines for 'RADIX_MMU' have been renamed to 'MMU_TYPE_RADIX'
> > which avoids conflict with the vmcoreinfo string 'RADIX_MMU', as well as
> > being more clear about the value 0x40 with a comment about MMU_FTR_TYPE_RADIX
> > 
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >  arch/ppc64.c   | 15 ++++++++++-----
> >  makedumpfile.c |  1 +
> >  makedumpfile.h |  9 ++++++---
> >  3 files changed, 17 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/ppc64.c b/arch/ppc64.c
> > index 96c357cb0335..3b4f91981f71 100644
> > --- a/arch/ppc64.c
> > +++ b/arch/ppc64.c
> > @@ -250,7 +250,7 @@ ppc64_vmalloc_init(void)
> >  		/*
> >  		 * 64K pagesize
> >  		 */
> > -		if (info->cur_mmu_type & RADIX_MMU) {
> > +		if (info->cur_mmu_type & MMU_TYPE_RADIX) {
> >  			info->l1_index_size = PTE_INDEX_SIZE_RADIX_64K;
> >  			info->l2_index_size = PMD_INDEX_SIZE_RADIX_64K;
> >  			info->l3_index_size = PUD_INDEX_SIZE_RADIX_64K;
> > @@ -300,7 +300,7 @@ ppc64_vmalloc_init(void)
> >  		/*
> >  		 * 4K pagesize
> >  		 */
> > -		if (info->cur_mmu_type & RADIX_MMU) {
> > +		if (info->cur_mmu_type & MMU_TYPE_RADIX) {
> >  			info->l1_index_size = PTE_INDEX_SIZE_RADIX_4K;
> >  			info->l2_index_size = PMD_INDEX_SIZE_RADIX_4K;
> >  			info->l3_index_size = PUD_INDEX_SIZE_RADIX_4K;
> > @@ -635,14 +635,19 @@ get_versiondep_info_ppc64()
> >  	 * On PowerISA 3.0 based server processors, a kernel can run with
> >  	 * radix MMU or standard MMU. Get the current MMU type.
> >  	 */
> > -	info->cur_mmu_type = STD_MMU;
> > -	if ((SYMBOL(cur_cpu_spec) != NOT_FOUND_SYMBOL)
> > +	info->cur_mmu_type = MMU_TYPE_STD;
> > +
> > +	if (NUMBER(RADIX_MMU) != NOT_FOUND_SYMBOL) {
> > +		if (NUMBER(RADIX_MMU) == 1) {
> > +			info->cur_mmu_type = MMU_TYPE_RADIX;
> > +		}
> > +	} else if ((SYMBOL(cur_cpu_spec) != NOT_FOUND_SYMBOL)
> >  	    && (OFFSET(cpu_spec.mmu_features) != NOT_FOUND_STRUCTURE)) {
> >  		if (readmem(VADDR, SYMBOL(cur_cpu_spec), &cur_cpu_spec,
> >  		    sizeof(cur_cpu_spec))) {
> >  			if (readmem(VADDR, cur_cpu_spec + OFFSET(cpu_spec.mmu_features),
> >  			    &mmu_features, sizeof(mmu_features)))
> > -				info->cur_mmu_type = mmu_features & RADIX_MMU;
> > +				info->cur_mmu_type = mmu_features & MMU_TYPE_RADIX;
> >  		}
> >  	}
> >  
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index 3705bdd93deb..1bd7305f49ca 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -2987,6 +2987,7 @@ read_vmcoreinfo(void)
> >  #endif
> >  
> >  	READ_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
> > +	READ_NUMBER("RADIX_MMU", RADIX_MMU);
> >  
> >  	return TRUE;
> >  }
> > diff --git a/makedumpfile.h b/makedumpfile.h
> > index 3ed3ba551d96..a7b344974636 100644
> > --- a/makedumpfile.h
> > +++ b/makedumpfile.h
> > @@ -747,12 +747,13 @@ unsigned long get_kvbase_arm64(void);
> >  /*
> >   * Supported MMU types
> >   */
> > -#define STD_MMU         0x0
> > +#define MMU_TYPE_STD         0x0
> >  /*
> >   * The flag bit for radix MMU in cpu_spec.mmu_features
> > - * in the kernel. Use the same flag here.
> > + * in the kernel (MMU_FTR_TYPE_RADIX).
> > + * Use the same flag here.
> >   */
> > -#define RADIX_MMU       0x40
> > +#define MMU_TYPE_RADIX       0x40
> >  
> >  
> >  #define PGD_MASK_L4		\
> > @@ -2258,6 +2259,8 @@ struct number_table {
> >  	unsigned long kernel_link_addr;
> >  	unsigned long va_kernel_pa_offset;
> >  #endif
> > +
> > +	unsigned long RADIX_MMU;
> >  };
> >  
> >  struct srcfile_table {
> > -- 
> > 2.43.0
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
