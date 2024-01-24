Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFA6C46CD2
	for <kexec@archiver.kernel.org>; Wed, 24 Jan 2024 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eyEno/arnapZoerZJRCXovf89l6rHMDjoXeo7SoCCkg=; b=1wbMwuC+FOWOBz
	6aHEg5ydDTHv/ZI7T+QX16imiZAYSMmxTjAEnk6roPz+fxFKAq7oBEgo9buWd/nKpLMUpWI/Rcmuk
	ETsWL92GfCBY3955X4TFraaNqn7LsbpuG0CJFw2Ny2JL2mIfPeDiRD1lu6/mu4y9mxjarnV8QH6A/
	Wq5+nnnP4WkiGiLUmx5B+PqeJWGyXlPnAoAhkMFibyUSqpXBqBL/aPEFMDvOppK5qN0rUCQIPrl04
	98cM78/fuUWgeuGHahc2AIeZCbjtDIcRyZ3wIDxqkuVLatHy+VMSE1V90E1XB5U/RXkICXfh5g5+7
	TFvNIDddTsWIPMzAl3UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSdO3-003U4c-1r;
	Wed, 24 Jan 2024 13:33:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSdO0-003U30-1Y
	for kexec@lists.infradead.org;
	Wed, 24 Jan 2024 13:33:50 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBWKVl006278;
	Wed, 24 Jan 2024 13:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QFrOoUDx7oqBcA6chvgF+hyY0GkfGAxZPy/Ry2T2upM=;
 b=IYzCo1Vpyg/G451VaAPRVRNoia5k76zEz2ui6izPuyU6CoZfwIBIs7oP1pGz458oXa03
 Sc3bGjLdeak4z0i4Q68UxeBiJtOnau13c13cSrUPg5tIgkjjRW/zPbFAC9IYNSxBGzuc
 Ty2gW3J4lL81xnXT22AdvJHDaYnESsnMWZALCp4b7bf/1uQJEX3FoU0WNkr1XE6lD55+
 7CXmQzh3xILkNZRPnfF6/EEkYcyAAVQc992AH6V53Hu6atcHBm3hWKBAkc++EZOTTKIx
 8IqQQL20MvNfWEk+ULwf9KOTq1HhwpsFtmA8uIVI0fVUsLlCeZIIrxdU6kxD6XeCXLD3 ZQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu1rt2sk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 13:33:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBuSpi025268;
	Wed, 24 Jan 2024 13:33:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkdp4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 13:33:07 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40ODX7Of26018534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 13:33:07 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C4A158054;
	Wed, 24 Jan 2024 13:33:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1529C5805C;
	Wed, 24 Jan 2024 13:33:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.166.202])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 13:33:05 +0000 (GMT)
Message-ID: <8f8b573a3dda6020972f359f9c54d03272afe852.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/7] ima: define and call ima_alloc_kexec_file_buf
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 24 Jan 2024 08:33:05 -0500
In-Reply-To: <20240122183804.3293904-2-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
	 <20240122183804.3293904-2-tusharsu@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3sntGgXaV1I3vNnS7rqBknklyO8b8ALu
X-Proofpoint-ORIG-GUID: 3sntGgXaV1I3vNnS7rqBknklyO8b8ALu
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_053348_608317_3E177D75 
X-CRM114-Status: GOOD (  20.98  )
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

Hi Tushar,

On Mon, 2024-01-22 at 10:37 -0800, Tushar Sugandhi wrote:

Missing from this and the other patch descriptions is the problem
description.  Please refer to the section titled  "Describe your changes" in 
https://docs.kernel.org/process/submitting-patches.html.

"Describe your problem.  Whether your patch is a one-line bug fix or 5000 lines
of a new feature, there must be an underlying problem that motivated you to do
this work.  Convince the reviewer that there is a problem worth fixing and that
it makes sense for them to read past the first paragraph."

In this case, "why" you need to refactor ima_dump_measurement_list() is the
problem.

For example:

Carrying the IMA measurement list across kexec requires allocating a buffer and
copying the measurement records.  Separate allocating the buffer and copying the
measurement records into separate functions in order to allocate the buffer at
kexec "load" and copy the measurements at kexec "execute".

"Once the problem is established, describe what you are actually doing about it
in technical detail.  It's important to describe the change in plain English for
the reviewer to verify that the code is behaving as you intend it to."

> Refactor ima_dump_measurement_list() to move the memory allocation part
> to a separate function ima_alloc_kexec_file_buf() which allocates buffer
> of size 'kexec_segment_size' at kexec 'load'.  Make the local variable
> ima_kexec_file in function ima_dump_measurement_list() as local static to
> the file, so that it can be accessed from ima_alloc_kexec_file_buf().
> Make necessary changes to the function ima_add_kexec_buffer() to call the
> above two functions.

Please make this into an unordered list.

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
