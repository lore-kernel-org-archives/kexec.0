Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999D6EB64D9
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FURmPkYfCx3vG7wCwzNw4b/baioymO0P+rZmSoVEPVc=; b=Lb8ucgo+4UbQSX
	IS55NvBUsghIVz7DVT5WW2mptR4Tnq20Od4ZJwwhe2y8KzvyGtd0WVwkGh+G+0eCOab5z2l3hj+iY
	VcEFbf2URJq6EGN4wEtPQHeT5JndxeCmqNtHsQOn4NQIXy/aXkBqpR3GXo+RFc5npbPoiuYDBqDo6
	iJTY4GpSypT+GL/znt43FT2/lqEvbrC40O6w2hQfQ8PFYCH2drjrqe6+1kgUn0aJm149t2VCaIB4p
	IfzBeXktV4X2ZKRfFSPp/75tYdT0JNas59WKViDtccKiEwjlF54zkA0jZiqVNWbW8AcVQD16IWTH1
	oTZ4hoq0gTdFo0UPfPkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHl5A-004gWd-35;
	Fri, 07 Jul 2023 13:01:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHl54-004gVG-2W
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 13:01:07 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367CpfQd013222;
	Fri, 7 Jul 2023 13:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rk6ezievK7GXgin+dUr6d7LlQx4ezNJs5jn4BVNNTx0=;
 b=fZQUriv/bezp2XEB+3CAIezAxpxj9few3boH1OzvYd3GuOTq5voxPWUM8HVn7T1WgEjc
 v3A0+7oh47HGq8ph9LDEf3OzONeEDlTzl6BxHk8uO993hyrICIPFdQwIKTXRr80a30pc
 TkrfYmL5VbphBn7hkfvqlx1eLX3ZOSwABBHAkyzSgH+/KWiuWAqj2ReT/dz1O+pbTHNW
 0GgCnTZ/a/GCBkhCzYkNblIIs11WPknrYl7t/WjxgkII4oAklEeyxDr5+aTwMsbaS5y9
 JYdPpaCf+HZbHb8a273rttMG/Vl8Epy52mkQp3ZVpxeLVYhQW0XDh7dbrRxuks+GXVvU rg== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpk36g75p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jul 2023 13:00:44 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 367AjNbT001850;
	Fri, 7 Jul 2023 13:00:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
	by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3rjbs5a1tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jul 2023 13:00:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367D0guQ44106150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jul 2023 13:00:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53F315804B;
	Fri,  7 Jul 2023 13:00:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4741D58063;
	Fri,  7 Jul 2023 13:00:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.7.157])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jul 2023 13:00:41 +0000 (GMT)
Message-ID: <7ecb8c00ca03831c68c3cdae8b402b119463f4f3.camel@linux.ibm.com>
Subject: Re: [PATCH 02/10] ima: implement function to populate buffer at
 kexec execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Fri, 07 Jul 2023 09:00:40 -0400
In-Reply-To: <20230703215709.1195644-3-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
	 <20230703215709.1195644-3-tusharsu@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ed2K5-gw_226PqH0dcwk0ekW3VAdFa18
X-Proofpoint-GUID: ed2K5-gw_226PqH0dcwk0ekW3VAdFa18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_08,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 clxscore=1015 mlxlogscore=980 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_060103_143472_5B089684 
X-CRM114-Status: GOOD (  29.62  )
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

On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
> There is no existing IMA functionality to just populate the buffer at
> kexec execute with IMA measurements.

The same function that copies the measurement list at kexec 'load',
could be re-used at kexec 'exec'.   Why is a new function that is very
similar to the existing ima_dump_measurement_list() needed?

> 
> Implement a function to iterate over ima_measurements and populate the
> ima_kexec_file buffer.  After the loop, populate ima_khdr with buffer
> details (version, buffer size, number of measurements).  Copy the ima_khdr
> data into ima_kexec_file.buf and update buffer_size and buffer.
> 
> 
> The patch assumes that the ima_kexec_file.size is sufficient to hold all
> the measurements.  It returns an error and does not handle scenarios where
> additional space might be needed.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 52 ++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 48a683874044..858b67689701 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -62,6 +62,58 @@ static int ima_allocate_buf_at_kexec_load(void)
>  	return 0;
>  }
>  
> +static int ima_populate_buf_at_kexec_execute(unsigned long *buffer_size, void **buffer)
> +{
> +	struct ima_queue_entry *qe;
> +	int ret = 0;
> +
> +	/*
> +	 * Ensure the kexec buffer is large enough to hold ima_khdr
> +	 */
> +	if (ima_kexec_file.size < sizeof(ima_khdr)) {
> +		pr_err("%s: Kexec buffer size too low to hold ima_khdr\n",
> +			__func__);
> +		ima_clear_kexec_file();
> +		return -ENOMEM;
> +	}
> +
> +	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> +		if (ima_kexec_file.count < ima_kexec_file.size) {
> +			ima_khdr.count++;
> +			ima_measurements_show(&ima_kexec_file, qe);
> +		} else {
> +			ret = -ENOMEM;
> +			pr_err("%s: Kexec ima_measurements buffer too small\n",
> +				__func__);
> +			break;
> +		}
> +	}
> +	if (ret < 0)
> +		goto out;
> +
> +	/*
> +	 * fill in reserved space with some buffer details
> +	 * (eg. version, buffer size, number of measurements)
> +	 */
> +	ima_khdr.buffer_size = ima_kexec_file.count;
> +	if (ima_canonical_fmt) {
> +		ima_khdr.version = cpu_to_le16(ima_khdr.version);
> +		ima_khdr.count = cpu_to_le64(ima_khdr.count);
> +		ima_khdr.buffer_size = cpu_to_le64(ima_khdr.buffer_size);
> +	}
> +
> +	memcpy(ima_kexec_file.buf, &ima_khdr, sizeof(ima_khdr));
> +	*buffer_size = ima_kexec_file.count;
> +	*buffer = ima_kexec_file.buf;
> +
> +out:
> +	if (ret < 0)
> +		ima_clear_kexec_file();
> +
> +	return ret;
> +}
> +
> b+
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
>  {

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
