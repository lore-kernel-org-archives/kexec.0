Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D217CC433EF
	for <kexec@archiver.kernel.org>; Mon, 13 Jun 2022 21:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7z+cAvNdSbTfE2gktzm2bR9miMVJ5+opo3JVcbFYCYk=; b=Qq6AJBVFd3ds67
	B3b/N83z09AR4kv4G3K7TWKzs+mdAt29zSoWjKyTpj5Ud6UGIX+FsVRo9/kRPloMGpi/aO/0Km440
	z5bQqlJ22pstJXn5NS1P8GtDtA8ZAhCx2Z7qxEMtLyFhVmAbVp9Dm/wD/wg03NR9RnQdr/f/AwBrK
	PGwWlZwpx0hYG4vy6nUHfr1LEVGWDezU2mw+qBcLoHiPX3H7moLjK9xcKR2hdKurAPvtV3mugGFLO
	64q3msL6auRhxbxwUZRRGrshWZy72vlMg8uWOrpFzK1YMnDGVClwnFKhaqMHxBcBRO8tmMwRoDG5Y
	9INkzVjQE3i73yTVm7hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0rCy-005rXs-Uu; Mon, 13 Jun 2022 21:02:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0rCi-005rQW-5f
	for kexec@lists.infradead.org; Mon, 13 Jun 2022 21:02:33 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DHvM4g026345;
	Mon, 13 Jun 2022 21:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=W0/VfWmZQgxGvSGY5XnvxyNb6iblBpoBtC43Q10PWmI=;
 b=bKpeWdJRq3Ifvwkynlc8oRkbREyFjYehay+X60+UlivVfF6ou+/VhpDEE+Ea0Y//QCMO
 ivGAeZb5CGcE6N9sbf+rhm1jBNEYNvS3Id9zKQRFUFuvsFvbqW9qwixhK0Uvasc86SA+
 H/ZnI557qHO0QyyxOqRxDmkmzoRL67SLAl98dyB3rSoDawnf30nCUUYkI0rtwnlGsCZ1
 szYIFiPZYw6dPa+lD+B1iZjkrj01JQ1X0w7ZlXJQMatiUnKg9eO7KCkqvoizm9yVz6zL
 1AgVeVToIZyd7cppmV+hkFqr9TTR0yv1sxJW/FIrLctOyuU3vcI76lo13m+bjbKzcCUr PA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpa3eb9gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jun 2022 21:01:57 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25DKu5DJ010578;
	Mon, 13 Jun 2022 21:01:57 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpa3eb9gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jun 2022 21:01:56 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25DKoUm9024692;
	Mon, 13 Jun 2022 21:01:55 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma04fra.de.ibm.com with ESMTP id 3gmjp8tjnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jun 2022 21:01:54 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25DL1q1o19595744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jun 2022 21:01:52 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78F32AE045;
	Mon, 13 Jun 2022 21:01:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB506AE051;
	Mon, 13 Jun 2022 21:01:50 +0000 (GMT)
Received: from sig-9-65-64-7.ibm.com (unknown [9.65.64.7])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jun 2022 21:01:50 +0000 (GMT)
Message-ID: <60813f86e960d12ed3738531a14382769a061a02.camel@linux.ibm.com>
Subject: Re: [PATCH v5] x86/kexec: Carry forward IMA measurement log on kexec
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jonathan McDowell <noodles@fb.com>, Thomas Gleixner
 <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        Baoquan He <bhe@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	 <linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org"
	 <kexec@lists.infradead.org>
Date: Mon, 13 Jun 2022 17:01:50 -0400
In-Reply-To: <YqcRuQFq5fg1XhB/@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
	 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
	 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
	 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
	 <YqcRuQFq5fg1XhB/@noodles-fedora.dhcp.thefacebook.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IdBbU-yAIygxqLrqW7q8yZr9R4zpKttp
X-Proofpoint-GUID: GnMqjeNHS5KRt7PsYb3tN2XwW1atiTtK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_08,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206130082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_140232_377415_012A54B1 
X-CRM114-Status: GOOD (  32.18  )
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

On Mon, 2022-06-13 at 10:30 +0000, Jonathan McDowell wrote:
> On kexec file load Integrity Measurement Architecture (IMA) subsystem
> may verify the IMA signature of the kernel and initramfs, and measure
> it. The command line parameters passed to the kernel in the kexec call
> may also be measured by IMA. A remote attestation service can verify
> a TPM quote based on the TPM event log, the IMA measurement list, and
> the TPM PCR data. This can be achieved only if the IMA measurement log
> is carried over from the current kernel to the next kernel across
> the kexec call.
> 
> powerpc and ARM64 both achieve this using device tree with a
> "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> device tree, so use the setup_data mechanism to pass the IMA buffer to
> the new kernel.
> 
> (Mimi, Baoquan, I haven't included your reviewed-bys because this has
>  changed the compile guards around the ima_(free|get)_kexec_buffer
>  functions in order to fix the warning the kernel test robot found. I
>  think this is the right thing to do and avoids us compiling them on
>  platforms where they won't be used. The alternative would be to drop
>  the guards in ima.h that Mimi requested for v4.)hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
> 
> Signed-off-by: Jonathan McDowell <noodles@fb.com>
> ---
> v5:
>  - Guard ima_(free|get)_kexec_buffer functions with
>    CONFIG_HAVE_IMA_KEXEC (kernel test robot)
>  - Use setup_data_offset in setup_boot_parameters and update rather than
>    calculating in call to setup_ima_state.
> v4:
>  - Guard ima.h function prototypes with CONFIG_HAVE_IMA_KEXEC

> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 8d374cc552be..42a6c5721a43 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -9,6 +9,7 @@
>   *  Copyright (C) 2016  IBM Corporation
>   */
>  
> +#include <linux/ima.h>
>  #include <linux/kernel.h>
>  #include <linux/kexec.h>
>  #include <linux/memblock.h>
> @@ -115,6 +116,7 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_HAVE_IMA_KEXEC
>  /**
>   * ima_get_kexec_buffer - get IMA buffer from the previous kernel
>   * @addr:	On successful return, set to point to the buffer contents.
> @@ -173,6 +175,7 @@ int ima_free_kexec_buffer(void)
>  
>  	return memblock_phys_free(addr, size);
>  }
> +#endif

Inside ima_{get,free}_kexec_buffer(), there's no need now to test
whether CONFIG_HAVE_IMA_KEXEC is enabled.

        if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
                return -ENOTSUPP;

Otherwise,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>  # IMA function
definitions

>  
>  /**
>   * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
> diff --git a/include/linux/ima.h b/include/linux/ima.h


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
