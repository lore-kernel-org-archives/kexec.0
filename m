Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27372C3DA64
	for <kexec@archiver.kernel.org>; Thu,  1 Aug 2024 08:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=if1d+I2A/9HKa7xckydKc+w13Cjj0uV5cjFNloPE0eg=; b=1dQBfYGuNhbAoq
	jyg/1tGJ/gIEjhoGC4IDmGuRcgk3PwGTFf3WeCtfKvy+r8Iu5yc9mLO5Zr0CR86dkFlZJGxim50rW
	X9pkUBvqrWoLouC2J2B5R9pEdmliH1lg3MQYz7iHrf8n/QU6OiIs527HaPFkZetpsskg3OTy3acmO
	BDmWHpIU88wK+/kbDvGDIGV0JMFp+/6VGGNU3NRP0xFcvl1/2OwknXSJArC42AphNQWXbTz76GDhS
	KQOpUosmhdg5rS6E6sVXo0OIub+fBOTAYQTDb5F2CzFKTOKpeXtKQ4LZOJUqg3XYwb9a53bgS+Cgx
	BW1NPFY69mVH7QP/Vn+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZQq1-00000004Hjl-2FzW;
	Thu, 01 Aug 2024 08:07:05 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZQpy-00000004HiJ-0bel
	for kexec@lists.infradead.org;
	Thu, 01 Aug 2024 08:07:04 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4716TZk5025652;
	Thu, 1 Aug 2024 08:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=z
	EJ35kZA6S/kXGZD/9MxIB1NcUqP6U4ESYSerPwyfa8=; b=eQHR7tPxPlEQPCGue
	pFavgZHzwVk+OcKBpTMeB0eoO7sQpIwFz04kVwAqFZRtrSbEpdYMmhyNrdxvAbMu
	kge5VxgXc/shTm76iOAgRNCY6hJe/1cJSgXXv2fuZbjrkv5/wZj0VZ1qiYrXbita
	ZLvrbYAWA+VT9w/tjN9iqGFf0TUzVccacyadWbUuIVMN7O9mkAjrdpw9CMOWtPTK
	pu3kfQkZHsFgtnnyj7dTsswLkMC4FXS220tNml3kY9bcQwY3BAqxmXrtzTU8XY57
	KhSzlh+S+EVmg+hPrWh/uJPS35VO/1wG26ieTCz9jb5xO0t1T8N4YU6aMpgFEjsk
	8rwsg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r54u06ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 08:06:55 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47186sN9030950;
	Thu, 1 Aug 2024 08:06:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r54u06nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 08:06:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47183b9n018969;
	Thu, 1 Aug 2024 08:06:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q0m6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 08:06:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47186oka57344276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 08:06:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06F2120040;
	Thu,  1 Aug 2024 08:06:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D22F20043;
	Thu,  1 Aug 2024 08:06:47 +0000 (GMT)
Received: from [9.43.79.112] (unknown [9.43.79.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 08:06:47 +0000 (GMT)
Message-ID: <b7a52f5b-df93-476b-a9b1-931fad1474e0@linux.ibm.com>
Date: Thu, 1 Aug 2024 13:36:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
To: Baoquan He <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <Zqs8veRya7v/pXEt@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Zqs8veRya7v/pXEt@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EmUxLjMbJNMxGW1YDEzR98PdsVJe6uf0
X-Proofpoint-ORIG-GUID: qj94FuyCbc8v7B-LkClrnY6NYyMkaLDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_04,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 mlxlogscore=864 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240801_010702_642136_967540BB 
X-CRM114-Status: GOOD (  12.49  )
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

Hello Baoquan,

On 01/08/24 13:13, Baoquan He wrote:
> On 07/31/24 at 08:57pm, Sourabh Jain wrote:
>> The following errors are observed when kexec is done with SMT=off on
>> powerpc.
>>
>> [  358.458385] Removing IBM Power 842 compression device
>> [  374.795734] kexec_core: Starting new kernel
>> [  374.795748] kexec: Waking offline cpu 1.
>> [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>> [  374.935833] kexec: Waking offline cpu 2.
>> [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>> snip..
>> [  375.515823] kexec: Waking offline cpu 6.
>> [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>> [  375.695836] kexec: Waking offline cpu 7.
>>
>> During kexec, the offline CPUs are brought online, which triggers the
> Is this a generic action or specific on ppc about the offline CPUs being
> brought line during kexec?

I think it is powerpc specific.
Patch that introduced this on powerpc: e8e5c2155b003 ("powerpc/kexec: 
Fix orphaned offline CPUs across kexec")

- Sourabh Jain


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
