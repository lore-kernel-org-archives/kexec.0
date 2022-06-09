Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B7AC43334
	for <kexec@archiver.kernel.org>; Thu,  9 Jun 2022 22:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U2ELSl4vYlsozBez/66L3scb2jBJpb83S5Hb5IUAqik=; b=184J4JqLtTmsxf
	7aw3WeylaxUWbEY/YKFAcNUyWi2H4icKqgrtY+1X/FSVipfnuDl5y0Z8lHraINAQ+TGyhOAPowJmP
	yEtIFL49bJaPicQv6LyJXO0IWXtjymfhlWSJUNgDR1OM4iKqIuC4+0XeLfp+XakkkBRidZS82fTsB
	RALfX4nct4L8JFEssahxylS7BQYRlw9REtnf2SF7cCrzVn2uzkcdQ17KjgJL7C1gCfGAyQiR/Rgtu
	5mhJMzS+Q6VlFYfw1zW9krBrSOBc+zvtuDA4AfdE+5QT+4ZDdX4MZUAAM/NSXFph31jebTE0vulDu
	d7fS+Jt3VH7g68pK7g0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzQUm-004NAf-To; Thu, 09 Jun 2022 22:19:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzQUk-004N9I-Pf; Thu, 09 Jun 2022 22:19:16 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259LqV4d021237;
	Thu, 9 Jun 2022 22:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=5HFels0siO9Bs1KgO2JhJGYpJaNAG8PeqPH7KCpQZ8I=;
 b=iAzYl3HGbDPjGXTh3OP2TMtL8+E00E4alPACUjc12mHEx1F0g4Wav7UU13WA58TpKEN/
 v6svbQGfFE5DAdCcgmlNFzKBE+Eg000u0UbngUGaRd/c6ooO0uKyt8bL4tWzFKvEH80x
 w3pe1l2FoKqhiHzfDe0FNnF7eEOGiyQ//lcjABbhVvN3CyO8iJL8P/m9rSQR2RFK4Jqf
 ZvD55hb1u8ldwCuT+DqIv4ppav4SCUQUf3IjuBlPaM7mQLxC4GlYpocdXVXrVmdKSxG1
 Io++Oyg5UxHMfTpYFdaQswQqtjpC6/7M3jgumv2ROuP29D2kSIu3MfU8vvZRNRU/0hjV RA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gks5cgctx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jun 2022 22:18:51 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 259MD8WL005156;
	Thu, 9 Jun 2022 22:18:51 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gks5cgct7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jun 2022 22:18:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 259M6fwY027968;
	Thu, 9 Jun 2022 22:18:49 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma04ams.nl.ibm.com with ESMTP id 3gfy19ff4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jun 2022 22:18:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 259MIkPq9175434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jun 2022 22:18:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEFFC4C044;
	Thu,  9 Jun 2022 22:18:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD1FF4C040;
	Thu,  9 Jun 2022 22:18:44 +0000 (GMT)
Received: from sig-9-65-64-6.ibm.com (unknown [9.65.64.6])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jun 2022 22:18:44 +0000 (GMT)
Message-ID: <5db507747b2be22499e7357ce65f1800b36e1de4.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/4] kexec, KEYS: make the code in
 bzImage64_verify_sig generic
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, Michal Suchanek
 <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman"
 <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav
 Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H.
 Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>
Date: Thu, 09 Jun 2022 18:18:44 -0400
In-Reply-To: <20220512070123.29486-3-coxu@redhat.com>
References: <20220512070123.29486-1-coxu@redhat.com>
	 <20220512070123.29486-3-coxu@redhat.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7wDBaP3m-VYgn90ZlORpX0j8Rd3YzlsY
X-Proofpoint-GUID: BG6JqiSb9BIi2R873tnMtsXFSjA4dDlA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_15,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=781
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206090082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_151914_979998_0C86F95D 
X-CRM114-Status: GOOD (  19.65  )
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

On Thu, 2022-05-12 at 15:01 +0800, Coiby Xu wrote:
> commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
> signature verify") adds platform keyring support on x86 kexec but not
> arm64.
> 
> The code in bzImage64_verify_sig makes use of system keyrings including
> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to
> verify signed kernel image as PE file. Make it generic so both x86_64
> and arm64 can use it.

^uses the keys on the .builtin_trusted_keys, .machine, if configured
and enabled, .secondary_trusted_keys, also if configured, and .platform
keyrings to verify the signed kernel image as PE file. 

> 
> @@ -202,6 +203,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
>  				 const Elf_Shdr *relsec,
>  				 const Elf_Shdr *symtab);
>  int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#ifdef CONFIG_KEXEC_SIG
> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
> +int kexec_kernel_verify_pe_sig(const char *kernel,
> +				    unsigned long kernel_len);

Please join this line with the previous one.

> +#endif
> +#endif
>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
