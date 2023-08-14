Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D845C001B0
	for <kexec@archiver.kernel.org>; Mon, 14 Aug 2023 02:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:To:Subject:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p9rsYiGhwMDNytkekGzLHaBWLZoWpohvO19p8B9S0UA=; b=OO+f/To/yJCJ7K5E1Y3qTi7Sr1
	tHmwhdwSfRUMNHgiIvKNI9x8bnqoTtCM9Ibno01ls2gY/tfYlbzEvJsjSeMRSVHRbiEntliJJOUoI
	u2o7NzgkstV0Q96a6/ZlYLu66J+8S3///GcQi2J33yw7s0cAIs6HM1UuSKQvLMQmGocCUBVzZkZoV
	ZE/kX0uCZsDO941nNCGM9wu2BAQ1I5PCErvnxazMc7lAM4Qd/aUYOJpBkmK+JuEi3F1ZuFoV1LOG+
	bmyO9WGfX0kokVo87hYqdYpqkjElpIpEcZalspoBSWHQCaNFe4PbywgZV4kAXXL5Q5oQtHIjcKeQt
	XdXOoMUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVNcZ-00G1tL-2F;
	Mon, 14 Aug 2023 02:47:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVNcV-00G1sr-1P
	for kexec@lists.infradead.org;
	Mon, 14 Aug 2023 02:47:54 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E2aP7H000600;
	Mon, 14 Aug 2023 02:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dZ5RaQ14VzBWOImUEARLesn39jmdLfDHVSXi/8zqd+4=;
 b=jGiv9MKqI0SLigsG/GZCIIHoUE4yrpSm4Bv5UtlQD2s3aH8qd13otwL6r1VBRrR52Fch
 ES1g2gK+i1YgHqEDm/t14UEeLTGK2dLXi9x91aUjQwId+1u1E1WV2AwyUQvx7VWKcIIh
 /b2zmVWEmRkGDSnSo+pveLzdyVxjnfD4vT/mip9gdltT7iHGQSE2kdUYxmc9xxmL+F73
 3PPKyYtBsnIphw6ZAI1vSEwi/Tfe0yqwCTHxuSIY3PAyRS3EHIaJ/SaeR4PuS5f2OJc0
 t+BQX67215t2p/QWHHCKvIHDjw5UurcqU5W6YUGIl/OMI2T555It5TEFmOIY4QUae/rB 8g== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfbh0gaa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 02:47:39 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E0q3Bq002403;
	Mon, 14 Aug 2023 02:47:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendmrgh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 02:47:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37E2lZOP23659084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Aug 2023 02:47:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C451720043;
	Mon, 14 Aug 2023 02:47:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DBCF20040;
	Mon, 14 Aug 2023 02:47:35 +0000 (GMT)
Received: from [9.43.3.22] (unknown [9.43.3.22])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Aug 2023 02:47:34 +0000 (GMT)
Message-ID: <d92decbb-768c-27e7-8c0b-eea662a86670@linux.ibm.com>
Date: Mon, 14 Aug 2023 08:17:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [ANNOUNCE] kexec-tools v2.0.27 preparation
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, kexec@lists.infradead.org
References: <ZNXjs19UOvGEl/5K@vergenet.net>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZNXjs19UOvGEl/5K@vergenet.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fLEsrPdjdH8_vdmBwAhSBQwYIbnUAh8v
X-Proofpoint-ORIG-GUID: fLEsrPdjdH8_vdmBwAhSBQwYIbnUAh8v
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1011 suspectscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_194751_720142_8379D77D 
X-CRM114-Status: GOOD (  20.75  )
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

Hello Simon,

Can we include below fix?
https://lists.fedoraproject.org/archives/list/kexec@lists.fedoraproject.org/thread/O3W4SLVVFT6J25U5YSXNZ3URZ4QY6SRU/

Thanks,
Sourabh

On 11/08/23 13:00, Simon Horman wrote:
> Hi all,
>
> I am planning to release kexec-tools v2.0.27 in the next two weeks
> to roughly coincide with the release of the v6.5 kernel.
>
> I would like to ask interested parties to send any patches they would like
> included in v2.0.27 within one week so they can be considered for inclusion
> in an rc release.
>
> For reference the patches queued up since v2.0.26 are as follows.
>
> Thanks to everyone who has contributed to kexec-tools!
>
> f67c4146d7b5 arm64: Hook up the ZBOOT support as vmlinuz
> fc7b83bdf734 arm64: Add ZBOOT PE containing compressed image support
> f41c4182b0c4 kexec/zboot: Add arch independent zboot support
> 1572b91da7c4 kexec: Introduce a member kernel_fd in kexec_info
> 714fa11590fe kexec/arm64: Simplify the code for zImage
> a8de94e5f033 LoongArch: kdump: Set up kernel image segment
> 4203eaccfa92 kexec: __NR_kexec_file_load is set to undefined on LoongArch
> 63e9a012112e ppc64: Add elf-ppc64 file types/options and an arch specific flag to man page
> 806711fca9e9 x86: add devicetree support
> 29fe5067ed07 kexec: make -a the default
> e63fefd4fc35 ppc64: add --reuse-cmdline parameter support
> 8fc55927f700 kexec-tools 2.0.26.git
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
