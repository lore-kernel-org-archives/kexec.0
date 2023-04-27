Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A8FC77B73
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 17:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nmisiJCVJS8J2NzG/dcboEXHCuU85ouu/FCWu+7ngO0=; b=bqSGJVrlWCLqEB43rcoHiaqlzD
	4OcD66J8/YH9XGfFREmaFKRNXXin31jXbbFgM76jtWRFCQ3uD1TO62hxj2jq+PrzYFqGh61lU30Gw
	59vrMA20f3qbhMw7a/+Tlhep/qwG4hfj8BLCy+0MNcIqDfbAaGgcVFBMdNHVzEyjTF5PazBqahJou
	KOoPyi0neip96NCT3cryQoHDlcLK/H/SOmQEmfUROwftudEmhcYOw0gnacIw/dwiRzVmtLZKPueQt
	MHdkXz4AnyNxmBwHrWskOhQp281QQOqPomOTsHPibbxdy8JeMa4jQZ7K+TSFevpECBIjb61AEq7y4
	7Fls5H5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ps5af-0078U4-0t;
	Thu, 27 Apr 2023 17:39:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps5ad-0078To-1U
	for kexec@bombadil.infradead.org;
	Thu, 27 Apr 2023 17:39:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YY1eU6KVInrSGsuCBJRKp3Lzn9FzZY/PlEZG2Tc12Fg=; b=UA+WsDKPSkXzWJatnxQl2+Z7IX
	RkXH0UlwDFhK08sMx8XHAHikFbUEx3txSpkyNZXADfg641uIKkdwOgHcnsl2H0IfqVTD7V1/hLuTI
	gBpcZeyL6vBnqd8z8hF4pHxnG/XOZTfYvCSHByT8bB7ytRI8Adqjk4FbtrnuB3RStFZxRXCk4jFCp
	dhUn8HH1qgUSEwISw25z53LSCDVInX2txTjPl3coZVFeX7tSUDMJ3Rrpmx+7VqkqRHlndMhRR9mQs
	u25rR4URhN/6Gcn3fRylmeP1TCe07IcxyxUtEFC1CP0+kzTugrMVlz/Yc062tcGdpK4Ct/IyaRSiM
	rhIgiD4w==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps4vv-00CSpg-2W
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 16:57:30 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RGuxhM022579;
	Thu, 27 Apr 2023 16:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YY1eU6KVInrSGsuCBJRKp3Lzn9FzZY/PlEZG2Tc12Fg=;
 b=CjqWT9rOhjjbV13zofGnBpLCj7LV/J9uD00YS+flu5zqYs8/GEYNEmZUwKcL2DGJtdnY
 ttmOqsdQi9MFzdIHM8TLYAf+TgnhC4CVnM4wSQN9lc39iKqhPCmYxE8XLuNLBxBmRWel
 gWFiG6Y8HZ5YmxWtySZzGHAsA7DH28fBUeHyT+1AvtuT2/i7ZWNAtaXRqWYjxVcsOVxy
 EoGoIfjRxlPWagzRzylwDQR3P7rN713nRzcFXYx61K3gelRAPW5nlDlTLB0cdNDLB0CO
 Z85nAJ9VfcYPWLiLM725O0azFe2W1LuEJuZV2TXYaSRGkz80A4n6t1vySrHEVSFLWIpk /g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7uq8tgvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Apr 2023 16:57:06 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33RGv4Wg023619;
	Thu, 27 Apr 2023 16:57:05 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7uq8tgu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Apr 2023 16:57:05 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33RCS5WW011043;
	Thu, 27 Apr 2023 16:57:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3q47772hu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Apr 2023 16:57:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33RGv0MQ23134860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 16:57:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02F7B20063;
	Thu, 27 Apr 2023 16:57:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6185A2005A;
	Thu, 27 Apr 2023 16:56:55 +0000 (GMT)
Received: from [9.43.104.115] (unknown [9.43.104.115])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Apr 2023 16:56:55 +0000 (GMT)
Message-ID: <409c8253-49b9-6993-f79e-8e6203ce4b31@linux.ibm.com>
Date: Thu, 27 Apr 2023 22:26:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v21 5/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-6-eric.devolder@oracle.com>
 <da95e01d-24bd-676b-3a48-bafda1b36cda@linux.ibm.com>
 <ZEo3NK/9Nkc7ctrc@bhe.users.ipa.redhat.com>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <ZEo3NK/9Nkc7ctrc@bhe.users.ipa.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gEeB348Y7Xvl-kPyBZag4ffOB8bhZsRx
X-Proofpoint-GUID: VH_7V8MsqvIwj1-Ty-x2nDl0oBq5U4re
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_175728_184633_45F02700 
X-CRM114-Status: GOOD (  22.26  )
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

On 27/04/23 2:19 pm, Baoquan He wrote:
> On 04/27/23 at 12:39pm, Hari Bathini wrote:
>> Hi Eric,
>>
>> On 04/04/23 11:33 pm, Eric DeVolder wrote:
>>> When CPU or memory is hot un/plugged, or off/onlined, the crash
>>> elfcorehdr, which describes the CPUs and memory in the system,
>>> must also be updated.
>>>
>>> The segment containing the elfcorehdr is identified at run-time
>>> in crash_core:crash_handle_hotplug_event(), which works for both
>>> the kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
>>> is generated from the available CPUs and memory into a buffer,
>>> and then installed over the top of the existing elfcorehdr.
>>>
>>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>>> the need to update purgatory due to the change in elfcorehdr was
>>> eliminated.  As a result, no changes to purgatory or boot_params
>>> (as the elfcorehdr= kernel command line parameter pointer
>>> remains unchanged and correct) are needed, just elfcorehdr.
>>>
>>> To accommodate a growing number of resources via hotplug, the
>>> elfcorehdr segment must be sufficiently large enough to accommodate
>>> changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
>>> only on the kexec_file_load() syscall; for kexec_load() userspace
>>> will need to size the segment similarly.
>>>
>>> To accommodate kexec_load() syscall in the absence of
>>
>> Firstly, thanks! This series is a nice improvement to kdump support
>> in hotplug environment.
>>
>> One concern though is that this change assumes corresponding support
>> in kexec-tools. Without that support kexec_load would fail to boot
>> with digest verification failure, iiuc.
> 
> Eric has posted patchset to modify kexec_tools to support that, please
> see the link Eric pasted in the cover letter.
> 
> http://lists.infradead.org/pipermail/kexec/2022-October/026032.html

Right, Baoquan.

I did see that and if I read the code correctly, without that patchset
kexec_load would fail. Not with an explicit error that hotplug support
is missing or such but it would simply fail to boot into capture kernel
with digest verification failure.

My suggestion was to avoid that userspace tool breakage for older
kexec-tools version by introducing a new kexec flag that can tell
kernel that kexec-tools is ready to use this in-kernel update support.
So, if kexec_load happens without the flag, avoid doing an in-kernel
update on hotplug. I hope that clears the confusion.

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
