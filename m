Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E0EC001DF
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 21:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PuI6umjU3qp3B3/0auwZarRG5V3PUqQCpfCzmYrJEmw=; b=3rdUBOIoES6NJl
	hz5cvpr1eVic0vdtwJ/IXqgyVAZZSdZ9jGvkBwKhBtQFT5ZpvhU2IJqHyzFrd6uLutdAuwJO9BNIj
	PvsYLNblXXPMsIqJKuG7hklIFwv2TInUIncvDw3jeJH1wBL8Dioe1+4rFB3x1wLOybHNacZceQdsD
	Rg60EK+TpSFGQFVdr+pJfHOPyyoU0c2SZl/IM2rNHqESZLsyx70Qd5m443Dx21aFH5JJ8uJSmv1+E
	DJWgU/jiGfaqWx3pNNIY4zF0Pj24Q5r/TlkjoRh9QlYaB+MvH+gP6uBeZsJHxv1RMqtkVHmlU+zft
	o7OOgQd2j++DFmy85HLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtww9-0032eW-2u;
	Fri, 20 Oct 2023 21:21:41 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtww3-0032dB-17
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 21:21:40 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KLEbwL015717;
	Fri, 20 Oct 2023 21:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OJqk9oRTwKuB1dVSpV+Rl3kAJfUn/HziALgIchb9yhg=;
 b=ZyW4YlMLLCBMlFa4YluFjx2qPekekMfx066X/hX36iE2IU3z1QECd5rBGLoHAFvLItO9
 P39D6Y/x6ggOFN67BDxZrUDBCuAi7MEkf2C/NKmfKQi+ZVmCWo7Wy15f3vjSj4hgi7Ho
 LpSnlgZYVcKcC1Aat3z+5MI+QErh/c3chNma14wOk98lAdlMqj/OszrSGs68phasftCe
 GjB1GlpSYeaE4/TQguagSaUW8hRagtnIyRHLnh8FQimtUMQLr8epflazSlF8zUT1ODpM
 obq91f7LOn+PNnOeyUF3t0NXM4rQY8/PD7Xs1V9efgkZpryWZDIQjd4YqCD3gv93lWfE Jg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tv19q872d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 21:21:10 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39KKY0q8029895;
	Fri, 20 Oct 2023 21:21:10 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc47qdf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 21:21:10 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39KLL9av5178036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Oct 2023 21:21:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3225858059;
	Fri, 20 Oct 2023 21:21:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 419815804B;
	Fri, 20 Oct 2023 21:21:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Oct 2023 21:21:08 +0000 (GMT)
Message-ID: <f60a08b3-408b-05e0-2c91-9c19159c7fd2@linux.ibm.com>
Date: Fri, 20 Oct 2023 17:21:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/7] ima: refactor ima_dump_measurement_list to move
 memory allocation to a separate function
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-2-tusharsu@linux.microsoft.com>
 <2c06f9c5-6f3a-b163-20ca-24178d7cba4e@linux.ibm.com>
 <9b227c0a-ddb3-b1c3-4ed0-e3e740db7788@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <9b227c0a-ddb3-b1c3-4ed0-e3e740db7788@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QrmFz3OpKob0DBTxcJcEGDoqRDdenUNx
X-Proofpoint-GUID: QrmFz3OpKob0DBTxcJcEGDoqRDdenUNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=957 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_142135_732616_100B7D3E 
X-CRM114-Status: GOOD (  14.03  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Ck9uIDEwLzIwLzIzIDE2OjMzLCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4gVGhhbmtzIGEgbG90
IFN0ZWZhbiBmb3IgcmV2aWV3aW5nIHRoaXMgc2VyaWVzLgo+IFJlYWxseSBhcHByZWNpYXRlIGl0
LgoKCllvdSBhcmUgd2VsY29tZS4KCldoYXQgbWF5IGJlIGEgYml0IHByb2JsZW1hdGljIGlzIHRo
ZSBmYWN0IHRoYXQgYmV0d2VlbiB0aGUgdGltZSB0aGUgCmJ1ZmZlciBmb3IgdGhlIGZsYXR0ZW5l
ZCBJTUEgbG9nIGlzIGFsbG9jYXRlZCAoa2V4ZWMgJ2xvYWQnKSBhbmQgdGhlIAp0aW1lIGl0IGlz
IGZpbGxlZCAoa2V4ZWMgJ2V4ZWMnKSB0aGF0IHRoZSBsb2cgbWF5IGdyb3cgcXVpdGUgYSBiaXQu
IEkgCndvdWxkIHNheSB0aGF0IHRoZSBzaXplIG9mIHRoZSBncm93dGhzIG1heSBkZXBlbmQgYSBs
b3Qgb24gaG93IHBlb3BsZSAKYXJlIHVzaW5nIHRoZWlyIHN5c3RlbSB0aGF0IHRoZSBhZGRpdGlv
bmFsIGtpbG9ieXRlc8KgIG1heSBvciBtYXkgbm90IGJlIAplbm91Z2guIFNvIGEgZGlzdHJvIHdv
dWxkIHByb2JhYmx5IGhhdmUgdG8gc3BlY2lmeSBhZGRpdGlvbmFsIGJ5dGVzIHRvIAphbGxvY2F0
ZSBmb3IgbGlrZSB0aGUgd29yc3QgY2FzZS4gQnV0IGhvdyBtYW55IGtpbG9ieXRlcyBpcyB0aGUg
d29yc3QgY2FzZT8KCiDCoMKgIFN0ZWZhbgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
