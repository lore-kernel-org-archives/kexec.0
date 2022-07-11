Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71BEC43334
	for <kexec@archiver.kernel.org>; Mon, 11 Jul 2022 22:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lx+4LJmhv8Ek985VefUs5bMA/huycQBXMZ/3jNSDcGs=; b=qwV/pcJky2NDBu
	4SMJzMvGHIwWXRNnHtXbgO0tY7nnEBJuNfNPykjfVT/fV+ro2jgdFhcK0oOwVQQ58CVIba4k4wsC8
	ItPs1mzlJaoHqIxuNHpK9EuaaMvahdC1mrxJ8SsD3ex+YClEM8T7UlFEGnJGSj60GejzkQ1ZmbCQU
	fNSFS/yjv1X1fAipZ3b+mtWqqiAsUr+aDQugPay6DqcEzAcy2kEVDxQ1s+nbDm41AcjJb3Vzlg1z4
	i0+Hjcc7GqjehXOUlqaiScli4nEVOAw2NtvXlE5moeoh5M1U9N2J+7t4MCLzHn3TXkCNmmL3v6vUJ
	YEG4zNc//JJr/R5w3BPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB1WY-0059zG-Ja; Mon, 11 Jul 2022 22:05:02 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB1WV-0059xn-I5
	for kexec@lists.infradead.org; Mon, 11 Jul 2022 22:05:01 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BL1d99026535;
	Mon, 11 Jul 2022 22:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=NlUTSrATc/Oo6yFV3itCCCQNw/+QGn98bH6P3kymRIk=;
 b=boELpH/9bESNN5HeGDDTHPAG+7q5AVBcBL9TDZ5wk4D9Onikl9t5Tul22UP+6Ss8fKFy
 pUIaDOtuKJGROPWVkiqe+YcuyQz8c/iE3bMf/FMEuCEUhlLiKT9C1OnmcocWUIuI0DwA
 5JycdxHbsO1tOKV0Zmx6a/EM+slT4Hff02HZRUrUcZizjqGjNqYUZqv4f2oIMCN2cIXQ
 0p6t5Lx8q5zrzKqfM9sbluEpxYb9IOAz8u0r5SKnSRorLx4dDWlTfN2N3vgodqEPtch1
 D+p4sBpG11y2Vs3N8J8t8fQkgn7otMNJQtKAIb+IF7G08a5bdVj0iYIj1C3qrQdZk3WG rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h8udv16eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Jul 2022 22:04:51 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26BM0GK0026468;
	Mon, 11 Jul 2022 22:04:51 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h8udv16dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Jul 2022 22:04:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26BLoD9c008894;
	Mon, 11 Jul 2022 22:04:48 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03ams.nl.ibm.com with ESMTP id 3h71a8u8qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Jul 2022 22:04:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26BM4j4H24117732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Jul 2022 22:04:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6481C52050;
	Mon, 11 Jul 2022 22:04:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.107.19])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2F05D5204E;
	Mon, 11 Jul 2022 22:04:41 +0000 (GMT)
Message-ID: <9fc4f6dc2ee497a4d4998df17392ac73ebdf3d63.camel@linux.ibm.com>
Subject: Re: [PATCH v6 4/6] tpm: of: Make of-tree specific function commonly
 available
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Jarkko
 Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Rob Herring
 <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Date: Mon, 11 Jul 2022 18:04:41 -0400
In-Reply-To: <20220707172026.831614-5-stefanb@linux.ibm.com>
References: <20220707172026.831614-1-stefanb@linux.ibm.com>
	 <20220707172026.831614-5-stefanb@linux.ibm.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gFV0BXBuvKy5jtRQecH9o9Ts7rE2PizX
X-Proofpoint-ORIG-GUID: ZYsN1Rxnx9KOvVXOzFIN86sR19W3fJPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_25,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=850 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207110089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_150459_863731_64A4B0B2 
X-CRM114-Status: GOOD (  15.58  )
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

Hi Stefan,

On Thu, 2022-07-07 at 13:20 -0400, Stefan Berger wrote:
> -       /*
> -        * For both vtpm/tpm, firmware has log addr and log size in big
> -        * endian format. But in case of vtpm, there is a method called
> -        * sml-handover which is run during kernel init even before
> -        * device tree is setup. This sml-handover function takes care
> -        * of endianness and writes to sml-base and sml-size in little
> -        * endian format. For this reason, vtpm doesn't need conversion
> -        * but physical tpm needs the conversion.
> -        */

This comment is dropped.  Perhaps not in such detail, but shouldn't a
comment or function description exist in the new function.

Otherwise,
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
