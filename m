Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3D0C43334
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R1tbm0uelr+hfjF/P/HzH7iDhHjV0HtPUBXsWOIAZBg=; b=ojfwbPUGOchCNJ
	F2dfN/sIkIZPiB6fnyL5vL++pc6LBcPtKFu14oGRLf5xE20DsHM9z7EjbxnamLjUuDQ5gRasE9Vea
	7/vFFYIqaVG44BBtssTuvWDqXj400YrxD94ER2gIXMn4FS5kwO/tXvtCJ/CX2rIj0Z4ct8eLcqQ74
	+rwSnanj2U8Dtl+2v/Vb7fSMF58uD9fROndokkq0J6xk6EP1jgx2WKT8L1RJqciyaLu9U47XKXSav
	XKU5culUot7Lbl7OxNq3LeKE/gc5Mfrv8IahaWFNXOllN3xDpetJra4iRSmFXoB/17Pvoixt5XDkD
	NjHb3rtnb2N9sM346ixw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2AeV-007WHP-4Z; Fri, 17 Jun 2022 12:00:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2Ack-007V3y-JM; Fri, 17 Jun 2022 11:58:52 +0000
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25H9TFID027146;
	Fri, 17 Jun 2022 11:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=X4Z3zQ5+mFHBDU8Sx09GH6XvLG/SE8Z2hi8mB2RvUzI=;
 b=gum+CPd7u17mCe+M1pnt+My1wA0dhsT+T42VW9PzQulCo4xee8jXqzGECt4ni30iPape
 v8gC5DXBNtdXD0eoPdIZ8H3Yly7oBH36BUtt4+ewi+XvXnjvGrwg83xm+iZ6QodZOZbW
 la2P+j0HNuPdmaid5odFoRubjXhwqmKnvlsnWZfHHLh7B1R8B56L3B2o85rL5D8zxIvd
 MKNt43sFvsOZX/beISXbA9gI7V6TL69Y65ANgp124EmGrkACx9Rbw5lpUjy2uZN4+HHW
 VSNvagyOOa+4NVi/8NRnePVeWGAzvYQQOCKPYHd1FQ2v4vzVaxJQKsdv3Z2DdEnRz+2p /A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3grq182xd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jun 2022 11:58:45 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25HBKmJ9031992;
	Fri, 17 Jun 2022 11:58:44 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3grq182xbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jun 2022 11:58:44 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25HBpcbP018058;
	Fri, 17 Jun 2022 11:58:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma03fra.de.ibm.com with ESMTP id 3gmjp8xtxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jun 2022 11:58:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25HBwhvF23396612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jun 2022 11:58:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71FF35204F;
	Fri, 17 Jun 2022 11:58:39 +0000 (GMT)
Received: from sig-9-65-64-10.ibm.com (unknown [9.65.64.10])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3F28B5204E;
	Fri, 17 Jun 2022 11:58:38 +0000 (GMT)
Message-ID: <dc23f46380e6fb218181e685ad2f0a1db34500fe.camel@linux.ibm.com>
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
Date: Fri, 17 Jun 2022 07:58:37 -0400
In-Reply-To: <20220617035724.uyc7mp4n5gdlzta5@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
	 <e382780002db9767671ca5a0213237f443243537.camel@linux.ibm.com>
	 <20220525095957.vvref4yeaidd5iww@Rk>
	 <d1a431e8cf69b3d892c118204705739a0ed907b7.camel@linux.ibm.com>
	 <20220527134315.afnuszqbfqkpnxpv@Rk>
	 <b3c87ce140b8d46659adcf07142e1d01ffbb2267.camel@linux.ibm.com>
	 <20220616011506.ymbz2xuhw3refasw@Rk> <20220617035724.uyc7mp4n5gdlzta5@Rk>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c5wsuLOJszpqyeJGHO4EZA70gUYEUW0z
X-Proofpoint-ORIG-GUID: jJ4of5LDnZpo9bxkM8SXs1rSvOrIrRZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-17_08,2022-06-16_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=951 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206170051
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_045850_951806_40C2D7EB 
X-CRM114-Status: GOOD (  19.17  )
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

On Fri, 2022-06-17 at 11:57 +0800, Coiby Xu wrote:
> >Thanks for explaining IMA to me! There is still the question of what's
> >the root of trust for .builtin_trusted_keys when there is no real
> >signature verification. For example, when CONFIG_KEXEC_SIG is enabled,
> >the default IMA policy is to not appraise kexec image. Since lockdown is
> >not enabled by default, there is no real verification as
> >kimage_validate_signature succeeds even when kexec_image_verify_sig
> >fails.
> 
> I realize my reasoning is incorrect. Actually the signature
> verification which establishes the trust on the keys happens in the
> bootloader. So IMA appraisal or kimage_validate_signature is irrelevant
> to the question of the root of trust of .builtin_trusted_key. For GRUB,
> it won't verify the signature by default when secure boot is not enabled.
> Thus the question of what's root of trust when there is no signature
> verification is still valid.

We're saying the same thing, just differently.  Your wording describes
secure boot, how it is established, and who/what is responsible for it.
I don't think those details are needed.  I originally said,

.builtin_trusted_keys:

For example,

Keys may be built into the kernel during build or inserted into memory
reserved for keys post build.  In both of these cases, trust is based
on verification of the kernel image signature.  On a physical system in
a secure boot environment, this trust is rooted in HW.

The last line should have said, "For example, on a physical system in a
...".

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
