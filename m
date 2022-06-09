Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458B3C43334
	for <kexec@archiver.kernel.org>; Thu,  9 Jun 2022 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4mpftyOHtALXX+cJS73CxoGC/JvEsjv4T9I1YoUljL0=; b=G9oY+zJxalSoYL
	D0T+9NtUJrO6nzvQPXHdTI87HxGx2woEO8oiZlNTDv6wZxcmADSaks2xy4na+/02f4tj7ohC9YdNr
	hoxCvvch/zk/zV3eN+CXRL1jg99SCmzZjisxsnU1jcMISugG/a0rlSu6pb7+Ig2229zAy4/st66xh
	Gw+vD2BG6/gtz/g3QV3JhPLIR/tHZ7pu6pUqi0Ht5Ua1d48fwx1fbI92yj74HA1V/We2GaTpJTUgQ
	WXuxI9lU/ELJhburv4GtNIZ5oJpZtlh1y038dCl31uSS8h4u1vGaa/12G7rNbZNR78712SjINoHr2
	qhOr3O3jZM9Uy2p1bx6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzKC8-002jtg-KR; Thu, 09 Jun 2022 15:35:36 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzKBx-002jsF-1h; Thu, 09 Jun 2022 15:35:26 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259FG4hg017446;
	Thu, 9 Jun 2022 15:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IchkCASojNLdXaRbIe3vwTkVh5EuNCQRY6UNYzSB5X4=;
 b=FQS9+sFoD5jRnXWBfloKmT7eWLA+bNeaabwUNUNYGWV73Ck0vJ8dMB36QIj/QWYfiQe+
 daiBNH5J/vdYAxRZQrsZHM/YmwfKpe3IbwJcMHuZXlKhdXUhpwyUkp94j558NSPM33zC
 kk6qDAeHJTT6YqT3EURpPBB7NEGbOV0fSaUbR2ZLuFHmmBNMCv5xcC1w31BbHfXYqoVD
 ZI7xeBtus0lga5VguIvf/xqUc+m6M0o/7S1wUGrUF+OpA3/27gSyC2oP8NLR6UHSdXEK
 3q9+Cv3vm+CDHvUDc+Obb0slH5IApp2YVHm4a6Y+sQjgqi+tYty/8UtDBCBttCSSFZ0x qw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gkkbn0etp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jun 2022 15:35:20 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 259FTk5P012091;
	Thu, 9 Jun 2022 15:35:20 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gkkbn0esr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jun 2022 15:35:20 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 259FJ4IZ022759;
	Thu, 9 Jun 2022 15:35:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03fra.de.ibm.com with ESMTP id 3gfy18wn92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jun 2022 15:35:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 259FZFeN10092836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jun 2022 15:35:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F7F7AE053;
	Thu,  9 Jun 2022 15:35:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AE74AE051;
	Thu,  9 Jun 2022 15:35:14 +0000 (GMT)
Received: from sig-9-65-64-6.ibm.com (unknown [9.65.64.6])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jun 2022 15:35:14 +0000 (GMT)
Message-ID: <5b11a8043f78ef5ca41254b8a46f78dca0a5b159.camel@linux.ibm.com>
Subject: Re: [PATCH v8 0/4] use more system keyrings to verify arm64 and
 s390 kexec kernel image signature
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Michal
 Suchanek <msuchanek@suse.de>, Baoquan He <bhe@redhat.com>,
        Dave Young
 <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman"
 <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>
Date: Thu, 09 Jun 2022 11:35:13 -0400
In-Reply-To: <20220527134315.afnuszqbfqkpnxpv@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
	 <e382780002db9767671ca5a0213237f443243537.camel@linux.ibm.com>
	 <20220525095957.vvref4yeaidd5iww@Rk>
	 <d1a431e8cf69b3d892c118204705739a0ed907b7.camel@linux.ibm.com>
	 <20220527134315.afnuszqbfqkpnxpv@Rk>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v0Xub8E530OuzEU-0-wx5yTlCgoQjil1
X-Proofpoint-GUID: HHiYUklJHVCNDtfjYJ-1OUCng0k49Nom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_12,2022-06-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=787 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206090061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_083525_278409_016E0066 
X-CRM114-Status: GOOD (  15.37  )
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

Hi Coiby,

On Fri, 2022-05-27 at 21:43 +0800, Coiby Xu wrote:
> It seems I need to only change cover letter and commit message i.e.
> there is no concern about the code. So it's better to provide a
> new cover letter here to collect new feedback from you thus we
> can avoid unnecessary rounds of patch set.

One other thing before re-posting, the existing Subject line is a bit
snarky.  Perhaps you could come with a more appropriate title?

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
