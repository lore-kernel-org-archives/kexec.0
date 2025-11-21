Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C4ACFA469
	for <kexec@archiver.kernel.org>; Fri, 21 Nov 2025 02:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H5tZ2/Lm/gwCoVyrTlSZTq69Ul+D19GqVTSkmWCtWRE=; b=ShtcRzPJCjV+FuWUHQL5pfvgpU
	96mrn0HJaEYJLV4HNJIB+LK0Y5lERTybn/tBTtcwVhiK94jZaNvbLUtwcKJltYAHk+RrTBMStd0Je
	62KrSrzshmRA4x/duZ7mogwtGrxo8YKOfS3KcMLW1bnSE4ep/YgASFNDlbLu9uxte4zLTVM05hksj
	xIy07whrr+iGyAIEzKIkUAHVC+iYreK3keSAsQMxp1ruB3OsQOubE0fX1BGyNHbr3rjoRaR5XLoIk
	jYfoSHYe4RaqUDWokIERsm3wyz92LaPT5lIJfLfGiLxsg9zIYcHnTMaXPZqShypFAPqRlUHV35qmf
	Q4uCt9gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMHIV-00000007jNw-1Kkr;
	Fri, 21 Nov 2025 02:54:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMHIP-00000007jNZ-1Ljb
	for kexec@lists.infradead.org;
	Fri, 21 Nov 2025 02:54:51 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL0n2Nf029035;
	Fri, 21 Nov 2025 02:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H5tZ2/
	Lm/gwCoVyrTlSZTq69Ul+D19GqVTSkmWCtWRE=; b=e6w9pPUKor/gD+tYE2FTQM
	eV6u09Ne7eBu0Ow+iKyf2J3UIFL90BumHNq+MabfoPBCDdYezt9xSKo/nekVWI4l
	mKo491DQcS2f6w0hJ+wKpzIOg5VLfQG1d5VpZUxWjFmP0jS8PjZwpQR9CCxggkBA
	iRImm6gaJ3kazGiDTuWQDaBNZh/iv7kdD1KSXJGDkCmxjejKlVwE6nm/oIaaPh24
	Z3vbvccgTPFLuvr4aZBL7DUwu8Y7ydWFcUYU4qQhBGAwBSsFCRsf5Dph4kw3qAAG
	QCjjwoKst4GpMZ9xn02JDaC538P40tgGf4T85GQ6kXM+R/WVgyL6D7nzMFo4+Skg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1srtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 02:54:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AL2sfrL031888;
	Fri, 21 Nov 2025 02:54:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1srts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 02:54:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKNGhge010399;
	Fri, 21 Nov 2025 02:54:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3usj5e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 02:54:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AL2saOK49414554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 02:54:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C398A201EC;
	Fri, 21 Nov 2025 02:54:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E93C201EA;
	Fri, 21 Nov 2025 02:54:33 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.98.111.108])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 02:54:33 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Baoquan he <bhe@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>, kexec@lists.infradead.org
Subject: Re: [PATCH v7] powerpc/kdump: Add support for crashkernel CMA reservation
Date: Fri, 21 Nov 2025 08:24:02 +0530
Message-ID: <176369324781.72695.15722637983958584587.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107080334.708028-1-sourabhjain@linux.ibm.com>
References: <20251107080334.708028-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691fd472 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=FGl_mr9ZrwtVw05MWQUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JDc77HEW783QNu7Y_CCJUKAi0M4AWlC6
X-Proofpoint-ORIG-GUID: wU6oy4Zd1G1bDYG3hZJsO81U1dpSqrgT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX7CSINEqgEjln
 89blGDgfGy3JrZ5GlK+Q8wKVSzwZ0qfTg+4aBX+soYTy590uQvWMZhkhpLt55KDZQBnQW7LkkCI
 vLJ80IL9SMnFYFZ7Fx8tTk1MT8nz1OdXdIY6b7oE8blR0TSGCVfNxsq04NcVLXCje8oR9lJcLRZ
 ySb42V/NystjGAkLjuC8t/n1aR9cMcUH0B1lxMo+iZvgv62ZBNho1ww6LHYYfh7rp9JoVGz+MwZ
 e6e0yDVjhawEHmLVOESHj6nd0TE7Wf/APOy0DoNiAUQBwF3ynPqnlf8Tu2PuYp7Ty9wNFULFzrw
 auf6F8vhL6RU6D36ZY6PZ+3GYX0f7g5d4GNFOVpb1M4Kq02qvI9ReJVnCs7hCFMTMXSkwCXhNkl
 UN8qCwPG/Z9Jrz1L1H46KTn5Sd5PQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_01,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_185449_710698_42AD4977 
X-CRM114-Status: UNSURE (   9.07  )
X-CRM114-Notice: Please train this message.
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

On Fri, 07 Nov 2025 13:33:34 +0530, Sourabh Jain wrote:
> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
> crashkernel= command line option") and commit ab475510e042 ("kdump:
> implement reserve_crashkernel_cma") added CMA support for kdump
> crashkernel reservation.
> 
> Extend crashkernel CMA reservation support to powerpc.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kdump: Add support for crashkernel CMA reservation
      https://git.kernel.org/powerpc/c/b4a96ab50f368afc2360ff539a20254ca2c9a889

Thanks

