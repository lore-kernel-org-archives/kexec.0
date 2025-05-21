Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA87CC2D0CD
	for <kexec@archiver.kernel.org>; Wed, 21 May 2025 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ZBTcqAAJGahPNJL6QJFCYv9rJB6qJJlgN6LrW/cYyI=; b=fXynGnm3n12TquLDWnZdMLofez
	vSrEzhCju1bk8C0RoGze9FhOQ7jPQlfCL0uP2gCb4ZATZUGsytlDn0DxPYK3bC0HGwQ8wRFmfyNw2
	MIOODTGTH/mco4HegGPXvNjHidGY03mwoZTGG4YHqJWtLL8EzxX4KSLgDGUnASy8Dyb0jbD0Z1/CF
	BdQ2TgjP75DLqc2ldUD45RRKEEuoyKOfDEB86hXtkff2ikdx8Qv+rnGmTyiY15C6TCT/JJZI4nFuy
	F8l+lra3EnbKYmA5u+6Mhomw09TcmVEAHnoFxZ3tgodRMSh0zy7H9bWueQG85La1i+jy37yJVvP5o
	dJvNNoOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHjVf-0000000FwM0-0QeJ;
	Wed, 21 May 2025 13:29:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHj24-0000000Fr69-0v7l
	for kexec@lists.infradead.org;
	Wed, 21 May 2025 12:58:53 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L4b229023126;
	Wed, 21 May 2025 12:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7ZBTcq
	AAJGahPNJL6QJFCYv9rJB6qJJlgN6LrW/cYyI=; b=Ul4K2NoFmk9KUmodTNUKzY
	phICVuDdTsSaNtxHhvH3bbiE5TgBHkAA5geD+VtjpXWsjK3S9sC7Js9x8txr6nxA
	y7mCA+ISHNcnQne7XgZzAg4ZX/RXRZ1822qvlFPZiQY8tCDjRQbE3eSmb8ObrXs+
	9uaDBvu9d+DZ6GlVp27PZhP9lFzDA10B19StmJ/r5npn/eQXRAz3FjWjDhDynXO1
	Plk07KZc+syWAOuQ6mFaFWB9nCrZlYFjmLshUupts8FWX48QzmBBHibz5KPcmzxb
	NgiX1ox1TxO7PumP8Ny3JjTRIc4Ijj8zc2VXhcuc3jJ8F6j33hbawn2tkti+KrzQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rxaamg6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 12:58:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9totF032087;
	Wed, 21 May 2025 12:58:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnmc81k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 12:58:49 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54LCwmeR32965234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 12:58:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 781A95805F;
	Wed, 21 May 2025 12:58:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A19558059;
	Wed, 21 May 2025 12:58:47 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.23.72])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 May 2025 12:58:47 +0000 (GMT)
Message-ID: <02e5091f96404a86073abacb2861a07cf1deb439.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, coxu@redhat.com,
        ruyang@redhat.com, chenste@linux.microsoft.com
Date: Wed, 21 May 2025 08:58:47 -0400
In-Reply-To: <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
References: <20250515233953.14685-1-bhe@redhat.com>
	 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
	 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CMEqXQrD c=1 sm=1 tr=0 ts=682dce09 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=UeMwZWw34uBX8khp:21 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=WRvSffXkUtG6d0X-7VIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lXfcAT3opLDtnDkB2T7VqkO6QB2HWX4P
X-Proofpoint-GUID: lXfcAT3opLDtnDkB2T7VqkO6QB2HWX4P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyMiBTYWx0ZWRfXzBppxba+OEb5 kKuLEwKx1C5wTNf2l/LEGzpF+L6vh8Kkrhiggu5ubJhUYA5J4ACWH2pxkMRcCq6agHD/gzozcuS skl7UpcDtuN+MMPI8BYwiLeCJmBIV2DRJDxR3+u3xrw7p/5XWx1vrekVa4X3/3ELAT4AvZxZtDI
 hpV1DImQSCI5TmSPHCW7UwKBvVXMcF2cwU9l+hBlqdJ6VwtsOMy1j99L4yybk8PbEwz4wtCwZkm ZZlBZrcpvDifcNjKjhED6nFfw1MydwwWFOYu23PUMqX875QwXKFBPJI/57FuylYouKdQNinNR24 nfmy0CFx3PzN+h0s4iBOnwJJW7B1KGqa/zYAh1MzICJ3CwwhhyWi5hutMzla7jY/VucdNYm8EAW
 SfEzO9rBllvcTDVja98nvCCVjg5HqII9dJVO10mYwsWrSWmIzxdgFAp9B4X2b4kXt7TBFCHX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_055852_551165_6D6C25A0 
X-CRM114-Status: GOOD (  33.90  )
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

In addition, please update the Subject line to be less generic.

thanks,

Mimi


On Wed, 2025-05-21 at 08:54 -0400, Mimi Zohar wrote:
> On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
> > CC kexec list.
> >=20
> > On 05/16/25 at 07:39am, Baoquan He wrote:
> > > Kdump kernel doesn't need IMA functionality, and enabling IMA will co=
st
> > > extra memory. It would be very helpful to allow IMA to be disabled fo=
r
> > > kdump kernel.
>=20
> The real question is not whether kdump needs "IMA", but whether not enabl=
ing
> IMA in the kdump kernel could be abused.=C2=A0 The comments below don't a=
ddress
> that question but limit/emphasize, as much as possible, turning IMA off i=
s
> limited to the kdump kernel.
>=20
> > >=20
> > > And Coiby also mentioned that for kdump kernel incorrect ima-policy
> > > loaded
> > > by systemd could cause kdump kernel hang, and it's possible the booti=
ng
> > > process may be stopped by a strict, albeit syntax-correct policy and
> > > users
> > > can't log into the system to fix the policy. In these cases, allowing=
 to
> > > disable IMA is very helpful too for kdump kernel.
> > >=20
> > > Hence add a knob ima=3Don|off here to allow people to disable IMA in =
kdump
> > > kenrel if needed.
>=20
> ^kernel
>=20
> > >=20
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > > =C2=A0.../admin-guide/kernel-parameters.txt=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
> > > =C2=A0security/integrity/ima/ima_main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 +++++++++++++++++++
> > > =C2=A02 files changed, 27 insertions(+)
> > >=20
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > > b/Documentation/admin-guide/kernel-parameters.txt
> > > index d9fd26b95b34..762fb6ddcc24 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -2202,6 +2202,11 @@
> > > =C2=A0			different crypto accelerators. This option can
> > > be
> > > used
> > > =C2=A0			to achieve best performance for particular HW.
> > > =C2=A0
> > > +	ima=3D		[IMA] Enable or disable IMA
> > > +			Format: { "off" | "on" }
> > > +			Default: "on"
> > > +			Note that this is only useful for kdump kernel.
>=20
> Instead of "useful" I would prefer something clearer like "limited".
>=20
> > > +
> > > =C2=A0	init=3D		[KNL]
> > > =C2=A0			Format: <full_path>
> > > =C2=A0			Run specified binary instead of /sbin/init as
> > > init
> > > diff --git a/security/integrity/ima/ima_main.c
> > > b/security/integrity/ima/ima_main.c
> > > index f3e7ac513db3..07af5c6af138 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -27,6 +27,7 @@
> > > =C2=A0#include <linux/fs.h>
> > > =C2=A0#include <linux/iversion.h>
> > > =C2=A0#include <linux/evm.h>
> > > +#include <linux/crash_dump.h>
> > > =C2=A0
> > > =C2=A0#include "ima.h"
> > > =C2=A0
> > > @@ -38,11 +39,27 @@ int ima_appraise;
> > > =C2=A0
> > > =C2=A0int __ro_after_init ima_hash_algo =3D HASH_ALGO_SHA1;
> > > =C2=A0static int hash_setup_done;
> > > +static int ima_disabled;
>=20
> Like the ima_hash_algo variable definition above, ima_disabled should be
> defined as __ro_after_init.
>=20
> > > =C2=A0
> > > =C2=A0static struct notifier_block ima_lsm_policy_notifier =3D {
> > > =C2=A0	.notifier_call =3D ima_lsm_policy_change,
> > > =C2=A0};
> > > =C2=A0
> > > +static int __init ima_setup(char *str)
> > > +{
>=20
> is_kdump_kernel() should also be called here, before the tests below.=20
> Something like:
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_kdump_kernel()) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pr_info("Warning ima setup option only permitted in kdump");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> > > +	if (strncmp(str, "off", 3) =3D=3D 0)
> > > +		ima_disabled =3D 1;
> > > +	else if (strncmp(str, "on", 2) =3D=3D 0)
> > > +		ima_disabled =3D 0;
> > > +	else
> > > +		pr_err("Invalid ima setup option: \"%s\" , please
> > > specify
> > > ima=3Don|off.", str);
> > > +
> > > +	return 1;
> > > +}
> > > +__setup("ima=3D", ima_setup);
> > > +
> > > +
> > > +
>=20
> Remove the extraneous blank line.
>=20
> > > =C2=A0static int __init hash_setup(char *str)
> > > =C2=A0{
> > > =C2=A0	struct ima_template_desc *template_desc =3D
> > > ima_template_desc_current();
> > > @@ -1184,6 +1201,11 @@ static int __init init_ima(void)
> > > =C2=A0{
> > > =C2=A0	int error;
> > > =C2=A0
> > > +	if (ima_disabled && is_kdump_kernel()) {
> > > +		pr_info("IMA functionality is disabled");
> > > +		return 0;
> > > +	}
> > > +
>=20
> Even with the additional call to is_kdump_kernel() in ima_setup, please k=
eep
> the is_kdump_kernel() test here as well.=C2=A0 Even though the code is se=
lf
> describing, please add a one line comment emphasizing disabling IMA is
> limited
> to kdump.
>=20
> > > =C2=A0	ima_appraise_parse_cmdline();
> > > =C2=A0	ima_init_template_list();
> > > =C2=A0	hash_setup(CONFIG_IMA_DEFAULT_HASH);
> > > --=20
> > > 2.41.0
> > >=20
> >=20
> >=20
>=20
> thanks,
>=20
> Mimi
>=20


