Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BACC54791
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 16:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NmHYWpjnSb8HNirbNulIF0l8DX75g5lLfmJzp5llZGE=; b=1RzTOBXzYXP8dR
	3EXZg+c0BlPixxxMbS7pjgVAiNNbbUz6Y2P7xxkYS5OCQWMSB/eTnO9d8IK2xlSB8Z+YT2N/iluYJ
	LYaYMvFWsH9ndTpVQtKDS01XZArEQh7X64YwT8mmDvxju3urJBVywYqAWt30Z9I7WnT8p4ZPQAYAV
	8qOAvcPTiUnUqoNSialSGhwcCXPOzx9Y1N8AEAl9fVKPWxAEwvoG6+Cb/YiORHJUdk1wXACI7vHOM
	T67INYqIbeQOIbr10ciQK/rxymRFtyPmKfPQuR33dqtom6laZoecYG7LKN3FWmhJJafjiO+HO3Ly/
	fq+Wu0nMH1as7RFM99ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdC64-00000005dPV-12zJ;
	Thu, 22 Feb 2024 16:38:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdC61-00000005dP1-0R80
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 16:38:54 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MGCYvq030268;
	Thu, 22 Feb 2024 16:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hBVCn4JTyk5zpW79u1HmKmXhJ5aN6oHaCdhr0WuwLpI=;
 b=hyERcdDCxE6hXVn+WXGJ//eBKL65DrAkU4e732UlrU6FFKbnisCTwdGEZ4LoBURQ55it
 1BiKFOyS0saC79kYNfNkZ+PG0PCuAArnOKF9lk5j/OycOT3RQZs634PXOq+w5lCtLU7R
 SrGzILKqT/+bnXpWWDMsI+ZY+84Q9dJCscono80hZTrPDP1IApq7iM7T8n6T/1vG/tnr
 b2QS6iJqyC1fMP7HoVoeVamoeTPLsWFLzViZHuq0H/VbJSj+c+3eHCtAnJFx8D2gHrXf
 bcEUCRc1oSYV7WpA3sIa5C8yblmRkE0Sv53uRA1kVWg+4XnT/LYttQvO+xNdLTpHokZp 4g== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we9k68psg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 16:38:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41MGUcjh003615;
	Thu, 22 Feb 2024 16:38:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74tyq3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 16:38:28 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41MGcQBm19595824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 16:38:28 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E63975805D;
	Thu, 22 Feb 2024 16:38:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C0055806D;
	Thu, 22 Feb 2024 16:38:24 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.99.109])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Feb 2024 16:38:24 +0000 (GMT)
Message-ID: <20b13e7bab048b3afb94a8878299aa7d61016364.camel@linux.ibm.com>
Subject: Re: [PATCH v5 6/8] ima: suspend measurements during buffer copy at
 kexec execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Thu, 22 Feb 2024 11:38:23 -0500
In-Reply-To: <cba09611c2e069be49faca2f137d99c772635831.camel@linux.ibm.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	 <20240214153827.1087657-7-tusharsu@linux.microsoft.com>
	 <cba09611c2e069be49faca2f137d99c772635831.camel@linux.ibm.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4lpycoiXWSoC6ncV3YuTuu16Vl4K81Zw
X-Proofpoint-GUID: 4lpycoiXWSoC6ncV3YuTuu16Vl4K81Zw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_12,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxscore=0 phishscore=0 mlxlogscore=960 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_083853_399540_55871782 
X-CRM114-Status: GOOD (  20.32  )
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


> > @@ -176,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry
> > *entry, int violation,
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * suspend_ima_measurements will be set if the system is
> > +	 * undergoing kexec soft boot to a new kernel.
> > +	 * suspending measurements in this short window ensures the
> > +	 * consistency of the IMA measurement list during copying
> > +	 * of the kexec buffer.
> > +	 */
> 
> Either remove the 2nd sentence "suspending measurements in this short window
> ..." or explain what is meant by "short window".
> 
> 
> > +	if (atomic_read(&suspend_ima_measurements)) {
> > +		audit_cause = "measurements_suspended";
> > +		audit_info = 0;
> > +		goto out;

After the suggested changes, understanding how many measurements are not being
added to the measurement list and not being extended into the TPM would be
really interesting.

Mimi

> > +	}
> > +
> >  	result = ima_add_digest_entry(entry,
> >  				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
> >  	if (result < 0) {
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
