Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB93C3ABAA
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A374Ia2eihIBArGg3av+KovsTBYAujbuPpUovFjTXlk=; b=O6VSqrxpJIrelzBTy6BvJ3GaJ9
	K9dTmJWeAzQtp3DYwGXEkyENoygHgKTVXQ2jgZhV0bmyFIGLqUhcCE8AF0cKHIcHEFWg1v+7zO/+d
	k4wrTgKqqSWMIgS6eSLj2FqRGGYRN+ihLHuMv3gRIjDY3TLL7DGRcV+3u5xW9cZVcy/7Cag2wNv6b
	g8eaAezIHJdYWBC/O3VjdnkJfA6jDE1LM9XgTszl/EiWaU89PaXFmhQembP4mT3y9AimgMAXUthF1
	MNf2Ygo5QuECsfMNx3tMUO8hYwQpnBZ2hojIvhIxjRsA1CC2ruJPfUsKJSt/BLiiNqRrjy3aOLFqM
	oU7HNlvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9jLH-00000009VnJ-2onu;
	Tue, 29 Apr 2025 11:41:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9jJ6-00000009Uu0-24D5
	for kexec@lists.infradead.org;
	Tue, 29 Apr 2025 11:39:25 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4EMol006317;
	Tue, 29 Apr 2025 11:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A374Ia
	2eihIBArGg3av+KovsTBYAujbuPpUovFjTXlk=; b=LadRgvewpxqiXvDxJIhdRm
	t+ewj2K8QW0XQw2p4tY7vLpjfMzQA6fgWRkd83uVPp9XVFO+RvfwvuFEXkTLlIiR
	FlpHkfoh/ORmDXg5XNj4BDMcvPYb24f5AWMpta8+/x17602mdxb44P7NjPFmPzQT
	Hv2vU3Tm0xoNWVYu9AmXKGRqqomcFFQcqTPLBCLjCqcniiYbKK1hpxwGLu5TZ4K2
	HSETToHLc+FQbMN0fwwbLPSHG++OUjerNYV+Hx9X/CUy+gTjswbsp6JjUaTVCi6j
	Ox0vMIui9lvGlAncmWwWlAIeSgwDmP7Mj5X4fZSQz2BIBgh7GXc2OXJfqMbeOURw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahs9as1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 11:39:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T8pXkn016119;
	Tue, 29 Apr 2025 11:39:19 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70b3k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 11:39:19 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TBdIVN66257290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 11:39:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E22F58054;
	Tue, 29 Apr 2025 11:39:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA87D58045;
	Tue, 29 Apr 2025 11:39:17 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.23.164])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 11:39:17 +0000 (GMT)
Message-ID: <80766b04cafd24a1d7171b8da03c822d86272f3c.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, Baoquan He <bhe@redhat.com>
Cc: chenste@linux.microsoft.com, RuiRui Yang <ruyang@redhat.com>,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date: Tue, 29 Apr 2025 07:39:17 -0400
In-Reply-To: <f75tvrcc6xhfwz5rbwh2ps34wt2odz4wq32vez7dsct732x4ik@sv6nyjqr2ykr>
References: <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
	 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
	 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
	 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
	 <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
	 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
	 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
	 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
	 <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
	 <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
	 <f75tvrcc6xhfwz5rbwh2ps34wt2odz4wq32vez7dsct732x4ik@sv6nyjqr2ykr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LuKSymdc c=1 sm=1 tr=0 ts=6810ba68 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=UeMwZWw34uBX8khp:21 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=IEkr5_qL8TULfPe6LFIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: l8EajplDRmdXjHixE9JkogN50rW0u7rP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA4NiBTYWx0ZWRfX3Fj/ea1s26a5 I78qyPkSEDoGEkGs0f6f68WWhuq1zy/OY48w5mh3Z0MKR2cSAlUVo8M88oD3o5vn1jOn4wI2KTZ h8HsvSj2mi+/W56ofs8jEAXIUfbDonBeELGtp7+NzFXUPO/Bj5+hpj/3Yxd5TJknghkDPLmmjjT
 53Z1lOu6wQvFY5wxI066qW5p/+GwwIatN9Gp5FGpNgHF3KNUTzgLoZvvDITqrS1EFuZ3P8jnTvn jzdUgJotBzhWQNI06VtpVqa2Xsmv/KnlTuo1/NW6Lqv9RPz/5EGi9SuFboRWZ7bTwxBU3n69xti T3iAA2oLjJXtnmMQo1qNjEwsd8QMSS2BQeEq8AKzI5UpzD96weR8l6Qk+JsbRGo6f4GQBrhPsyr
 FiWfFWuFLb424f0QifMYsTD60oXrkikWiLZrDtwenwzUYAQ62yuiV/4w1hTPHXm/nbHOwNqV
X-Proofpoint-GUID: l8EajplDRmdXjHixE9JkogN50rW0u7rP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_043924_542973_A2FC7855 
X-CRM114-Status: GOOD (  37.79  )
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

On Mon, 2025-04-28 at 11:48 +0800, Coiby Xu wrote:
> On Wed, Apr 16, 2025 at 11:22:52AM +0800, Baoquan He wrote:
> > On 04/09/25 at 11:40am, Mimi Zohar wrote:
> > > On Wed, 2025-04-09 at 10:42 +0800, Baoquan He wrote:
> > ......snip..
> > > > Thanks for confirming. I will consider how to fix it accordingly. M=
aybe
> > > > after Steven's patches are merged. That would be great if the buffe=
r
> > > > allocating and storing can be skiped for kdump in Steven's patch. W=
hile
> > > > I am worried that could disrupt the progress of Steven's patches.
> > >=20
> > > Agreed, let's get Steven's patch set upstreamed and then make the kdu=
mp
> > > exceptions.
> > >=20
> > > - "ima: kexec: move IMA log copy from kexec load to execute" looks li=
ke it
> > > isn't
> > > copying the IMA measurement list records (kexec_post_load), but the m=
emory for
> > > the IMA measurement list is being allocated (ima_alloc_kexec_file_buf=
).
> > >=20
> > > - Do you really want to totally disable IMA for kdump or would disabl=
ing IMA-
> > > measurement be sufficient?=C2=A0 Remember there's already an option t=
o disable IMA-
> > > appraisal.=C2=A0 Disabling just IMA-measurement would allow IMA-appra=
isal to
> > > continue
> > > to work.=C2=A0 Meaning based on policy the integrity of files - execu=
tables, kernel
> > > image, etc - could still be verified.
> > >=20
> > > Without IMA-measurement:
> > > - No adding records to the IMA measurement list
> > > - No IMA measurement list pseudo securityfs files
> > > - No extending the TPM
> > >=20
> > > With IMA-appraisal:
> > > - Integrity verification of files based on keys, keyrings
> > > - Loading keys
>=20
> Thanks for listing the impacts of disabling IMA measurement or
> appraisal!=20
>=20
> kdump builds and loads its own initramfs as a cpio archive. After a
> kernel crashes, the loaded initramfs will save the crashed kernel's
> memory (vmcore) to specified location and then it will reboot the system
> immediately. Since kdump merely copy files from existing fs into its
> initramfs, I think at least majority of users don't need IMA for kdump.

That's fine.

> In fact, currently IMA-appraisal doesn't work for kdump because cpio
> doesn't support xattr.

Although CPIO doesn't support xattrs, tmpfs supports xattrs.  I'm aware tha=
t some
store the security xattr information in a file and write it out as xattrs.

> As for the issue of not properly updating the
> security xattrs, I think in most of cases disabling IMA-appraisal in
> kdump won't cause the trouble. If the vmcore is saved to a remote fs, the
> local fs won't even be touched. If the vmcore is saved to local fs and
> the appraisal rules cover the saved vmcore and the created logs files,
> we only need to update the xattr file of three files. So from the
> perspective of kdump, it's good to disable IMA for kdump to save memory.

Remember my original concerns weren't about disabling IMA for kdump, but ab=
out not
limiting disabling IMA to just kdump.

> Of course we can't rule out the possibility some users may want to need
> IMA in kdump. So a flexible solution like providing a knob to allow
> users to enable IMA in kdump will be the ideal solution.

Agreed

>=20
> Btw, recently, a colleague reminds me of an issue that the system hangs
> because systemd fails to load incorrect /etc/ima/ima-policy. Of course,
> we should ask users to verify the policy beforehand. But it's still
> possible the booting process may be stopped by a strict, albeit
> syntax-correct policy and users can't log into the system to fix the
> policy. Do you think a knob to disable IMA is needed to address these
> cases or is there a better solution?

Agreed a new policy should always be tested, before attempting to load it o=
n boot.=20
However there are situations when even a tested policy fails.  Commonly thi=
s occurs
when attempting to load an IMA policy based on IMA features that don't exis=
t in an
older kernel.  This can normally be resolved by booting into the newer kern=
el and
"fixing" the policy.  Instead of disabling IMA, I would allow specifying on=
 the boot
command line an alternate IMA policy (e.g. ima-policy.backup-version) to be=
 loaded
as fallback.

>=20
> >=20
> > Currently, Kdump has no demand to do integrity verification based on
> > keys, keyrings, except of Coiby's LUKS support in kdump:
> >=20
> > [PATCH v8 0/7] Support kdump with LUKS encryption by reusing LUKS volum=
e keys
> > https://lore.kernel.org/all/20250207080818.129165-1-coxu@redhat.com/T/#=
u
> >=20
> > I have talked to Coiby, he will do some investigations to see if loadin=
g
> > keys related to IMA or IMA-appraisal functionality is related to LUKS
> > support in kdump because the LUKS support in kdump also needs
> > store/restore keys/keyrings between normal kernel and kdump kernel.
>=20
> Thanks for reminding me about kdump LUKS support. IMA will create
> keyring like .ima for loading keys and other components can still create
> their own keyrings or use existing keyrings. And I can confirm kdump
> LUKS support won't be affected.=20

thanks,

Mimi


