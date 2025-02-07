Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C180C02194
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 19:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2D2JyvOBarhZSAqtc1h5NHJGa1JGnXoIakCrs2JBdA=; b=L2GfP36ScPsXSQXaN6mcVDigGk
	FqKLFBkgC7Yo66y+qOY8jWMUhr3nmI1NDGbGzdN3AAsfnbfBbcF2krmbbsu7obh4a0n8G66R2bd+c
	JztfqZY33knGmskP88MH0+1/utAswuLxEjaVBti35MjbTsEDwnW9eYp2heMTqABylkJSmQyw+w1yc
	uTlqCJo11u7xyVVi/VShLlDYqdf/5DM9tm1N1yUYi4+Qqlps+LV5GK3YUOvPbajYph/cwXGe6nFZd
	YkFfYlwL2w1kFSO3wDzXZATBkHe+B2zqdb6Y+/9obsnIYh0Ly+LO/0Led6qtKb5Kw3vuvvaIzyg4b
	ngNDsYTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgUA4-0000000AvTy-3NJi;
	Fri, 07 Feb 2025 19:37:12 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgUA2-0000000AvTN-0nbi
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 19:37:11 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517FdXl1029989;
	Fri, 7 Feb 2025 19:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r2D2Jy
	vOBarhZSAqtc1h5NHJGa1JGnXoIakCrs2JBdA=; b=R6AnF65dImnzu8mVMbNSKj
	RKiw7Gcexw16/wXJbVFFtgVAtR1te4/CfxbfZHEPzhNYsc7kvkS9Sh7wXmu2blPZ
	CUjq+CariqQRxUTNiy/r03F2uCTjQ1EUnbAf9uj0T5s5I0YXyQ4jhtDsrAlu4xM7
	86bNOIXYs572ONfNqoPOZ71KfWypFf0zefRC1QE+ms1Z1NfTGIGZj1Ej4TKLLICa
	7E8BmAHTOjsn37NRxX8bqLPw5Zzes8HN5f3GYXmbj7tsEmI9hqTJtMMHeXvxYaPx
	CtfNsC79RNdLKysQ11buXtkkR/MQO7m+wYumtVdN71TQi8BcAdj30q2XEuXKtp4Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44nn0th672-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 19:36:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517Gp572005261;
	Fri, 7 Feb 2025 19:36:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05kcw3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 19:36:52 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517JapDf27722370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 19:36:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E93A58053;
	Fri,  7 Feb 2025 19:36:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5FCE58043;
	Fri,  7 Feb 2025 19:36:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.80.253])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 19:36:49 +0000 (GMT)
Message-ID: <9dd19d7824aad9be423d8ef57cbfc7b0faf689d5.camel@linux.ibm.com>
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
Date: Fri, 07 Feb 2025 14:36:49 -0500
In-Reply-To: <4d258641d36088b1a1239724a2951211159d81f0.camel@linux.ibm.com>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
	 <20250203232033.64123-2-chenste@linux.microsoft.com>
	 <4d258641d36088b1a1239724a2951211159d81f0.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L5gyLswepfzIr3-MuG4mL7461Y4cl6iI
X-Proofpoint-ORIG-GUID: L5gyLswepfzIr3-MuG4mL7461Y4cl6iI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=948 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070146
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_113710_349994_3853E800 
X-CRM114-Status: GOOD (  25.90  )
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

On Thu, 2025-02-06 at 11:49 -0500, Mimi Zohar wrote:
> Thanks, Steven, for picking up and working on Tushar's patch set.
>=20
> I normally finish reviewing the patch set, before commenting.=C2=A0 In th=
is case,
> there's
> a generic comment that relates to all of the patches.=C2=A0 It's also a w=
ay of letting
> you
> know that I've started reviewing the patch set.=C2=A0 The remaining comme=
nts will come
> after I finish reviewing the patch set.
>=20
> On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
> > Carrying the IMA measurement list across kexec requires allocating a
> > buffer and copying the measurement records.=C2=A0 Separate allocating t=
he
> > buffer and copying the measurement records into separate functions in
> > order to allocate the buffer at kexec 'load' and copy the measurements
> > at kexec 'execute'.
> >=20
> > This patch includes the following changes:
> > =C2=A0- Refactor ima_dump_measurement_list() to move the memory allocat=
ion
> > =C2=A0=C2=A0 to a separate function ima_alloc_kexec_file_buf() which al=
locates
> > =C2=A0=C2=A0 buffer of size 'kexec_segment_size' at kexec 'load'.
> > =C2=A0- Make the local variable ima_kexec_file in ima_dump_measurement_=
list()
> > =C2=A0=C2=A0 a local static to the file, so that it can be accessed fro=
m=20
> > =C2=A0=C2=A0 ima_alloc_kexec_file_buf(). Compare actual memory required=
 to ensure=20
> > =C2=A0=C2=A0 there is enough memory for the entire measurement record.
> > =C2=A0- Copy as many measurement events as possible.
> > =C2=A0- Make necessary changes to the function ima_add_kexec_buffer() t=
o call
> > =C2=A0=C2=A0 the above two functions.
> > =C2=A0- Compared the memory size allocated with memory size of the enti=
re=20
> > =C2=A0=C2=A0 measurement record. If there is not enough memory, it will=
 copy as many
> > =C2=A0=C2=A0 IMA measurement records as possible, and this situation wi=
ll result
> > =C2=A0=C2=A0 in a failure of remote attestation.
> >=20
> > Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>=20
> I understand you want to credit Tushar for the patch, but the mechanism i=
s
> described
> in Documentation/process/submitting-patches.rst.=C2=A0 Refer to the parag=
raph on "Co-
> developed-by".=C2=A0 There is no tag named "Author".
>=20
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>=20
> "Suggested-by" goes before the Signed-off-by tag(s). "Reviewed-by" tag go=
es after
> your and/or Tushar's Signed-off-tag.
>=20
> > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>
>=20
> Before the "Co-developed-by" tag was defined, it was implied simply by th=
is
> ordering
> of the "Signed-off-by" tags.
>=20
> For those patches you didn't modify, simply import Tushar's patch with hi=
m as the
> author and add your Signed-off-by tag after his.

Thanks, Steven.  The patch set at this point is bi-sect safe.  The are just=
 a few
formatting cleanups based on "scripts/checkpatch --strict --codespell".  Be=
fore re-
posting, please re-base on the next-integrity branch and address the missin=
g
"kexec_execute" critical data.

Eric is the kexec maintainer so we need his Ack.

thanks,

Mimi

