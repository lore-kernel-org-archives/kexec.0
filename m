Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0E0C7EE37
	for <kexec@archiver.kernel.org>; Fri,  9 Jun 2023 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ztuh4JRF/7Waxhyj751bSPalpiGEcNXTv8JrTrtdIDQ=; b=I/rG4ckRycSJCuFu6m2nybTH2n
	C4849XYRw08K5NYJ+yorA+8b7rS1sPrP1RDlmZ93BviTZmFP9KEdRJnJepTLKisuKNSjtBi9ERKHg
	ijf8xMn853OBtgPaWvwe/6aWX2zX57qx8wX5S2y+Grou4shniWMWQGYJWgvaUwuQiI8Xba4lhufC5
	jnLjjxU1PuCFbFS3wjJ4W2T7X6AF2yU1K5nI0YT9gtQUc9w1UhvL1vmptp/a0/dLeVyDRkOFSqkQQ
	Y1jsFqgOPmCDOPLrXNCLPAaRgCiKt+UUZYOA0xBeTVEJTzhTzxdzLUmkRXxaAulEOUHA/Jyfn6sFL
	BY2WQFKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7hBW-00Du3O-23;
	Fri, 09 Jun 2023 18:50:06 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7hBT-00Du2I-0X
	for kexec@lists.infradead.org;
	Fri, 09 Jun 2023 18:50:04 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359IlA3R001149;
	Fri, 9 Jun 2023 18:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=myGzGs2NawOBCwWz7+upUz/JwK6dQ3oOlKG8artjLsg=;
 b=Tlg2h+4k+8omqvp18PZBG69LYolCdOgFacEckvNHPvQX1jTTKCFC+TNkGivoe/AclTpa
 22LLDWt8RrmwRfrpfwF8V0VnLFPr+eVUkU8F1F59DUjplMwvEVXnzq/ap+K0CmOJp2Xp
 FyuhXtuv4AEyjwxzUZLl3c8BQ9KZeaibZzT/riHzE21lSwv6N/VBCt/gL7HgGqvF4t1U
 pR3PRa4e46xwNcF/ixiLU1uJBzjYd5R61bXT/qg22tfnhJK+U8ppPCoL8v30d41gEbaj
 tcVPvYq0XYUrS1POto4RFDj6TLjLB5t/MBNEf5H9YOD/C7iLhafsqddfBiz8advqlaqu jg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r49nkr3av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jun 2023 18:49:45 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359IniJb009506;
	Fri, 9 Jun 2023 18:49:45 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r49nkr3ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jun 2023 18:49:44 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 359IAhWv022632;
	Fri, 9 Jun 2023 18:49:43 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
	by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3r2a77q2c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jun 2023 18:49:43 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 359Ingwv6292016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Jun 2023 18:49:42 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29E905805D;
	Fri,  9 Jun 2023 18:49:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A91358054;
	Fri,  9 Jun 2023 18:49:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Jun 2023 18:49:40 +0000 (GMT)
Message-ID: <4afde78d-e138-9eee-50e0-dbd32f4dcfe0@linux.ibm.com>
Date: Fri, 9 Jun 2023 14:49:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 2/4] tpm: of: Make of-tree specific function commonly
 available
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au,
        Jason Gunthorpe <jgg@ziepe.ca>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nageswara R Sastry
 <rnsastry@linux.ibm.com>,
        Coiby Xu <coxu@redhat.com>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-3-stefanb@linux.ibm.com>
 <e4dcxwp63uisirxwanjwrhzrnve45wqnxhijfp4oq274r4neco@v2btoy43ue5h>
 <CT8BRJZS8RQU.9ICEA2UAFC7G@suppilovahvero>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CT8BRJZS8RQU.9ICEA2UAFC7G@suppilovahvero>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vnMB3zCx4Hhs6QhKY0JaE9KiteMDLAjg
X-Proofpoint-ORIG-GUID: ekM5eMhdXay5_PWqimPauZQ9QWzNxbDb
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_14,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=881 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090155
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_115003_470331_0A937ABD 
X-CRM114-Status: GOOD (  16.43  )
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



On 6/9/23 14:18, Jarkko Sakkinen wrote:
> On Thu May 25, 2023 at 1:56 AM EEST, Jerry Snitselaar wrote:
>> On Tue, Apr 18, 2023 at 09:44:07AM -0400, Stefan Berger wrote:
>>> Simplify tpm_read_log_of() by moving reusable parts of the code into
>>> an inline function that makes it commonly available so it can be
>>> used also for kexec support. Call the new of_tpm_get_sml_parameters()
>>> function from the TPM Open Firmware driver.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
>>> Tested-by: Coiby Xu <coxu@redhat.com>
>>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>
>>
>> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> If I just pick tpm only patches they won't apply so maybe TPM changes
> should be better separated if that is by any means possible.

Per the comment here I am putting this series here on hold.
https://lore.kernel.org/linux-integrity/20230418134409.177485-1-stefanb@linux.ibm.com/T/#m03745c2af2c46f19f329522fcb6ccb2bf2eaedc7


BR,
    Stefan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
