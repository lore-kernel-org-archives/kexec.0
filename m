Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F49CC6FA82
	for <kexec@archiver.kernel.org>; Tue, 20 Sep 2022 04:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ET/6g9expBxiwJ2cRUezBlvRYoAca645wxLmEYx2UhU=; b=cDx0bbJckjRWvy
	EzSsnyRh+qTD0J7/ZKlujlQnp/eC5CgsEZwDEbM+engewqtkSETsFz8PV4PSTWu3pYeg/g4h8A/ok
	32vgKkbJ8X0JuxW2Bh0P//aijwfzMp0wB+VZDt2aX9xu8Th5VHzF3PKqcvVe2qWoOXv7w8LOtfdJV
	RrDfTaJy4YbSlJd5EzMP57QzYaT0oAOQyLfaeniRg83XpREsy0AetUVqrpKiljY9pYN428IOk6941
	KJV46XDTsNnk5I+cMzcR62PLr3CBL9MWtFMCWFDZDZiefZbetVrq8awjyMDEq/yT5ZIooqUUYCKaI
	eBa4Y0SSS679e5hT6ywA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaVEt-000WJP-Nx; Tue, 20 Sep 2022 04:52:07 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaVEj-000WH7-CN
	for kexec@lists.infradead.org; Tue, 20 Sep 2022 04:52:01 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K4jnFN014565;
	Tue, 20 Sep 2022 04:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ReNxDq+OXjoa0TuLmS1SPt5dXin5U+l/b//S056vBzY=;
 b=hslfgM/LuQMdXAkrOJVWE2+3siOi9b+hrSf9Wi2k7/984Pa/EuctEK+QtzbRSdBwny+B
 TWhWjnUDrUoq5SPZvwylEA/SWZA2MVeOM97AmTuVfySMK7TUS4rm4eExA0Q9r95T0e49
 UkgaCSBemeH+LPcbLB6c4tUlSy8eEh18L72oBF1t+/rZTe5ihunCP4XIYB/oTiPhgSIG
 BzOMFC0nYHmTP1zhXdOccHAvmG99Z2t/IVbpMur+x+V3YNWLUD1AKxz3ybLE9/uYgvuK
 OaUNQaNY9GS0N4RKIve5gZ7arwV8RVV3/8rhoyTRk7yeIrpsGp/sN2EYc5VmPNLE6eLd Sg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jq6se04cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Sep 2022 04:51:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28K4p5Ji030116;
	Tue, 20 Sep 2022 04:51:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma04ams.nl.ibm.com with ESMTP id 3jn5v8ka2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Sep 2022 04:51:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28K4pkli39256370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Sep 2022 04:51:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FE3E11C04C;
	Tue, 20 Sep 2022 04:51:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22DAD11C04A;
	Tue, 20 Sep 2022 04:51:45 +0000 (GMT)
Received: from [9.43.4.12] (unknown [9.43.4.12])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 20 Sep 2022 04:51:44 +0000 (GMT)
Message-ID: <b2133953-404f-7b03-7ae7-f25085e42766@linux.ibm.com>
Date: Tue, 20 Sep 2022 10:21:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] ppc64: remove rma_top limit
To: Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org
Cc: horms@verge.net.au
References: <20220915084240.133742-1-sourabhjain@linux.ibm.com>
 <3ec0476b-275e-8a12-72f0-780b5e08cb1c@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <3ec0476b-275e-8a12-72f0-780b5e08cb1c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tT8ofO2-dzwUqisGy_Hdz8qQ5SYqzyel
X-Proofpoint-GUID: tT8ofO2-dzwUqisGy_Hdz8qQ5SYqzyel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_13,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209200026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_215157_585593_BC78E939 
X-CRM114-Status: GOOD (  17.21  )
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


On 16/09/22 16:28, Hari Bathini wrote:
>
>
> On 15/09/22 2:12 pm, Sourabh Jain wrote:
>> Restricting kexec tool to allocate hole for kexec segments below 768MB
>> may not be relavent now since first memory block size can be 1024MB and
>> more.
>>
>> Removing rma_top restriction will give more space to find holes for
>> kexec segments and existing in-place checks make sure that kexec segment
>> allocation doesn't cross the first memory block because every kexec 
>> segment
>> has to be within first memory block for kdump kernel to boot properly.
>>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>
> Yeah. The restriction seems arbitrary. Even more so since commit
> 47478ea66d43 ("kexec-tools: ppc64: fix how RMA top is deduced")
> with which kexec_load was sure to place all segments within the
> first memory block. So, the change looks good to me.
>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>

Thank you!

Sourabh Jain


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
