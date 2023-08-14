Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E59BC001B0
	for <kexec@archiver.kernel.org>; Mon, 14 Aug 2023 03:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wbKtZLbNoR+n8M7oHg3Hl4m/koPNo9zoz8alJ+muSBA=; b=sIGo1R0ZLKyh9m9E9Dz2ibyM5m
	jYi/3ktmn516V39Ylt1NtfZnOp4/N0NmAZra7bZgpkr8PC1YoWfTYfDlAq+PcXOeBGtEac/uqRVA8
	cSKGf92pmV9C0LkF2Ko/4POqmsrMxH9E8BU17XXaWkUDs4MF1Ce+d/Zb612l3MhwUzlQFWIRuU2JY
	hbLZJxJiuEzp/hU2c01aGsEduYj4MHfNOGHB16BLubYd3ZRf4BYkz2CdzfC4qaubuKWy4LXGJD/+u
	OftLtoG5VvIiSVxebEgxThSLVJXJgIEFWI5SNye0vztZ5SgOJQbyIWfPXU7NEixfwOdElVN1HmZV6
	YY2xGVUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVOb1-00G5r0-2Z;
	Mon, 14 Aug 2023 03:50:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVOay-00G5qU-2P
	for kexec@lists.infradead.org;
	Mon, 14 Aug 2023 03:50:22 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E3Qmre000787;
	Mon, 14 Aug 2023 03:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7Qpap9VCLg8cuj1k1eLi5wa37OKohJQ+CQhWCHahuY8=;
 b=jMzV98CJyDUC5lE+3AHRCLoKNaywrbGT+pyow/02LEwnZwVE4wXCYyqJlE8+p+iN6RwL
 VRrOfLxRzpfbJ1ZAFG9GbVucNpec6g+tezBCv6o8zRRxRGdPdSuoxdLPnNgQnbQoqpSM
 D8Xj0pXZosSwil3FJ5o4I/A+xMNe1M8+jNONh53HORHSYaTy/ulPEkkaBptbuYwwoWMv
 G+R8ETueFAcnL7z2W5/U0vQVkkLKiLVEUauvfO1B2qPMoepv5UCzqnXX4sQVsYSfl17B
 Mipv8nweGcWaC7rw/ODQ9kApu5xJ8sRE9oN3/Q4uN8Is42rAQPxpsjnhnR6kqRWh9V99 Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfccd8kqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 03:50:15 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37E3mbVJ002687;
	Mon, 14 Aug 2023 03:50:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfccd8kqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 03:50:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E1cPQl007832;
	Mon, 14 Aug 2023 03:50:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwjrnxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 03:50:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37E3oBSg41157006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Aug 2023 03:50:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C1662004E;
	Mon, 14 Aug 2023 03:50:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D00520040;
	Mon, 14 Aug 2023 03:50:10 +0000 (GMT)
Received: from [9.43.3.22] (unknown [9.43.3.22])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Aug 2023 03:50:10 +0000 (GMT)
Message-ID: <a35b5b18-de90-5570-a296-44d110709a29@linux.ibm.com>
Date: Mon, 14 Aug 2023 09:20:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [ANNOUNCE] kexec-tools v2.0.27 preparation
Content-Language: en-US
To: Coiby Xu <coxu@redhat.com>
Cc: Simon Horman <horms@kernel.org>, kexec@lists.infradead.org
References: <ZNXjs19UOvGEl/5K@vergenet.net>
 <d92decbb-768c-27e7-8c0b-eea662a86670@linux.ibm.com>
 <ymdn754ihzovgpgoikjnpwueqx6zzmgcempvlr6bsn5rx3mwrw@62dmgvygv4eo>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ymdn754ihzovgpgoikjnpwueqx6zzmgcempvlr6bsn5rx3mwrw@62dmgvygv4eo>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _p3V5BAuDtfxOT--FbAnql3wzyuQoMNm
X-Proofpoint-GUID: 3Qu2JGjR6KVB2vIPxt5xFSY-9JoLl1VR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_205021_032494_3E77FC84 
X-CRM114-Status: GOOD (  22.42  )
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

Hello Coiby,

On 14/08/23 08:49, Coiby Xu wrote:
> Hi Sourabh,
>
> On Mon, Aug 14, 2023 at 08:17:34AM +0530, Sourabh Jain wrote:
>> Hello Simon,
>>
>> Can we include below fix?
>> https://lists.fedoraproject.org/archives/list/kexec@lists.fedoraproject.org/thread/O3W4SLVVFT6J25U5YSXNZ3URZ4QY6SRU/ 
>>
>
> I'll review your patch! Note the patch is against Fedora's kexec-tools
> so it doesn't apply to this upstream kexec-tools. The relationship
> between Fedora's kexec-tools and this upstream kexec-tools can be
> described as follows,
> 1. Fedora's kexec-tools packages the kexec binary which is provides by 
> upstream
> kexec-tools; 2. The kexec binary is used for loading the kdump kernel 
> and initrd but
> it's not responsible for building the kdump initrd. Fedora's kexec-tools
> is used to build the kdump initrd instead.
> Currrently it's WIP to split current Fedora kexec-tools into
> kexec-tools, kdump-utils, makedumpfile and eppic. Hopefully after it's
> done, you and other uses will no longer be confused by the relationship
> between Fedora's kexec-tools and this upstream kexec-tools.

My Thunderbird filters mail from kexec@lists.fedoraproject.org and 
kexec@lists.infradead.org
to the same folder so I got confused. I should update my Thunderbird filter.

Thanks for clarification.
Sourabh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
