Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670C3C6FD19
	for <kexec@archiver.kernel.org>; Mon, 13 Mar 2023 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sEdNWn7JNeAYxX4FYn/NS0OWoWEF7yOBEOVyR2SZHCw=; b=zxJmzDfp9WgiOt
	WJcdkMqX6bGudBFJPYxehWGxJQC69xxh66tS4KURuv+zeudo1hrZW424ZQaGg+AatsjsG3DUtwQH2
	DUNWYNWl5T9burpaJX7rBeHk8hsxi/TBDGkicmmVEKtTtru7XDBeShEcZH687L5TvBap3p2ZDkfhl
	qajedREzSJlydyr/Att2nildNoLGLw/M/2tIX/6viFzwI35OKugwUob7q9WJbvHraDfvEE1ceB8ZA
	38cG0dQzC5luXmLj/38NW8JjGPjspxx/Oo8+bvKuGcglgy5LtxEVucaY4cxmz4k047eG3qsvNtwFQ
	Sd3lpewhBFHqSCDZTm8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pblCj-006oUt-Hh; Mon, 13 Mar 2023 16:39:21 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbkzc-006k8b-4Y
	for kexec@lists.infradead.org; Mon, 13 Mar 2023 16:25:49 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DFAgoS003552;
	Mon, 13 Mar 2023 16:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WisQbImFAuZ6JQDJ6XFsiqOEX0hrs010qoAhkkLAT58=;
 b=FiBD+zhLZf+2AMvJ3W6/eqt9GhflhsmVob0mVKZxx0XjqdLAHSr7RGHiPZW7ddKqxzDl
 P4qn//02GHBqp3Ln86lIFZ3Wlq7HIwETtMBj+yFI+huNFF+3WO9z7DKSLpIDD+jRtVlm
 pijFG+3rROMxOAJH1x9DtHveTEC24RJ/1IriFTowTDbKKsIzmEBdmnQX3Yu1JIOt7o6Z
 /HA1mFWJJkiGeqD427qMd6psGWrayMigH5XdK04kS0L0RmuGO2bgiO3dnU6ECCzsEDf7
 yBx4xA5i72EOVngTxKv4xPPqjQHSac2k/VU7DHtFKTSAc2BSHm4yB+AzyHhon4SAQCJR tw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pa3dm03cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Mar 2023 16:25:45 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32DDkW85013034;
	Mon, 13 Mar 2023 16:25:44 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pa3dm03bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Mar 2023 16:25:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32DEj77l001030;
	Mon, 13 Mar 2023 16:25:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96km2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Mar 2023 16:25:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32DGPcMw32899764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Mar 2023 16:25:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5BB820043;
	Mon, 13 Mar 2023 16:25:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 728DA20040;
	Mon, 13 Mar 2023 16:25:38 +0000 (GMT)
Received: from [9.101.4.33] (unknown [9.101.4.33])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Mar 2023 16:25:38 +0000 (GMT)
Message-ID: <5093127d-0199-2ef5-8a10-f293d54f3d90@linux.ibm.com>
Date: Mon, 13 Mar 2023 17:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v9 3/6] powerpc/crash: add a new member to the kimage_arch
 struct
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20230312181154.278900-1-sourabhjain@linux.ibm.com>
 <20230312181154.278900-4-sourabhjain@linux.ibm.com>
From: Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20230312181154.278900-4-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M25RaPiz6UY-iP41V1Ewf7jJ3Fbh9X2A
X-Proofpoint-GUID: 54zZ5X1ZLyCSoD0oHzzerb46Z4gNQxjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_07,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_092548_309840_7FEC3460 
X-CRM114-Status: GOOD (  32.16  )
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
Cc: eric.devolder@oracle.com, kexec@lists.infradead.org, bhe@redhat.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 12/03/2023 19:11:51, Sourabh Jain wrote:
> A new member "fdt_index" is added to the kimage_arch struct to hold
> the index of the FDT (Flattened Device Tree) segment from the kexec
> the segment array.
> 
> fdt_index will provide direct access to the FDT segment in the kexec
> segment array after the kdump kernel is loaded.
> 
> The new attribute will be used in the arch crash hotplug handler
> (added in upcoming patches) on every CPU and memory hotplug event.
> 
> The fdt_index is populated for both kexec_load and kexec_file_load
> case.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/kexec.h |  5 +++++
>  arch/powerpc/kexec/core_64.c     | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 8090ad7d97d9d..348eb96e8ca67 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -103,6 +103,8 @@ void kexec_copy_flush(struct kimage *image);
>  struct crash_mem;
>  int update_cpus_node(void *fdt);
>  int get_crash_memory_ranges(struct crash_mem **mem_ranges);
> +int machine_kexec_post_load(struct kimage *image);
> +#define machine_kexec_post_load machine_kexec_post_load

Minor comment, when CONFIG_CRASH_HOTPLUG is not set the function is simply
returning 0, why not defining it has an inline in that case?

>  #endif
>  
>  #if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_PPC_RTAS)
> @@ -118,6 +120,9 @@ extern const struct kexec_file_ops kexec_elf64_ops;
>  struct kimage_arch {
>  	struct crash_mem *exclude_ranges;
>  
> +#if defined(CONFIG_CRASH_HOTPLUG)
> +	int fdt_index;
> +#endif
>  	unsigned long backup_start;
>  	void *backup_buf;
>  	void *fdt;
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 0b292f93a74cc..531486c973988 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -77,6 +77,37 @@ int machine_kexec_prepare(struct kimage *image)
>  	return 0;
>  }
>  
> +int machine_kexec_post_load(struct kimage *kimage)
> +{
> +#if defined(CONFIG_CRASH_HOTPLUG)
> +	int i;
> +	void *ptr;
> +	unsigned long mem;
> +
> +	/* Mark fdt_index invalid */
> +	kimage->arch.fdt_index = -1;

Why is that not done in the series introducing the generic
crash hotplug update, in do_kimage_alloc_init() ?
This way there is a guarantee that the field will not be used while set by
default to 0.

> +
> +	/* fdt_index remains invalid if it is not a crash kernel load */
> +	if (kimage->type != KEXEC_TYPE_CRASH)
> +		return 0;
> +	/*
> +	 * Find the FDT segment index in kexec segment array and
> +	 * assign it to kimage's member fdt_index to enable direct
> +	 * access to FDT segment later on.
> +	 */
> +	for (i = 0; i < kimage->nr_segments; i++) {
> +		mem = kimage->segment[i].mem;
> +		ptr = __va(mem);
> +
> +		if (ptr && fdt_magic(ptr) == FDT_MAGIC) {
> +			kimage->arch.fdt_index = i;
> +			break;
> +		}
> +	}
> +#endif
> +	return 0;
> +}
> +
>  /* Called during kexec sequence with MMU off */
>  static notrace void copy_segments(unsigned long ind)
>  {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
