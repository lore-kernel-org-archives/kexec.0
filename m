Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85D5C43334
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 12:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u2MoFhmzYW51Xzcpce344Y4PGTI1iCHlq1X1bOgNK7s=; b=igSEhx505wLnS+
	M75joL6OH20pSpNjbM3Cz8dawExV8/MILEPzePTs9eaANWp6dHr9qAjxNWtm/OjZrajJw0XNCNfXo
	s0aRw2OLZ133+YkPeWIrAql6FUig1jDpipn1mVmrc1ZV4FMu3xcmXnUrjbmB7vER+LNQzif7AwRKK
	2Pkk/fbzEJTa6qgFrYRg0NNsVxIzwTwokB0nQER/FJFvJzNCs27ACYRyXlzFetoc/CXsJ8qcb9e6f
	LUMGoopOSMhbtyMLIFvdXnJN7fMECFJ93yTQj35q+Tcj/EBqKYGLRwjeAQeXkK26zjjQ/aEN8qzO9
	POdX9xcKStBCJE+5zq0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2Aka-007Z0n-68; Fri, 17 Jun 2022 12:06:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2AkM-007YwJ-Jo; Fri, 17 Jun 2022 12:06:44 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HAStwX009341;
	Fri, 17 Jun 2022 12:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=RK1S5QRq6OnkH1tO9zSXMrDf3DOeXFynmS+dhVp4jRk=;
 b=amWFB4FWSvO+W1F3trTF9r3zfqRN/mmpxEcrNWdYHr7DlOG79MoY+SDxqA+cYQ2pl8/q
 45cw0betvpkpw0PVUyH2K6QmMCeKsreJO2KHeSbP7t0jqSemkDn+7SHXBrqVh5vZlFPB
 zKvAN10YRgjvALhDJ2ZP4M/UL09LRNSWu68RmR4BMmx55Was5m8EDZHeS06/VLghTQFz
 NhIX2sIAQ1t3quIh1PUdIjNzfE9Nl4hl3C2dBkB4RO3ztH8F5yFP/+wvBh622GVW6tQS
 icP+0FZ33ElMK4MHsFAf9k7QHpt8q31XqqOHYJaTLezSZs/29GcbJrE2gV+5p8W05KgB UA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3grqw8t19d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jun 2022 12:06:39 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25HBX7WX015266;
	Fri, 17 Jun 2022 12:06:38 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3grqw8t18r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jun 2022 12:06:38 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25HC5CuT026884;
	Fri, 17 Jun 2022 12:06:37 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma04ams.nl.ibm.com with ESMTP id 3gmjp98rqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jun 2022 12:06:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25HC6c1v23462210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jun 2022 12:06:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 911B411C052;
	Fri, 17 Jun 2022 12:06:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C5A211C054;
	Fri, 17 Jun 2022 12:06:33 +0000 (GMT)
Received: from sig-9-65-64-10.ibm.com (unknown [9.65.64.10])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jun 2022 12:06:33 +0000 (GMT)
Message-ID: <c17e61cc155d7af4bbfc3fcb7671b6a8efd4ba4d.camel@linux.ibm.com>
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
Date: Fri, 17 Jun 2022 08:06:32 -0400
In-Reply-To: <20220616012128.7ufebi2lkusx5aga@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
	 <e382780002db9767671ca5a0213237f443243537.camel@linux.ibm.com>
	 <20220525095957.vvref4yeaidd5iww@Rk>
	 <d1a431e8cf69b3d892c118204705739a0ed907b7.camel@linux.ibm.com>
	 <20220527134315.afnuszqbfqkpnxpv@Rk>
	 <5b11a8043f78ef5ca41254b8a46f78dca0a5b159.camel@linux.ibm.com>
	 <20220616012128.7ufebi2lkusx5aga@Rk>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P-AxglNK8Wjlhb2fFnOaqYfcp73cEc2p
X-Proofpoint-ORIG-GUID: P6o3sQirG_ZLk1xIDfbLEQiYJ70-X4Pi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-17_08,2022-06-16_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206170054
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_050642_827521_99B36B23 
X-CRM114-Status: GOOD (  21.28  )
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

On Thu, 2022-06-16 at 09:21 +0800, Coiby Xu wrote:
> Hi Mimi,
> 
> On Thu, Jun 09, 2022 at 11:35:13AM -0400, Mimi Zohar wrote:
> >Hi Coiby,
> >
> >On Fri, 2022-05-27 at 21:43 +0800, Coiby Xu wrote:
> >> It seems I need to only change cover letter and commit message i.e.
> >> there is no concern about the code. So it's better to provide a
> >> new cover letter here to collect new feedback from you thus we
> >> can avoid unnecessary rounds of patch set.
> >
> >One other thing before re-posting, the existing Subject line is a bit
> >snarky.  Perhaps you could come with a more appropriate title?
> 
> How about "Using the same keyrings as x86 to verify kexec'ed kernel image
> signature for arm64 and s390" or "Uniform keyrings to verify kexec'ed
> kernel image signature across x86, arm64 and s390"?

Instead of using "Uniform", I would use the verb form "Unify".

Mimi
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
