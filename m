Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACA3C433EF
	for <kexec@archiver.kernel.org>; Thu,  2 Jun 2022 01:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=whcC2SgM/VNJkESPEls55L7cZATUfpn23esqYY2JpH4=; b=hRKFL9gO6/GVBvaIPkSsl2PZO6
	opJ/Yki3S/MR6+Q4gEpzw8oY77L5XWsoCZtcyylsMKZS4mLMUmIq/9jsPP2y/K9E+4uwuJ4m182EW
	FArQj/fzXumyClQyfRJzdtTLQJTW3YEiOKZQDOnykPIpPFDrEKl9ODMa/D20/Z/afOqb6D3D/cNpk
	FIlRIEPTq6slS0lLPWjT8cfIa6jAjZlfGAtyeTobWosPJslO2K0rIzwCuctmA1IHL/FRFA6d/edRA
	3eoHNY1rUbxxEr9pmmMh2r6nM+tD9Pj6VWXJrn/CytSNrAeq0oZe2rvOaAzQWeGbr5t6VJfnAH2Fh
	Dx9qhfMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwZEC-000wqA-ET; Thu, 02 Jun 2022 01:02:20 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwZE9-000wnw-6Y; Thu, 02 Jun 2022 01:02:19 +0000
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LD74C5FsSzjWwG;
	Thu,  2 Jun 2022 09:00:59 +0800 (CST)
Received: from [10.67.111.227] (10.67.111.227) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 2 Jun 2022 09:02:10 +0800
Subject: Re: [PATCH] RISCV: kexec: Fix build error without CONFIG_MODULES
To: Randy Dunlap <rdunlap@infradead.org>, <palmer@rivosinc.com>
CC: <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
	<liaochang1@huawei.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <ebiederm@xmission.com>,
	<kexec@lists.infradead.org>, <linux-next@vger.kernel.org>
References: <20220601063924.13037-1-lizhengyu3@huawei.com>
 <b9c831a3-44ab-0374-34f8-8bd8bc311e5c@infradead.org>
From: "lizhengyu (E)" <lizhengyu3@huawei.com>
Message-ID: <cf78d358-fb43-8366-c648-ae6c0085b51d@huawei.com>
Date: Thu, 2 Jun 2022 09:02:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b9c831a3-44ab-0374-34f8-8bd8bc311e5c@infradead.org>
X-Originating-IP: [10.67.111.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220601_180217_462473_0015FEC6 
X-CRM114-Status: GOOD (  11.19  )
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


On Wed, 01 Jun 2022 09:08:16 -0700, Randy Dunlap <rdunlap@infradead.org> 
wrote:
> Hi--
>
> On 5/31/22 23:39, Li Zhengyu wrote:
>> When CONFIG_MODULES is not set/enabled:
>>
>> ../arch/riscv/kernel/elf_kexec.c:353:9: error: unknown type name 'Elf_Rela'; did you mean 'Elf64_Rela'?
>>    353 |         Elf_Rela *relas;
>>        |         ^~~~~~~~
>>        |         Elf64_Rela
>>
>> Replace Elf_Rela by Elf64_Rela to avoid relying on CONFIG_MODULES.
>>
> BTW, does this mean that RISC-V kexec is only available on 64BIT
> and not on 32BIT?

Currently, yes, CONFIG_KEXEC_FILE depends on 64BIT.

Palmer is working on it, see 
https://lore.kernel.org/all/20220520154430.18593-1-palmer@rivosinc.com/ .

>
> thanks.
>
>> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
>> ---
>>   arch/riscv/kernel/elf_kexec.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
>> index 9cb85095fd45..0cb94992c15b 100644
>> --- a/arch/riscv/kernel/elf_kexec.c
>> +++ b/arch/riscv/kernel/elf_kexec.c
>> @@ -349,7 +349,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>>   {
>>   	const char *strtab, *name, *shstrtab;
>>   	const Elf_Shdr *sechdrs;
>> -	Elf_Rela *relas;
>> +	Elf64_Rela *relas;
>>   	int i, r_type;
>>   
>>   	/* String & section header string table */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
