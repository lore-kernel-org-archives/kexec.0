Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525E6C35FFA
	for <kexec@archiver.kernel.org>; Wed, 19 Mar 2025 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sZYTAlykF2FnSrFAp20+Ku9prCRhz16lr5GBVRpvJb8=; b=uugbJSkdZGJO4KsIrUR5l/gnFf
	Rr4RvHUBpC06uT5MpUXtsxRhB7XS+jdVMHOl0h7UoWBIayN/ma3m5Y+uLV8iv/xd724Jg3k4RxWQB
	y9GYiIHLdqxAo3Uq11tbgkZNVS4tbzof4PXJMVOZx3rZfMt6IfXevbGGy4lJq1Tq0sqyiCMdjHr5Z
	RiFzUEDGB9AkSvXEnPM9GO0kRIsQojoqBsQ7MWbvM5wkn582Jbu+Ibpg+wk1wH3PfHEe5aKOIMtRY
	3MEFOPulFFOLFXNefDb0NdvFmJh8DHrhZgWIkhrSWDzVBihOtLbLQCr6vdiGcee4Rl6+0z/53OBKA
	zffL4KoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuwGN-00000009YGi-1NYH;
	Wed, 19 Mar 2025 16:27:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuwGK-00000009YFd-2pYq
	for kexec@lists.infradead.org;
	Wed, 19 Mar 2025 16:27:25 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J9ASqe014501;
	Wed, 19 Mar 2025 16:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sZYTAl
	ykF2FnSrFAp20+Ku9prCRhz16lr5GBVRpvJb8=; b=mbvGsgbI93DbUq2TznRg6H
	44nYtDHbUmqPbyg6F2egoQD1aL4OZKHLRMAevkuzJwtLkLmI7zYpPj2Wo2ivAWPh
	hseuZloN9HOipgDIVm8mg2huK9qArKwCUQt/SMCdj9O/5djOhxSJtyqwiXVCb0eX
	btRthzgr1gGx8ViLC4QQ7L9A7QS5CjeVN4umUMb/GEHfETzxghYhEM9VU147e+0X
	H7PH6mhQKGPN28CBex6N8tQSYm6hYgbDwZGHTUQUMF6Jc+51KkTUEQglYmbzSAsK
	O5uXqucb0ne0mzmVwEnmNr3HZTwsgsy5tdj9CZM7tXaGL/R3XIjiUfAlCe7dfGCg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg0pvxrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 16:27:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JG89Lf012341;
	Wed, 19 Mar 2025 16:27:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvp2k0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 16:27:09 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JGR9mL14025338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 16:27:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 401F95805C;
	Wed, 19 Mar 2025 16:27:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65F6B58054;
	Wed, 19 Mar 2025 16:27:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.177.219])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 16:27:07 +0000 (GMT)
Message-ID: <447b1bf7b31e936ab959b8ba13f09a9c25bb3977.camel@linux.ibm.com>
Subject: Re: [PATCH v10 2/8] ima: define and call ima_alloc_kexec_file_buf()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, steven chen <chenste@linux.microsoft.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Wed, 19 Mar 2025 12:27:06 -0400
In-Reply-To: <Z9p7rwXqjB3vjCpj@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
	 <20250318010448.954-3-chenste@linux.microsoft.com>
	 <Z9p7rwXqjB3vjCpj@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KCpjc3unk0l9_sdrT7WYIOPKHGIIcEOU
X-Proofpoint-ORIG-GUID: KCpjc3unk0l9_sdrT7WYIOPKHGIIcEOU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_092724_839435_98061280 
X-CRM114-Status: GOOD (  41.82  )
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

On Wed, 2025-03-19 at 16:09 +0800, Baoquan He wrote:
> On 03/17/25 at 06:04pm, steven chen wrote:
> > Carrying the IMA measurement list across kexec requires allocating a
> > buffer and copying the measurement records.  Separate allocating the
> > buffer and copying the measurement records into separate functions in
> > order to allocate the buffer at kexec 'load' and copy the measurements
> > at kexec 'execute'.
> >=20
> > This patch includes the following changes:
> >  - Refactor ima_dump_measurement_list() to move the memory allocation
> >    to a separate function ima_alloc_kexec_file_buf() which allocates
> >    buffer of size 'kexec_segment_size' at kexec 'load'.
> >  - Make the local variable ima_kexec_file in ima_dump_measurement_list(=
)
> >    a local static to the file, so that it can be accessed from=20
> >    ima_alloc_kexec_file_buf().
> >  - Make necessary changes to the function ima_add_kexec_buffer() to cal=
l
> >    the above two functions.
>=20
> We may not need above details about code change because it's not so
> difficult to get them from patch.

Agreed.  The changes don't even reflect the current patch.  Please remove t=
he
entire section.

>=20
> >=20
> > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > ---
> >  security/integrity/ima/ima_kexec.c | 67 +++++++++++++++++++++++++-----
> >  1 file changed, 56 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/im=
a/ima_kexec.c
> > index 8567619889d1..45170e283272 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -15,6 +15,48 @@
> >  #include "ima.h"
> > =20
> >  #ifdef CONFIG_IMA_KEXEC
> > +static struct seq_file ima_kexec_file;
> > +
> > +static void ima_reset_kexec_file(struct seq_file *sf)
> > +{
> > +	sf->buf =3D NULL;
> > +	sf->size =3D 0;
> > +	sf->read_pos =3D 0;
> > +	sf->count =3D 0;
> > +}
> > +
> > +static void ima_free_kexec_file_buf(struct seq_file *sf)
> > +{
> > +	vfree(sf->buf);
> > +	ima_reset_kexec_file(sf);
> > +}
> > +
> > +static int ima_alloc_kexec_file_buf(size_t segment_size)
> > +{
> > +	/*
> > +	 * kexec 'load' may be called multiple times.
> > +	 * Free and realloc the buffer only if the segment_size is
> > +	 * changed from the previous kexec 'load' call.
> > +	 */
> > +	if (ima_kexec_file.buf && ima_kexec_file.size =3D=3D segment_size)
> > +		goto out;

The call to ima_reset_kexec_file() in ima_add_kexec_buffer() resets
ima_kexec_file.buf() hiding the fact that the above test always fails and f=
alls
through.  As a result, 'buf' is always being re-allocated.

> > +
> > +	ima_free_kexec_file_buf(&ima_kexec_file);
> > +
> > +	/* segment size can't change between kexec load and execute */
> > +	ima_kexec_file.buf =3D vmalloc(segment_size);
> > +	if (!ima_kexec_file.buf)
> > +		return -ENOMEM;
> > +
> > +	ima_kexec_file.size =3D segment_size;
> > +
> > +out:
> > +	ima_kexec_file.read_pos =3D 0;
> > +	ima_kexec_file.count =3D sizeof(struct ima_kexec_hdr);	/* reserved sp=
ace */
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Copy the measurement list to the allocated memory
> >   * compare the size of IMA measurement list with the size of the alloc=
ated memory
> > @@ -26,23 +68,16 @@
> >  static int ima_dump_measurement_list(unsigned long *buffer_size, void =
**buffer,
> >  				     unsigned long segment_size)
> >  {
> > -	struct seq_file ima_kexec_file;
> >  	struct ima_queue_entry *qe;
> >  	struct ima_kexec_hdr khdr;
> >  	int ret =3D 0;
> > =20
> >  	/* segment size can't change between kexec load and execute */
> > -	ima_kexec_file.buf =3D vmalloc(segment_size);
> >  	if (!ima_kexec_file.buf) {
> > -		ret =3D -ENOMEM;
> > -		goto out;
> > +		pr_err("Kexec file buf not allocated\n");
> > +		return -EINVAL;
> >  	}
> > =20
> > -	ima_kexec_file.file =3D NULL;
> > -	ima_kexec_file.size =3D segment_size;
> > -	ima_kexec_file.read_pos =3D 0;
> > -	ima_kexec_file.count =3D sizeof(khdr);	/* reserved space */
> > -
> >  	memset(&khdr, 0, sizeof(khdr));
> >  	khdr.version =3D 1;
> >  	/* This is an append-only list, no need to hold the RCU read lock */
> > @@ -79,8 +114,6 @@ static int ima_dump_measurement_list(unsigned long *=
buffer_size, void **buffer,
> >  	*buffer_size =3D ima_kexec_file.count;
> >  	*buffer =3D ima_kexec_file.buf;
> >  out:
> > -	if (ret =3D=3D -EINVAL)
> > -		vfree(ima_kexec_file.buf);
> >  	return ret;
> >  }
> > =20
> > @@ -119,6 +152,12 @@ void ima_add_kexec_buffer(struct kimage *image)
> >  		return;
> >  	}
> > =20
> > +	ret =3D ima_alloc_kexec_file_buf(kexec_segment_size);
> > +	if (ret < 0) {
> > +		pr_err("Not enough memory for the kexec measurement buffer.\n");
> > +		return;
> > +	}
> > +
> >  	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> >  				  kexec_segment_size);
> >  	if (!kexec_buffer) {
> > @@ -140,6 +179,12 @@ void ima_add_kexec_buffer(struct kimage *image)
> >  	image->ima_buffer_size =3D kexec_segment_size;
> >  	image->ima_buffer =3D kexec_buffer;
> > =20
> > +	/*
> > +	 * kexec owns kexec_buffer after kexec_add_buffer() is called
> > +	 * and it will vfree() that buffer.
> > +	 */
> > +	ima_reset_kexec_file(&ima_kexec_file);
>=20
> I can't see why we need call ima_reset_kexec_file() here. If we need
> reuse the buffer, we will reset the needed fields at the end of
> ima_alloc_kexec_file_buf(). Not sure if I miss anything.

Without ima_reset_kexec_file(), calling 'kexec load' consecutively without
"kexec -s -e" in between fails.

# kexec -s -l /boot/vmlinuz-`uname -r` --initrd=3D/boot/initramfs-`uname -r=
`.img --reuse-cmdline
# kexec -s -l /boot/vmlinuz-`uname -r` --initrd=3D/boot/initramfs-`uname -r=
`.img --reuse-cmdline
Killed

As mentioned above, the call to ima_reset_kexec_file() resets
ima_kexec_file.buf, so the segment size test always fails and the memory is
being allocated.

Mimi

>=20
> static int ima_alloc_kexec_file_buf(size_t segment_size)
> {
> ......
> out:
>         ima_kexec_file.read_pos =3D 0;
>         ima_kexec_file.count =3D sizeof(struct ima_kexec_hdr);    /* rese=
rved space */
>=20
>         return 0;
> }
>=20
>=20


