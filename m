Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04AFC021A0
	for <kexec@archiver.kernel.org>; Wed, 12 Feb 2025 13:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=krHBiN5fDn9iL+VMLKCmrS+HPrhLWm4BXzABiQLQpLw=; b=TfHpVNXs23zhygdAwd3+P2ht46
	ldp/VqN5snsP2u60YEiIVA4SWdqHr4/u1jQWsB8Qi8W5H5AQkDrdWJlKqkm8DXV0s+RW4omtGjz6S
	bOSIKNth6+TUsQXMPCnYeNUw9102ZdryWDb/dqFiHDdf55tvlbMazFNdzAZXvEhCBkJNAnikxhpyM
	zkIhDLHLxs+YEYO1ChgLUYqjKZeXxCuUS1+XKcAlQCn4gXOWoM9bihWzrgfPkUu75xXFc8CY6+3Pl
	sXldlpELD79aXSwmxdVADDivbyMGpduW8RywMAgrVhd/rduZEU/RuNHWMgEVcBYDgmwphjMcS5t8e
	mRXmGUjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiCP1-00000007R8Z-29B9;
	Wed, 12 Feb 2025 13:03:43 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiCOz-00000007R7i-0lht
	for kexec@lists.infradead.org;
	Wed, 12 Feb 2025 13:03:42 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CAxSbX013670;
	Wed, 12 Feb 2025 13:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=krHBiN
	5fDn9iL+VMLKCmrS+HPrhLWm4BXzABiQLQpLw=; b=JexrGaX++PInzP3zdCZjD3
	KbkFtDaJsk3RVitxji+enBcU3Rt1JPEFclfW7tGURxY+sQK4uiv8/rP6fE5udfuD
	etkhmGGIaCJmOgGPosuxlqotL8lgDmvzh/6e1qiXkRNnWvh9MCwprerHMA+q/cYm
	apU79lmHhkus3D6Eb0vJ36I3RFGcwhZgJdnv7k1gj0sK3smFjjBkRx9wRdd7Bpe0
	1eE2bSH+LxoDCH1q9U0sVX5bsqtWam7aTMCLgCMC9+gJiT04UioUvfWgM+/XoihA
	0ivcaVGGv9ZM8kEXCy/Vnkjlyx+VsMe0pyMV+guTWlvFM6u0u7jpgsJtZmADWCVA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rjfytvs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:03:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CCZBb4028197;
	Wed, 12 Feb 2025 13:03:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyygsnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:03:19 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51CD3JrI27132602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 13:03:19 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1505958077;
	Wed, 12 Feb 2025 13:03:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A32E25806F;
	Wed, 12 Feb 2025 13:03:17 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.88])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Feb 2025 13:03:17 +0000 (GMT)
Message-ID: <b7dd78f21a9fa9dc3b6f90eae2668cfe5c7670c7.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/7] kexec: define functions to map and unmap segments
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
Date: Wed, 12 Feb 2025 08:03:17 -0500
In-Reply-To: <47565966-c735-4758-80a5-523fd93adc72@linux.microsoft.com>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
	 <20250203232033.64123-3-chenste@linux.microsoft.com>
	 <6fd5510827a2ebb91aee8c72432e248e967fa5be.camel@linux.ibm.com>
	 <47565966-c735-4758-80a5-523fd93adc72@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wb7pe2c-W48JJx9ojXknjIakieQe4wt2
X-Proofpoint-ORIG-GUID: Wb7pe2c-W48JJx9ojXknjIakieQe4wt2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_050341_340511_8716D0E0 
X-CRM114-Status: GOOD (  21.72  )
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

On Mon, 2025-02-10 at 09:06 -0800, steven chen wrote:
> On 2/7/2025 11:15 AM, Mimi Zohar wrote:
> > Hi Steven,
> >=20
> > On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
> > > Currently, the mechanism to map and unmap segments to the kimage
> > > structure is not available to the subsystems outside of kexec.=C2=A0 =
This
> > > functionality is needed when IMA is allocating the memory segments
> > > during kexec 'load' operation.=C2=A0 Implement functions to map and u=
nmap
> > > segments to kimage.
> > >=20
> > > Implement kimage_map_segment() to enable mapping of IMA buffer source
> > > pages to the kimage structure post kexec 'load'.=C2=A0 This function,
> > > accepting a kimage pointer, an address, and a size, will gather the
> > > source pages within the specified address range, create an array of p=
age
> > > pointers, and map these to a contiguous virtual address range.=C2=A0 =
The
> > > function returns the start of this range if successful, or NULL if
> > > unsuccessful.
> > >=20
> > > Implement kimage_unmap_segment() for unmapping segments
> > > using vunmap().
> > >=20
> > > From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > I don't recall previously adding my "Reviewed-by" tag.
> >=20
> > Eric, I'd appreciate your reviewing this and the subsequent patch "[PAT=
CH v7 3/7]
> > ima: kexec: skip IMA segment validation after kexec soft reboot" in par=
ticular.
> Hi Eric, Could you help to review this patch as Mimi mentioned? Thanks!
> >=20
> > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Steven, since these patches impact kdump, before re-posting the patch set, =
please
include the following tags before your Signed-off-by tag on the kexec patch=
es.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>                                            =
=20
Cc: Vivek Goyal <vgoyal@redhat.com>                                        =
=20
Cc: Dave Young <dyoung@redhat.com>  =20

> > > Signed-off-by: steven chen <chenste@linux.microsoft.com>

thanks,

Mimi



