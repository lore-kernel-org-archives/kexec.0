Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C51EC021B3
	for <kexec@archiver.kernel.org>; Thu, 20 Feb 2025 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S+lsw3J2GGZrkffZVS1uXbFw8jdnLUvAixzKeCH+EC0=; b=m8fhk+5ycpu8QGV3bS2zjndNM6
	8AhVq6u/HhHnYFcqiQ+TSVS5Lyxw16JW/qhyLHi+fhQtScQXuPdkoHq5y4wstXXDryNx+YbjO20dN
	4UrBiW1UzWtzv/92JyBMxB4NbT2kVoV+tYI9JdnYNuVlnjelV1vxexDw1zRNRXWAAX97kMODZxtFl
	bR5OBFK1HX5AP3ifGAu+2wLARSXPAfSctKaCd+CexYjXeUxGGYGkdZejj2ApDW5f1L+vsU62/Lr1y
	1BRo0+6DIPuuRt7VpompzefxUoFURggI/FBDcHPvzG6rPRLtrf+plJGo36ljCdvQ6VSNUaCUdfLkQ
	1uu3TDDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlAG7-0000000274j-3QaT;
	Thu, 20 Feb 2025 17:22:47 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlAG5-0000000273E-1T6t
	for kexec@lists.infradead.org;
	Thu, 20 Feb 2025 17:22:46 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1ew6007899;
	Thu, 20 Feb 2025 17:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S+lsw3
	J2GGZrkffZVS1uXbFw8jdnLUvAixzKeCH+EC0=; b=XYDRTG/pmvtz43XuqCR8Lk
	q4wHnqTWDvJyI0a7mnMN/TMyrLAhH596y1MmXEgma9OFnlhI+iKKbjY6fviALDQn
	6aiO/uZAbxz5/5aRiMeOEWEiQICjUbrSiNEyKH5g2+cThWluGSBhHTB5rF4df7Tf
	hDRuP2ebQnkB42k2hPyuQzOgqQhFCh3B8YV8sWeAbl6Lk5d96FXd+LgPxIxC3YOA
	7rhN9NYb2ZsL7YskeRvvtBbJ2uoUa4CkK++p6X+h9qI5Km6CTMYp61Twel/meDIq
	L3BQnS0D9aQHN+1NRj8JmS2ayvrOgbf4/I3lnazhbl2AsEjXyDVeGdaaVEHLR7XQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa4bag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 17:22:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KF6sLU002343;
	Thu, 20 Feb 2025 17:22:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xb6d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 17:22:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KHMPT129098640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 17:22:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E5D558052;
	Thu, 20 Feb 2025 17:22:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E475F58056;
	Thu, 20 Feb 2025 17:22:23 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.68.26])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 17:22:23 +0000 (GMT)
Message-ID: <c76a6a741b6f465d270153b65ea6f728383ca608.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
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
Date: Thu, 20 Feb 2025 12:22:23 -0500
In-Reply-To: <20250218225502.747963-3-chenste@linux.microsoft.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-3-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9eyMENDAtdtjGXHKLQ0XI_TrwLnteDmW
X-Proofpoint-GUID: 9eyMENDAtdtjGXHKLQ0XI_TrwLnteDmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_092245_428370_920AD4C4 
X-CRM114-Status: GOOD (  16.92  )
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

On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
> Currently, the mechanism to map and unmap segments to the kimage
> structure is not available to the subsystems outside of kexec.=C2=A0 This
> functionality is needed when IMA is allocating the memory segments
> during kexec 'load' operation.=C2=A0 Implement functions to map and unmap
> segments to kimage.

Obviously up to now Kexec was mapping the segments. Missing from this patch=
 description is
the reason "why" these functions are needed now.  It's not enough to say "i=
s needed when
IMA is allocating the memory segments during kexec 'load' operation".  The =
question is why
does "IMA" need to allocate the memory segments.  Don't make the kexec/kexe=
c_dump
maintainers guess.

Refer to the section "Describe your changes" in
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst

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

Again, no such thing as an "Author" tag.  Refer to the comments on 1/7.

> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

As previously requested, please add the Cc's inline here and in all the kex=
ec/kdump
related patches:

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>=20
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>

> Signed-off-by: steven chen <chenste@linux.microsoft.com>

thanks,

Mimi


