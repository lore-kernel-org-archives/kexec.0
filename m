Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0CDC43334
	for <kexec@archiver.kernel.org>; Thu,  7 Jul 2022 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1K/aMMVoT3qfBPfxEFTa2t5G9z6TTgMBsqN1/8ISqaM=; b=ZPvqs0sMYKqK59
	S+RVhGWX+fKZWYNZQWT8qBDZ2BIDSWW/OKegiT/2wZeLL0q/9x312cbGMRsj4FOqpi3D0jqo2EpxP
	2ahbyvxNxoIFUclnBvAhJDWeRot8btRr8Md3QS7bG+DuFVNS0kVhoO5fxKISz0zLj25Fq5aqYGBaj
	zFsIYMK0UQN2YUsMyEWy8ECxGuQib9/h+3Kca85+9iLy32my6e1LNMdivsunbwlCJ5qbHbZm8WMo7
	CHKoVjKnkS6K0AIhbBms+2rqkU/bsFXo0CQyEuC0E55XL2Pfarq+nXT96CFls6N3MfRA9dxBDkTrh
	njQgXO4w9YbVykGpzUvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9U5c-00GtIo-Ci; Thu, 07 Jul 2022 16:10:52 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9U5Z-00GtGb-CV
	for kexec@lists.infradead.org; Thu, 07 Jul 2022 16:10:50 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267Fpb0X019270;
	Thu, 7 Jul 2022 16:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=k2FbwF9n2WlYsbyJT6u8wd+x1qkusCWll51c/T/HkIg=;
 b=HVp6oxP9r52mmrtl2+FUSAvdoYlihvjsRlt27n6DESdPoWQHYJ4lAdzZ88Wi4m9UAfeN
 oyC7HOBFYKzsKUvUhjWmoxBQtLgfY4BXBMZq+u2+NHXOcgLVxkhY3F40+2VtMU8mCZ3i
 MqPm9PWb7e4y5RKpwWG5zWmnPpLJIuPuFsg9vLLqpSG6Kli+I4FtHke8EWairzbKIbiY
 wzx9aC0dO1EhDOvJqYgVdk/UP6iiHI5HXSSdsa9z0VD/yopbBJtxSKHGR4b4tS0O9GQZ
 LC6sUvoc1GbecoJEKxnDgjWMzl2vKJwdaLG2V5zcv6n631PQz5ux4yE9LK9xh355uLg5 oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h62ge8mns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Jul 2022 16:10:36 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267FqNKI021028;
	Thu, 7 Jul 2022 16:10:35 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h62ge8mms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Jul 2022 16:10:35 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
	by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267G6WYQ001499;
	Thu, 7 Jul 2022 16:10:34 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
	by ppma05wdc.us.ibm.com with ESMTP id 3h4v50466j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Jul 2022 16:10:34 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267GAXeL19202458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Jul 2022 16:10:33 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0163BE04F;
	Thu,  7 Jul 2022 16:10:32 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44C5FBE05A;
	Thu,  7 Jul 2022 16:10:32 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu,  7 Jul 2022 16:10:32 +0000 (GMT)
Message-ID: <985a1b8b-5c1c-ba9c-ce6c-4968239448a2@linux.ibm.com>
Date: Thu, 7 Jul 2022 12:10:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 5/6] of: kexec: Refactor IMA buffer related functions
 to make them reusable
Content-Language: en-US
To: Jonathan McDowell <noodles@fb.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "nasastry@in.ibm.com" <nasastry@in.ibm.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20220706152329.665636-1-stefanb@linux.ibm.com>
 <20220706152329.665636-6-stefanb@linux.ibm.com>
 <YsbyENo0bOLljuI8@noodles-fedora.dhcp.thefacebook.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <YsbyENo0bOLljuI8@noodles-fedora.dhcp.thefacebook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _OaNNuDjz8Hd459zm8GiKq_DyNZHoUcS
X-Proofpoint-GUID: U-3ZkHWU9gvO6dxrVjnbK-s6nuslBSZu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_091049_514238_C90A7F65 
X-CRM114-Status: GOOD (  21.68  )
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



On 7/7/22 10:47, Jonathan McDowell wrote:
> On Wed, Jul 06, 2022 at 11:23:28AM -0400, Stefan Berger wrote:
>> Refactor IMA buffer related functions to make them reusable for carrying
>> TPM logs across kexec.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Cc: Mimi Zohar <zohar@linux.ibm.com>
>>
>> ---
>> v5:
>>   - Rebased on Jonathan McDowell's commit "b69a2afd5afc x86/kexec: Carry
>>     forward IMA measurement log on kexec"
>> v4:
>>   - Move debug output into setup_buffer()
>> ---
>>   drivers/of/kexec.c | 125 ++++++++++++++++++++++++++-------------------
>>   1 file changed, 73 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
>> index 548dd5b1b5c1..404a86bb3978 100644
>> --- a/drivers/of/kexec.c
>> +++ b/drivers/of/kexec.c
>> @@ -117,45 +117,56 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
>>   }
>>   
>>   #ifdef CONFIG_HAVE_IMA_KEXEC
>> -/**
>> - * ima_get_kexec_buffer - get IMA buffer from the previous kernel
>> - * @addr:	On successful return, set to point to the buffer contents.
>> - * @size:	On successful return, set to the buffer size.
>> - *
>> - * Return: 0 on success, negative errno on error.
>> - */
>> -int __init ima_get_kexec_buffer(void **addr, size_t *size)
>> +static int get_kexec_buffer(const char *name, unsigned long *addr, size_t *size)
> 
> I think this new function can + should be marked __init as well; it's
> only called from the existing IMA functions and your new
> tpm_get_kexec_buffer which is already __init.

Yes, right. Thanks.
    Stefan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
