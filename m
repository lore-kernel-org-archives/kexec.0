Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B58C369C2
	for <kexec@archiver.kernel.org>; Wed, 23 Apr 2025 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zP0LfZGpwbqZDJ21fCd0eUwqSuBp9uFaHTWiXcNrQqM=; b=JwzSig+Cr/c6q1s1X1acey24uf
	QhyT0hSN3Ce3eed5gVeczAOE5EIqmayBQv5K4v0Fy8DYaIwgC3HYMW7p9dbiIyDexxFi8UU4PZBdu
	JQ4L5TTTADdecNjUSSgaqt7cPmLndJfmE+PJQDg06fvYfhjyeJZWcHDkUdrsk/L5wNOwSFISGGYQB
	Dgc/4zIC14PxpdNcIhjNbg4xEcsQ6LW18lxEVmxKSCN+ZiEyLQATYMF9a+NP8arvgA8G3u0feXxWc
	sWZN9ni3QV41ZLB09hkyMq05MxAF8HOn6pskYMLJyhheOA7EaFfoCNVNPfPoZiS5u0fvQnJc30tRM
	RKod6Brg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7O0F-00000008tPI-3uJ5;
	Wed, 23 Apr 2025 00:30:15 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7O0A-00000008tO9-3msZ
	for kexec@lists.infradead.org;
	Wed, 23 Apr 2025 00:30:14 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MLgJ5K030812;
	Wed, 23 Apr 2025 00:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zP0LfZ
	GpwbqZDJ21fCd0eUwqSuBp9uFaHTWiXcNrQqM=; b=ZT4O+dDMHd1ZWfMwEdhBWE
	0vDM6AfI7jiC75PEg9d/FC5ygtCCLNFN9qKiDmmXhsCy78OhwUIIuQmSMvbTLeAv
	AbOu0U0KSYvBvVwwcOqJGTEpC1uG2dZWOeyEYRA67F6rIkjatqBEJ4vntPA1qI1/
	ItQlpknuYtGQxjPbMG568zdCPPjh5iboCeCRy7ZKxZDTrLGCFiq8S1NEfoqft6Qq
	/LF8LrU7A6+8V6poerR5YHMFh+AkNcaVNIR6G/5YInWzLu4NrwDTXyXrJj2GRjKv
	1kv8jQ2EU88zX5398hVsHXFF43alcf1rQDRz95dAZj3ibGFMB2HIayUKi+W+oCsQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466k8v0h97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 00:29:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53MKmw46022293;
	Wed, 23 Apr 2025 00:29:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfx8p1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 00:29:47 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53N0Tl3331785616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 00:29:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CC035803F;
	Wed, 23 Apr 2025 00:29:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44F2A58054;
	Wed, 23 Apr 2025 00:29:45 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.45.91])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 00:29:45 +0000 (GMT)
Message-ID: <f2f4a873489b28d3baa4ac1f6073a49fe888d120.camel@linux.ibm.com>
Subject: Re: [PATCH v13 3/9] kexec: define functions to map and unmap
 segments
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
Date: Tue, 22 Apr 2025 20:29:44 -0400
In-Reply-To: <20250421222516.9830-4-chenste@linux.microsoft.com>
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
	 <20250421222516.9830-4-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N-HPUPvuwLViIwRbrlcAKZKs3eZcNoLQ
X-Proofpoint-ORIG-GUID: N-HPUPvuwLViIwRbrlcAKZKs3eZcNoLQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIyMDE4MCBTYWx0ZWRfX3QGqsmNjo4PC rp7FroN/vz/OYr5qyk3DHKRYPgPxZlA4YmHnidgcnPxESyQnF0/pME8L/0Ca2YVdvWTQCGhtAgs OqFq1azKoM0k7Xoo56WqpQe5RLVljvvTgPR8mdBvPBiOHSoFNF29mvG3bE52HHYrVGmc0EQOPIM
 Q3Wi2G0zQRSJHKgySRS8t7rpJOA30Qm3n5/848hMD7YHso9NBwDGAEJ4+CjTEdcG+7WJst3Qzf7 FM45wkztP7bzJJWER/A/TsLakskZ5YNT9ubyyAbhcJorhBejGfbTi9qMg9fVfc8X762fHXoOeZK 5KMEfnzGWxEhEgG/okdBGZI6NVVY+gbwtWxhk039wVxo1q2Mao+980VqjztgI1ZBLrDJ2qEwrd0
 zsytEOj1VICqf11RAbyHu0HS307MzlVMWHaVIGCUDy4SLjHv2UA0hvW57G2xhrsRLUqksYf9
X-Authority-Analysis: v=2.4 cv=TcuWtQQh c=1 sm=1 tr=0 ts=6808347c cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=yMhMjlubAAAA:8 a=PtDNVHqPAAAA:8 a=20KFwNOVAAAA:8 a=yVc3JbiMAKBsHqyCaYgA:9
 a=QEXdDO2ut3YA:10 a=BpimnaHY1jUKGyF_4-AF:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_11,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504220180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_173011_069304_1998B517 
X-CRM114-Status: GOOD (  14.69  )
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

On Mon, 2025-04-21 at 15:25 -0700, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
>=20
> Implement kimage_map_segment() to enable IMA to map the measurement log=
=20
> list to the kimage structure during the kexec 'load' stage. This function
> gathers the source pages within the specified address range, and maps the=
m
> to a contiguous virtual address range.
>=20
> This is a preparation for later usage.
>=20
> Implement kimage_unmap_segment() for unmapping segments using vunmap().
>=20
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>=20
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>

Checkpatch.pl is complaining that the Signed-off-by tag does not matches th=
e
"From:" line only on this patch.  I've updated your Signed-off-by tag to ma=
tch
the "From:" line above.

> Acked-by: Baoquan He <bhe@redhat.com>

Missing from v13 is Stefan's Tested-by tag.  As the code hasn't changed, I'=
ve
added it.  In the future, please don't forget to add the tags.

Stefen Berger spent quite a bit of time reviewing this patch set, but with =
v13
most of his Reviewed-by tags are missing. Stefan?

For now the patch set is staged in the next-integrity-testing branch.

thanks,

Mimi

