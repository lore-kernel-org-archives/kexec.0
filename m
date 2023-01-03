Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEFFC3DA7D
	for <kexec@archiver.kernel.org>; Tue,  3 Jan 2023 17:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6kjqAkmgKuMqbD0o1Mb13NKCnRnhQmGJMl5w7Kn4RZk=; b=OTKVtmVrUnwVbY
	quxDDxZABAi42WUWv5bWL/Sr98exs7MjRu2nnID46ooOgDuNLf2IkKkx98hWn896kacCtsMc4j0MH
	OcuFju6MGgEbfzeIbJ8/1HLGjycdAvKTDAmYWOiUGbiX04IJqJthqV/TCpx1ftu3/bD91F/L/cgpD
	wIxxJu5x4oFKv+biu7xq8IVSJxDv/coz0IyzObrSakCkYO5ieoBUnM6gKftw1hJKShsLbNw34DbnD
	UOUBdZaFiIN5V6xgcIoIZ9ZCxbWcoZ0Zyv8SCfn09wU+Oc0Wgd0ZtgIDHb+CHKh3yXtdwOGeyasyL
	9yAYJbwMfyzerD5ooniw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCl4I-003Or2-Go; Tue, 03 Jan 2023 17:27:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCiUp-0024ph-Ka
	for kexec@lists.infradead.org; Tue, 03 Jan 2023 14:42:39 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303BsSHi012278;
	Tue, 3 Jan 2023 14:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=V5SYefJTflvsDT1Raha3+RcL0YPGYJhZPbSXBN2Wync=;
 b=bwoEpH83Qm83OrP3aU5PxDb4oN2NrakevNPaOZaUJo0xrAJx4Wxyvy8HcO7MCX0Y2t61
 beMArTDaF65onusmp2Vi+8BlDSvXMaryJVE+8H9NkIbkjnOPqptlgWu10VAEbzoClJZJ
 IUiVCiKyDOTqCoNqhjTdWINe1gvFWZj3kM9lw6hHfeYqseDq5lRruap2W3vmRN9Hbvez
 NW29Gv6JMbNRd++rk9ZPtdAT6qUliHs8P8r9fRZ7C551eh6zamSrTVMgEdQt5HAXPKK2
 GMhdukc3IncdSb2H3UIVmmvLwzDlJarQoDjWWHIPEb4SYnoRfgjkEhQXU3dP2CEt9gif wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvkwcueyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jan 2023 14:42:29 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 303C8QgB002419;
	Tue, 3 Jan 2023 14:42:29 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvkwcueye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jan 2023 14:42:29 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303Cq9Ut011450;
	Tue, 3 Jan 2023 14:42:28 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
	by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3mtcq726jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jan 2023 14:42:28 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 303EgRdw53477822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Jan 2023 14:42:27 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FDAD5804E;
	Tue,  3 Jan 2023 14:42:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 778C958063;
	Tue,  3 Jan 2023 14:42:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.32.150])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Jan 2023 14:42:26 +0000 (GMT)
Message-ID: <bd1d2f66bffb25fd80b2dd2464f8cda24f68c249.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] lockdown: kexec_file: prevent unsigned kernel
 image when KEXEC_SIG not enabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>, linux-integrity@vger.kernel.org,
        Eric
 Biederman <ebiederm@xmission.com>,
        Matthew Garrett <mjg59@google.com>, James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Tue, 03 Jan 2023 09:42:26 -0500
In-Reply-To: <20221230065850.897967-1-coxu@redhat.com>
References: <20221230065850.897967-1-coxu@redhat.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C95uZj5SPEk7WXoIttTBfPO4blQSSKOm
X-Proofpoint-GUID: YY4UBTk5waiOyIqDmUnHQ4H3PS3O6OHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_04,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=895
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_064232_042366_457BBF87 
X-CRM114-Status: GOOD (  15.34  )
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

On Fri, 2022-12-30 at 14:58 +0800, Coiby Xu wrote:
> A kernel builder may not enable KEXEC_SIG and some architectures like
> ppc64 simply don't have KEXEC_SIG. In these cases, unless both
> IMA_ARCH_POLICY and secure boot also enabled, lockdown doesn't prevent
> unsigned kernel image from being kexec'ed via the kexec_file_load
> syscall whereas it could prevent one via the kexec_load syscall. Mandate
> signature verification for those cases.

The phrase "unless both IMA_ARCH_POLICY and secure boot also enabled"
doesn't reflect the code.  IMA could contain a custom policy rule which
requires the kexec kernel image signature verification as well.  Refer
to the comment now in mandate_signature_verification().

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
