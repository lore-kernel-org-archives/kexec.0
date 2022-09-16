Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90B7C54EE9
	for <kexec@archiver.kernel.org>; Fri, 16 Sep 2022 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6dMoqxtuuYiSKUC9CT9PAIBBHqJovjMxNv5MvBUToLo=; b=sI9KOtJQcNPiKC
	VbXRewDwo1P0u/XSmdyaDq1+wEILkCleXZnyOaBq/QAAfa8hLgXz8XIvs9SA3Q1dk0DeP8GJvoVWN
	rGO0BV4U70LRx1M78AEF0yk0YjAs/prIDXj4kHfum+wkM7bCJewkFVz/hUJyyrcwo7Y8kvETBfhX3
	Sgou3p0SZy5Tqq+IpMg90OUj2UuTQflvD63CGxbLA9qh/3x0duOcdt/LvQD26PKZIyKkAUetE8wpP
	QGcjnsyaHGD1T9UI/RsBRid81u8VaLruElBevflVSqemtw9LJxjvuvJEslPKNrUPsdZa4L+9S5xPk
	qpge3+01v8Ky850ZeVUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZ933-00CR5d-Qn; Fri, 16 Sep 2022 10:58:17 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZ931-00CR2g-Un
	for kexec@lists.infradead.org; Fri, 16 Sep 2022 10:58:17 +0000
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GA49eY006971;
	Fri, 16 Sep 2022 10:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Wp3E9K+bLCWJ+Zm1TeuH+DWI79FWMqE80zIk2Dq6jJo=;
 b=Ri1/1VMwRJgQZBaXqkW8brj/AW2c5HSyiMZc249pJXcxoI/OWl2QXfR4UjakGpQcYszo
 AhY65L/Paje374Ax0ApfasdUrJmtdQScNaz+D7yZJcoe/E7f2HIQFMMWKEXw5vRM+rx2
 tQmNL0D1G5VKPXHB4IMUEYipIxFJx9gcLe+8Gjyyz6ehuksAJ1eqZqzi+qMnJib5Ykpr
 TMB2WxqzOW/w0+1C3at4RD8SS4IVFk4UXrQ3tRNvTc1qSHYBxiyASAvWA1Eak64g9p5j
 VYdU38GTxIaEg17hxDQycFZsSENl1qPr6aaaH/wcWaJOxCpz2j/PqmGsoLzE6jyxLyBp vQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jmq2g9dsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Sep 2022 10:58:10 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28GAsCMr014561;
	Fri, 16 Sep 2022 10:58:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma05fra.de.ibm.com with ESMTP id 3jm91crn95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Sep 2022 10:58:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28GAw6iU37814716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Sep 2022 10:58:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC25711C054;
	Fri, 16 Sep 2022 10:58:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FFE011C04A;
	Fri, 16 Sep 2022 10:58:05 +0000 (GMT)
Received: from [9.203.106.190] (unknown [9.203.106.190])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 16 Sep 2022 10:58:05 +0000 (GMT)
Message-ID: <3ec0476b-275e-8a12-72f0-780b5e08cb1c@linux.ibm.com>
Date: Fri, 16 Sep 2022 16:28:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] ppc64: remove rma_top limit
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org
Cc: horms@verge.net.au
References: <20220915084240.133742-1-sourabhjain@linux.ibm.com>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20220915084240.133742-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OgvKq9hqLAd4gtlkN-vpd2Ddwarr937J
X-Proofpoint-ORIG-GUID: OgvKq9hqLAd4gtlkN-vpd2Ddwarr937J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 mlxscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220916_035816_159799_2CA531B2 
X-CRM114-Status: GOOD (  20.81  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 15/09/22 2:12 pm, Sourabh Jain wrote:
> Restricting kexec tool to allocate hole for kexec segments below 768MB
> may not be relavent now since first memory block size can be 1024MB and
> more.
> 
> Removing rma_top restriction will give more space to find holes for
> kexec segments and existing in-place checks make sure that kexec segment
> allocation doesn't cross the first memory block because every kexec segment
> has to be within first memory block for kdump kernel to boot properly.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Yeah. The restriction seems arbitrary. Even more so since commit
47478ea66d43 ("kexec-tools: ppc64: fix how RMA top is deduced")
with which kexec_load was sure to place all segments within the
first memory block. So, the change looks good to me.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> ---
>   kexec/arch/ppc64/kexec-ppc64.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
> index 5b17740..611809f 100644
> --- a/kexec/arch/ppc64/kexec-ppc64.c
> +++ b/kexec/arch/ppc64/kexec-ppc64.c
> @@ -717,8 +717,6 @@ static int get_devtree_details(unsigned long kexec_flags)
>   			if (base < rma_base) {
>   				rma_base = base;
>   				rma_top = base + be64_to_cpu(((uint64_t *)buf)[1]);
> -				if (rma_top > 0x30000000UL)
> -					rma_top = 0x30000000UL;
>   			}
> 
>   			fclose(file);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
