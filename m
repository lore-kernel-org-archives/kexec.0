Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B46C77B73
	for <kexec@archiver.kernel.org>; Sat,  6 May 2023 07:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ESmmq2ug9b8uVAJVcfjZGIh8sv/cvQ/zTQjVVa66Uy8=; b=HGkfji7myQ1Wy8
	ZX1cCXxv1HIBB2SnpKdP/cxbcB46G9gk3adXUsuO8li6sqb6fKvELvjfJYktNdSJzocg0mDOu5VuJ
	W3C7oB3IacJWGlw6CeIDnpWInQZ+v3VfAs3tOQBeRmU265ADcqiifijYCBowGSyMxyofSLkZXcKtu
	f94sCx3DhJ62g4LKWd/2bJTpXTJKz3Jr9+xxPS6iIkb1TMo0SmAXRf+6roToII0SD6qXHiQ1kIahR
	8cWz6npo7AKWE7JTPbv+ftM1ch4aLsZMS93jSNJG88bAIyqiFGVCXMVVffERjhlk+pbK6FLnSgcEY
	JPZmO9gU3jM/kNE0r4LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvCmY-00Cq3E-1E;
	Sat, 06 May 2023 07:56:42 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pvCmW-00Cq2b-1c
	for kexec@lists.infradead.org;
	Sat, 06 May 2023 07:56:41 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643846c006fso2930302b3a.0
        for <kexec@lists.infradead.org>; Sat, 06 May 2023 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683359797; x=1685951797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSXqKKL2DM5ohMjcHFVamqTpkCqxvyAHPkfC2Zw2f2Y=;
        b=ICQZu93FaTdOWK1lWtPwQ6fV3se+udSFcWL+PX02WV5hmUCuWM1vm69LM2Ew0WtkAG
         AYwB/VBtO9q9nBrGgXxxp/P7t4YJjwxxloHfy+W2rj6QtoooYwfzSw4FG30PhManLORX
         Dobl3L47/V0W4e3uq5DXNhAonfv5CuHhePYN2W1AWFVaSOSJpcLz0TP09p6VUgCRl5nE
         WtzDFfac+YTPQ4y17OXd+J/Kv7YF4lyiR+QElUsHM/w6FjjThXGnbkK74JFI9fJtNEfZ
         KSnk6rzR6p0+/iN64StLdRR4o5D9Z9HMDD4Q9H3y+lIKkXnFm1GJftui1DejIzFwB1OQ
         A9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683359797; x=1685951797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSXqKKL2DM5ohMjcHFVamqTpkCqxvyAHPkfC2Zw2f2Y=;
        b=UBVXJ9VXz/YPo16csI9VSfHOsV28plpghpr194CLMpbXIIcCVDujnQpRwKlqnxmbgk
         /KA6s8qX0fffllLvry/OsJOGwzqPtbkP3xao6fSx4aA7hGObDxsG7i6hZ/56E25TR/hR
         Oc5flThIBRk5UwETbZqnq2RaG+BW1cBfZqUWN8fbTCFh2p1/sjiYe6UCPWBToAvror96
         lsW9sFUrrv13kA0K2MTrTdAb7n16RLSW9j1VTHKGe45yzoC+3qF73bpuaSQ1jeKEIREk
         9vo5k0e6YAgcd9SvcUfKW0QFox4vTFpcE7DzRMTKBziZ1Uo9WSQQCMi1du4+Kfmisd9g
         3R+g==
X-Gm-Message-State: AC+VfDwHAnomg13Dbb01J+NdEGQikD5Td5MTEkBsKvK1hU0TTJAekSjY
	aC/QEzjZXVcFrFXxSQlkalFoqT4uV1U=
X-Google-Smtp-Source: ACHHUZ4RWbkiR7mdDfiHmHp/BQEz0RuV+uOOFyLTWkWCNB+y/nFFtdZpPV2V1ex8dOzmoZa/+razmA==
X-Received: by 2002:a05:6a00:1483:b0:63b:89a9:529f with SMTP id v3-20020a056a00148300b0063b89a9529fmr5038706pfu.14.1683359797435;
        Sat, 06 May 2023 00:56:37 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id e19-20020aa78253000000b0063b96574b8bsm2648811pfn.220.2023.05.06.00.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 00:56:37 -0700 (PDT)
Message-ID: <0f62ff02-f601-e629-6524-972441035129@gmail.com>
Date: Sat, 6 May 2023 14:56:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
Content-Language: en-US
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, luto@amacapital.net,
 nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <ZFTA0kg98XxeP2Hh@debian.me>
 <765a94ac-ed2c-267d-0ee9-be21757ceb16@oracle.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <765a94ac-ed2c-267d-0ee9-be21757ceb16@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230506_005640_536125_9FCA3243 
X-CRM114-Status: UNSURE (   7.57  )
X-CRM114-Notice: Please train this message.
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

On 5/5/23 22:45, Ross Philipson wrote:
> Sorry about that. In the future I will include a base-commit field. It is based off of torvolds/master as of 5/1/2023. The branch where the patches came from is now pushed to the TrenchBoot repository here:
> 
> https://github.com/TrenchBoot/linux/tree/linux-sl-master-5-1-23-v6
> 

Pulled, thanks!

-- 
An old man doll... just what I always wanted! - Clara


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
