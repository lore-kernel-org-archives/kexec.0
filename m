Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A338E63F3F
	for <kexec@archiver.kernel.org>; Mon, 16 Feb 2026 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gbFGcN+w3fR9jnZFuf/i9EiHs6mK4TmGoGErRfWToDE=; b=DkP237qVIZmqDdUSsnYG6MKmuS
	8fPnEMr0NjyDN7MdNialIXU1mgzesyQZvVcZ45Q3pmeGtc7OaFO5UjnoZjHNH9T4EN+3x9CrIDd/J
	+S1+XcLiAkUYQXHMYgWmMqbtOOqaS35ZVqpIIG20xT1oF3ikRvg95vq7cFlR2I2eDaPQzn4I2qmyl
	S846IUhFF1d03L83vkEXZPNEjoWsrBXH3hEOXnx/ZRenD3sq7b4WbfvSbyANHCG2KySr5g28ArTJc
	nH5MIacXEfA65EqE26FTmIHlz25E6NYaGhc/FSXigfJy6Eu3wbKY856YQadecLxW8gKC4/lZh7Byg
	dz9+dDPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vruaz-00000006DxM-0u62;
	Mon, 16 Feb 2026 09:08:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vruas-00000006Dws-3MxD
	for kexec@lists.infradead.org;
	Mon, 16 Feb 2026 09:08:39 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FKo9Bu3434976;
	Mon, 16 Feb 2026 09:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gbFGcN+w3fR9jnZFuf/i9EiHs6mK4T
	mGoGErRfWToDE=; b=gIC+h4+R6VvLM0jpeD+yzWko1RRL6XdOZiC6pYo47i11vt
	rOIU9doZ5l3lybSJXf2krUckpLIZK/SbCCRL7dK/hSmAwpe+Prq64BlU+9T542Sw
	hXSRk4tKKfuL6RvrmzA00IQBpJFTWoJwwgsxuvRgYrQxJ0JfnfVx2+L6UM8h6YQj
	9JMp5R7d2BrDExyN09376sA3cWXx28osrYCtc7L8jzo8sI3u6rV7d+/oC4t4YYc0
	1TBriJFfQgT7EmxZN5qfgLT6hZMvBFMB5yoK/73j4DohGrCOk+9BTIOZkddii71a
	5bo5R9TqfbrzITt3MUNTn1j5XeOUvm/Dd8WZVjbQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6uevrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 09:08:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G7186T004035;
	Mon, 16 Feb 2026 09:08:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4cmvqs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 09:08:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61G98V6354395360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 09:08:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8D322004B;
	Mon, 16 Feb 2026 09:08:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B3F020043;
	Mon, 16 Feb 2026 09:08:31 +0000 (GMT)
Received: from osiris (unknown [9.87.144.68])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Feb 2026 09:08:31 +0000 (GMT)
Date: Mon, 16 Feb 2026 10:08:29 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, kexec@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390/kexec: Make KEXEC_SIG available when
 CONFIG_MODULES=n
Message-ID: <20260216090829.12756A41-hca@linux.ibm.com>
References: <20260216062916.818071-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216062916.818071-1-egorenar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6992de94 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=NxbVVSpuZNI24rlRSKEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3NiBTYWx0ZWRfX0cE/W+EVSeVc
 K+kMwzbYA1uwI5Hm//lJEESmlID3WQeD1ffbUKI9WqPv3l2bLgG2uoU+bFnAdz1LB/RxOJKjBkb
 0oNOrDWYasZNzIx+3R52EPb4hEAj+/9V+sBcJaoJVUned+rwWR2+GwS9GsjgfYo12F1/gC2pLN0
 TgLjFKuGM1+hS/WNvCxyI7gDcvpB964LwxTyUFxCzIXzx9VLYAD24CcSTRknjftmLgBpfXvkZUN
 QEoF8o70Cgqn7Rl5fGdosqy92iK6sFd4PE+L0gji2E9Nq99FslwbbenkSkpBJ4wvju8U/6bcTmT
 5b0wblHMTdqXfupRdhCPwNFdYk4pgFJRXNLemWgOM4ZGhRIcJae8x3ZdOhnUw656CXoyCwjlo+K
 cgpAAjvtDZQPxqwum0TDhCOFER4TMo1OzFaF+3dlGc2YmO74fG9VR9QwRITRg6LKs4kzhleI8cl
 RGpUvYYXeo9cIy/oSoQ==
X-Proofpoint-ORIG-GUID: -jU0seWRZ-D6LsGZu_pN_RQDxne5aoAG
X-Proofpoint-GUID: -jU0seWRZ-D6LsGZu_pN_RQDxne5aoAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160076
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_010838_845920_0F2BC609 
X-CRM114-Status: GOOD (  19.07  )
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

On Mon, Feb 16, 2026 at 07:29:16AM +0100, Alexander Egorenkov wrote:
> The commit c8424e776b09 ("MODSIGN: Export module signature definitions")
> replaced the dependency of KEXEC_SIG on SYSTEM_DATA_VERIFICATION with
> the dependency on MODULE_SIG_FORMAT. This change disables KEXEC_SIG
> in s390 kernels built with MODULES=n if nothing else selects
> MODULE_SIG_FORMAT.
> 
> Furthermore, the signature verification in s390 kexec does not require
> MODULE_SIG_FORMAT because it requires only the struct module_signature and,
> therefore, does not depend on code in kernel/module_signature.c.
> 
> But making ARCH_SUPPORTS_KEXEC_SIG depend on SYSTEM_DATA_VERIFICATION
> is also incorrect because it makes KEXEC_SIG available on s390 only
> if some other arbitrary option (for instance a file system or device driver)
> selects it directly or indirectly.
> 
> To properly make KEXEC_SIG available for s390 kernels built with MODULES=y
> as well as MODULES=n _and_ also not depend on arbitrary options selecting
> SYSTEM_DATA_VERIFICATION, we set ARCH_SUPPORTS_KEXEC_SIG=y for s390 and
> select SYSTEM_DATA_VERIFICATION when KEXEC_SIG=y.
> 
> Fixes: c8424e776b09 ("MODSIGN: Export module signature definitions")
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
> 
> Changes v1 -> v2:
> - Let S390 config option select SYSTEM_DATA_VERIFICATION if KEXEC_SIG is selected
> 
>  arch/s390/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks!

