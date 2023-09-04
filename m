Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B175C83F33
	for <kexec@archiver.kernel.org>; Mon,  4 Sep 2023 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zPAZVfMx9ugk+DWbnJnIgaZswwpIRo0lIkGMmP293io=; b=h6EIVN1xPKpWWt
	NsrTm1lPVHCNvrRWV1gBE1NTf+b9s5kNpB5X3lbg1FsqE3XTleJqppLA94QwMYB+mtQAszscS7Sqf
	g7EdIjqObGkDPZpYRO2TQC7M1kVayq73KUkB9mk8o8JCtojgXpEI+ZcXlkQPl0hMwUE/LMpB/LHPJ
	z57R275/xkH9sZQDFy+ga4fqDMFQxKb14IoH0Y3RApCf8iJolhZiYyg0qalIWd79pAQCFLbYHHoCM
	h50MrujRGf1PtBHkkJ5waqZ/5L1F8OLVG4VMu2HCYYWxqGqGS2jSXtZy+yD9IYO1JiLnVLvSNIa/P
	jBxbsqq+fqoQjL++7Yjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdAhf-004HOW-05;
	Mon, 04 Sep 2023 14:37:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdAhb-004HLp-0N
	for kexec@lists.infradead.org;
	Mon, 04 Sep 2023 14:37:20 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384E6meZ006297;
	Mon, 4 Sep 2023 14:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mbwLhV2NYtXQOdQV1fKkqCEuFE3DjJZqNv6HLQL5yuQ=;
 b=NZvp+LA7wou5W/q740r+0PvnXwxzxXNmfTmUydxSo4uUDPcMoE8POOFlbXEjDrpZZm/E
 gtrC13k4GdontN+oKUO+q/obAemrJh06zWyN4K/r06o75/Rz/URWDIsvapdUIhA7QdDI
 Zam4ZPLvrOgbUsD0exAwc4GI+J3aUQFS10bWioJ5BEV3N+iL0I6iJQe2YDVU0K4trE1+
 1QHkFCe5p4cPaWrK1Q3qAv4vMcg7KZWijYhYWSYcld2EadDTzyUzUQW4zf+/+IWo1xBd
 bBco996MZVGgoPmvwpdpvdK/eEfHnP6kmJz2qOd5/kUv1I9YeGUSEZSIIV3gGZADd1hK xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw80jdr50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Sep 2023 14:36:06 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 384E6wXj007713;
	Mon, 4 Sep 2023 14:34:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw80jdpcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Sep 2023 14:34:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 384E0A8C001624;
	Mon, 4 Sep 2023 14:34:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfcsbpcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Sep 2023 14:34:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 384EYA2334472528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Sep 2023 14:34:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAD4F20049;
	Mon,  4 Sep 2023 14:34:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DCE020040;
	Mon,  4 Sep 2023 14:34:09 +0000 (GMT)
Received: from [9.43.27.211] (unknown [9.43.27.211])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Sep 2023 14:34:08 +0000 (GMT)
Message-ID: <8fcd7ba7-0f27-7bbc-676f-7e13c8bf00d7@linux.ibm.com>
Date: Mon, 4 Sep 2023 20:04:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] vmcore: allow alternate dump capturing methods to
 export vmcore without is_kdump_kernel()
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>
References: <20230901190438.375678-1-hbathini@linux.ibm.com>
 <ZPP/UeP1zUbGPzrt@MiWiFi-R3L-srv>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <ZPP/UeP1zUbGPzrt@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y6cJGnzQveuKjsB-D8l-jwH2wOhgoTRc
X-Proofpoint-ORIG-GUID: rYr90DU-mk0NiOVoDnuGwmqdNDa4Y-s7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=473 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230904_073719_162853_96256355 
X-CRM114-Status: GOOD (  22.83  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Baoquan,

Thanks for the review...

On 03/09/23 9:06 am, Baoquan He wrote:
> Hi Hari,
> 
> On 09/02/23 at 12:34am, Hari Bathini wrote:
>> Currently, is_kdump_kernel() returns true when elfcorehdr_addr is set.
>> While elfcorehdr_addr is set for kexec based kernel dump mechanism,
>> alternate dump capturing methods like fadump [1] also set it to export
>> the vmcore. is_kdump_kernel() is used to restrict resources in crash
>> dump capture kernel but such restrictions may not be desirable for
>> fadump. Allow is_kdump_kernel() to be defined differently for such
>> scenarios. With this, is_kdump_kernel() could be false while vmcore
>> is usable. So, introduce is_crashdump_kernel() to return true when
>> elfcorehdr_addr is set and use it for vmcore related checks.
> 
> I got what is done in these two patches, but didn't get why they need be
> done. vmcore_unusable()/is_vmcore_usable() are only unitilized in ia64.
> Why do you care if it's is_crashdump_kernel() or is_kdump_kernel()?
> If you want to override the generic is_kdump_kernel() with powerpc's own
> is_kdump_kernel(), your below change is enough to allow you to do that.
> I can't see why is_crashdump_kernel() is needed. Could you explain that
> specifically?

You mean to just remove is_kdump_kernel() check in is_vmcore_usable() &
vmcore_unusable() functions? Replaced generic is_crashdump_kernel()
function instead, that returns true for any dump capturing method,
irrespective of whether is_kdump_kernel() returns true or false.
For fadump case, is_kdump_kernel() will return false after patch 2/2.

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
