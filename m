Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811CBC43334
	for <kexec@archiver.kernel.org>; Wed, 22 Jun 2022 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b4eM+UYmZdO1Ba6FXRz8ItLyireqL59AX4YfRaVHnVE=; b=Lju4kEtfrXXt3B
	qR4lJAxxB7s9rf/6CzT/wHmMZd4g/optj5piDC9tyYHQ5BvYGu+s6K0jZxqSroY2h7KHCP4HmETZt
	5kn9r/xbfM/xXluK5ZLS1TKwvrLbe3Z1qv55AZr0Q5eAjDSIKxsdf0juRqmvlHjeoDa4ZM090Rh88
	mRtU8Z9zNCHa3XqSUX4cpo5m/2KaHuEYAOzze1ZvzFVLxo0Tv+Ggb30H7MM2nxK4OlxdqLIW9GU+F
	rMNvkBCyspWHFj0OPY7r4rG7uZx1nRWK5ortai+3GvkO3cGM8dxrjJbFh0Y5Okx+Vil5vl3BqO5Nw
	VfZ+pwW/Ij0JZnJ009qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o42Ei-00BB50-1Y; Wed, 22 Jun 2022 15:25:44 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o42Ef-00BB3v-8l
	for kexec@lists.infradead.org; Wed, 22 Jun 2022 15:25:42 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MEpBEa018355;
	Wed, 22 Jun 2022 15:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dtjJzRSRZbBew4AvdjsnZ+HFwA6KmK9RJLyNrXIy+6U=;
 b=Ehu706n+v667Plmmeqj+4sAS0I4VmlTdDwB7yXGgsUuQQicJZF+ILu/rGjHR9qEIYNSu
 lnKhcPR77+nK95YuKUv0CeqD/FH+6797RVue8hUGMHYVJA95WjcSxal91bvkOHK3GQI6
 M6hCD/hO0JBHj4I9FUAO7yja3Y+hKwFTZ43rgTOS34r1SlMHKUH5gaRaEjRVtnplCLE/
 oUKminO4lliMnIooPF8h1dic/M4uH96a4kX72uJRN8nPolec9R8SdTklGMh3r2PRd9/g
 LzgokyjQMo3tna4aAZMLx4otR0d0UWm5q/c2gEipkwqWPBl7XulB4+aFADzHdtd28qsf Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv56x9072-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jun 2022 15:25:37 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25MErgbj028622;
	Wed, 22 Jun 2022 15:25:37 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv56x906d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jun 2022 15:25:37 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MFM6KW009056;
	Wed, 22 Jun 2022 15:25:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma04fra.de.ibm.com with ESMTP id 3gs6b8vk1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jun 2022 15:25:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MFPV7w15991116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jun 2022 15:25:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F4A15204F;
	Wed, 22 Jun 2022 15:25:31 +0000 (GMT)
Received: from [9.145.21.142] (unknown [9.145.21.142])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DED1252050;
	Wed, 22 Jun 2022 15:25:30 +0000 (GMT)
Message-ID: <4a217cf4-a634-04a7-4ff6-85d27736090a@linux.ibm.com>
Date: Wed, 22 Jun 2022 17:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v5 4/5] powerpc/crash hp: add crash hotplug support for
 kexec_load
Content-Language: fr
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20220620070106.93141-1-sourabhjain@linux.ibm.com>
 <20220620070106.93141-5-sourabhjain@linux.ibm.com>
From: Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20220620070106.93141-5-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CI1Ju9QZ2rRLCrQ83EjhJAm2XYFuTMz6
X-Proofpoint-GUID: aRPrreBBnSQrO2grFxtO-JgYkR6wUWAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_04,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_082541_381077_0561763F 
X-CRM114-Status: GOOD (  27.05  )
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

On 20/06/2022, 09:01:05, Sourabh Jain wrote:
> A common crash hotplug handler is used for both kexec_load and
> kexec_file_load, which is already implemented in earlier patches while
> adding support for kexec_file_load.
> 
> To enable the crash hotplug handler to work for kexec_load case the
> fdt_index attribute of kimage_arch needs to be populated with index of
> FDT segment in kexec segment array.
> 
> After loading kexec segments the FDT segment is identified by looping
> through all the kexec segments and fdt_index is updated accordingly.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/kexec/core_64.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 6d448b55dfad..373cb46bcc0e 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -74,6 +74,31 @@ int machine_kexec_prepare(struct kimage *image)
>  	return 0;
>  }
>  
> +#if defined(CONFIG_HOTPLUG_CPU)
> +int machine_kexec_post_load(struct kimage *kimage)
> +{
> +	int i;
> +	void *ptr;
> +	unsigned long mem;
> +
> +	if (kimage->type != KEXEC_TYPE_CRASH)
> +		return 0;
> +
> +	/* Mark fdt_index invalid */
> +	kimage->arch.fdt_index = -1;

If fdt_index should be set to -1, this should be done in
machine_kexec_prepare().  Anyway, there is no need to set it to -1 because
this image will not be registered in do_kexec_load() before the following
loop is complete.

> +
> +	for (i = 0; i < kimage->nr_segments; i++) {
> +		mem = kimage->segment[i].mem;
> +		ptr = __va(mem);
> +
> +		if (ptr && fdt_magic(ptr) == FDT_MAGIC)
> +			kimage->arch.fdt_index = i;
			break;

there is no need to check the other segments, isn't it?

Cheers,
Laurent.

> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>  /* Called during kexec sequence with MMU off */
>  static notrace void copy_segments(unsigned long ind)
>  {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
