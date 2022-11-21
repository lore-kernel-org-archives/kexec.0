Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D882C4332F
	for <kexec@archiver.kernel.org>; Mon, 21 Nov 2022 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=njpsmLlW6fRJWwsb/jGHf2kyztRg6EKG3t2/Z+/5DOo=; b=s3YFODc03cmkLR
	CX7LXWqxLg2tKeRwbEyFC/upkOSENXOZvIrTJdVvIeX++gmU0s/IpHpaHRRmWJDBoMd/V/WJwRYsX
	NENWMJZ+tje7NU/425WHOzadKenWgzRTwtG6UBud+Yod3O+zfGPG92CZ36aLSGq9cTOZ6wPDUqbTf
	/KqcVclai/uaL0cNoNzh7FUX6Z13kFizXwukD5XW+9vMHPZoQILXGURUCdBxUgTikOge/1bhnMuiz
	8e1coxcxGHk9wwwf5vfho5F6TmF9aikX7Bl9k3lcQJlme6dXnRRpI8h3BXuUX/cNvBy2xXqZbfX/k
	4fWImQOesad3TLcEZS1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxBSp-00GpRy-J5; Mon, 21 Nov 2022 18:24:15 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxBSm-00GpPS-LM
	for kexec@lists.infradead.org; Mon, 21 Nov 2022 18:24:14 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALGRpHi009307;
	Mon, 21 Nov 2022 18:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=AMtjW6WLFCULVG/XV+qA98xsr1zwM1JGCHIM1oBMy+g=;
 b=mesbrjG7UOwJd7gfx3lnVVoiKpNXvsmwJ/RBuN0mXq8l2ewijI2edu2Crwk0wOW1pXRE
 /EbPdnKf9pY2DxX1olRVe95iqd1KZqwHDMdR9+0IlQWHUnDSQmtKj8lSYltYLl7eEEyn
 tRyYAeIUjVXiVbpE+coLm+7kIFrr1vYl5/vydFmJOdtxBPHJIlV4bwH4OC84Dg7JSxEq
 800ikAO4lIhdEleiJk4iGS0HT/KEDRxLyrIkXnw4JQzRvpVzvr6gqCR3PPGjIgyoDI3A
 WqdRGq6sw/5VAy8CwG1MJNqnehKiOmUz+OGxxlfIT5MygeHKi2/9iFLUC3UlEfLPe77o eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0cvg2ky4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Nov 2022 18:24:07 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ALGWIXc028182;
	Mon, 21 Nov 2022 18:24:07 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0cvg2kxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Nov 2022 18:24:07 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ALIL5h1016971;
	Mon, 21 Nov 2022 18:24:06 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by ppma01wdc.us.ibm.com with ESMTP id 3kxps970cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Nov 2022 18:24:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ALIO5TQ8717046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Nov 2022 18:24:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 352B458054;
	Mon, 21 Nov 2022 18:24:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2C155805C;
	Mon, 21 Nov 2022 18:24:03 +0000 (GMT)
Received: from sig-9-65-226-3.ibm.com (unknown [9.65.226.3])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Nov 2022 18:24:03 +0000 (GMT)
Message-ID: <5d98172d77a8a0f1e3daab44ad51bf38978cc053.camel@linux.ibm.com>
Subject: Re: [PATCH] lockdown: kexec_file: prevent unsigned kernel image
 when KEXEC_SIG not enabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>, linux-integrity@vger.kernel.org,
        Eric
 Biederman <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>, Matthew Garrett <mjg59@google.com>,
        open list <linux-kernel@vger.kernel.org>
Date: Mon, 21 Nov 2022 13:23:57 -0500
In-Reply-To: <20221121072947.836672-1-coxu@redhat.com>
References: <20221121072947.836672-1-coxu@redhat.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3bqLPIylRMF8WNuVop5Oo8wkFbGC0ndk
X-Proofpoint-ORIG-GUID: myQEqmbxYN6708CMzE6cOpu7wWalPzdx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_16,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=905 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211210139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_102413_086801_C67B17CE 
X-CRM114-Status: GOOD (  17.45  )
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

On Mon, 2022-11-21 at 15:29 +0800, Coiby Xu wrote:
> A kernel builder may not enable KEXEC_SIG and some architectures like
> ppc64 simply don't have KEXEC_SIG. In these cases, unless both
> IMA_ARCH_POLICY and secure boot also enabled, lockdown doesn't prevent
> unsigned kernel image from being kexec'ed via the kexec_file_load
> syscall whereas it could prevent one via the kexec_load syscall. Mandate
> signature verification for those cases.
> 
> Fixes: 155bdd30af17 ("kexec_file: Restrict at runtime if the kernel is locked down")
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: David Howells <dhowells@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Other than correcting the function name to mandate_signature_verificati
on(),

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
