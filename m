Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892E9C28B30
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 13:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8mFVcqFA1C6pWd8bYYrSIaZl/JCsBhWrZXtha/PnkrI=; b=MaOv8sGzAopl4COJqMquAh1WxS
	Lgp7nRMjEZpsA1Gtj+YW653WhM/gFuhjz5RFokuj8Ai6PAAfQBmZvIj4j2BCp9nSqY6LNuo3VTHqG
	0J00LukeWGfTIeEjWuVRmv3Dj0iGSwtxC/VEMzn/f+LZOGWhU3cYghrOTRAu97Ga3iT75/fm8rxdF
	y1ucnP4o8ku96wH1HWVFX2swoQ+rLfH999fnVZTxRJZSEVeZ3U8sBn+2hyJitR9cBIq6DwSCoEeJx
	8OHXMeLNRIYPQQpqPI9N6yEaFmgLfmAlMK2QWrLY8MD0tu/buk/U4ejzpejdmu1lDogWjbd6UlTyG
	7ujTaNbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvFuS-0000000CE9D-32RD;
	Thu, 20 Mar 2025 13:26:08 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvFbT-0000000CBWN-14fM
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 13:06:32 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K7gpHg030809;
	Thu, 20 Mar 2025 13:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8mFVcq
	FA1C6pWd8bYYrSIaZl/JCsBhWrZXtha/PnkrI=; b=XIXSk8AijIN/BUxZkkingD
	FfD51MOdZPzJhKy2MqmDm4PPzuTpx75PcVsadZGSxxPTjKA0ZgzjsIpwdlvfS11P
	0rwPzHbobNC0ce+DhMW29rir5mVgF30UEpuN3KTX21HPg04GgVb0h5XtFlj7f6yE
	73dHeT9HK4cTYPn8OihB10RHPV+cT4IIAy1rU/kf+A90mymEvHxiD1H73XewgFgw
	UU0TAjoO0wSb0S4UGMQg1CpqN3pGE8UQbda2atCVGR1Fc8HcuZsERonSJmy7LAcW
	EWEFIETKDJBDM/oFr6WsCzdUDd89Pk959Iq9taunZV5BioLNo13HUWKJhy5Y+h9g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g53qc5sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 13:06:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KAqeNP032041;
	Thu, 20 Mar 2025 13:06:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvtrbbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 13:06:15 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KD6Eu118612764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 13:06:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0FE75805A;
	Thu, 20 Mar 2025 13:06:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8919E58062;
	Thu, 20 Mar 2025 13:06:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.21.227])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 13:06:13 +0000 (GMT)
Message-ID: <a8368f2402e1145c134e445d015c434140874e06.camel@linux.ibm.com>
Subject: Re: [PATCH v10 2/8] ima: define and call ima_alloc_kexec_file_buf()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
        dyoung@redhat.com
Date: Thu, 20 Mar 2025 09:06:13 -0400
In-Reply-To: <Z9t0h5vvxP+meMkO@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
	 <20250318010448.954-3-chenste@linux.microsoft.com>
	 <Z9p7rwXqjB3vjCpj@MiWiFi-R3L-srv>
	 <447b1bf7b31e936ab959b8ba13f09a9c25bb3977.camel@linux.ibm.com>
	 <Z9t0h5vvxP+meMkO@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VxlXgarFD0AYjfhnl5T_btcofPGxYlna
X-Proofpoint-ORIG-GUID: VxlXgarFD0AYjfhnl5T_btcofPGxYlna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_060631_422142_D5E033B3 
X-CRM114-Status: GOOD (  19.21  )
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

On Thu, 2025-03-20 at 09:51 +0800, Baoquan He wrote:
> > > > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrit=
y/ima/ima_kexec.c
> > > > index 8567619889d1..45170e283272 100644
> > > > --- a/security/integrity/ima/ima_kexec.c
> > > > +++ b/security/integrity/ima/ima_kexec.c
> > > > @@ -15,6 +15,48 @@
> > > > =C2=A0 #include "ima.h"
> > > > =C2=A0=20
> > > > =C2=A0 #ifdef CONFIG_IMA_KEXEC
> > > > +static struct seq_file ima_kexec_file;
> > > > +
> > > > +static void ima_reset_kexec_file(struct seq_file *sf)
> > > > +{
> > > > +	sf->buf =3D NULL;
> > > > +	sf->size =3D 0;
> > > > +	sf->read_pos =3D 0;
> > > > +	sf->count =3D 0;
> > > > +}
> > > > +
> > > > +static void ima_free_kexec_file_buf(struct seq_file *sf)
> > > > +{
> > > > +	vfree(sf->buf);
> > > > +	ima_reset_kexec_file(sf);
> > > > +}
> > > > +
> > > > +static int ima_alloc_kexec_file_buf(size_t segment_size)
> > > > +{
> > > > +	/*
> > > > +	 * kexec 'load' may be called multiple times.
> > > > +	 * Free and realloc the buffer only if the segment_size is
> > > > +	 * changed from the previous kexec 'load' call.
> > > > +	 */
> > > > +	if (ima_kexec_file.buf && ima_kexec_file.size =3D=3D segment_size=
)
> > > > +		goto out;
> >=20
> > The call to ima_reset_kexec_file() in ima_add_kexec_buffer() resets
> > ima_kexec_file.buf() hiding the fact that the above test always fails a=
nd falls
> > through.=C2=A0 As a result, 'buf' is always being re-allocated.

Hi Steven,

[Reiterating the comment in the "ima: kexec: move IMA log copy from kexec l=
oad
to execute" thread, here, for completeness.]

Instead of adding and then removing the ima_reset_kexec_file() call from
ima_add_kexec_buffer(), defer adding the segment size test to when it is
actually possible for the segment size to change. Please make the segment s=
ize
test as a separate patch.

ima_reset_kexec_file() will then only be called by ima_free_kexec_file_buf(=
).=20
Inline the ima_reset_kexec_file() code in ima_free_kexec_file_buf().

thanks,

Mimi

