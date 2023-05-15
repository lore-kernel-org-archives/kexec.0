Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C81C7EE24
	for <kexec@archiver.kernel.org>; Mon, 15 May 2023 20:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qF8p4qGtsWm6rIvr3I4XVJCe0L1jAaQE3ABby40aB9E=; b=LgdjDgkfm91vpq
	60UBAbOKm7z+KWRiQmmfK1OdFkTdWUlyzpxSvorC/NmAUMBs5+0x8jXZtcQLG7RVhecMbAxuVUwM+
	KpLs1qMy7IxA0i4wdOpDbHx7kOnYzPTwvYCpXzQyT3c/XovIzOooXntooLRh8/bncxRRV1VtjPMk5
	9kp2EzqFM/ZU1nb/PWyurD+o3d2Uv4pogmprBRD48EC1kaQzO6Aq0qpEf7FZk+iPT0LoOLWRce4bV
	1+k8+/CcBfw3SpscX2tIOBU27e/Q168Au65J7gSj2/agPZC+qSuptrYAc94h937q/EdIxwX4bTcqv
	ltG5dJ7HLvw0EVnT53QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyfHr-003UUk-1c;
	Mon, 15 May 2023 20:59:19 +0000
Received: from sender4-of-o50.zoho.com ([136.143.188.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyfHp-003UUA-0I
	for kexec@lists.infradead.org;
	Mon, 15 May 2023 20:59:18 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1684184340; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eTGG1qsyWmh6mu4/xm11IQw7s1gdYv4wGvAMFKKyLRT51V+/z6BOjxVCBpiwB6CMycnMECWystMjsmL/u0JqgXPRB5EXaxgK4eQOlJjVO2CkUNz2vfSt0t4slM/RQ63f27JiCFzCq1I5bPQwEWAeY67A/hOdr6OJYk8FG1MVYcI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1684184340; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=O2n7lr3iwvkCVvfhSjCoMROTkl+hJy1NY/ie4hm8LcM=; 
	b=FeCTxvsGT8jeqxZkhjgu39fSBaYYu7S8x0zxTztiUlKYIa1wXsKfbNQaRPOZA9aMuT1U8PwBzzAUEv8HeP0XHl2bhGisLG9ga7nDgwxxQWMnZpkjeYcd5tT6TyaSHUIGJNrdwPn8pBExC/pMlfg3e6e7z7dTjhjE+JXWOSd/DRQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684184340;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=O2n7lr3iwvkCVvfhSjCoMROTkl+hJy1NY/ie4hm8LcM=;
	b=OiNJMmRZ3ylUV4zirQtm7+fuyXPEpSnMGwX0T+NHQ0fPeierTKbni+JLyU3PkarY
	vGfd/MkFaPxp1Hzmg/eGHriCNOmgLj9f+ipBILCEOVZVKzXycxHyE7BNNPk6dEabqLw
	O2gtkkut9XmlM9GbkzlBx526n25j5vYVeh4JbfMA=
Received: from [10.10.1.128] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1684184339064954.6533982182539; Mon, 15 May 2023 13:58:59 -0700 (PDT)
Message-ID: <276bf3a2-2518-60cb-a745-5778aa5d66a5@apertussolutions.com>
Date: Mon, 15 May 2023 16:58:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 luto@amacapital.net, nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-5-ross.philipson@oracle.com>
 <CSIZ2DT5C4WQ.19ZUUIWKNAJY9@suppilovahvero>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <CSIZ2DT5C4WQ.19ZUUIWKNAJY9@suppilovahvero>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_135917_219388_B8975726 
X-CRM114-Status: GOOD (  13.04  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 5/10/23 19:04, Jarkko Sakkinen wrote:
> On Thu May 4, 2023 at 5:50 PM EEST, Ross Philipson wrote:
>> Introduce the Secure Launch Resource Table which forms the formal
>> interface between the pre and post launch code.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   include/linux/slr_table.h | 270 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 270 insertions(+)
>>   create mode 100644 include/linux/slr_table.h
>>
>> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
>> new file mode 100644
>> index 0000000..d4b76e5
>> --- /dev/null
>> +++ b/include/linux/slr_table.h
>> @@ -0,0 +1,270 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Secure Launch Resource Table
>> + *
>> + * Copyright (c) 2023, Oracle and/or its affiliates.
>> + */
>> +
>> +#ifndef _LINUX_SLR_TABLE_H
>> +#define _LINUX_SLR_TABLE_H
>> +
>> +/* Put this in efi.h if it becomes a standard */
>> +#define SLR_TABLE_GUID				EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
>> +
>> +/* SLR table header values */
>> +#define SLR_TABLE_MAGIC		0x4452544d
>> +#define SLR_TABLE_REVISION	1
>> +
>> +/* Current revisions for the policy and UEFI config */
>> +#define SLR_POLICY_REVISION		1
>> +#define SLR_UEFI_CONFIG_REVISION	1
>> +
>> +/* SLR defined architectures */
>> +#define SLR_INTEL_TXT		1
>> +#define SLR_AMD_SKINIT		2
>> +
>> +/* SLR defined bootloaders */
>> +#define SLR_BOOTLOADER_INVALID	0
>> +#define SLR_BOOTLOADER_GRUB	1
>> +
>> +/* Log formats */
>> +#define SLR_DRTM_TPM12_LOG	1
>> +#define SLR_DRTM_TPM20_LOG	2
>> +
>> +/* DRTM Policy Entry Flags */
>> +#define SLR_POLICY_FLAG_MEASURED	0x1
>> +#define SLR_POLICY_IMPLICIT_SIZE	0x2
>> +
>> +/* Array Lengths */
>> +#define TPM_EVENT_INFO_LENGTH		32
>> +#define TXT_VARIABLE_MTRRS_LENGTH	32
>> +
>> +/* Tags */
>> +#define SLR_ENTRY_INVALID	0x0000
>> +#define SLR_ENTRY_DL_INFO	0x0001
>> +#define SLR_ENTRY_LOG_INFO	0x0002
>> +#define SLR_ENTRY_ENTRY_POLICY	0x0003
>> +#define SLR_ENTRY_INTEL_INFO	0x0004
>> +#define SLR_ENTRY_AMD_INFO	0x0005
>> +#define SLR_ENTRY_ARM_INFO	0x0006
>> +#define SLR_ENTRY_UEFI_INFO	0x0007
>> +#define SLR_ENTRY_UEFI_CONFIG	0x0008
>> +#define SLR_ENTRY_END		0xffff
> 
> "Enums are preferred when defining several related constants."
> 
> See:
> 
> https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl

These values are only used for a u16 field in a packed structure. 
Correct me if I am mistaken, but if an enum is used this will result in 
type/casting handling to/from the u16 which would negate some of the 
main benefits of using an enum.

v/r,
dps


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
