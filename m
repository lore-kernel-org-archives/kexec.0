Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356B6C3600C
	for <kexec@archiver.kernel.org>; Tue,  8 Apr 2025 04:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJywaqrnmlK5U5SI9yto+vFRj86TY6JyAJ3Ep7jYLJ4=; b=03IzwEQRXt5n2mGzcG2Nh5034T
	CBt4sF9mRQsOZHtdJ5LXNOFys/KbTcXBvAbr57kmTrNirziNCRKELOGhSu9J2Rv39clJHms9tnGXs
	A4/I6L6X2dl19mRDujyjH3twGY133Y1NBNVr8Dq4RQ2Cok8oXsf5Tj0YQ3KtHHLP9Jr0qXma5xOa4
	LmGhSA9mLTP3ifiE7pksvODHvWtZ+7EBnZZETaSR6iQtUq2ucf6XNXraLt5p7IvOqv6lEW3oE5uQj
	lwExTd58g1iYr2Ff+1y4pC+//vLzK+BvkO2hKHEdyhJhIGfjhyXu6XIQA55+4J99bc2SGC+46BIHq
	DP8OhJEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20ig-00000002hhG-2ybB;
	Tue, 08 Apr 2025 04:37:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20ie-00000002hg1-105R
	for kexec@lists.infradead.org;
	Tue, 08 Apr 2025 04:37:53 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537MAIsc000417;
	Tue, 8 Apr 2025 04:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jJywaq
	rnmlK5U5SI9yto+vFRj86TY6JyAJ3Ep7jYLJ4=; b=o360SZ94vhQ3my70zmepWJ
	QmjXcFQ2mCm4GoSJFKEL/yayUdn02lrloiJi3eM+IcqcueGHz/liv4r2jGN2TGNs
	zth7LPvFYgamRnKev9mTgpSoBtQXblE7raBV9aq1W91RmHqEbeoty16NZ9VUl1sx
	APzKq9SN9+ZpuABcEu+N/Rk8f7gnDD8vpeIJYC4Gedbnk76NJBPbRdhSHFgNVkFL
	okOGxT9Q642l0eztsidi+mOdrCmHIA0QH7204IRXm/T1kcaAbymBzLPSNf/2K66I
	ZNOW1d+w27Dioiy4WfYdLKKWRUUPg1wNlFYO/J6nJLiGHZTNXmy7359tt9bVVr2w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ver7c3qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 04:37:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53845sJ8017457;
	Tue, 8 Apr 2025 04:37:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kgumy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 04:37:32 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5384bV7L20775588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 04:37:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64F2358059;
	Tue,  8 Apr 2025 04:37:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82F5C58058;
	Tue,  8 Apr 2025 04:37:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.146.87])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 04:37:29 +0000 (GMT)
Message-ID: <9d1af6223f17ec0d99635bac7ca208226e5eb8d2.camel@linux.ibm.com>
Subject: Re: [PATCH v11 1/9] ima: rename variable the set_file "file" to
 "ima_kexec_file"
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
Date: Tue, 08 Apr 2025 00:37:29 -0400
In-Reply-To: <20250402124725.5601-2-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-2-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZfBJAJSs4vOr0HlDsxMARqpGUmja_62D
X-Proofpoint-GUID: ZfBJAJSs4vOr0HlDsxMARqpGUmja_62D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 adultscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_213752_284517_B7F6EA04 
X-CRM114-Status: GOOD (  15.63  )
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

Please fix the Subject line: change set_file -> seq_file

On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
> The current kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'. IMA log is then carried
> over to the new kernel after kexec 'execute'. However, the time gap
> between kexec load and kexec reboot can be very long. During this
> time window, new events extended into TPM PCRs miss the chance
> to be carried over to the second kernel.
> =20
> To address the above, the following approach is proposed:
>   - Allocate the necessary buffer during the kexec load phase.
>   - Populate this buffer with the IMA measurements during
>     the kexec execute phase.
>=20
> In the current implementation, a local variable "file" of type seq_file
> is used in the API ima_dump_measurement_list() to store the IMA measureme=
nts
> to be carried over across kexec system call. To make this buffer accessib=
le
> at kexec 'execute' time, rename it to "ima_kexec_file" before making it
> a file variable to better reflect its purpose.

Only the reason for the variable name change is needed.  Please remove
everything else.

>=20
> Renaming the local variable "file" of type seq_file defined in the=20
> ima_dump_measurement_list function to "ima_kexec_file" will improve code
> readability and maintainability by making the variable's role more explic=
it.

As previously mentioned, there is a difference when naming local and file s=
tatic
global variables. Variable naming is described
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#naming

-> Before making the local ima_dump_measurement_list() seq_file "file" vari=
able
file static global, rename it to ima_kexec_file.

thanks,

Mimi


