Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1B0C36010
	for <kexec@archiver.kernel.org>; Mon,  7 Apr 2025 11:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XuHDToxdn1OHiYXd4Qyq2ur7sKTh36MOolgzXWnoIkk=; b=rymtpBt8s31tO5KOAPQvnlsWSG
	pM3gGFMq2Gv6xoxSvmx/daYhQkHW1RRv3/ANspONNo6WZaebz+5JfprruAPOxKZMbP3t4/FYnAXNy
	yHhSoT/8ZKwaBVWFduBd72ZzyOxoBska3N18zcPfTA7DtDV/YJk+FGKAQz5zsczUrmZu1nxhh2b8Z
	He3/E2fhbXAb5ZiAGSXYOsrxBjxMNL4Jm0+JPW/HbGLVdZVD2/Ao21UTAa0uYCYoiTlqXn3nqrSeG
	xe4Jmu3uIfG9elaH7fdR4Ffy0qvxzu/gFeflND4Z7sUMYoiHn52S6upB5/U/UarDsYwl0YdJVY+bA
	6zH2PNMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ky3-000000004sW-333C;
	Mon, 07 Apr 2025 11:48:43 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1kw9-000000004MQ-3wTS
	for kexec@lists.infradead.org;
	Mon, 07 Apr 2025 11:46:47 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53786w9Y018728;
	Mon, 7 Apr 2025 11:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XuHDTo
	xdn1OHiYXd4Qyq2ur7sKTh36MOolgzXWnoIkk=; b=scLfDesq88Lao2J9Mfllp+
	DYePmaKlB/AOTTwD2/ixMXjgtXPrV9AsLbGZgZcrT8ithKsxTSEZNODWCJ27xqTv
	ecvIrmQ/EchrxfxDc2kidBImoV3U2Q4NQgVVUS+NqC3raPaoZ/9ttccARN+COf02
	21ID3FiDZu0+ME56w/kJP+a/oBF2qvKYGtmBthnCUluOScNlKESEJnkTNVLjVt5K
	Z8jG0SZpz2etMvfPzw01DhojKMsokQPkHQ3ceRNxOSyU4moZ2+Tlv4upNwdSvZLA
	SEBcQWuNVA9ZW2qqiqOYuCZwUAVNN5vohDnWxnNIs2vslGPOs1kM/nx9/VMVkbDQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45uu1pm774-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 11:46:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 537A1jXL013915;
	Mon, 7 Apr 2025 11:46:43 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufundktj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 11:46:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 537Bkgr132768708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Apr 2025 11:46:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50C0E5804B;
	Mon,  7 Apr 2025 11:46:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99B795805B;
	Mon,  7 Apr 2025 11:46:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.147.44])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Apr 2025 11:46:41 +0000 (GMT)
Message-ID: <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>, RuiRui Yang <ruyang@redhat.com>,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date: Mon, 07 Apr 2025 07:46:41 -0400
In-Reply-To: <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
References: <20250331061611.253919-1-bhe@redhat.com>
	 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
	 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
	 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
	 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
	 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
	 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
	 <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
	 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 17jjyCXIfmSx_CsmYckZnLuz6iyrxQMI
X-Proofpoint-ORIG-GUID: 17jjyCXIfmSx_CsmYckZnLuz6iyrxQMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504070082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_044645_986763_1FF3B5E4 
X-CRM114-Status: GOOD (  50.07  )
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

On Mon, 2025-04-07 at 09:34 +0800, Baoquan He wrote:
> On 04/03/25 at 04:03pm, Mimi Zohar wrote:
> > On Wed, 2025-04-02 at 19:49 +0800, Baoquan He wrote:
> > > On 04/02/25 at 04:43pm, Coiby Xu wrote:
> > > > On Tue, Apr 01, 2025 at 11:30:09PM -0400, Mimi Zohar wrote:
> > > > > On Wed, 2025-04-02 at 09:47 +0800, RuiRui Yang wrote:
> > > > [...]
> > > > > > > > that.  Please don't make it generic like this.
> > > > > > > >=20
> > > > > > > > Please refer to ima_appraise_parse_cmdline().
> > > > > > >=20
> > > > > > > Hi Mimi,
> > > > > > >=20
> > > > > > > To save memory for kdump, it seems init_ima has been to be sk=
ipped thus
> > > > > > > ima=3Doff is necessary (ima_appraise=3Doff won't serve the pu=
rpose). Or do
> > > > > > > you have any specific concerns in mind?
> > > > > >=20
> > > > > > I think as Mimi said see below logic enforces the IMA even with=
 the
> > > > > > cmdline disabling, see ima_appraise_parse_cmdline:
> > > > > > if (sb_state) {
> > > > > >                 if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
> > > > > >                         pr_info("Secure boot enabled: ignoring
> > > > > > ima_appraise=3D%s option",
> > > > > >                                 str);
> > > > > >         } else {
> > > > > >                 ima_appraise =3D appraisal_state;
> > > > > >         }
> > > >=20
> > > > Thanks for pointing me to the above code! Note with the whole IMA
> > > > disabled as done by this patch, the above code will not run so IMA
> > > > (appraisal) won't be enforced.
> > > >=20
> > > > >=20
> > > > > Thanks, RuiRui.
> > > > >=20
> > > >=20
> > > > Mimi, so do I understand it correctly that your want IMA-appraisal =
to be
> > > > always enabled as long as secure boot is enabled even if users choo=
se to
> > > > disable IMA?=C2=A0
> >=20
> > Secure boot is not the only reason.  Based on policy IMA-appraisal and =
EVM
> > calculate and store file hashes and HMAC's in their respective security=
 xattrs.
> > Normally the usage of file hashes and HMAC's is limited to mutable file=
s.=20
> > Disabling IMA-appraisal could result in not properly updating the secur=
ity
> > xattrs, which would result in not being able to verify the file's integ=
rity on
> > reboot.
> >=20
> > On systems where the RPM includes file signatures, file signatures of i=
mmutable
> > files can be safely restored.  Although it is possible to walk the file=
system(s)
> > "fixing" the xattrs of mutable files, it defeats the purpose.  "fix" mo=
de should
> > only be enabled in a trusted environment.
> >=20
> > > > I wonder what security issue will it bring if this promise
> > > > gets broken considering other LSMs can SELinux can be disabled when
> > > > secure boot is enabled?
> >=20
> > The builtin IMA policy rules are not defined in terms of SELinux labels=
.  If the
> > initial IMA custom policy defines rules based on SELinux labels and SEL=
inux is
> > not enabled, the policy will fail to be loaded.
> >=20
> > > > > Coiby, would disabling just IMA-measurement, as opposed to IMA-ap=
praisal, save
> > > > > sufficient memory for kdump?
> > > >=20
> > > > For disabling just IMA-measurement, do you mean not enabling any me=
asure
> > > > rules?  The more memory reserved for the kdump kernel, the less mem=
ory
> > > > can be used by the 1st kernel. So from the perfective of kdump, we =
try
> > > > to make the memory footprint as smaller as possible.
> >=20
> > Got it.
> >=20
> > > > Baoquan, do you have any statistics about the memory overhead of IM=
A?
> > >=20
> > > I am getting a system to check that. I think there are two aspects of
> > > IMA functionality we want to disable. One is disable the IMA-measurem=
ent
> > > copying from 1st kernel to 2nd kernel, this is only needed by kexec
> > > reboot; the other is IMA is not needed at all in kdump kernel, means =
we
> > > don't want to call ima_init() to initialize
> > > ima_keyring/crypto/template/digests/fs etc.=20
> > >=20
> > > With my shallow knowledge about IMA, I don't know how to imitate
> > > appraisal cmdline to disable IMA partially in kdump kernel case.
>=20
> Thanks for detailed explanations. Just back from holiday, sorry for late
> reply.
>=20
> >=20
> > The IMA policy controls how much or how little IMA measures and apprais=
es.  Most
> > of the memory usage is the IMA measurement list, itself, and the per fi=
le cache
> > info.  (The per file cache info limits re-measuring or re-appraising fi=
les.)
>=20
> In Steve Chen's kexec supporting ima patchset, kdump kernel loading
> should skip ima_kexec buffers allocating and storing via checking if
> (image->type =3D=3D KEXEC_TYPE_CRASH).
> >=20
> > Similarly my knowledge of kdump is very limited.  Is there a way for th=
e kernel
> > to differentiate between kexec and kdump?  If we need a mechanism to di=
sable
> > IMA-measurement, I'd *really* prefer it be limited to kdump.
>=20
> Yes, function is_kdump_kernel() is provided for checking if the current
> kernel is in kdump kernel.
>=20
> As said in earlier reply, for kdump kernel, there are two things we
> should do:
> 1) when loading 2nd kernel to prepare for switching, we should not
> allocate buffer and store IMA measurement list;
> 2) when switched into kdump kernel, we should not call ima_init() to do
> kinds of init which is useless.
>=20
> My personnal opinion.

Thanks for pointing out the KEXEC_TYPE_CRASH check and is_kdump_kernel().  =
Both
changes sound reasonable.

Mimi


