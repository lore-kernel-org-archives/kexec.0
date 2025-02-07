Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED39C02194
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 19:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dk2j0J+eS/QWj4FsL5BAgahZNwivPzCZXjf2EXIxrzs=; b=Oy27Jgcqp8Wf/xGfFxyUNIbgaX
	RVAox0PLMQ58bHIKkRGzm3A0OuFL9pE76Alf8gNL1AgfJXYrFJnWwp0cmvmTOqSWx9ru8VlBadITH
	F/NXkWabzMA9tpNpfD1zPLsd+dMrz73EQLGu0Plm5FR39xsq4RkvZBWiAHu4kRvB9lZy03+9jzSR9
	rNr0eixdudVSFgV4YSsxcwSAaLXCAbreV8iLzUOtGBEaavDDeYZHTOelQCSyj1Z8qsBKFxgazSuzQ
	PrInRoDavZ4D0L+am9mEeq7EAddpFYCeR2+GiKqv+Gaxf+W+cprTDd4D+57bwSMdyFlHmDSzrP0lZ
	HLTApolg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTpk-0000000AsDz-2FgL;
	Fri, 07 Feb 2025 19:16:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTpi-0000000AsDS-1EZi
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 19:16:11 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517I2j45004483;
	Fri, 7 Feb 2025 19:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dk2j0J
	+eS/QWj4FsL5BAgahZNwivPzCZXjf2EXIxrzs=; b=eR7+BPhZVgOzAXiIS5OmYj
	ZlWPEIdTzPk8eRYGaJrL17BPs+hks1X1jLVgHE9UFuXRXVXyxIQ2WOEwa2zJFal6
	/UWkkKwZ+NMT22B3Hckscitvgm2xLngIHKYWU2OtkEua5EoLy8K3lwatBJJOFNtr
	RA0NDglUeHNDUlVUeDcn5rJbQqhM6Pmc+g7o5c92rZlI/YzJMUloX6+8kUv6Jn0K
	5OPbNg/Brb44LNDndsRS/GWgEF6ydPpMlc5LIVMIW25tIU4rXsrvRnYcR8Sv4WEU
	1ZUV4+o9WEb+j16IwTeSfojxJLft7mVXe+CQbiKKD14Csc3bf8lNoZvJQQ9oM/9w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44nfn5jxdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 19:15:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517G0Dmp024492;
	Fri, 7 Feb 2025 19:15:56 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxnn2kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 19:15:56 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517JFtSx28770944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 19:15:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4DB75805C;
	Fri,  7 Feb 2025 19:15:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 303F65805F;
	Fri,  7 Feb 2025 19:15:54 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.80.253])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 19:15:54 +0000 (GMT)
Message-ID: <6fd5510827a2ebb91aee8c72432e248e967fa5be.camel@linux.ibm.com>
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
Date: Fri, 07 Feb 2025 14:15:53 -0500
In-Reply-To: <20250203232033.64123-3-chenste@linux.microsoft.com>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
	 <20250203232033.64123-3-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Pm6QXLq6tCgJjRp7sdIVpXMhMuihNR2
X-Proofpoint-GUID: 9Pm6QXLq6tCgJjRp7sdIVpXMhMuihNR2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070142
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_111610_340643_FDC0F236 
X-CRM114-Status: GOOD (  20.80  )
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

Hi Steven,

On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
> Currently, the mechanism to map and unmap segments to the kimage
> structure is not available to the subsystems outside of kexec.=C2=A0 This
> functionality is needed when IMA is allocating the memory segments
> during kexec 'load' operation.=C2=A0 Implement functions to map and unmap
> segments to kimage.
>=20
> Implement kimage_map_segment() to enable mapping of IMA buffer source
> pages to the kimage structure post kexec 'load'.=C2=A0 This function,
> accepting a kimage pointer, an address, and a size, will gather the
> source pages within the specified address range, create an array of page
> pointers, and map these to a contiguous virtual address range.=C2=A0 The
> function returns the start of this range if successful, or NULL if
> unsuccessful.
>=20
> Implement kimage_unmap_segment() for unmapping segments
> using vunmap().
>=20
> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

I don't recall previously adding my "Reviewed-by" tag.

Eric, I'd appreciate your reviewing this and the subsequent patch "[PATCH v=
7 3/7]
ima: kexec: skip IMA segment validation after kexec soft reboot" in particu=
lar.


> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
> =C2=A0include/linux/kexec.h |=C2=A0 7 ++++++
> =C2=A0kernel/kexec_core.c=C2=A0=C2=A0 | 54 ++++++++++++++++++++++++++++++=
+++++++++++++
> =C2=A02 files changed, 61 insertions(+)
>=20
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3..f8413ea5c8c8 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -467,6 +467,9 @@ extern bool kexec_file_dbg_print;
> =C2=A0#define kexec_dprintk(fmt, arg...) \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do { if (kexec_file_dbg_=
print) pr_info(fmt, ##arg); } while (0)
> =C2=A0
> +extern void *kimage_map_segment(struct kimage *image,
> +					unsigned long addr, unsigned long size);

scripts/Checkpatch.pl complains about the parenthesis alignment here and el=
sewhere.

Mimi

> +extern void kimage_unmap_segment(void *buffer);
> =C2=A0#else /* !CONFIG_KEXEC_CORE */
> =C2=A0struct pt_regs;
> =C2=A0struct task_struct;
> @@ -474,6 +477,10 @@ static inline void __crash_kexec(struct pt_regs *reg=
s) { }
> =C2=A0static inline void crash_kexec(struct pt_regs *regs) { }
> =C2=A0static inline int kexec_should_crash(struct task_struct *p) { retur=
n 0; }
> =C2=A0static inline int kexec_crash_loaded(void) { return 0; }
> +static inline void *kimage_map_segment(struct kimage *image,
> +					unsigned long addr, unsigned long size)
> +{ return NULL; }
> +static inline void kimage_unmap_segment(void *buffer) { }
> =C2=A0#define kexec_in_progress false
> =C2=A0#endif /* CONFIG_KEXEC_CORE */
> =C2=A0


