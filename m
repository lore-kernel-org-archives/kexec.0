Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53319C004D4
	for <kexec@archiver.kernel.org>; Thu, 19 Jan 2023 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kmEBUthRMM4tDMVg1LwtuDF+RgNkDdgu93N7m+BlLGk=; b=b3AEeHm+qYsQdM
	TExkpP2Zmn76KhmbjMidlYV66Lc/j5v6dmQFB5/2cnPGsxhyr1K8Nso9tId8qWtQZX4NOhw7fXcgg
	BLNpiecu/i6lnkMjnLR7db9vuAVIt2g+h6dfXBIcdqho2im6YJ1LLN1K/JFu3LnzlmfCcudizUaj5
	X+xn42QshJbibVDyfoo7FYVzQj9qw9mXxZkEMEgoCdbGyj7h3I4b/e4JaGmyN3vO1BDMNllrIDE3V
	BthPOqtCa+v9psiwEu8Cy1TzGNGlGkO4d+0Qvy0y6hCOilnR6TXCBHHlXjBp2eDlcvEhWi+WfQITx
	bCNZslSpLXaymwSYHJcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIZfx-006Zai-OH; Thu, 19 Jan 2023 18:30:13 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIZfr-006ZXp-Np
	for kexec@lists.infradead.org; Thu, 19 Jan 2023 18:30:10 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JID4BQ017535;
	Thu, 19 Jan 2023 18:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7QaXGnFJtdhIMUQIJ9Cp7OYA0zV/uBnMr2yUJiZmPKk=;
 b=Nih3jJBbp7PgRKhBkE6NiZAO0KXXy8ad6HoW0k0tH6+u1h+gchyIACY4qqIwKgYCAFYc
 BFUKGZryyRjuMJGShVrlB13ZRUgIPGR9DeLrDeKy9uCOC0KA74eaM1ni66KD+zTLA1ig
 GD3kXiVdSpLjQNaygRRsQvdzgRerWm8LdZzEk0OEkhoIK88IKrnGp8aV55fuqY71yft9
 AddcPzq9p9LeCIFB+cywetZHD3IubLVk+Gd4JGMef9sg41fCAoy7r/H2nvyGihnBsoU2
 KgMGz88d78+QsdrzyoEuF/RkGNUV7cmsgeFJzw7Z8u/vQXJ5tqwt9nax3OIM66XUbTS8 Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n78qscpd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jan 2023 18:30:00 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30JIIxH0006881;
	Thu, 19 Jan 2023 18:29:59 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n78qscpce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jan 2023 18:29:59 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5X3RB023782;
	Thu, 19 Jan 2023 18:29:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16q1p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jan 2023 18:29:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JITr6q40829194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jan 2023 18:29:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCA4620043;
	Thu, 19 Jan 2023 18:29:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3077B20040;
	Thu, 19 Jan 2023 18:29:53 +0000 (GMT)
Received: from [9.179.13.66] (unknown [9.179.13.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Jan 2023 18:29:53 +0000 (GMT)
Message-ID: <51fa22e4-efab-a931-fb8f-48180baaac61@linux.ibm.com>
Date: Thu, 19 Jan 2023 19:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v7 4/8] crash: add phdr for possible CPUs in elfcorehdr
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20230115150206.431528-1-sourabhjain@linux.ibm.com>
 <20230115150206.431528-5-sourabhjain@linux.ibm.com>
Content-Language: fr
From: Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20230115150206.431528-5-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PlRiUW0zaDBDhE-lxgxM6FgUJZZk9Qcx
X-Proofpoint-ORIG-GUID: f7WvtRJknNe6nlQ-tVauFUrrS1RjvXOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_11,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190149
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_103008_010654_DAE03FD2 
X-CRM114-Status: GOOD (  24.65  )
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
Cc: eric.devolder@oracle.com, kexec@lists.infradead.org, hbathini@linux.ibm.com, bhe@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 15/01/2023 16:02:02, Sourabh Jain wrote:
> On architectures like PowerPC the crash notes are available for all
> possible CPUs. So let's populate the elfcorehdr for all possible
> CPUs having crash notes to avoid updating elfcorehdr during in-kernel
> crash update on CPU hotplug events.
> 
> The similar technique is used in kexec-tool for kexec_load case.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  kernel/crash_core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

This patch is not applying on ppc/next (53ab112a9508).

As far as I could see, crash_prepare_elf64_headers() is defined in the file
kernel/kexec_file.c and that's not recent, see babac4a84a88 (kexec_file,
x86: move re-factored code to generic side, 2018-04-13)

Am I missing something?

> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 910d377ea317e..19f987b3851e8 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -364,8 +364,8 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>  	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
>  	ehdr->e_phentsize = sizeof(Elf64_Phdr);
>  
> -	/* Prepare one phdr of type PT_NOTE for each present CPU */
> -	for_each_present_cpu(cpu) {
> +	/* Prepare one phdr of type PT_NOTE for possible CPU with crash note. */
> +	for_each_possible_cpu(cpu) {
>  #ifdef CONFIG_CRASH_HOTPLUG
>  		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
>  			/* Skip the soon-to-be offlined cpu */
> @@ -373,8 +373,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>  				continue;
>  		}
>  #endif
> -		phdr->p_type = PT_NOTE;
>  		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
> +		if (!notes_addr)
> +			continue;
> +
> +		phdr->p_type = PT_NOTE;
>  		phdr->p_offset = phdr->p_paddr = notes_addr;
>  		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
>  		(ehdr->e_phnum)++;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
