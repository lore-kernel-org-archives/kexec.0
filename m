Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AF4C3600C
	for <kexec@archiver.kernel.org>; Tue,  8 Apr 2025 05:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zJVlrVYmSXlUiKyvWRTsRH727ICp1NDWo/zS354Lji4=; b=CsZEy9zFStFAr+1EVIZc7t5awW
	NaON7z46116vdG+gV89IQ6R9eSfydCnsaPQ6h6yxCBcroynOcZAfMePWJZ3S3U6Wu24igKusNHRbx
	Df7czpSHdvF+i3WNB0lPcAmQPMzS1wCUlsuYCmx3BUsxW273tsY4OptHJPQctNxmuWRhyjN9Mq+OX
	7wwLor/8JkCp73xdbApW+dw9MI2JLNMbF1aN7DGn7HYZO6qmdAzTPQEi61udH53TEYjQzl/dIpI9g
	K6wKHfOZCDw6hiWdOjwYpZieFH51hye2qOH8ShHXarCglX/2VoowMh93CJJGuFWFxGl0TU1zIksIn
	pePq+a3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u219K-00000002kJU-05U5;
	Tue, 08 Apr 2025 05:05:26 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u217f-00000002k63-0nJC
	for kexec@lists.infradead.org;
	Tue, 08 Apr 2025 05:03:45 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381fnLw025560;
	Tue, 8 Apr 2025 05:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zJVlrV
	YmSXlUiKyvWRTsRH727ICp1NDWo/zS354Lji4=; b=BWXz/d2CuPB8v25xRLUFI3
	Yt75ZQzBrm3gwDY2r6ezYwoCsCMyZ6LPZSviwe6hNe+5540t+2N3SIhE3fiKu7wk
	h9XaPKl2IweIAqOuUxlxHFcfNurM3eCMYRKuGt4maYiymYUscsH2oIm9lqEnOJmo
	/q+/7HnXaMP2AxF7/3J3B50PZTQ0tbtJx4MA4izDj/T0ogUnJSWsmU8DwVnMFO6/
	b2891aaCdSpLM5HIioCUfheHu8dYXF3qFQvMsbC10Vbr4MWqPwupi7rIA3NI7zop
	ET8FqTQdT/z9kpd4t+wnGkif7RlnwB7FJarJ5VCAgkUSt+L+pdv5+qSNczz+mLMg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vg4qbpjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 05:03:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5384CfSq018432;
	Tue, 8 Apr 2025 05:03:12 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kgwqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 05:03:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53853CPl47251910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 05:03:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D7A45805A;
	Tue,  8 Apr 2025 05:03:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA85D58056;
	Tue,  8 Apr 2025 05:03:10 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.146.87])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 05:03:10 +0000 (GMT)
Message-ID: <36e244edd96a51f0749d54811c9567f954680a39.camel@linux.ibm.com>
Subject: Re: [PATCH v11 2/9] ima: define and call ima_alloc_kexec_file_buf()
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
Date: Tue, 08 Apr 2025 01:03:10 -0400
In-Reply-To: <Z/SoekIdreYI3uBZ@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-3-chenste@linux.microsoft.com>
	 <a293ed27094f7fa7a36f1641a9e6b17a49e26fa0.camel@linux.ibm.com>
	 <Z/SoekIdreYI3uBZ@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hqBCVgsalKlyQjgCFXw2vb7U18nsoY8J
X-Proofpoint-GUID: hqBCVgsalKlyQjgCFXw2vb7U18nsoY8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_220343_239404_0744D73E 
X-CRM114-Status: GOOD (  32.34  )
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

On Tue, 2025-04-08 at 12:39 +0800, Baoquan He wrote:
> On 04/08/25 at 12:07am, Mimi Zohar wrote:
> > On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
> > > In the current implementation, the ima_dump_measurement_list() API is=
=20
> > > called during the kexec "load" phase, where a buffer is allocated and=
=20
> > > the measurement records are copied. Due to this, new events added aft=
er
> > > kexec load but before kexec execute are not carried over to the new k=
ernel
> > > during kexec operation
> >=20
> > Repeating this here is unnecessary.
> > >=20
> > > To allow the buffer allocation and population to be separated into di=
stinct
> > > steps, make the function local seq_file "ima_kexec_file" to a file va=
riable.
> >=20
> > This change was already made in [PATCH v11 1/9] ima: rename variable th=
e
> > set_file "file" to "ima_kexec_file".  Please remove.
> >=20
> > >=20
> > > Carrying the IMA measurement list across kexec requires allocating a
> > > buffer and copying the measurement records.  Separate allocating the
> > > buffer and copying the measurement records into separate functions in
> > > order to allocate the buffer at kexec 'load' and copy the measurement=
s
> > > at kexec 'execute'.
> > >=20
> > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > > ---
> > >  security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++-----=
--
> > >  1 file changed, 35 insertions(+), 11 deletions(-)
> > >=20
> > > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/=
ima/ima_kexec.c
> > > index 650beb74346c..b12ac3619b8f 100644
> > > --- a/security/integrity/ima/ima_kexec.c
> > > +++ b/security/integrity/ima/ima_kexec.c
> > > @@ -15,26 +15,46 @@
> > >  #include "ima.h"
> > > =20
> > >  #ifdef CONFIG_IMA_KEXEC
> > > +static struct seq_file ima_kexec_file;
> > > +
> > > +static void ima_free_kexec_file_buf(struct seq_file *sf)
> > > +{
> > > +	vfree(sf->buf);
> > > +	sf->buf =3D NULL;
> > > +	sf->size =3D 0;
> > > +	sf->read_pos =3D 0;
> > > +	sf->count =3D 0;
> > > +}
> > > +
> > > +static int ima_alloc_kexec_file_buf(size_t segment_size)
> > > +{
> > > +	ima_free_kexec_file_buf(&ima_kexec_file);
> >=20
> > After moving the vfree() here at this stage in the patch set, the IMA
> > measurement list fails to verify when doing two consecutive "kexec -s -=
l"
> > with/without a "kexec -s -u" in between.  Only after "ima: kexec: move =
IMA log
> > copy from kexec load to execute" the IMA measurement list verifies prop=
erly with
> > the vfree() here.
>=20
> I also noticed this, patch 7 will remedy this. Put patch 7 just after
> this patch or squash it into this patch?
>=20
> [PATCH v11 7/9] ima: verify if the segment size has changed

I'm glad you noticed this too!  I've been staring at it for a while, not kn=
owing
what to do.

"ima: verify if the segment size has changed" is new to v11.  It was origin=
ally
part of this patch.  My comment on v10 was:

The call to ima_reset_kexec_file() in ima_add_kexec_buffer() resets
ima_kexec_file.buf() hiding the fact that the above test always fails and f=
alls
through.  As a result, 'buf' is always being re-allocated.

and

Instead of adding and then removing the ima_reset_kexec_file() call from
ima_add_kexec_buffer(), defer adding the segment size test to when it is
actually possible for the segment size to change. Please make the segment s=
ize
test as a separate patch.

ima_reset_kexec_file() will then only be called by ima_free_kexec_file_buf(=
).
Inline the ima_reset_kexec_file() code in ima_free_kexec_file_buf().

>=20
> >=20
> > > +
> > > +	/* segment size can't change between kexec load and execute */
> > > +	ima_kexec_file.buf =3D vmalloc(segment_size);
> > > +	if (!ima_kexec_file.buf)
> > > +		return -ENOMEM;
> > > +
> > > +	ima_kexec_file.size =3D segment_size;
> > > +	ima_kexec_file.read_pos =3D 0;
> > > +	ima_kexec_file.count =3D sizeof(struct ima_kexec_hdr);	/* reserved =
space */
> > > +
> > > +	return 0;
> > > +}
> > > +
> >=20
>=20
>=20


