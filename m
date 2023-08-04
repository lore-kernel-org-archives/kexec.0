Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A2BC0015E
	for <kexec@archiver.kernel.org>; Fri,  4 Aug 2023 01:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7jlaUzcXUvQ7oC54OScHeBOr3ByJlC+k7Cc2k191ngI=; b=WIrYqdgsmKzDxO
	gMmto3q81wcfU+s1iaB2IHw17DOWaw1jmNlFHP90SklfqsZFNw01GSmbqV5aVJ3RNwMwVlUpqBg9h
	Vy+uewh0/6+2PHYyBDBPVfYu3KO8r/FyZX8e6QdVKTbxNNDb4FocOV1SAvvhEcrQHMMS8av1RNCUW
	pT2HlLO3Uc7GuO/TpMH3MWgaZtsMzX2kw8P31za+tiajFAi3dwxJ1XImoOpeS+n0rspbYy48Wb7oT
	Fkae/if7g4kcpgU+ne7HkoGATasl6UK/yr+vqNt41mdSXAXZ/Oa6Et4M6HBFZp4UlIHw2ZXsn6Cpf
	m94KwWt0HEF9h7NU5gRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRjWr-00BE6w-0l;
	Fri, 04 Aug 2023 01:22:57 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRjWo-00BE6W-3A
	for kexec@lists.infradead.org;
	Fri, 04 Aug 2023 01:22:56 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3741Cal4028127;
	Fri, 4 Aug 2023 01:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EZoQ5baYBy78pGSk/DSTrKlYzfl3jQVpfJQNoavlcBM=;
 b=rewqE4bc620Oiw+mDYx1rxgA/zmXIrx0WO9IXy1S0tpuHE827166LxhuacQSQZcsOzU5
 x34hWCZi+gO5GNbUKCoAA6Jw8L+nmiiCdBChUAb4vI5hJln2y0VtW4Lqd3rKrrExh2b0
 U14vhfg0Oz3aQgg1f/+MMzbsO66fIIel1KPCZLJKTZHMYMDP6o+uTKdzXr6EvdWXF5OZ
 vZ0FRhXugDENW+k1A383hWiIaGcKV+cX5dyUElcI50ymT1Nl5gEdbMSwAijtx1du/9NI
 1Vr4lnDv39mVTE8mrsYWgUjTeONRcVYrpaBYfeWEKFJYFoGIasBO43l4nHUZ9lpo9WKC JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8qf4r707-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Aug 2023 01:22:39 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3741CcIJ028149;
	Fri, 4 Aug 2023 01:22:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8qf4r6yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Aug 2023 01:22:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373NOjKf015780;
	Fri, 4 Aug 2023 01:22:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8kn71hew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Aug 2023 01:22:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3741MaRE34406860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Aug 2023 01:22:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53CC558059;
	Fri,  4 Aug 2023 01:22:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 898DD58058;
	Fri,  4 Aug 2023 01:22:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.157.226])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Aug 2023 01:22:35 +0000 (GMT)
Message-ID: <7da13140fd4ab43e797214f08bf7bca07640c238.camel@linux.ibm.com>
Subject: Re: [PATCH 4/6] ima: implement functionality to measure TPM update
 counter
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Thu, 03 Aug 2023 21:22:35 -0400
In-Reply-To: <b9a77076-d6ac-a1ec-5e75-ab066dfade69@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
	 <20230801181917.8535-5-tusharsu@linux.microsoft.com>
	 <a2d9af7f54f364da9aeaef3dc6e03b7412957c23.camel@linux.ibm.com>
	 <b9a77076-d6ac-a1ec-5e75-ab066dfade69@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jaJ8LnyPfg9dn1-OxJnFtHMtbnDbuJF3
X-Proofpoint-GUID: rZO39hUoQVqgxUpGFOsyAhRV3uwuXekn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_24,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040007
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_182255_025913_3C5E5B49 
X-CRM114-Status: GOOD (  19.58  )
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

On Thu, 2023-08-03 at 16:01 -0700, Tushar Sugandhi wrote:
> >> +    scnprintf(buf, IMA_TPM_UPDATE_CTR_BUF_SIZE, "update_counter=%u;",
> >> +                      update_counter);
> >> +
> >> +    buf_len = strlen(buf);
> >> +
> >> +    result = ima_measure_critical_data("tpm_pcr_update_counter", event_name,
> >> +                              buf, buf_len, false, NULL, 0);
> >>
> > The new record should contain everything needed to verify the
> > pcrCounter.  For example, each IMA measurement record updates the
> > pcrCounter for each TPM bank enabled.  So the number of enabled TPM
> > banks and number of IMA measurements should also be included in this
> > record.
> Agreed. That should be valuable information.
> How does the below format look like for the buf above?
> 
> version=<N>.<N>.<N>;num_enabled_pcr_banks=<N>;pcrUpdateCounter=<N>;num_ima_measurements=<N>;

Refer to comment in 5/6.

> > Perhaps include a version number as well, so that if we ever want to
> > include other information, we could.
> By version number, do you mean kernel_version, or a new version
> number specific to this record? Or something else?

This is a record version type number.  The record format shouldn't
change, but we should be prepared for it changing.  A single number
should be fine.

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
