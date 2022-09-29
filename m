Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2325EC04A95
	for <kexec@archiver.kernel.org>; Thu, 29 Sep 2022 06:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3A9gWFPLOSIdR4kot+XHBrcPNveTESZAfn0bd4KLai0=; b=uPfoX9PdhJK4s8
	0cMP2chQlAzDFhzHo2XBQKVOXIAaiE1scSjQaG8G2HMZsK214ugbDE2ZvVATXsVJVtxQ47XQmaY9+
	qFmz4KZIx1yNvELLD70EvYv0zed8OSjNrfdmx0+dQt2KM+9fcOoOl1+Apz4X0cQF+13wEW5+EwGmS
	L/iUMHQvDM0Xby6X+Q3oYslpfFJWZaRqTDj2l1VeykL9201oPKQtJKNRB/ecsjBHMAFEUUPzPYrl1
	fW3X/yV8hFN9W8b7NGaf5uhSxUqNm8KNO9oU04QD6LeHgX0eewvlG3773Nc9F0+u70HkrkxdkHWnE
	CIahBbasQ8OdCSiVPVsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odnMf-001SxT-Db; Thu, 29 Sep 2022 06:49:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odnMc-001Swi-P2
	for kexec@lists.infradead.org; Thu, 29 Sep 2022 06:49:44 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28T5wVJY028411;
	Thu, 29 Sep 2022 06:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Di/yinLFiJiB+xEclTsZ2OrqTxXTFTjygu8RmiLceHc=;
 b=hA6elATtqrgUNFbsNmaU20rwEpLUTrnukPUEpXun8NLcPFfkrbuZrJq3y3JKSfKh0ZJ8
 k6HPyPHc+F9HhMFkDUEoX3ulrW9Cn/ktEzfuYvUHHjxSKu5X3KfWPanTBjlRUHOgf+gq
 THVg4Y+UFTsDHwNZoiFLAMxqOIkJPJNb0A1G1CA17R6nn4sa0CFF4FydylEsMAB/B9Qh
 PB4or+358Rf579V+NaEVV7yJu9fsHX05LXOnuwRxg11cyFyRMHg3ilpLRMBG3sxvVYsm
 BYjK4rcA1VxTzXSQ3jNv9mfLCoYQveNuJ3SZmjI1zrk3WWoKfcyszNj5sjnM/svpT61d hg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw5p79b0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Sep 2022 06:49:38 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28T5xCg1030433;
	Thu, 29 Sep 2022 06:49:37 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw5p79ay9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Sep 2022 06:49:37 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28T6Z5gs000307;
	Thu, 29 Sep 2022 06:49:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03fra.de.ibm.com with ESMTP id 3jssh94ng5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Sep 2022 06:49:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28T6nW7b49742264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Sep 2022 06:49:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4234A4051;
	Thu, 29 Sep 2022 06:49:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7BA3A4040;
	Thu, 29 Sep 2022 06:49:31 +0000 (GMT)
Received: from [9.124.31.155] (unknown [9.124.31.155])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 29 Sep 2022 06:49:31 +0000 (GMT)
Message-ID: <fca097c1-9bf2-8951-1994-9fc17b77b822@linux.ibm.com>
Date: Thu, 29 Sep 2022 12:19:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] ppc64: remove rma_top limit
To: Simon Horman <horms@kernel.org>, Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, hbathini@linux.ibm.com
References: <20220915084240.133742-1-sourabhjain@linux.ibm.com>
 <20220920071447.om36ms2leara2o2v@Rk> <Yy7zs/4cDgybRUNl@vergenet.net>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Yy7zs/4cDgybRUNl@vergenet.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WqqSSUYH0TIVkHTjoJ7N7xV4Z_9vYzfa
X-Proofpoint-ORIG-GUID: Tnqf9Ndr-3eTKTNh1amgmkokVjw-Ozvg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_04,2022-09-29_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=948 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209290037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_234942_845530_4BBA80DD 
X-CRM114-Status: GOOD (  14.29  )
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

Hello Simon,

On 24/09/22 17:40, Simon Horman wrote:
> Hi Sourabh,
>
> could you address this question?
> It would be good to know before applying this patch.
Apologies for the delayed response, query is answered now.

Thanks,
Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
