Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26C2C2BD09
	for <kexec@archiver.kernel.org>; Fri, 12 Jul 2024 04:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Owb3Pq9qXPRTZKOUJb55aRcd2lK7BHdH9+GAguTqo5Y=; b=erYF6l0DzXSeFV
	cgLOzSCU9BWnkEGWJVQ74W6+2uftqOqanUofXPf3E0Q/OuBPZddKJcvF0pIiIN0GKrzRv8dv1viLq
	P34EyJVp0GEPql3sV+IO/dGMbyRee6bB6dDbMw0NuCI1caWdX3KhLwoxc2mEX8rqawqMTZSoUe9XV
	c2vqQHQeQcjMrSQne6wd4YKSQAaS/fI4Yd4zMGi2qqnM4jeVM/BGWYV3iNMcvE0o1KiGRxlvYceU8
	1uBLdTM8KMTQswHrfo2EV6YS1XcxzNmoool0Qg+aFCzlUoawJJIataEGD6A3AHbuqeYjRGvnu+f4d
	0ecD0i5S/YWk+CR7jnEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS7vP-0000000GO5q-29Z8;
	Fri, 12 Jul 2024 04:30:27 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS7vL-0000000GO55-20N9
	for kexec@lists.infradead.org;
	Fri, 12 Jul 2024 04:30:25 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C4RE6D021833;
	Fri, 12 Jul 2024 04:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=1
	zOVV4QHtjkS/1m/+veVhz4yMLjjRvy4S5mRVNpptow=; b=SFhgyT7EM7p8G/UQD
	IlPWpM1jKGWBA5LaiwjjS9m1Vh0spNEFVXiNgG46wRcyeLk1Oqhiws2sFtPiQsvK
	YIAuRcO+XpFl53XrucoubfKvjyRtSMubC2CrFtcxSnoTyccPciaPQ3/O9snb4TGB
	bjhnA0fjVRoG9X6leqSLMV5m7Y+Ow4Q+Fl88S17PifeGub1uMjJp3RGtX37EYC3o
	Kp9Q8entqCshBmswaVkitYyLw/ygI2SXJ88F/viHMJt+pGqDqKryD5WDj6NWUy1r
	fhXeBre0xqfyGgAQRfqjE8VWo9c75Rv3lfDnuyo/O3Il8DurA80DdaUDpJeKroLQ
	GmzgA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40atdtgep2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 04:30:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46C2kovv024583;
	Fri, 12 Jul 2024 04:30:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrn4j80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 04:30:16 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46C4UCMU18547162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 04:30:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB5320043;
	Fri, 12 Jul 2024 04:30:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2B2320040;
	Fri, 12 Jul 2024 04:30:10 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jul 2024 04:30:10 +0000 (GMT)
Message-ID: <59d88de7-369a-44e8-a965-109c8690869e@linux.ibm.com>
Date: Fri, 12 Jul 2024 10:00:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
To: Petr Tesarik <petr.tesarik@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Petr Tesarik <petr@tesarici.cz>,
        Petr Tesarik <ptesarik@suse.com>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240711103409.319673-1-petr.tesarik@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1NvJa-aqowZkCC7asWwgmigPWhVS0Kez
X-Proofpoint-GUID: 1NvJa-aqowZkCC7asWwgmigPWhVS0Kez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_02,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407120029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_213023_776279_8E924DEF 
X-CRM114-Status: GOOD (  22.48  )
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

Hello Petr,

Just want to mentioned few points about the commit message. No strong
opinion on changing the commit message.

On 11/07/24 16:04, Petr Tesarik wrote:
> From: Petr Tesarik <ptesarik@suse.com>
>
> There is no reason to restrict access to this attribute, as it merely
> reports whether crash elfcorehdr is automatically updated on CPU hot
> plug/unplug and/or online/offline events.

Now, it is not just elfcorehdr; there could be multiple kexec segments 
based on the architecture's needs.
For example, on PowerPC, it is elfcorehdr and FDT.

>
> Note that since commit 79365026f8694 ("crash: add a new kexec flag for
> hotplug support"), this maps to the same flag which is world-accessible
> through /sys/devices/system/memory/crash_hotplug.

The previous comment is more relevant for the kexec_load system call.

For the kexec_file_load system call, the kexec flag introduced in the 
commit message
mentioned above is irrelevant. Building kernel with CONFIG_CRASH_HOTPLUG 
is enough.

> Signedoff-by: Petr Tesarik <ptesarik@suse.com>
> ---
>   drivers/base/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index c61ecb0c2ae2..73d69791d0d3 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -308,7 +308,7 @@ static ssize_t crash_hotplug_show(struct device *dev,
>   {
>   	return sysfs_emit(buf, "%d\n", crash_check_hotplug_support());
>   }
> -static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
> +static DEVICE_ATTR_RO(crash_hotplug);

I agree, it doesn't have to be readable by admin only.

Acked-by: Sourabh Jain <sourabhjain@linux.ibm.com>


Thanks for the patch.
- Sourabh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
