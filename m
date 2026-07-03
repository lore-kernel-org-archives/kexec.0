Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E20C43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 13:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j645c2D7HtwVcsPA69lZTtQpjVCwUV/sEYrOt+2paLM=; b=MvIBGmMhe3eKY1eFXIsedJK2zr
	EAr4LBWFdrOWi4A43YQ12R4oH5jgI96fqkh98hxsNTt3WWSILWaKusFb7aXgIj093xoB2NPBgExvh
	TDC6A5npGXrTFoyA13YEcHi3uvOhfVbb+mHBZBgoLckwe7pE3lwcZaCfyM2M9RmwaLndevXM7eiyA
	2xb/rkWsJOqZa4jsdyzh2EWl1bZy/H8hrUKGRwmpWfAQG4XuQwfZwR3JQ38Uj+1Cxl2q4mqj3V97U
	Cy/1QFVF5qYvoFg2ReY1sIIfnz7Qqr/lUa4T2dRzffBxWwRvb+FF3MT7Du0NofCDcatx0FLqCY8/C
	txOVq2Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfdyL-000000075fc-04Ar;
	Fri, 03 Jul 2026 13:30:25 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfdyI-000000075f8-0QXe
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 13:30:23 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2c821a50615so4442585ad.0
        for <kexec@lists.infradead.org>; Fri, 03 Jul 2026 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783085420; x=1783690220; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j645c2D7HtwVcsPA69lZTtQpjVCwUV/sEYrOt+2paLM=;
        b=iwXybkKhcFENO2A2Q8coQWnVy5B21zN3AgscBjMLAIGSdH4UPZe/HHjqz2jZv+SeCf
         SpmkNB/Q8Omg6j+xBLk/SEKyieuWdjqMtXccWRbSsm+d6OPWl9dsizcgy4M+LEPhE7Ww
         8PkFZs5qqb0GME4NjhkDFqc0mwIqX4iRBSdcpSLwUb2kye7AZJk0jNQ4NVmJjO3mhy+k
         7+7YSCKDJW5y7OKW4m5G19So7hLnE8HyxFmwiH6+Otlcg4ja2qmrDJkMybQF7i8zbQaC
         DTZL9LU6/O014TXsXufcjFa6zqmRyC5nIQh4pbscg4SqVDR7m9tWussJz8IA4TFaerso
         isNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783085420; x=1783690220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j645c2D7HtwVcsPA69lZTtQpjVCwUV/sEYrOt+2paLM=;
        b=CPdZyauuqHsIdwoOZ/H7XlaW4pVW4PI1CAfE0n/+eyBka5pZTuHv3f5QfbmrhFbtI4
         ToTDweWSG6Iul2m0I4rvvKn2QlDYdtg55y5aOzUrCLotvheLZH36XJyT1k3GaENp276Z
         n8URF0V6mP07I6Nk5eVA9kZMtskji2cmIhXawiCiWQgL8mMfPZ9Ks44OBHfXsiuEMivl
         kTXAlo09x1M3LyP0GK3RKw4+6ZSM3IPI3tAedAhjb5Pfhjca9MUD6DHTJLUb1FemF7Rk
         lI/d6luICAwkRIhwiTZG6LR2Zfs/4R5knbxAWYGSDdzI7FmyEvoo3b2FtJnRu7G/v/uS
         FMNw==
X-Forwarded-Encrypted: i=1; AHgh+RqvbjUVWnlzku2EevnUsp+7Tg1mEq4NQMJd/S2F8+uWMcogIw0GRUx6kJ1hJGlCBhKM0q4AHg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyRWZTtmOePHyWrSqF7EIJdsnfwjRoa+hRDeRRInDa6mUSzdLi8
	RPJHB8uvBSPcfYJLwKKjJDhRpBzEzq2M/nsGrFpneo6dMD/hgsSdQH1K
X-Gm-Gg: AfdE7clOjtRurnI3VrEeCjL+LiYhT0jZndqUfvZpKVGd5YEQ1iG/YhuNmqTN4zZi6/A
	4PzsRvikXQ/iPsDnKYEvtHlCgQGUMODaptR6zaAcsMz4tslylT8Kz9vvpS6Rw6YaTRG48d1/3aE
	L6ohiSzNbOBlxkf+MQOvc8teVFBittIvmS3M+8OSDiuC3Q+vJBVJucqTq85ZF5+foAWh1Z9ZnYo
	XO56EuXy733N2aaQEgqiyPgLYiEEjH00opm17o2Jk+KEwDNL45hHxjLsTz4BTcWp2bpC20qtqUt
	/0kV5xtYtT5dWhh73lzKlbQ9D5rTu5+YULxNCK9nxMhjCSOZo8JvOTrS/MH8uk6kOOSv8By/ABB
	byG5zB/Ig8UgycNTGYC4YjJQPXb0/naKYM0zUx2ZAzkLnWQYB+zTpPnZzfJumdmx9GWLQsSU=
X-Received: by 2002:a17:903:2444:b0:2c9:d8c6:1db8 with SMTP id d9443c01a7336-2ca911d35d4mr101211985ad.28.1783085420394;
        Fri, 03 Jul 2026 06:30:20 -0700 (PDT)
Received: from localhost ([2a09:bac5:55f2:18c8::278:51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f260c7sm9901615ad.12.2026.07.03.06.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:30:19 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Fri, 3 Jul 2026 21:28:25 +0800
To: Pratyush Yadav <pratyush@kernel.org>
Cc: mdshahid03@gmail.com, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Dave Young <ruirui.yang@linux.dev>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH] dm: crash dump: remove redundant NULL check before
 kvfree()
Message-ID: <ake3qmuFi62j85r7@Rk>
References: <20260703112642.65498-1-mdshahid03@gmail.com>
 <2vxzbjcogu0b.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2vxzbjcogu0b.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_063022_162829_34ECADB5 
X-CRM114-Status: GOOD (  10.14  )
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

On Fri, Jul 03, 2026 at 02:03:32PM +0200, Pratyush Yadav wrote:
>On Fri, Jul 03 2026, mdshahid03@gmail.com wrote:
>
>> From: Mohammad Shahid <mdshahid03@gmail.com>
>>
>> kvfree() safely handles NULL pointers, so the explicit NULL check
>> before calling kvfree() is unnecessary.
>>
>> This issue was reported by ifnullfree.cocci.
>>
>> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
>
>Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Hi Pratyush,

Thanks for reviewing this patch!

>
>BTW, Sashiko [0] pointed out a bunch of problems in the surrounding code,
>and they seem to look legit. If you're interested, help in fixing them
>would be much appreciated.
>
>[0] https://sashiko.dev/#/patchset/20260703112642.65498-1-mdshahid03@gmail.com

I'll send a new version of
https://lore.kernel.org/kexec/20260501234342.2518281-1-coiby.xu@gmail.com/
soon which can address Sashiko's feedback scrutinized by Sourabh.

>
>[...]
>
>-- 
>Regards,
>Pratyush Yadav
>

-- 
Best regards,
Coiby

