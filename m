Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C737D2E006
	for <kexec@archiver.kernel.org>; Fri,  5 Dec 2025 11:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FJmrnVAWmxW9nZlblGKQ8BQKPdrOnw9FZ2cIhgKrb+M=; b=vBSQfW+He/pTse/SSV0PSj6s5A
	Rl3ZQXSImb18njlgWYHpI0AkgEO19tzWyneyEw9pQSTWmx1Ib+a3Xqf8fUGQ373bO0Kq41JDgM4Jm
	9pqVyuICaFuJVWXCpwNyrV+jIV82Q/BSGdw7OSWTaKcSjcIA39gl1ETGSsnykP32ZwnfTiAwSc+NC
	TbR7/OxkJiC9eU4Ew0LDm5c0ubw5fY33yJRqOv6TtFAP3lRrOHMnEwKahxZYg2s2hNT2+1zFIV4+2
	GJYTN8QSUhDHTrJJRfcf2uCPaxyhsrxlZ7ewlntqEWpzRxkSAEO8sxUrALXXfYJQNILcvtQ9bE1Nk
	PQ6aNSrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRTb2-00000009PvR-3wVL;
	Fri, 05 Dec 2025 11:03:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRTb1-00000009Pv3-1AgA
	for kexec@lists.infradead.org;
	Fri, 05 Dec 2025 11:03:32 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B50btS0008539;
	Fri, 5 Dec 2025 11:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FJmrnV
	AWmxW9nZlblGKQ8BQKPdrOnw9FZ2cIhgKrb+M=; b=Jlk/tWqS+Mvj2GkJTqEjsM
	h9JHlqR5fEVkln5EC/D2gFobE6oWQM+eMTBuqtfHCReBQbKKZwfNixChaxcKFHVi
	06kSgn33U02ZgilNM0ivacYLVYJkoC9cHyA4hmTXfEb5hLxAzLUdyRx6Tdq3cBc5
	I+VNu4igdYJnX9erV55EV5oyGojlhMQ+vChL+dWOl1CcOuTahrLZHNLTX+dNJH0e
	y6WcSI6T2/WYbPWceKUdF+cOmK3fmmDezXYOx8oAqUP+gL5VjlTn7agxDxnLCipe
	ss2wPr0K9hTUzK+fdeUGb+YSF9tKRI93s0QLxRPefWUvvDILyMnJYRvZ+NI1MHyQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8v4kq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 11:03:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5B3Gk8027460;
	Fri, 5 Dec 2025 11:03:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8v4kpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 11:03:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5A8Tdb024045;
	Fri, 5 Dec 2025 11:03:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4arb5sw0m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 11:03:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5B3EQ738666604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 11:03:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10EF320049;
	Fri,  5 Dec 2025 11:03:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CED22004B;
	Fri,  5 Dec 2025 11:03:13 +0000 (GMT)
Received: from osiris (unknown [9.87.131.209])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Dec 2025 11:03:13 +0000 (GMT)
Date: Fri, 5 Dec 2025 12:03:11 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, linux-mm@kvack.org,
        ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, elver@google.com, sj@kernel.org,
        lorenzo.stoakes@oracle.com, snovitoll@gmail.com,
        christophe.leroy@csgroup.eu, Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: Re: [PATCH v4 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <20251205110311.11813A10-hca@linux.ibm.com>
References: <20251128033320.1349620-1-bhe@redhat.com>
 <CA+fCnZcVV5=AJUNfy6G2T-UZCbAL=7NivmWkBr6LMSnzzTZ8Kg@mail.gmail.com>
 <aTKGYzREbj/6Hwz6@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTKGYzREbj/6Hwz6@fedora>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Eym7r3xetcUFAk65KHhR67Lgmhyr4aUZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX7B7O4z0hwN0F
 PgOIq4ByAtB986RdaLRKvfuMymJWSwBG8yT17AQ+IHImaU5V4iKH22yS3C5KzddRnwhm3s5zhty
 J8dz5GSoaKbQ+QWsxQ/IMQIucT0AWhv6MkKp+FXlGEa9GYbg7YSn+ENTKp/TTwFRLBsoSbxTllb
 qvSSpl3oy3rGiW3WU8mRJyX4vV194CHOR93yKCJvGX2OKBr1BLyZUfduF/1ZL7Jy0g0ahlzhDGL
 q9S00qZyEdjOetvG31YFmuuXki4r0/7SHZr/UJeTmmxjCri8M+QGhX4rmnWXPlxoZICqVXOmPH9
 J1Sd2B/Ip0yIec6pnApVTgi8T9oMnMA+jxyng5MunAgiMX4gDXab2LXyFkn+hoMmV1m+DlossCy
 o4l0uJ04VKST6L6MWkGhMoRvN53nfQ==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=6932bbf5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=40HSkAYmfyoHoQYM2uIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oD0qT5z5etYDFvofq45rGIQq18lrpDXv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290008
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_030331_465239_FCB3F708 
X-CRM114-Status: GOOD (  22.35  )
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

On Fri, Dec 05, 2025 at 03:14:43PM +0800, Baoquan He wrote:
> On 12/04/25 at 05:38pm, Andrey Konovalov wrote:
> > On Fri, Nov 28, 2025 at 4:33 AM Baoquan He <bhe@redhat.com> wrote:
> > I also wonder if we should keep this kasan=off functionality
> > conservative and limit it to x86 and arm64 (since these are the only
> > two tested architectures).
> 
> We may not need to do that. I tested on arm64 because it has sw_tags and
> hw_tags. And if x86_64 and arm64 works well with kasan=off in generic
> mode, it should be fine on other architectures. I am a little more
> familiar with operations on x86/arm64 than others.  I can manage to get
> power system to test kasan=off in generic mode, if that is required.
> From my side, I would like to see x86_64/arm64/s390/power to have
> kasan=off because RHEL support these architectures. I need consult people
> to make clear how to change in s390. Will post patch later or ask other
> people to help do that.

We are aware that s390 support is missing / does not work, and will
provide something. I guess something based on this series would be
good, or are you planning to send a new version anytime soon?

