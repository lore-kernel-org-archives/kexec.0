Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CE9C4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 13:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k9erlWmlDCRKV2DsFXiRJrqBVBEL2xnxQEPm0pKK6nc=; b=YTo/SrZzP8vmvz
	yBg+NdkYhegN3yFEREGaUDAd/Ly234GK3JjbYngiI3jCUPaOtxXDdqk5qarm5EE/Y/y77aq/j8J/s
	+5cRM35Av1cN4VpX1mAxZYijNiq788TAuks2KMn7ietIJALTSf6wlPDd0SEPwgWbJi8k7RevPx9uc
	etIGJmDBSoCBTdZk1j3kMoaOrvTQyoSyQ7/PkUv2yAgQPE6O000cOXHZVkUadtu2hsnXxUrgkGBm0
	JnnWqJ1mWBFbCusd0Snm6OhdVagK70tQGQAyNTlCG0KRj4nuI22O2oEL+v8zu6uzK5WP8KkFAZO0r
	2Y5l+UFl0YtbpH8PBJpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7yDr-005Oo1-35;
	Tue, 28 Nov 2023 13:33:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7yDo-005OnR-1C;
	Tue, 28 Nov 2023 13:33:53 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASC5h0j014950;
	Tue, 28 Nov 2023 13:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=hESqDSNNAellCERePN1U2wbTqOxBU+IMLun7hwIqHyg=;
 b=NL2dLL0DvdyQbKVJzt3NHj5PJ9gGnO1k9a82DcytKAZzRtDLWurxJYITVo6WjkVE+Wg0
 I40u0JcmSVgyiOHhkvMRH4xxDLmZh98yuOZyihcGmIZiBmWUI5rmSZ7KG0R5kuFUlknC
 UqvHn6cJU+7IM4tqxkFc+Am4XM/rQMnWqDv4kzZa+fo4stgYmPeVBO6QlF76PNCl4cQE
 ftFCt5AQr0ztwCWyOftS7igiz5VbmiMibqztBYaUfD5qnI/tRoggKb72l0O5Fyvt57Hz
 KvrjTt4gt+fWE1tr1YUDuskc0QXmbGbczyyt9duV8Le7aoA3AC4j5Aop01aZ8EBZ1mMa rg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unfbg36fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 13:33:45 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASDULbd024505;
	Tue, 28 Nov 2023 13:33:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unfbg36f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 13:33:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASDTCMj027610;
	Tue, 28 Nov 2023 13:33:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumyg2xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 13:33:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASDXfEe30147138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 13:33:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CC5920049;
	Tue, 28 Nov 2023 13:33:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6138820040;
	Tue, 28 Nov 2023 13:33:40 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.44.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Nov 2023 13:33:40 +0000 (GMT)
Date: Tue, 28 Nov 2023 14:33:38 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        ignat@cloudflare.com, eric_devolder@yahoo.com
Subject: Re: [PATCH v2] kernel/Kconfig.kexec: drop select of KEXEC for
 CRASH_DUMP
Message-ID: <ZWXsMvkf8vvRUpYR@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231128054457.659452-1-bhe@redhat.com>
Content-Disposition: inline
In-Reply-To: <20231128054457.659452-1-bhe@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 64QzWJwVKOLBFlmU1jABrlIZ9QsGVZuR
X-Proofpoint-ORIG-GUID: ktx8MhTbS_gn0F1YuN7_xjpJHLKBDBPx
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_14,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=921 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_053352_414527_41B2E67C 
X-CRM114-Status: GOOD (  21.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Nov 28, 2023 at 01:44:57PM +0800, Baoquan He wrote:
> Ignat Korchagin complained that a potential config regression was
> introduced by commit 89cde455915f ("kexec: consolidate kexec and
> crash options into kernel/Kconfig.kexec"). Before the commit,
> CONFIG_CRASH_DUMP has no dependency on CONFIG_KEXEC. After the commit,
> CRASH_DUMP selects KEXEC. That enforces system to have CONFIG_KEXEC=y
> as long as CONFIG_CRASH_DUMP=Y which people may not want.
> 
> In Ignat's case, he sets CONFIG_CRASH_DUMP=y, CONFIG_KEXEC_FILE=y and
> CONFIG_KEXEC=n because kexec_load interface could have security issue if
> kernel/initrd has no chance to be signed and verified.
> 
> CRASH_DUMP has select of KEXEC because Eric, author of above commit,
> met a LKP report of build failure when posting patch of earlier version.
> Please see below link to get detail of the LKP report:
> 
>     https://lore.kernel.org/all/3e8eecd1-a277-2cfb-690e-5de2eb7b988e@oracle.com/T/#u
> 
> In fact, that LKP report is triggered because arm's <asm/kexec.h> is
> wrapped in CONFIG_KEXEC ifdeffery scope. That is wrong. CONFIG_KEXEC
> controls the enabling/disabling of kexec_load interface, but not kexec
> feature. Removing the wrongly added CONFIG_KEXEC ifdeffery scope in
> <asm/kexec.h> of arm allows us to drop the select KEXEC for CRASH_DUMP.
> Meanwhile, change arch/arm/kernel/Makefile to let machine_kexec.o
> relocate_kernel.o depend on KEXEC_CORE.
> 
> Fixes: commit 89cde455915f ("kexec: consolidate kexec and crash options into kernel/Kconfig.kexec")
> Reported-by: Ignat Korchagin <ignat@cloudflare.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm/include/asm/kexec.h | 4 ----
>  arch/arm/kernel/Makefile     | 2 +-
>  kernel/Kconfig.kexec         | 1 -
>  3 files changed, 1 insertion(+), 6 deletions(-)

On s390:
Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
