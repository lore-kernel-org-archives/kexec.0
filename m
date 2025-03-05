Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA481C282DE
	for <kexec@archiver.kernel.org>; Wed,  5 Mar 2025 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Md/Snk5p9sNZnLIho40zGrrO+am14oZcFnJQ7JNna9U=; b=haxkKDa3niG/K0TzrhmZ+eH5eC
	kBpypQ69XA42TOAb6WJkb19cfC3kCkVS/sszBfCYsVTuTpJUR4AzuK0fQynnZIASjzQqEj3IDQUfo
	OXbPdfU7bc9zjSxo+aEMMUYRyzAFReTxjlVb664bzvbQqh3fHPTArEsAx7sIyVlZeYWbEEy/RDbdr
	W5ki2RIadWt49Vv9+nv2zRzeFF/+8BlJLlSfJHt3lrBeNqEKQqpYU137zhKzYNMHuIbGNmOdRiMRC
	O+hTxk+UQf0+iyit1XNFBRiOPH7EOvXXfgoRigzlhz0uuWHtrJ1QlVqy7W7lOkTb2lxYB62c8WWPP
	RMD/g3SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpqHf-00000008SRm-0H3i;
	Wed, 05 Mar 2025 15:03:43 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpnr4-000000081GS-3Uys
	for kexec@lists.infradead.org;
	Wed, 05 Mar 2025 12:28:08 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525A7vNi014667;
	Wed, 5 Mar 2025 12:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Md/Snk
	5p9sNZnLIho40zGrrO+am14oZcFnJQ7JNna9U=; b=WwfjqxBS/+97sKDxCVYFlL
	vMdNh4h4lVwyIbj5kKBtpjCNMeXhrk72pvbnqZ6OnMSybU+uXjWG8UJ6EsO7AmDs
	ksy1w6VrSbVTrj6r/xT89Nc8uFK/K6vxNDVmZJedYzS+SbgvK1KtFkkcIPxcFH/e
	E9kfoVCHVsiX31puZKqy2m/cAWRx+WD/DvJvAMdO2Zr6J1ybevE//5+yW7ho2FtP
	A53oQdYkFik29+vIhVBUTKzh491xvxwKQLdBC8pTEjJYzJnm9QRBEduDHVlW/lRW
	GcDlTvfXnsj/bb7jzOs6L6jcShZJ5eQfo+7cPwIhlT5Nz4FE86GsdVZ2KQIMztbA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568r0kfdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 12:27:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5258mWB6020800;
	Wed, 5 Mar 2025 12:27:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esk2e2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 12:27:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525CRhVQ33030860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 12:27:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 038685805F;
	Wed,  5 Mar 2025 12:27:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B05658053;
	Wed,  5 Mar 2025 12:27:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.124.31])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 12:27:41 +0000 (GMT)
Message-ID: <fe6e3c1333a50d66dc876b5a196d3491170802a8.camel@linux.ibm.com>
Subject: Re: [PATCH v9 1/7] ima: copy only complete measurement records
 across kexec
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, steven chen <chenste@linux.microsoft.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Wed, 05 Mar 2025 07:27:40 -0500
In-Reply-To: <Z8g+uhZQ6totYLmp@MiWiFi-R3L-srv>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
	 <20250304190351.96975-2-chenste@linux.microsoft.com>
	 <Z8g+uhZQ6totYLmp@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UwpSgXRFf13zE8n_AFST4KQ1dLsi0RaD
X-Proofpoint-ORIG-GUID: UwpSgXRFf13zE8n_AFST4KQ1dLsi0RaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_05,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050099
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_042807_019967_B4A0F186 
X-CRM114-Status: GOOD (  23.96  )
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

On Wed, 2025-03-05 at 20:08 +0800, Baoquan He wrote:
> On 03/04/25 at 11:03am, steven chen wrote:
> > Carrying the IMA measurement list across kexec requires allocating a
> > buffer and copying the measurement records.  Separate allocating the
> > buffer and copying the measurement records into separate functions in
> > order to allocate the buffer at kexec 'load' and copy the measurements
> > at kexec 'execute'.
> >=20
> > This patch includes the following changes:
>=20
> I don't know why one patch need include so many changes. From below log,
> it should be split into separate patches. It may not need to make one
> patch to reflect one change, we should at least split and wrap several
> kind of changes to ease patch understanding and reviewing. My personal
> opinion.

Agreed, well explained.

Mimi

>=20
> >  - Refactor ima_dump_measurement_list() to move the memory allocation
> >    to a separate function ima_alloc_kexec_file_buf() which allocates
> >    buffer of size 'kexec_segment_size' at kexec 'load'.
> >  - Make the local variable ima_kexec_file in ima_dump_measurement_list(=
)
> >    a local static to the file, so that it can be accessed from=20
> >    ima_alloc_kexec_file_buf(). Compare actual memory required to ensure=
=20
> >    there is enough memory for the entire measurement record.
> >  - Copy only complete measurement records.
> >  - Make necessary changes to the function ima_add_kexec_buffer() to cal=
l
> >    the above two functions.
> >  - Compared the memory size allocated with memory size of the entire=
=20
> >    measurement record. Copy only complete measurement records if there=
=20
> >    is enough memory. If there is not enough memory, it will not copy
> >    any IMA measurement records, and this situation will result in a=20
> >    failure of remote attestation.
> >=20
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>


