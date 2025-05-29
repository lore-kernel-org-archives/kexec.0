Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE717C5AD49
	for <kexec@archiver.kernel.org>; Thu, 29 May 2025 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sBs1I6xHilGGQRussSPtkrqmDw9YqjU5AiWB9gav/i8=; b=UIUqyA2ftsW32UZcYEfMiLCDeI
	/0nbDS2IfZdRTgFNPGXfQpodkPPfemdseArouPtW7lH0tnOrrO9QBtcT+YyazJqC+iUcQF7jQ0X4H
	fsDVsDV5CgvA9TIJ2ygjn4mp3x2QoMmXzQ6SuEJ+fIOMzBNxWawBOMY9w/fh7lAU57A9Bp8ZYoMbM
	AO59tQWxY1bTEIwG0aUAjYkP/piHnv04t9XoJXarX5BYckirCFCa5vZko27KezAAfEs7Eim8K0qYy
	lyePU2VGuwL0Jn4OY9h1bBmvnxRelLwp5a1/bHuUQTCuWhoU14INyXKvhuK72T+88FTTYMnQOe5E4
	Y7EGSByQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKf3h-0000000G37A-2mVz;
	Thu, 29 May 2025 15:20:41 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKeIb-0000000FycE-02JP
	for kexec@lists.infradead.org;
	Thu, 29 May 2025 14:32:02 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDeFxD002030;
	Thu, 29 May 2025 14:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sBs1I6
	xHilGGQRussSPtkrqmDw9YqjU5AiWB9gav/i8=; b=Qhni8r+axcLKxqOJZEKHXq
	nzIHIlyjmEUl5vyzG2RoX4o4JdstdKtqOFr+nAu0ub7DkY49dL61k9EYEq1Qjapa
	WAep9qL0c39oICdmU6xFBYFqxE8uryMm+FtV/umpuBLFbtQ7AnPpTQwVrb3RI2OP
	kmV2XgS5fOIVcmIPZOby85ZvHqCIOJT0I972C+44fqlMUWbYZFfqcOhKO/IcFLPq
	hAD+wEAblg+AoAYb2WGNVROXsCTEntKQoghmuaiRYDukvtLxq/R+nHVnuf83eBpe
	Gr8CR6Yen/AjUjw9mKfpafz4FQvecPm0CHtmH5H/Y+c4aIHXFWpw0QY7JBUEJUsA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gp0k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 14:31:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54TCLibc006563;
	Thu, 29 May 2025 14:31:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46uru0vw32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 14:31:56 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54TEVtFu30867996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 14:31:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5297458069;
	Thu, 29 May 2025 14:31:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BCC65805E;
	Thu, 29 May 2025 14:31:54 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.84.67])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 May 2025 14:31:54 +0000 (GMT)
Message-ID: <91a9aa935b3a194c57a166133c9c1a537a9ca802.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, prudo@redhat.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, coxu@redhat.com,
        ruyang@redhat.com, chenste@linux.microsoft.com
In-Reply-To: <CAF+s44Q6ZJ8rdi1VG40JVJmxX-1hmss5eNaKvGhJSOS6xYLx-g@mail.gmail.com>
References: <20250515233953.14685-1-bhe@redhat.com>
	 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
	 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
	 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
	 <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
	 <aC86NSypHlER2C3L@MiWiFi-R3L-srv>
	 <CAF+s44QHJs8J27TEy0AW1m2wT=LRSz59nHf-8AuqL8px_zKGUg@mail.gmail.com>
	 <0e794fc984c8f37a6d3eb5acdb6cc094f14df940.camel@linux.ibm.com>
	 <CAF+s44Q6ZJ8rdi1VG40JVJmxX-1hmss5eNaKvGhJSOS6xYLx-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 May 2025 10:31:54 -0400
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=avmyCTZV c=1 sm=1 tr=0 ts=68386fdc cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=UeMwZWw34uBX8khp:21 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=8hGtjK_r-kYd2dVNGJkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDEzNiBTYWx0ZWRfXyEOtK7ZpFg9J lnVAWyCWxQPTKJBa8ZT/cCP1HrMSfQQaIrlmYGHALh/v0EGzBTIJXG5rSOMHBnTMj+5stW9M4KT RSY7jIfIy2sSiHZe+KYSZaG1DNVH5lcACtpb4liJduD+je1J+cKcFDnvNyGKR/h4jjcfQojnCRl
 4uH9BoqOz0UioUjz1Tw72jRsNKh9+UPPBr+3bHhv2ChAVW8KWWt8Ter3jZaGHqkM8D/VjSq4q10 C7zoc+giTl0qw6fm+KZuLpIESXiC50r/PLlaOIKVNInirl5KEOMmwNNv5VRIhQV12yyEA0CNYd1 +l1gpAQZqBChIZllDXoiKI5HrCqlKRyJititoepxeQymgQlRtWNUtHgTR6ffnx2NnTACf5RH+GR
 /IcHHDMfD+2QHlgmF+hzhtd87UMDc1BNJ3HVQJSbbKOYZVVsB5k8OfVjdeXC9KtoCdp/0F9R
X-Proofpoint-GUID: BXRwChCTEhrOCaz1qDFBrbZHmYfL-olt
X-Proofpoint-ORIG-GUID: BXRwChCTEhrOCaz1qDFBrbZHmYfL-olt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_07,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_073201_506462_46DFB236 
X-CRM114-Status: GOOD (  27.87  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, 2025-05-29 at 12:13 +0800, Pingfan Liu wrote:
> On Tue, May 27, 2025 at 10:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> >=20
> > On Tue, 2025-05-27 at 11:25 +0800, Pingfan Liu wrote
> > > > >=20
> > > > >=20
> > > > > We're trying to close integrity gaps, not add new ones.=C2=A0 Ver=
ifying the
> > > > > UKI's
> > > > > signature addresses the integrity of the initramfs.=C2=A0 What ab=
out the
> > > > > integrity of
> > > > > the kdump initramfs (or for that matter the kexec initramfs)?=C2=
=A0 If the
> > > > > kdump
> > > > > initramfs was signed, IMA would be able to verify it before the k=
exec.
> > >=20
> > > IMHO, from the higher level, if there is a requirement on the integri=
ty of
> > > the
> > > initramfs, it should take a similar approach as UKI. And the system a=
dmin
> > > can
> > > choose whether to disable the unsafe format loader or not.
> >=20
> > Yes, that is a possibility, probably a good aim, but in the case of
> > kexec/kdump
> > that isn't really necessary.=C2=A0 As filesystem(s) support xattrs, IMA=
 policies
> > could be written in terms of "func=3DKEXEC_INITRAMFS_CHECK" to include =
the
> > initramfs.
> >=20
>=20
> Just aware that we have such a cool feature. Thanks!

> I checked the code. IIUC, the relevant code has already been in the
> kernel. And the thing left to do is to install an IMA policy, right?

Correct.  The problem up to now has been that the initramfs was created on =
the
fly on the target system, so it was impossible to remotely sign it by the
distro.

>=20
> But there are still two things to be considered.
> -1.The UEFI partition is FAT format, which can not support xattr

The normal kexec/kdump kernel image and initramfs are stored in /boot, not =
the
UEFI partition.  Is that changing?

e.g. kexec -s -l /boot/vmlinuz-`uname -r` --initrd=3D/boot/initramfs-`uname=
 -
r`.img --reuse-cmdline

> -2. Just like in the UKI case, the kernel fd content is not necessary
> for the kernel image itself. The initramfs fd can be used to pass some
> extra data if we use a temp file as a package. So checking the
> signatures at the initramfs level will block this usage

Sorry I lost you here.  What exactly is included in the UKI signature?  Wha=
t is
this initramfs fd extra data?  Is it included in the UKI signature?  Can yo=
u
point me to some documentation?

thanks,

Mimi
> >=20

