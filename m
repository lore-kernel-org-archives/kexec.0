Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08B7C3DA6E
	for <kexec@archiver.kernel.org>; Wed, 20 Dec 2023 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iRL03Rb01Y0MUFGN2IJEKuxPrcRd+pKZ19afpHXFFW0=; b=xL5F58E5laK2y5
	rvBTl3s4jHXnFVwbDUYJUey2EhVzDvBlyqOGGu83jr7MjMuvsxeHaMgxiOLdYONobcFw+tYYfFHRg
	kAuTgpMpfX3ZmFhFfIqW/kBw7to6mTRE9HxnP1S2w0mJtt8iy7pde1jx5nwAhHKnXcKDlEsKiaj28
	FL+9T6XQEDa+GZw6duzfvgSlCut5A19DSwl2LPML5HCFOPuSkWW4k7yB4yowmevu3oaOVBrkuciqK
	f9amTiIIS3UHLd5G78X5wBL7z+E2/WIuV+y/ep8sdpEHJza8GS6irhzaJBY6dkqw4DylU4cGMKBXI
	YcshuuUZfB1lSyhOhBDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFzDS-000PcF-0s;
	Wed, 20 Dec 2023 16:14:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFzDQ-000PbV-1S
	for kexec@lists.infradead.org;
	Wed, 20 Dec 2023 16:14:37 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKFCqOZ007099;
	Wed, 20 Dec 2023 16:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/Hp/Sosk0ZfPSK9nUJIDpN6/hPtj+XJMD3rI6SR96EY=;
 b=gscSbagn9zMn6j8R5NRAGTBnSeMLf97uAYdxM+TwfZ8eYVMkGXnqztGzTwnGbBxXSn1W
 iscZWQqkFSzFaoK6Lq4LLd2qBvxsRcmXMVntR/wXPexTaQc1S/YPcPSmuj78uXpL26Ju
 TrUzRKh639v/fPZ5G5Wq4thFSn/B0hIt8Ia9NhqJYu2y7hM7aJudEaQQs73lNbkNdPj4
 0VCrR/nl+GgLZ72TuFzScdkVu7ukn6PkjICge39NIPMKSwl2LEfalMQjpVvk8tZ62p3N
 bLYtCq0vv3Njy0potWIRhn9dX0cmp+v/cxOQ3xWsWHsQ4kUqiFnC/hZeFfHGMznB2yiS ZQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v42q6hwwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 16:14:02 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKE8pXo004846;
	Wed, 20 Dec 2023 16:14:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1pkyykdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 16:14:01 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKGE0YU11534990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 16:14:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A830F58056;
	Wed, 20 Dec 2023 16:14:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B33BC58052;
	Wed, 20 Dec 2023 16:13:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.116.58])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Dec 2023 16:13:59 +0000 (GMT)
Message-ID: <ea2a4524bfd0af5515a547ce6e7fbbec8067e490.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/7] ima: define and call ima_alloc_kexec_file_buf
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 20 Dec 2023 11:13:59 -0500
In-Reply-To: <20231216010729.2904751-2-tusharsu@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
	 <20231216010729.2904751-2-tusharsu@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t8dy_epU3Y3TPUNm0xIHJN3VyaPfMndD
X-Proofpoint-ORIG-GUID: t8dy_epU3Y3TPUNm0xIHJN3VyaPfMndD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_09,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 impostorscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_081436_497237_D2247675 
X-CRM114-Status: GOOD (  21.24  )
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

On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
> Refactor ima_dump_measurement_list() to move the memory allocation part
> to a separate function ima_alloc_kexec_file_buf() to allocate buffer of
> size 'kexec_segment_size' at kexec 'load'.  Make the local variables in
> function ima_dump_measurement_list() global, so that they can be accessed
> from ima_alloc_kexec_file_buf().  

Only ima_kexec_file is being moved and does not need to be global, but
should be defined as local static.

> Make necessary changes to the function
> ima_add_kexec_buffer() to call the above two functions.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 96 +++++++++++++++++++++---------
>  1 file changed, 67 insertions(+), 29 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 419dc405c831..ae27101d0615 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,62 +15,93 @@
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
> +struct seq_file ima_kexec_file;

^static.

> +void ima_free_kexec_file_buf(struct seq_file *sf)

^static

> +{
> +	vfree(sf->buf);
> +	sf->buf = NULL;
> +	sf->size = 0;
> +	sf->read_pos = 0;
> +	sf->count = 0;

--  
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
