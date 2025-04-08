Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B996C369A2
	for <kexec@archiver.kernel.org>; Tue,  8 Apr 2025 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lcPbNoHY32hfMLXK0I9on2JgdqFyxj5M9NfZlD7bhIA=; b=PE2UCUaZdnyRZ1p/VtGAylaVBl
	S0p0Yby2iXmDuN6lnumxJZNZCj7B4FUCvh7XbXW+kUUew8BV3ATph8pWlRf+dSFDhFoA7BKYZxUnP
	Cxf0Ws0XYMp4hiLWBbZLduJk68XkACNiBODPbqHlUXsyjEnSJ+CFnewReMiDJXTP28HfufzmbvreP
	jbWe6rb3UBiCmkJPm5UDC5GgmFjWnBrVdv1OhBpcoAFLs6jg+a9Y+sKtFPNs6MZHddswMyvZaogRn
	g01mA6CvMfncE5SEEX0EJK/WnnDcRlvPFMbV8j6iZyb7fZcoiNCJSJxrrfnnMtPUuSCLeyH4GzYzC
	/fWD6x+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u29sm-00000004Muh-1JPP;
	Tue, 08 Apr 2025 14:24:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u29qS-00000004MUF-0j8z
	for kexec@lists.infradead.org;
	Tue, 08 Apr 2025 14:22:33 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538ChQh8029846;
	Tue, 8 Apr 2025 14:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lcPbNo
	HY32hfMLXK0I9on2JgdqFyxj5M9NfZlD7bhIA=; b=gDQ2dgo1+c3N4ulFEkxdKS
	4P2Jlx0wNUPeWNcyzkcq0r/EGsLs8gRdlX+6q8OFuXeU102zAC4FhNHL/V+4qzJc
	p+niv1CGoOrOt0eBkfU3cTQO4TIhnRf1rmfp9flprMX1XeAa+YvuRExxMXHcFKM4
	wk/WAkEzjXkt1EixICdM/sx95ZKceC9B9viXquEgUByH8UOIZbEJ1svnNjlfkJ+n
	x1o5sr5mcVzRaetZy5JA/+L1PZEo36umXXXxleb+3XduujkUjGCy1PJcb5OM/0dH
	NJK41hSCjQ1yIvcCHzoAkrKg4kYW727re/cQwBfxlboMwaEeAT3m3o0GLyZmvHxw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vv6a2tq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 14:22:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538BLD5Q011078;
	Tue, 8 Apr 2025 14:22:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7yk5hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 14:22:13 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 538EMDGD25035364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 14:22:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 288CB58057;
	Tue,  8 Apr 2025 14:22:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3FB458066;
	Tue,  8 Apr 2025 14:22:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.48.163])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 14:22:11 +0000 (GMT)
Message-ID: <deecee12f444b5b0ad03f5866749d6ad66659f7a.camel@linux.ibm.com>
Subject: Re: [PATCH v11 7/9] ima: verify if the segment size has changed
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Tue, 08 Apr 2025 10:22:11 -0400
In-Reply-To: <20250402124725.5601-8-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-8-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tD1oxfS_HxPWPw2k7-OlMQwtJG4Sl7kV
X-Proofpoint-GUID: tD1oxfS_HxPWPw2k7-OlMQwtJG4Sl7kV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=825 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_072232_220302_932410CC 
X-CRM114-Status: UNSURE (   8.04  )
X-CRM114-Notice: Please train this message.
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
> kexec 'load' may be called multiple times. Free and realloc the buffer
> only if the segment_size is changed from the previous kexec 'load' call.
>=20
> Signed-off-by: steven chen <chenste@linux.microsoft.com>

Thanks, Steven.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

