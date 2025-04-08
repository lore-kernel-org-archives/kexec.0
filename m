Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7524DC369A2
	for <kexec@archiver.kernel.org>; Tue,  8 Apr 2025 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GJgoecyAtEFkNbhaljeXNLdB75CNdGBhYrBniuFPltE=; b=GInUsYycpjcWNlGjPUmXnL2Vdz
	RXot+Kt6qkZI7oQChlQLBEtrmGoHhlY+mGlEvkRhaDy2Fn5YDDa38hIHsCtnPogbsSrj4W2QGxoEy
	diZpFIZKQtH+hkshkgtL9QYy5MSUj4WbgJGQ1HWP3pQ7lV7/zRMSb2pH7xw6INcL8lLsa5H4FNbH7
	aZFKDcZlqpA6pSo8WzMJ4C7gTzZuRGXlWcS51/ShCwXSKo+C/NNqO0+UboHbz3NwCu5cxUgmeuIgc
	Sk2roW2/PHw+DujQcN4J8JqZAOkWu57sTL8lVM83TDKSSUmxXGRPIu0mnWgpfulnluvCSH/sSLtZq
	tEBx1BRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2BrY-00000004p39-0ikJ;
	Tue, 08 Apr 2025 16:31:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2BrV-00000004p2e-1A9O
	for kexec@lists.infradead.org;
	Tue, 08 Apr 2025 16:31:46 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538G0D94029154;
	Tue, 8 Apr 2025 16:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GJgoec
	yAtEFkNbhaljeXNLdB75CNdGBhYrBniuFPltE=; b=Np9ga4LxZRMtXQiirqQTTx
	fF0RFDPSIbcrUht5WUHcfUOYB78uTPLeVUIQOTCh/BsDnTSjgsDKvyy1I+bRUwLF
	abnw32nwq/85xV4d3xrLxjJ0UlO+qxzl70vSvQfi/KOfNwz3BsXt2E6oYpDf+WVg
	uZwRxp9zPqjA5ku0btysHRS5DqbSRBbpqjfOlIK1fUSTekpIRsMr1n0L9Z/JhLaL
	kS+t0lHm+czkZCJAVdU3ANonBJG532ZrGm1nYt0ZA9l2+oDnbaeH+htgJr7N/d+N
	KzbR/c8LhXtR37t4aJyofcS+j0b36WLAjhgZhFXevfrHagQcdhMUpZKKNUTYPbrA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vnx0mqwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 16:31:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538CxRUr025525;
	Tue, 8 Apr 2025 16:31:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbkuf3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 16:31:24 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 538GVOp032703192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 16:31:24 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 009AF58065;
	Tue,  8 Apr 2025 16:31:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7B4158062;
	Tue,  8 Apr 2025 16:31:22 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.48.163])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 16:31:22 +0000 (GMT)
Message-ID: <59ba139f5454f00cd25e3b802780a5cae0e51978.camel@linux.ibm.com>
Subject: Re: [PATCH v11 9/9] ima: measure kexec load and exec events as
 critical data
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
Date: Tue, 08 Apr 2025 12:31:22 -0400
In-Reply-To: <20250402124725.5601-10-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-10-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M9Xvki70YhfvYI4U2on_ZEHiHQP19y1O
X-Proofpoint-ORIG-GUID: M9Xvki70YhfvYI4U2on_ZEHiHQP19y1O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_07,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_093145_459879_6F4B3A5B 
X-CRM114-Status: GOOD (  16.94  )
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
> The amount of memory allocated at kexec load, even with the extra memory
> allocated, might not be large enough for the entire measurement list.  Th=
e
> indeterminate interval between kexec 'load' and 'execute' could exacerbat=
e
> this problem.
>=20
> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be=20
> measured as critical data at kexec 'load' and 'execute' respectively.
> Report the allocated kexec segment size, IMA binary log size and the
> runtime measurements count as part of those events.
>=20
> These events, and the values reported through them, serve as markers in
> the IMA log to verify the IMA events are captured during kexec soft
> reboot.  The presence of a 'kexec_load' event in between the last two
> 'boot_aggregate' events in the IMA log implies this is a kexec soft
> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
> after kexec soft reboot implies missing events in that window which
> results in inconsistency with TPM PCR quotes, necessitating a cold boot
> for a successful remote attestation.
>=20
> These critical data events are displayed as hex encoded ascii in the
> ascii_runtime_measurement_list.  Verifying the critical data hash require=
s=20
> calculating the hash of the decoded ascii string. =20
>=20
> For example, to verify the 'kexec_load' data hash:
>=20
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements=
=20
> > grep  kexec_load | cut -d' ' -f 6 | xxd -r -p | sha256sum
>=20
>=20
> To verify the 'kexec_execute' data hash:
>=20
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements=
=20
> > grep kexec_execute | cut -d' ' -f 6 | xxd -r -p | sha256sum
>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Steven.=20

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


