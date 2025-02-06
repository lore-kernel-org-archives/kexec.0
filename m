Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0DAC02198
	for <kexec@archiver.kernel.org>; Thu,  6 Feb 2025 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=87apyh57lCqrmormY0JxtDEbgGCBEuSc8jI7v0zlMvI=; b=1u+qFKSUwDINLzwVkQ0duGtVSJ
	NNSbbuE51zGvG0RbaA8vAsOrZkm+Jv7QDgpv/w07Nt9uuAUd1eeLMELnaWw/97dwLfe+dNtr4G3Mo
	shr4uGlDjU/Qf9sWdRCevwTmGZvBuMn6uaYDcvhofAn2FvtaY7e20NzORXZqBmLu47HGZ3NPYMxgT
	+Ji4/bAonVVj4vw1qy/lSx4spotjdGPgibc0LDMxg0Cu5h+F0JXdbU14L2HR/3h3Cd8NQni01qHHU
	ywwwCqcYtO3rZbqnfGQMRcOp1ZlhhABjvlgQihYUI5W1EdtYYQMGsPM1psYSt/ltjSA/oaYtRY44l
	xzXDhXRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tg55z-00000006uJm-3xl5;
	Thu, 06 Feb 2025 16:51:19 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tg55x-00000006uJS-22zn
	for kexec@lists.infradead.org;
	Thu, 06 Feb 2025 16:51:18 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516ESLnv009659;
	Thu, 6 Feb 2025 16:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=87apyh
	57lCqrmormY0JxtDEbgGCBEuSc8jI7v0zlMvI=; b=r7o+9REJsqkM4wai6G0ECo
	crieIq7a3vPTutv/jbe+TJ/KWXdPIdmYXD2B/p5ZOvolj//bisS8CMBF52U8xe3Y
	qvGCPgf0lMng6Du2lrFqQkRq7tbBh3hwx1QDN5CIFEhJMp337ou3FvvkE6vXPYey
	hcTIdzKG169qIUInbt5MzFk2SChvtCC0unrb+4ZC1fLbVM7/8r/Na0s0U2tZZHte
	dWusE1XYlg/xuSiVqATR9ci56HUBpsJneX63aTLgWKEv5O5UMNgBsH3/ESGbVXVK
	kQWBZkFGDCWbIPzZgoygNkkKqNHhwA6+1PdQK1eqxfGxPqGuPbRg8I8jqSQ44R8Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44mk5a4cr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 16:49:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 516EZ345007150;
	Thu, 6 Feb 2025 16:49:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxayyd0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 16:49:50 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 516Gnnfj29295206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Feb 2025 16:49:49 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83A4058052;
	Thu,  6 Feb 2025 16:49:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79DC458056;
	Thu,  6 Feb 2025 16:49:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.168.13])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Feb 2025 16:49:48 +0000 (GMT)
Message-ID: <4d258641d36088b1a1239724a2951211159d81f0.camel@linux.ibm.com>
Subject: Re: [PATCH v7 1/7] ima: define and call ima_alloc_kexec_file_buf
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
Date: Thu, 06 Feb 2025 11:49:48 -0500
In-Reply-To: <20250203232033.64123-2-chenste@linux.microsoft.com>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
	 <20250203232033.64123-2-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 82HIc3utkTw5hw7G6_oAjrNeCVhsuthI
X-Proofpoint-ORIG-GUID: 82HIc3utkTw5hw7G6_oAjrNeCVhsuthI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_085117_536848_5166F190 
X-CRM114-Status: GOOD (  20.79  )
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

Thanks, Steven, for picking up and working on Tushar's patch set.

I normally finish reviewing the patch set, before commenting.  In this case=
, there's
a generic comment that relates to all of the patches.  It's also a way of l=
etting you
know that I've started reviewing the patch set.  The remaining comments wil=
l come
after I finish reviewing the patch set.

On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
> Carrying the IMA measurement list across kexec requires allocating a
> buffer and copying the measurement records.=C2=A0 Separate allocating the
> buffer and copying the measurement records into separate functions in
> order to allocate the buffer at kexec 'load' and copy the measurements
> at kexec 'execute'.
>=20
> This patch includes the following changes:
> =C2=A0- Refactor ima_dump_measurement_list() to move the memory allocatio=
n
> =C2=A0=C2=A0 to a separate function ima_alloc_kexec_file_buf() which allo=
cates
> =C2=A0=C2=A0 buffer of size 'kexec_segment_size' at kexec 'load'.
> =C2=A0- Make the local variable ima_kexec_file in ima_dump_measurement_li=
st()
> =C2=A0=C2=A0 a local static to the file, so that it can be accessed from=
=20
> =C2=A0=C2=A0 ima_alloc_kexec_file_buf(). Compare actual memory required t=
o ensure=20
> =C2=A0=C2=A0 there is enough memory for the entire measurement record.
> =C2=A0- Copy as many measurement events as possible.
> =C2=A0- Make necessary changes to the function ima_add_kexec_buffer() to =
call
> =C2=A0=C2=A0 the above two functions.
> =C2=A0- Compared the memory size allocated with memory size of the entire=
=20
> =C2=A0=C2=A0 measurement record. If there is not enough memory, it will c=
opy as many
> =C2=A0=C2=A0 IMA measurement records as possible, and this situation will=
 result
> =C2=A0=C2=A0 in a failure of remote attestation.
>=20
> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>

I understand you want to credit Tushar for the patch, but the mechanism is =
described
in Documentation/process/submitting-patches.rst.  Refer to the paragraph on=
 "Co-
developed-by".  There is no tag named "Author".

> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>

"Suggested-by" goes before the Signed-off-by tag(s). "Reviewed-by" tag goes=
 after
your and/or Tushar's Signed-off-tag.

> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>

Before the "Co-developed-by" tag was defined, it was implied simply by this=
 ordering
of the "Signed-off-by" tags.

For those patches you didn't modify, simply import Tushar's patch with him =
as the
author and add your Signed-off-by tag after his.

thanks,

Mimi

