Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDEFC28B20
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=06kw1eMIDDl0MRtbNBE5nxWWbtdvnEuIc/qfM/H/N84=; b=sPysGyf3F7pa7zDlX55Y1q9ux4
	LeALdVYDkfGNy0w0XED7uipqhg67fFBSWLsNWA7kd/Vw6ScLnRvh7p7edPMimku5wyyUA5ltB6iiI
	WIxnx01uUyji9NFL9LRNGObP7RZs+/CKkR+Z94uN9IDxuQZLXwyDamOTlGwkcUWCh3KdmneZXMf17
	gNY242pLBZMWzvir+Vzmn+RLZWCahYz8OicHDApFxgA6+HelMAXxdpYAFhawY7Xk9RNjEq3itlqxP
	/FotMoXxi+OIy0fcGVQqMk3RfVhL2+ctJ1/DtODMbfJ434+rdCBPaAUqD76IqrAHuV2ok2lxtO+lm
	rVgnp+yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzwDh-00000005tiO-1SK7;
	Wed, 02 Apr 2025 11:25:21 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzwDf-00000005thN-0aa9
	for kexec@lists.infradead.org;
	Wed, 02 Apr 2025 11:25:20 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532AOXt6010837;
	Wed, 2 Apr 2025 11:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=06kw1e
	MIDDl0MRtbNBE5nxWWbtdvnEuIc/qfM/H/N84=; b=iePZZQpMwmzbJfQxXmhMj/
	ykVWhH0yc7k2J8p5hM674v3zlg5Gb5oXs30NY32IIFglS/uA6EoON5XNMuFBt0/p
	bJNhRFfc+wApwBNJqelryELSzxO7jb8pbpPhziUANO4KdIy9TVZnG8eno3JE8Txx
	2/J7a0t+Y5sla44qyJt76cmC72+1Swfu41uQ7gHAQ6/lkYzVBfE6hyPVOabEEab7
	YC6j7jFyOC3KXqSp0enGUEXV79QxS2e40OBzzQOyP6H5/Jl25BHg5OSwcqIj5qdt
	ssFBRu6uc/vPvhYAuRyimhWK+BaQrBIRSCh1zMkfKi5yq19Hpefz9kAucAg5IKIw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rqaqkrh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 11:25:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53280oYm005213;
	Wed, 2 Apr 2025 11:25:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pujyysyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 11:25:16 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 532BPFHO18088500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 11:25:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA64E58062;
	Wed,  2 Apr 2025 11:25:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B85D5805A;
	Wed,  2 Apr 2025 11:25:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.92.168])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Apr 2025 11:25:15 +0000 (GMT)
Message-ID: <2c53cffcae9b05783dbb6c95d3f1255e2757d596.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, RuiRui Yang <ruyang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Date: Wed, 02 Apr 2025 07:25:14 -0400
In-Reply-To: <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
References: <20250331061611.253919-1-bhe@redhat.com>
	 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
	 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
	 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
	 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
	 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bvmoR57YSN-eF64F_s6CjoEOueApDG8N
X-Proofpoint-ORIG-GUID: bvmoR57YSN-eF64F_s6CjoEOueApDG8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_04,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=617
 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_042519_304229_939476CF 
X-CRM114-Status: GOOD (  11.42  )
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

On Wed, 2025-04-02 at 16:43 +0800, Coiby Xu wrote:
> > Coiby, would disabling just IMA-measurement, as opposed to IMA-appraisa=
l, save
> > sufficient memory for kdump?
>=20
> For disabling just IMA-measurement, do you mean not enabling any measure
> rules?=C2=A0 The more memory reserved for the kdump kernel, the less memo=
ry
> can be used by the 1st kernel. So from the perfective of kdump, we try
> to make the memory footprint as smaller as possible.

Yes, not enabling any "measure" rules and not restoring the kexec measureme=
nt
list.

