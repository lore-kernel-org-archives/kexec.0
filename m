Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EACAEA811B
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9BCbZ5VaM8E6O8CtxrV81YvFzyuG0PkGV3B/y9JLcfM=; b=2r4sWovfOH+LR+okkvNWCeu+qv
	ix5kU8pv37QqmOFCEnUY0itJivImr7QnWh4ClhnIkDilCu9DYI6m3oPqM6t+zQLmJozPeX4OgC9Qj
	afLfzm4G6QhFukwAhBlYvpfzOAW7aj7jD+F8JHUjBAHnrWJJKFyoKvCF5StvFdi17fY8qYLEd3NAV
	55oXKYyi3IqeYV6ol2ktLDOgmYjkBG99GADGIzhyNUOZAAa89FfImAn1VbKFNPBVXO4T0s/veza9/
	P4Z2zeV9Mys4Np1Nb7jXJItxTI5QFn12PHWxAyupFVQx4xG7HXe2lgcEbqBlVzXAXlxPbmN7mqvUL
	6ph9ZdRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpoJ3-0000000H1V7-0Gzg;
	Tue, 10 Feb 2026 14:01:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpoJ0-0000000H1UC-07XQ
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 14:01:31 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A8QxCr188751;
	Tue, 10 Feb 2026 14:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9BCbZ5VaM8E6O8CtxrV81YvFzyuG0P
	kGV3B/y9JLcfM=; b=fVHKE59RK4IWyUsWKidtw9j4Lc7RH9TfrXFYBHVrsZDWX6
	lytpYYebudkP4YlPTINZrJHkE8rpOwXNiKf11L5WZERdd1Exlv2oAxswmeo6X3YW
	bMJ/jhS1Qi9xJuI0wq7ipEWwPdwUwQF+49u2cAcPN30jQr52vSNpgbNxBIGtiYJ8
	rurVZaFelRoo4t+ZrDsFVLfPVVGOtlWmK0kOrX9JtcgU1KsEVod6mwWoh/yC1Ws8
	pkWnAqx29IwAcJs67SwngUe1M2TrSgM94kpaWNiWCUa7Tpt04IvBRXOAWJCWNAlS
	IJYTC7n9RJKDD4uCaFwAUUzd2IxbeLhHhnsHfeCg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wtdsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 14:01:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AARCU7012623;
	Tue, 10 Feb 2026 14:01:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7k9efv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 14:01:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61AE1Nv625232080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 14:01:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BD732004E;
	Tue, 10 Feb 2026 14:01:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 673C22004F;
	Tue, 10 Feb 2026 14:01:23 +0000 (GMT)
Received: from localhost (unknown [9.52.203.71])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Feb 2026 14:01:23 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc: linux-s390@vger.kernel.org, akpm@linux-foundation.org,
        kexec@lists.infradead.org
Subject: Re: [RESEND PATCH v1 1/1] s390/kexec: Make KEXEC_SIG available when
 CONFIG_MODULES=n
In-Reply-To: <20260210133652.15669A6b-hca@linux.ibm.com>
References: <20260209133308.118364-1-egorenar@linux.ibm.com>
 <aYqWhWQO265YRnPP@fedora> <20260210133652.15669A6b-hca@linux.ibm.com>
Date: Tue, 10 Feb 2026 15:01:23 +0100
Message-ID: <875x84k898.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698b3a36 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=lxvgQm3_RAlpGahvngQA:9
X-Proofpoint-GUID: B-IO1yp4kKiujqetpEyRNVpNNEI3HKyg
X-Proofpoint-ORIG-GUID: B-IO1yp4kKiujqetpEyRNVpNNEI3HKyg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExNiBTYWx0ZWRfX6G94n/wwTSKB
 XMYC1RD7JLcSKg2TQEp+fRS+3tD2HYnpR2dkRMkREUqXAUQUlDrFMBSfcLcwNmGq8goh1nVEj8E
 B7BxB+RfaVGF8EfNYs+RC07Fkyj+OWAR3EBkfqBmf4dP9REV0G9rVDi3uYKoCq8TgMpTAHePmM1
 wRd0E4v+cPXd8ziKRJwz76kaOMNnRG/ETp3g3Sz+UNgBceSLkemW1sOxJaYOub5E+/JsNBLWZxm
 dHuToUChItwx6kgR8L7sMI3bcID6zzDSF5vt+AEG7AHWrIGr6/iZ9MEHW+RoSm97NI/qcsikFdL
 49D+QxqgDlNUC+OoxXQ8/JOoM/Vd3dOKZyzS/6ygxvIQo9iC2mrV5UuBV0wntN8+3+xuoKwH0Zb
 O5Cs/x8LNWSru1GrjPEVhnsKLUajCwCvBXTtzYYvv33Fy74EUUglMcdb2uGV1l5gXueLjFzlRXG
 NhwS9CvTYIzIPpkbKSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_060130_182998_E40977F2 
X-CRM114-Status: GOOD (  13.95  )
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

>> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> > index c2c7bf974397..385c1052cf45 100644
>> > --- a/arch/s390/Kconfig
>> > +++ b/arch/s390/Kconfig
>> > @@ -313,7 +313,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
>> >  	def_bool y
>> >  
>> >  config ARCH_SUPPORTS_KEXEC_SIG
>> > -	def_bool MODULE_SIG_FORMAT
>> > +	def_bool y
>> >  
>> >  config ARCH_SUPPORTS_KEXEC_PURGATORY
>> >  	def_bool y
>> > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
>> > index 15632358bcf7..df97227cfca9 100644
>> > --- a/kernel/Kconfig.kexec
>> > +++ b/kernel/Kconfig.kexec
>> > @@ -50,6 +50,7 @@ config KEXEC_SIG
>> >  	bool "Verify kernel signature during kexec_file_load() syscall"
>> >  	depends on ARCH_SUPPORTS_KEXEC_SIG
>> >  	depends on KEXEC_FILE
>> > +	select SYSTEM_DATA_VERIFICATION if S390
>
> Alexander, would it make sense to move this to arch/s390/Kconfig and
> add something like
>
> 	select SYSTEM_DATA_VERIFICATION if KEXEC_SIG
>
> instead? This would have the slight advantage to keep arch specifics
> out of common code Kconfig.

That's even better, what i was actually looking for.
And works as expected too.

Thanks, Heiko.

