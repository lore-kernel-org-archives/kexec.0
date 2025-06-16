Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E72C71136
	for <kexec@archiver.kernel.org>; Mon, 16 Jun 2025 15:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HQibybfKSneV6BzjwRy5a7vJvWS9T25Q9V9pcFnb8JI=; b=htxgkVcFkDhy/iH2mPyNqJSJc2
	MsBCmZ8hnqQFLiyJmJg4BZxHrLz9dUCLa6ZGhGF0JnydMH726CMi7p5n5T4ZfH585+Iv6KM9bBi9U
	KHmmB/BLl/WGdfcKHHoGV3odpf4Fa/NZMADrRG/KI3u9YOVrqQpBXh7Hs9jj7DUoAZY74GZptkQap
	u6JfRbk2PuXDVOsZ6F/ALRY3i/XZ8pUHTDKqpK89kXpC7+CZyXSoALglTUCmZyvcu65lMDloVuNyc
	Xqn6igNG8wu9K4FF10YWWxIUMNVP29gsKXM1BhPcmBoJoMrsCLerc/RXz3QbuVyqE75kOPINAaGYh
	ybvSmgkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRBkY-00000004raE-0gKP;
	Mon, 16 Jun 2025 15:27:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRAS8-00000004duA-0jYo
	for kexec@lists.infradead.org;
	Mon, 16 Jun 2025 14:04:49 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GCxxVj023219;
	Mon, 16 Jun 2025 14:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HQibyb
	fKSneV6BzjwRy5a7vJvWS9T25Q9V9pcFnb8JI=; b=B1FPs9WdtatEvkmZol40Uw
	r2yBnZtJG1a9frb0wITebzNTsP8J7WN6Pwrp/cbdwghlO2SWJ7r02oiLl4dx8ZnO
	IWlGD1CoX2UNm++HgWz2b30aKMUXuJg5WFjqTPZ7szcx2XfJN09QllmvuBCxQXbj
	yIDIgz4gmdx5rqIt3Gh8zPP24pZcUESj5v+pOGU+nbYINRnzGZSSJV0YzboDvrTh
	Y6mAcx6o/j3AWNhFT4utjbHtyiWkgPAa0aIRN5tYUacJab8LXHwAzGmbBZqciq7Y
	1GieBDmIXakPPSfndwb/LSG6BbpeZ/oH1x9K8vRWGd5LYwI5yiCAs+PIg45FlbQw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qp18bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 14:04:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GCqr2v000762;
	Mon, 16 Jun 2025 14:04:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdnxdnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 14:04:42 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GE4gjh9962090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 14:04:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B7B058052;
	Mon, 16 Jun 2025 14:04:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9E5F5805E;
	Mon, 16 Jun 2025 14:04:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.78.137])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Jun 2025 14:04:41 +0000 (GMT)
Message-ID: <ca82fa443365217535aedacbcdf823370f387995.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ima: add a knob ima= to allow disabling IMA in
 kdump kernel
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, coxu@redhat.com, piliu@redhat.com,
        pmenzel@molgen.mpg.de, chenste@linux.microsoft.com,
        kexec@lists.infradead.org
In-Reply-To: <20250614022342.5988-1-bhe@redhat.com>
References: <20250614022342.5988-1-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jun 2025 10:04:41 -0400
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PFv6YYeTGdevxX5fjR_ZZeAOtqjB4hxU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA4NyBTYWx0ZWRfX824tsbTXqqpz GTEhThlZznVglfKIadaABCoEWarASEQR9plzOS7pc5VI0Ag7sPkW96uaRGbIq20P0UDmUe7lzCD +2jpc243sL1W3/1dJSCbqZhSkAwf/DHpM8y8Fehiy+tgen/yN716NvdYmjJ47/Y99pFJ+VuxgDc
 C1Ph5REP7TJ/SlEYuvdJqLM8pWCFEjm5JOb1jKIlQRhVkyl7X2BMOpVwdx4CQ0JqRobhlZfZ+/d YdZdMpm92tU2qXc2HusX2juD8WdtBBVkur1PvZBYHvYSb8f0c9uE30OvARPHfQks4rJvc9p2oGt rM94am+MMyyH7FcyYn6ENKdRLxBYmwbsxNFRPvTsp6LZ1gwbWcDf2GCuHHRujcE8FgV9MhxCN7D
 h9i45eHc2vNuvdtihKGGhgs6JCXVMHgBHAuKVVjOkbbaIYWes2vMvTaYfeCG1ZEF3wM/w+6a
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=6850247b cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=20KFwNOVAAAA:8 a=-XTtKo6BakjCtqxwOl0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PFv6YYeTGdevxX5fjR_ZZeAOtqjB4hxU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=630 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_070448_335221_910E368B 
X-CRM114-Status: GOOD (  14.06  )
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

On Sat, 2025-06-14 at 10:23 +0800, Baoquan He wrote:
> Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
> extra memory. It would be very helpful to allow IMA to be disabled for
> kdump kernel.
>=20
> Hence add a knob ima=3Don|off here to allow turning IMA off in kdump
> kernel if needed.
>=20
> Note that this IMA disabling is limited to kdump kernel, please don't
> abuse it in other kernel and thus serious consequences are caused.
>=20
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v2->v3:
> - Remove rdundant word 'only' and rephrase sentences in patch log code
>   comment, and rephrase patch subject, thanks to Mimi's comments.

Thanks, Baoquan.  The patch is now queued.

Mimi



