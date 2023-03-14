Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D8FC74A44
	for <kexec@archiver.kernel.org>; Tue, 14 Mar 2023 03:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f2EClvdr+7XrTusk4jMZQ8A0hBB7yEA3PX87585ad7w=; b=etsZPS3qBuKbHb5+U5F/+hQyiS
	cbD3EqmCARQ/hN3oaldhYxv9hiW048g3oSyvGzHNPAQl/VUUhIpU5iRaaIvdZVljaZOnuFq/f9nss
	hzWcMmhyDfmD6DbxLmglxVcLw3CPeNmN7EhZaHRUWyOa3jbiJegnX6VXRgs/A7eMWzd4N2OW1zMcv
	9n6HrJjW5e4fM4fOoFp9oLYW1WwN/6ySNyl/7FN0NJcfrbFcR5s6Dpo2xljP45RfTp9IP0xu/4SmS
	Jisg7VyItmKBVCY0uoL9l7M/reRC+KtGblfQ/M8wdxS3/jiFzTNpjNGA74XO3sVhdLkKKW7O6xUyf
	E+2nPuiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbvXQ-008t2M-5f; Tue, 14 Mar 2023 03:41:24 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbvXN-008t1N-BD
	for kexec@lists.infradead.org; Tue, 14 Mar 2023 03:41:22 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E343ij005828;
	Tue, 14 Mar 2023 03:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uC0i3aIc5pNy8rUQRZEFwP4DxuhfYhk4PNWqfvt4n1Y=;
 b=WC1J57b22YYQQvJaj8KS0jspcfNbdvHw2hvVlnqxZ+FBMUXsAMSvRUd0SuKfFNzduyIs
 QNFq3bjyiEaoWz2RfkIY+YsyJCOhbrv2HwjpPNxSF/oqUlXsEgmhYXitms89ig79XbPS
 mX6xToWfFBgEKhNhd55CBBGn4E6Yj15V/jVZzTLf+mCzjVibYU/Ha11m4jRiRvuErflC
 UkWvy9bCFvLKYehsZuxGyRVFyDW134AFlNlBgI+bT0j6ywHt21IDWlWzRQMhTZGLKTUy
 vg8LD0AbenqCO+TDRkczuP//OumskGs0CvqU/y/IP/vxB9wErPaI6mTi87+/optDBZc9 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pae0s43t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Mar 2023 03:41:17 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32E3FiuC021291;
	Tue, 14 Mar 2023 03:41:16 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pae0s43sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Mar 2023 03:41:16 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32DCSxpI018985;
	Tue, 14 Mar 2023 03:41:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3p8h96k9jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Mar 2023 03:41:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32E3f6cA27853424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Mar 2023 03:41:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81BC22004B;
	Tue, 14 Mar 2023 03:41:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA26B20043;
	Tue, 14 Mar 2023 03:41:04 +0000 (GMT)
Received: from [9.43.46.246] (unknown [9.43.46.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Mar 2023 03:41:04 +0000 (GMT)
Message-ID: <3eccc879-40bc-3748-f672-4209ee98df4c@linux.ibm.com>
Date: Tue, 14 Mar 2023 09:11:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 1/6] powerpc/kexec: turn some static helper functions
 public
Content-Language: en-US
To: Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20230312181154.278900-1-sourabhjain@linux.ibm.com>
 <20230312181154.278900-2-sourabhjain@linux.ibm.com>
 <d2346e25-56f0-f198-43cd-efdf73321f09@linux.ibm.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <d2346e25-56f0-f198-43cd-efdf73321f09@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kg453B1STxgjAFxBphwmbXL36DywFmDA
X-Proofpoint-GUID: dzOgKhiCF8MDhzTxzZ54Kqk5CGrFXdOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-13_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_204121_424178_E709F505 
X-CRM114-Status: GOOD (  15.20  )
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
Cc: eric.devolder@oracle.com, kexec@lists.infradead.org, bhe@redhat.com, hbathini@linux.ibm.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


On 13/03/23 21:48, Laurent Dufour wrote:
> On 12/03/2023 19:11:49, Sourabh Jain wrote:
>> Move update_cpus_node and get_crash_memory_ranges functions from
>> kexec/file_load.c to kexec/core_64.c to make these functions usable
>          file_load_64.c
>> by other kexec compoenets.
>                   components]
Thanks for points it out. I will fix them in next version.
>> Later in the series, these functions are utilized to do in-kernel update to
>> kexec segments on CPU/Memory hotplug events for both kexec_load and
>> kexec_file_load syscalls.
>>
>> No functional change intended.
>>
> FWIW, despite the 2 minor typos above,
>
> Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
Thanks for the review Laurent.

- Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
