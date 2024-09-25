Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860A2C369A0
	for <kexec@archiver.kernel.org>; Wed, 25 Sep 2024 07:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OLqPD1pTxbJwO1KZLntjuq/fCZ3BafXtJDBbPX53it8=; b=3e0h3R7hldIngn
	HQHxLCdG22Z9ugE52h/Bg52vXULjGMzAgCDLwZYLHxWRRYwZCsbWEPqEsm47O3W8YS6p+xJvgSnwH
	ArzoCI2s1aX3LxYZApy51ODVVbaB3wzjuD9lraCnubfPhvJQbxfyaXawL8hKOU6M5Zo3J6NH4H3I8
	J+ysj0muU4K0125UAUcd1yaKNnoMP6E0IkJRuh986ppPfVI6JH+VDXD4KEkhIxdXm8SCxO31dGWvA
	Xdr7vreJbEo09rlqfl95KMZXs+xGMuYMwWLeqqfb5WX35yb2EsJvPlvrCMNsTrwDe38OsymsKlhdF
	tMwtjsNH+UkeS2ZmwSUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stM2N-00000004FjH-0Xff;
	Wed, 25 Sep 2024 07:02:11 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stM0R-00000004FP8-2S1P
	for kexec@lists.infradead.org;
	Wed, 25 Sep 2024 07:00:13 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1WkFm004173;
	Wed, 25 Sep 2024 07:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=7esH8tVn3+1IljSug6nP9M2wC+U
	WMaXIe9n7g2r8W/4=; b=LI6VpJa3cQobyRMWXsCkQc13/gTejsOiE6q9FOwZW4M
	T2p4jtZeVEYaDMaz3VcMgfIt3rxwfBB2I6xGXySmnGVq0X0fpthix3IEskDzcJQA
	DQRW2QB+EKVL1tYJM3qfYGcn87fgrF7siJ5iAzRPLccQ3FfbfT4KD0sD28YplPID
	JqUOImpV3yqBoTnlekkwKvMHw8GFhcudTY21oEOfUD7ig5C9JdMAJzfFzbc/Yb73
	OM4Ko1HmnA15bFhMC6HOjRpnbnztZ3dea32/nSX0Od7Jzc1ZR6Ybu3XO7jOkIrNz
	76sLLOJOKR4a1+WEpqxC+mtOjAPWyp9XPmjDucJvPjQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snnaeds3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 07:00:08 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48P708A4023891;
	Wed, 25 Sep 2024 07:00:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snnaedrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 07:00:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48P6SPXC013998;
	Wed, 25 Sep 2024 07:00:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9yn013f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 07:00:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48P704Cf34865782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 07:00:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2AB920043;
	Wed, 25 Sep 2024 07:00:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 686AB2004E;
	Wed, 25 Sep 2024 07:00:04 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.2.154])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Sep 2024 07:00:04 +0000 (GMT)
Date: Wed, 25 Sep 2024 09:00:02 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, Masamitsu Yamazaki <yamazaki-msmt@nec.com>,
        Kazuhito Hagio <k-hagio-ab@nec.com>
Subject: Re: [PATCH] Submit physical address to is_phys_addr()
Message-ID: <ZvO08s9J4rH25N7w@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240913143500.3615218-1-agordeev@linux.ibm.com>
 <20240923134716.2cbc107c@rotkaeppchen>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240923134716.2cbc107c@rotkaeppchen>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4x2hZNj8pA-oGo7j1D_A2NdpXkTTtlXM
X-Proofpoint-ORIG-GUID: OEPv3kzekw04HnrYOrwJhlk-02RpplI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=762 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409250045
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_000011_874792_010128C1 
X-CRM114-Status: GOOD (  16.69  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Sep 23, 2024 at 01:47:16PM +0200, Philipp Rudo wrote:
> Hi Alexander,

Hi Philipp,

> On Fri, 13 Sep 2024 16:35:00 +0200
> Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> 
> > ELF program table virtual address is submitted to is_phys_addr()
> > function, most likely as a leftover of replaced is_vmalloc_addr()
> > function, as result of commit 2e452d75fa78 ("[PATCH v3] Enable
> > --mem-usage for s390x."). Submit the physical address instead.
> 
> is the patch supposed to fix the bug with /proc/kcore I reported? I
> gave it a try on a KVM VM and it's still failing...

No, it fixes another issue.

> Thanks
> Philipp

Thank you for testing!

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
