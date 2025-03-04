Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62ECC282D2
	for <kexec@archiver.kernel.org>; Tue,  4 Mar 2025 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+IoJ+2H9c2CFdb09znTxlwvThy3kn7nz7db1xHQkKkM=; b=RTjpqircmoCd35UFdooEqtLs/g
	XGVBePARk/Hteu7lcEakIAIf4+67pM8jmludQV5KtGT2kO8Vx1SA4oPC/5oNAYOj6AbOz5fi8Mfu4
	i0AXJR8XVAap6BWDV5ahY9knrYTEd7TGPRCbmFp1CFq2uj5qLon2Ir0TT+Ps41hg7XDmNDW1jQEbx
	ava6i/QPb/y0i/Pxh9bzwLd3u3JlU08g1v8biqU8gB3dM/9RKErXibo27/q3+DM3JGmejK2ahcRwb
	uLh22Y1Dif0w7FzMI4LXIxPo8N/cAXigjhql1STOJ/Go5VMffXLqisR+kNJUjJBYaYczEF2Nbu3RH
	NcgpkQkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpWPL-00000005iEh-3PnY;
	Tue, 04 Mar 2025 17:50:19 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpUvf-00000005Nvn-1IvP
	for kexec@lists.infradead.org;
	Tue, 04 Mar 2025 16:15:37 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524E3Ku9019009;
	Tue, 4 Mar 2025 16:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+IoJ+2
	H9c2CFdb09znTxlwvThy3kn7nz7db1xHQkKkM=; b=enFC4w7iAxa7xBJJ50nn5r
	YHwcsrqCj91bKzXNDMt/lK3Da6qrxKeOdyw55vTS+5tSRh/LCW7VTHne1QB6PDCH
	E04yAMBr5R0IT1MIh+lsBn12jaenqDXOL0kCAMHHp2uTEbSNtevMf7+6e0dWDjb3
	0lY9UYLFpaVgOmnxytJ40rCGXSXuXH4TBYq/l7WJhu8JIKDqVnSBaTqC7YQ2TDxY
	0QahawjYm0acYxmOxim50YEc2M6BG6sI/rWcct/6OOuBbSKYvlDUKuuZPlrWfyX+
	nVpHiXi756zfn953xIufU7xfTR8gGUa/HI/Lm5pZABYEOnqa+UXBjLdlMmRhLMTg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4562xpgp2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 16:15:18 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 524GFI8F012989;
	Tue, 4 Mar 2025 16:15:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4562xpgp2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 16:15:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524Fxqlx013776;
	Tue, 4 Mar 2025 16:15:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kp52f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 16:15:16 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524GFGpZ53936398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 16:15:16 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4700E58060;
	Tue,  4 Mar 2025 16:15:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A27758050;
	Tue,  4 Mar 2025 16:15:14 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.136.132])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 16:15:14 +0000 (GMT)
Message-ID: <6828fbeeff42ce962cc0195466760ea136f9c049.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
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
        dyoung@redhat.com, Mike Rapoport
 <mike.rapoport@gmail.com>
Date: Tue, 04 Mar 2025 11:15:13 -0500
In-Reply-To: <Z8FDlp8QvnSR58Vd@MiWiFi-R3L-srv>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-3-chenste@linux.microsoft.com>
	 <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
	 <55acf768b52b47dd9d33fa0486772d8c7ae38779.camel@linux.ibm.com>
	 <Z8FDlp8QvnSR58Vd@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -oBsvbmbJu1H4kuwA-IK6n9CtSiRlunB
X-Proofpoint-GUID: _0Rk9JlUBxHxaloj8zlUADdSvGWN6oiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503040129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_081535_375641_8D36D23C 
X-CRM114-Status: GOOD (  30.71  )
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

On Fri, 2025-02-28 at 13:03 +0800, Baoquan He wrote:
> On 02/27/25 at 10:41am, Mimi Zohar wrote:
> > [Cc'ing Mike Rapoport]
> >=20
> > On Mon, 2025-02-24 at 14:14 +0800, Baoquan He wrote:
> > > Hi Steve, Mimi,
> > >=20
> > > On 02/18/25 at 02:54pm, steven chen wrote:
> > > > Currently, the mechanism to map and unmap segments to the kimage
> > > > structure is not available to the subsystems outside of kexec.  Thi=
s
> > > > functionality is needed when IMA is allocating the memory segments
> > > > during kexec 'load' operation.  Implement functions to map and unma=
p
> > > > segments to kimage.
> > >=20
> > > I am done with the whole patchset understanding. My concern is if thi=
s
> > > TPM PCRs content can be carried over through newly introduced KHO. I =
can
> > > see that these patchset doesn't introduce too much new code changes,
> > > while if many conponents need do this, kexec reboot will be patched a=
ll
> > > over its body and become ugly and hard to maintain.
> > >=20
> > > Please check Mike Rapoport's v4 patchset to see if IMA can register
> > > itself to KHO and do somthing during 2nd kernel init to restore those
> > > TPM PCRs content to make sure all measurement logs are read correctly=
.
> > > [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
> >=20
> > Hi Baoquan,
> >=20
> > I was hoping to look at Mike's patch set before responding, but perhaps=
 it is
> > better to respond earlier rather than later with my initial thoughts.
> >=20
> > The IMA measurement list isn't stored in contiguous memory, but has to =
be
> > marshalled before being carried across kexec, and then unmarshalled to =
restore
> > it after the kexec.  Roberto Sassu has been thinking about changing how=
 the IMA
> > measurement list is stored so marshalling/unmarshalling wouldn't be nec=
essary.=20
> > Making both this change and using KHO going forward would be a good ide=
a.
> >=20
> > However, that sort of change wouldn't be appropriate to backport.  So t=
he
> > question comes down to whether being unable to attest the measurement l=
ist,
> > because the measurements are copied too early at kexec load, but the TP=
M is
> > being extended through kexec exec, is considered a bug.  If that is the=
 case,
> > then I suggest finish cleaning up and upstreaming this patch set so tha=
t it
> > could be backported.
>=20
> Ah, I understand your concern. There are stable kernels or distros
> kernels which need be taken care of. If then, we can continue to work on
> polishing this patchset, as you have pointed out, there are still room
> in this patchset to improve before merging.

Thanks, Baoquan!

I've already provided feedback on the IMA related patches.  Hopefully that =
will
be it.

Mimi



