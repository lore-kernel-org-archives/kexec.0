Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A4EC7EE24
	for <kexec@archiver.kernel.org>; Tue,  6 Jun 2023 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nleW65U9oqgMTipnVh6JlF+UR9ScCxmIsYOLSRx0VQI=; b=0YLPW55pMi4NvX
	Mifg7LTNi725I/BG8NTofOhV4z0GL+V4b704PBjAKb5qVp5fUGmEDbLHs7aPOtwK3hyrqHfPC11hF
	fta/kUlGqGPOl6YoSFmDFzfXyP9vb9loG8c7X8R8icWOJjYfiMQZ8Q/2tYj/uTnU52C5XPSIvActM
	J0xCAwBNuFXmfyAKzPFjBUdMhAbQaNaSrdV/eVnR2xYk41VWEXJR+IZ+TzFeGoDmFoyA3pJZnhWQu
	yXzsPvXPTCx5XfpHPaYU+FnVmfCU6dbc8W6avUImG/id88DjFCJyDpWx+3u8NJzyeeSQKe4ZwVLsK
	YnNOxoiHiFWghhxOmJGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Ymq-002HJJ-1d;
	Tue, 06 Jun 2023 15:39:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Ymn-002Gtq-27
	for kexec@lists.infradead.org;
	Tue, 06 Jun 2023 15:39:55 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356FYT1k016199;
	Tue, 6 Jun 2023 15:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+iU0jfCliskGbr5VuGAblecDaf5MOTrGkclGBCFdhxk=;
 b=NedsEughFl4uzPJuPL/jPnSD4WhfXgc0+AU1Ft1DSYqqE7ZTo6j9ozU99gnUhSRzRiiG
 eKlEEsnQgXKzRisGMXKbt2jBRitMolL5o26rdat3HeqaZBWEa3cfaZn6OhgBIaaITB41
 9eHvXActPMj0P+wLPOL2yeq6ehQbfogFed4tfBp7olPHPEVQ6cycPqPisC4VZaRGQD5H
 uHMCGZ3aRUdnhZuLlZ30ziGSp8rWL7S7M2wAnPrvFZE46/2PPp3a4XrZKgC5AWmg8SRQ
 EGmaC22xk06FgbJROtQQhOSoEBC9SEXplzKaEh+YXvwKuOBNMbPyvytA6tRbgAyh7YCA pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r27jeg32n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jun 2023 15:37:35 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 356FYntM017141;
	Tue, 6 Jun 2023 15:37:35 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r27jeg327-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jun 2023 15:37:35 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 356DlZOf012265;
	Tue, 6 Jun 2023 15:37:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
	by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3qyxenfd77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jun 2023 15:37:34 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 356FbXaV65667332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Jun 2023 15:37:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EBE158056;
	Tue,  6 Jun 2023 15:37:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A365E58052;
	Tue,  6 Jun 2023 15:37:32 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Jun 2023 15:37:32 +0000 (GMT)
Message-ID: <3748147f-85f5-4aeb-0083-cbeef375e12a@linux.ibm.com>
Date: Tue, 6 Jun 2023 11:37:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: need help: patches to capture events between kexec load and
 execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Jonathan McDowell <noodles@fb.com>, bauermann@kolabnow.com
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>, code@tyhicks.com
References: <c33ba2f1-bacd-54dd-90d7-b0ab82568fff@linux.microsoft.com>
 <Yp24dc/i8XU9A+5/@noodles-fedora.dhcp.thefacebook.com>
 <87775c1e-d1d3-519c-599b-30cdb1691cb2@linux.microsoft.com>
 <4eff26f794254c1f06ace12e68527fd3452ac47d.camel@linux.ibm.com>
 <41270374-dc5e-3aa2-d2ed-9b8fc73ad65f@linux.microsoft.com>
 <8308a411a50a1168aa5a1a0d70138b29cea73914.camel@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <8308a411a50a1168aa5a1a0d70138b29cea73914.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qp0471Iu3vi-qNfZN_MLCC2y0lBW9ZDA
X-Proofpoint-ORIG-GUID: OrHSsDaPY_dEiktUAAnkLvtnw9EjNbOF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_10,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306060128
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_083954_068123_C550927A 
X-CRM114-Status: GOOD (  19.65  )
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



On 5/31/23 18:43, Mimi Zohar wrote:
> On Wed, 2023-05-31 at 15:02 -0700, Tushar Sugandhi wrote:
>> Hi Mimi,
>>
>> On 5/31/23 04:39, Mimi Zohar wrote:
>>> Hi Tushar,
>>>
>>> On Thu, 2023-05-25 at 10:21 -0700, Tushar Sugandhi wrote:
>>>
>>>> The issue of IMA measurements getting lost between kexec 'load' and 'execute' still exists.
>>>> I verified it on the mainline kernel 6.4.rc3. See *Appendix A* for details.

I think there's a 2nd problem.  Once the IMA measurement list is frozen (at kexec 'exec' stage)
IMA must stop extending PCRs. It can log (into the void) if it wanted to but the PCR extensions
have to stop otherwise the TPM's PCR state won't match the log in the kexec'ed-to kernel. I have
seen that on PPC64 some processes are being kicked off by kexec 'exec' that end up causing TPM
driver error message due to what seems to be a shutdown of the driver subsystem at this point.
I am not sure what an elegant method would be to stop PCR extensions. Maybe a flag on the level
of IMA would do? Or notifying the TPM driver to reject PCR extensions or just any command?

    Stefan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
