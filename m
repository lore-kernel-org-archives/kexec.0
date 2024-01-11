Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7B5C47258
	for <kexec@archiver.kernel.org>; Thu, 11 Jan 2024 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ElrmGqeyWi3yNeF/Zum5JpOxA4/eGA89IYbR3KWIWPA=; b=sF+B3mvtoKOEkZ
	OrU4qvTFQdGlYZdvXWVBFCRQmvNaRYUiYpuq3x+tbhT3SWmWNAYu+e5+i4tATxABGyZNSdwXbKgsD
	JFr5XlUJImwH1kdvJL9YQItVI0XZRi/9n0h6eNIVlYL3VWDBG+Q8EOqbMcL9LCs0FmUcrFsmtZrB0
	luhwA3EO043Y/pr0EKsVB1CJndUZNyvqIsT/eHQV6M3GDsqTAhF/JgsW9f9+DZvDue2Y2071KRIxj
	Ui3vDGdgjEaePVSwn4y7+jDWKcaV9ojOxalUbDe1LOfLS4jBJU8KxItipKv0R4Pwc3zhfMjBC3wn7
	0Ni3qdxXi9r9M4sTa+Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNyt8-000jTG-1T;
	Thu, 11 Jan 2024 17:30:42 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNyt5-000jR5-2q
	for kexec@lists.infradead.org;
	Thu, 11 Jan 2024 17:30:41 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BFvZ0n009743;
	Thu, 11 Jan 2024 17:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=qWdfCt8z/P2xCnocYypnu8bW8jwmBddLfgsWWT9ZquQ=;
 b=tOLYBvFYWJd2ZQJQJW5yqslUztSt3lJzM5zbwTr2s+UOaMe6Rb3UtgQnnrUWuwPQb9Du
 188Y1dmS6cRWGkWfSJlXM9CNcpyEVSbooXSUSA2VFSB4hxJlzZCNoFT0l57pvhwsLXco
 MGiTFIvzlcZLhdvgAs5aM/NdrvXfPgQQpro6YklnvOfw4zFtkZLPmrziJjWsmLLNPpaR
 xodwh1B+I3Ob42D7dUTJKo92KYyCEP0m8rSxua9aHVywZCRnXKqCqZU/SUeiiZP667aE
 2m8gtmcztQba50nXWjvEFWFWhC67d0aIlNDwKLVqkLlqCs4nB6xdRMBUaYq6fEz5IAYF /A== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjke2ahqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 17:30:11 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40BGR9dn027026;
	Thu, 11 Jan 2024 17:30:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw2cex5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 17:30:10 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40BHU9ml12452546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 17:30:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55EC658056;
	Thu, 11 Jan 2024 17:30:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 900D058061;
	Thu, 11 Jan 2024 17:30:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jan 2024 17:30:08 +0000 (GMT)
Message-ID: <10d5bc81db27c21613dacace9bedad345705dcea.camel@linux.ibm.com>
Subject: Re: [PATCH v3 5/7] ima: suspend measurements during buffer copy at
 kexec execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Thu, 11 Jan 2024 12:30:07 -0500
In-Reply-To: <7ed7dccf-8482-4285-b21e-d518cb20d9e9@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
	 <20231216010729.2904751-6-tusharsu@linux.microsoft.com>
	 <c174d4d7d3ab646f0e0ebf5aa1dd6894f22dbc02.camel@linux.ibm.com>
	 <7ed7dccf-8482-4285-b21e-d518cb20d9e9@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wvqONkTzh_ZUAihedAj9J5XazHsvxL9g
X-Proofpoint-GUID: wvqONkTzh_ZUAihedAj9J5XazHsvxL9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_09,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401110137
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_093039_924986_3E99DB73 
X-CRM114-Status: GOOD (  41.18  )
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

On Fri, 2024-01-05 at 11:50 -0800, Tushar Sugandhi wrote:
> 
> On 12/20/23 12:44, Mimi Zohar wrote:
> > On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
> >> If the new measurements are added to the IMA log while it is being
> >> being copied to the kexec buffer during kexec 'execute', it can miss
> >> copying those new measurements to the kexec buffer, and the buffer can go
> >> out of sync with TPM PCRs.  This could result in breaking the integrity
> >> of the measurements after the kexec soft reboot to the new Kernel.
> >>
> >> Add a check in the ima_add_template_entry() function not to measure
> >> events and return from the function early when 'suspend_ima_measurements'
> >> flag is set.
> >>
> >> This ensures the consistency of the IMA measurement list while copying
> >> them to the kexec buffer.  When the 'suspend_ima_measurements' flag is
> >> set, any new measurements will be ignored until the flag is unset.  This
> >> allows the buffer to be safely copied without worrying about concurrent
> >> modifications to the measurement list.  This is crucial for maintaining
> >> the integrity of the measurements during a kexec soft reboot.
> >>
> >> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> >> ---
> >>   security/integrity/ima/ima_queue.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> >> index cb9abc02a304..5946a26a2849 100644
> >> --- a/security/integrity/ima/ima_queue.c
> >> +++ b/security/integrity/ima/ima_queue.c
> >> @@ -195,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
> >>   		}
> >>   	}
> >>   
> >> +	/*
> >> +	 * suspend_ima_measurements will be set if the system is
> >> +	 * undergoing kexec soft boot to a new kernel.
> >> +	 * suspending measurements in this short window ensures the
> >> +	 * consistency of the IMA measurement list during copying
> >> +	 * of the kexec buffer.
> >> +	 */
> >> +	if (atomic_read(&suspend_ima_measurements)) {
> >> +		audit_cause = "measurements_suspended";
> >> +		audit_info = 0;
> >> +		goto out;
> >> +	}
> >> +
> >>   	result = ima_add_digest_entry(entry,
> >>   				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
> >>   	if (result < 0) {
> > 
> > I assume you meant to include the suspend/resume code in "ima: kexec:
> > move ima log copy from kexec load to execute"  in this patch.
> > 
> 
> Sure, I can move the suspend/resume code from Patch 2/7 of this series
> to this patch (5/7).
> 
> Earlier I introduced the suspend/resume functionality in patch 2 because
> it was used in the functions in that patch.
> 
> But shifting it hear will make the patches cleaner.

Just a reminder this isn't the only issued mentioned in 2/7.  Please refer to it
for the other comments (e.g. make not including/verifying the IMA segment hash a
separate patch).

Before reposting, please remember to test after applying each patch in the patch
set to ensure that the measurement list is properly carried across kexec.
-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
