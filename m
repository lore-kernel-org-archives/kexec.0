Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B280AEE645D
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 08:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MHI1xajy8GDN38SfAtlF9opN78JTH1r6OM4jNKQ2sQs=; b=hZVDxjW612hdZBbfHAn7f104Vr
	IGJq3NZi7JKkOMPtAnwXE5O1kXzxtVvJIPE7lI4Jkgp5/zEHDxqM4+Wu8ExpZURM7QQQFZIb52wox
	p4wk9YlqEf/9Hx8Zm9ArnAip3uUcaGw19xxharj+6Y2At339/3DSdOXK3KLolXouCRuOtQpKahy2E
	F68HXwaiG9UkFXpSIhBsaLa/4o+Gbt/aHIPWtIRi2i1kVhd+/vSaUlJ8HMh/KSOZEu3CxMyw+7Lvd
	0cAOmzvfUeD6oo1CMTATi5Cr8/f7nGUmSzarR7zw/JoE+zKDnNgCCUr+vnofYXiTQ1jqQUVRgTi1y
	ElXUK3mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soenz-0000000CIUf-2O2G;
	Thu, 12 Sep 2024 08:03:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soenv-0000000CITt-0Dep
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 08:03:53 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BMdOZb025206;
	Thu, 12 Sep 2024 08:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	oYpDSObymtP5trr0Dg3dxQpCaFYppzt85CDjuduwHw4=; b=WMj64vR/seYiXMx8
	nXRJ085pVG5oNXnL+JMhlh/DUT4v/J1X8uk2AjD/ylvQz0heepRoK4QwibbmaFYw
	RNuqMwvu0Tk9s1NQoHR3jYNwc20WwtaKXmO7h8aNK7Yp8lXGc3fg3SxtnsXf9u85
	ZlW2/xJ4ldWDtCPlS6dLx5ghAzidnKEsLdCaJInbYleJIppYlJU3ERLjO0VDpfa7
	fUyXBg3lD/pf1hnUAlFthQf+c5lwtu+sUjFZYyo3IRq0jspQXIp+SKzYVkNhaZlw
	F2hA1JUhN6oy5DKaM3kngv+ADL7pwDKU2aUFsrT+PXd+kR1oqfPTrzpG8rti5ChU
	rW/Abw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyt16t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:03:41 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48C83eC9025017;
	Thu, 12 Sep 2024 08:03:40 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyt16p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:03:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48C5jH8K003122;
	Thu, 12 Sep 2024 08:03:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15u6rhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:03:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48C83cX18651188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 08:03:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74D4A20043;
	Thu, 12 Sep 2024 08:03:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D26562004B;
	Thu, 12 Sep 2024 08:03:33 +0000 (GMT)
Received: from [9.43.115.177] (unknown [9.43.115.177])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Sep 2024 08:03:33 +0000 (GMT)
Message-ID: <f4dcb6b4-2da8-4355-9d89-8b41af30214d@linux.ibm.com>
Date: Thu, 12 Sep 2024 13:33:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] kexec/crash: no crash update when kexec in
 progress
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
References: <20240911112111.108056-1-sourabhjain@linux.ibm.com>
 <ZuGnH5R+FOC481V3@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZuGnH5R+FOC481V3@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tq5vb7peLAjR_5_8qxwGwQdcYnON-O-e
X-Proofpoint-ORIG-GUID: Gdw-KrRH0ymkfw_x-UoPGfWRmIMBalgj
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120055
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_010351_622162_810B31EE 
X-CRM114-Status: GOOD (  17.07  )
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

On 11/09/24 19:50, Baoquan He wrote:
> On 09/11/24 at 04:51pm, Sourabh Jain wrote:
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
>> To avoid kexec kernel boot failure on PowerPC, all the present CPUs that
>> are offline are brought online during kexec. For more information, refer
>> to commit e8e5c2155b00 ("powerpc/kexec: Fix orphaned offline CPUs across
>> kexec"). Bringing the CPUs online triggers the crash hotplug handler,
>> crash_handle_hotplug_event(), to update the kdump image. Since the
>> system is on the kexec kernel boot path and the kexec lock is held, the
>> crash_handle_hotplug_event() function fails to acquire the same lock to
>> update the kdump image, resulting in the error messages mentioned above.
>>
>> To fix this, return from crash_handle_hotplug_event() without printing
>> the error message if kexec is in progress.
>>
>> The same applies to the crash_check_hotplug_support() function. Return
>> 0 if kexec is in progress because kernel is not in a position to update
>> the kdump image.
> LGTM, thanks.
>
> Acked-by: Baoquan he <bhe@redhat.com>

Thank you for the Ack!

My understanding is that this patch will go upstream via the linux-next 
tree, as it is based on 
https://lore.kernel.org/all/20240902034708.88EC1C4CEC2@smtp.kernel.org/ 
which is already part of the linux-next master branch. - Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
