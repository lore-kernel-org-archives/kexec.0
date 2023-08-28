Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF88C83F11
	for <kexec@archiver.kernel.org>; Mon, 28 Aug 2023 06:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sP89zBNhbMcKVNX4HtoyoEwcolgJLHyerWjNM5Ku7+k=; b=Spe0sOFskf3xoXDd7wlgb6q56I
	fdI21Qqe+EFWpOBgmlv+OsFpEjKsNYGsV0c+otglFCY8ri1Ad02I36RmdWZB4YPit+GQSDWaY/++A
	5ciIZnTk9zjrAAdG9ti6iiKHIaZDc80tV74SzI7XgVGjCr4gzoh2dJDby2CjOiPH2bapM3vB0NmOd
	NTtrkg9VP3EoM9F0o6C6osjTrRauZF8+YXTMLd9vP2U/zoX5hfjP+yuxB/rw2idYq+khuXwkvn+VA
	WKwPzdnDRI+tzD1vlzZcGaGjfIM3d9BiyViNq1WWkFEyfnKbEYuSnL4BXJYP2DbV8CJFfr2mgXDP5
	dkddLlTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaVY4-008wIT-0B;
	Mon, 28 Aug 2023 06:16:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaVY0-008wHP-15
	for kexec@lists.infradead.org;
	Mon, 28 Aug 2023 06:16:25 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S3UjcE025254;
	Mon, 28 Aug 2023 06:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BrpM+0SPkDpGjgOdzPooS4TQ40M6SgNZ+qZ41GLgf+Y=;
 b=o4w8EFkvoMo+tGm2RnZ42toc7TUMwZ2Razd6jqxmai+fbQd1pawlwsrpZPbVEUK/zbN6
 Iv0z9IMRx7sLIEQtkAonAwogxFUc76uiBfj9f34UwhBvSTt8ts0HP1tvAIyJ5nCPTf6U
 Y5feCi6PmaoezG4WOZGsz36lORqvzhFCkOA/dfdKJG0OxuhSVEJ1tlrsH7F6Yn2mQkUa
 T92J5DXluLLcpa25N7TZUrLMBuHmtGgvRmwK17MriLaasjFP3Bk3p0pX6ZA/ovj5mGJt
 32UWMk/zHlm2P4o3MpvIcd2N97/aLDMVmqSkungBCRVRuky45d98bM8jB9aTYwSyPxNA yg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr9j23qbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Aug 2023 06:16:19 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37S4dwwa014406;
	Mon, 28 Aug 2023 06:16:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqvqmrg1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Aug 2023 06:16:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37S6GGZ745613788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Aug 2023 06:16:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44F7F20043;
	Mon, 28 Aug 2023 06:16:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F84820040;
	Mon, 28 Aug 2023 06:16:15 +0000 (GMT)
Received: from [9.203.106.137] (unknown [9.203.106.137])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Aug 2023 06:16:15 +0000 (GMT)
Message-ID: <63e65749-4ec7-c618-72d3-1568992fff7a@linux.ibm.com>
Date: Mon, 28 Aug 2023 11:46:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] kexec: update manpage with explicit mention of clean
 kexec
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
To: Kexec-ml <kexec@lists.infradead.org>, Simon Horman <horms@kernel.org>
References: <20230707052929.427625-1-hbathini@linux.ibm.com>
In-Reply-To: <20230707052929.427625-1-hbathini@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UKnBw24MfiDtpkCyuSxIEKuWiwvY_lSE
X-Proofpoint-ORIG-GUID: UKnBw24MfiDtpkCyuSxIEKuWiwvY_lSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_03,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280055
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230827_231624_516793_8A1D79CF 
X-CRM114-Status: GOOD (  23.50  )
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

Any comments on this, please..

On 07/07/23 10:59 am, Hari Bathini wrote:
> While the manpage does mention about kexec boot with a clean shutdown,
> it is not explicit about it. Make it explicit.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>   kexec/kexec.8 | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/kexec.8 b/kexec/kexec.8
> index 3a344c5..87e4ab5 100644
> --- a/kexec/kexec.8
> +++ b/kexec/kexec.8
> @@ -95,8 +95,16 @@ then you would use the following command to load the kernel:
>   .RB "\-\-append=" "root=/dev/hda1" "\ \-\-initrd=" /boot/initrd
>   .RE
>   .PP
> -After this kernel is loaded, it can be booted to at any time using the
> -command:
> +After this kernel is loaded, assuming your Linux distribution supports
> +kexec-based rebooting, it can be booted to, with a clean shutdown, using
> +the command:
> +
> +.RS
> +.BR reboot
> +.RE
> +.PP
> +Alternatively, it can also be booted to, without calling shutdown(8), with
> +the command:
> 
>   .RS
>   .BR kexec \ \-e

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
