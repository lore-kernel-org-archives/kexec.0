Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE191C369C2
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 20:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IdFsdaUTDRdghsX8VxeZ/2CwFZKCgCoBXb6SP0DHe8w=; b=I03N+t4vIkI2n5Vfa21Mz1hFyS
	kTLHCSxWx+duHexM826x/y6TdYWO051IpR3NRoWWO6Z497ZuzVD8CV75fHja8P7zLFLcTU9fmrSou
	Sa8L20v7v+dpB+ib8Tl099ykS9xBWm1bnCHFH7nDn4pCqSuDjAYR7huqC7nBmZnkhmBmKjiX1jKv/
	EmCR0W/H1LWFdto+Uc60EFxrK2Wc8+ww7PU6WusbQEpRo8puBt94TI4zcVFM4tpvWboWFLhY5spYn
	/8xRx84TZOb5S4FWHddggvYd+QexUt7aKFhVOB0hocJMgQSkFpiITj2yQYd8g3FO+rCrD8K5IpidT
	kyMKEbhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Kb9-00000008VGo-1c6J;
	Tue, 22 Apr 2025 20:52:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7IBr-000000089NM-0Ptb
	for kexec@bombadil.infradead.org;
	Tue, 22 Apr 2025 18:17:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=IdFsdaUTDRdghsX8VxeZ/2CwFZKCgCoBXb6SP0DHe8w=; b=S1PUhHE+anTvxbXoHU4QGgiKAg
	lOgZZCj/VONVnVvxKMmTG8S3ElSyh5a3gbturpxOLMW5IwAuzjEF3lfOCghrgndxOxj9OQrDZC/E8
	cx3KQZSt/yRbQvIYof6jeUuJCnk5a6RWmRYOsSy76+WEIGm4KZIW7bdvzNuxRWnilX7N79Pa/ZHnE
	eSWXeui9KvRCg6559wRYXf2JPn0C7sQPzdHRaOWc9bSmMJG9q4CXIJ/9mHo6TD8CCLdbyZE6jdBfr
	9j8dcWm64XctBOe7JTq8i7GjOFOgq+6HEHq2NVECI9V+LC6PSsywZJOhVBvsU3NxYaGrpDiVua8x/
	DWCfEf+w==;
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7IBn-0000000BGgL-2ZGB
	for kexec@lists.infradead.org;
	Tue, 22 Apr 2025 18:17:50 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-440685d6afcso52133465e9.0
        for <kexec@lists.infradead.org>; Tue, 22 Apr 2025 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1745345865; x=1745950665; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IdFsdaUTDRdghsX8VxeZ/2CwFZKCgCoBXb6SP0DHe8w=;
        b=wdDJVb6d1FbuIugrsxvDhhh8v/oGUpLk2/KloL3nhUDZAcVt7OnAP0zbNObChmAi1z
         7C92rK108bbEG0luBgKE+ogOmCeSWA3HHZ+bupxVQ+Mq8bAH+knR++7f+Ewy0TGESdPo
         Z3QJP9PeXku8dlKY/dvpda4mqYREz0Y2Z9Y5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745345865; x=1745950665;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdFsdaUTDRdghsX8VxeZ/2CwFZKCgCoBXb6SP0DHe8w=;
        b=ARCfbFRyN97Buq/HwDoy79jXgiRv3UhoTeUx2L/Z7gCFl70kST1AL+IwZcLlsVHszZ
         pn2Xpm+PKvXLVS+lGDj4vSvhorG7uS8slp+kMDrwhNnFqZF9odcI7ChMbmkyJu8Ujvi5
         Acefb++ZtegDvuRF0Y5bTNxhlLAI7Mv0F5vUKMjdffwEdEQM1vDNRlxQPYHZQ2z46x/u
         j/F6iKdBiU2hMvSL0vUBFy1yX/FagksZh+p+s0b/YDFV0LFTHaLaRV+OMaHmdiLIx+05
         2UfgTlGb8yscEnM31UDgHaSSIAopCgTEg5hvYXQ6XVWdbeRLByv0MMCre7GJRI3/W53N
         6dzw==
X-Forwarded-Encrypted: i=1; AJvYcCVfyMoLy7G7jujyF9cReEst6AmpUiXmseW5nWgrV8943xsGjXMHN3ARdKsnmWnKU2Pxg3WQwQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YybOcsZSnDkL9FRfFS2UfyBRxaQMGsI/Ds+8lIytgV4EgnuQn7V
	vcEPy4n7IDEUVXjM2vcT4IRTe4hCy2eZl7AW6P6A2q3IxFoQvKQJ6drPoQJlXA4=
X-Gm-Gg: ASbGncuIt0HIUdFH3UQ/SJcUo+yca9Ig+emX+O6NUiqejVJ3WD6wipuMJXr2D1/TOwQ
	0xHPJv12e+BU0UEVrcXdtgfNEPq0GinfJ9syJMx3eRjbLR0sDdAwtDouvDCD2BtnXbiCDZFPnru
	4U5Ajw41c899sL94boCJK/VXna7eZAmUx3JXIyU3IDTG4ehpPvhDCHNfNhIXQ3Y5H0kfW8gGgnm
	3cm/ysmutk8J1lK73RgNyA5nGTuh0ffKnXHm0KMGNthuqmgv9W/qV1IjmeofgipC+zU4Pmz4gQJ
	09xutF1N8NwydegjPwx1bJcwRQVBCy5Zeqos33k8sbY55iqMiHIqPA==
X-Google-Smtp-Source: AGHT+IGCIWX5BVPPocsuZVlCHJEPbcYq+xpC2dCnc+JUo1mNSZJLBXsvA5T5y7KuBkfqLGA1fxMXKA==
X-Received: by 2002:a05:600c:4708:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-4406ab97c6cmr143192845e9.12.1745345864518;
        Tue, 22 Apr 2025 11:17:44 -0700 (PDT)
Received: from [192.168.86.29] ([83.104.178.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbcfesm186100505e9.23.2025.04.22.11.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 11:17:44 -0700 (PDT)
Message-ID: <c05731ae-bcf1-4747-b64c-0f4b79f3587f@citrix.com>
Date: Tue, 22 Apr 2025 19:17:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Dave Hansen <dave.hansen@intel.com>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <d96f9c5e-64ed-4c28-a8ad-e22daea19742@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <d96f9c5e-64ed-4c28-a8ad-e22daea19742@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_191748_072605_18AB68EC 
X-CRM114-Status: UNSURE (   8.04  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 21/04/2025 9:52 pm, Dave Hansen wrote:
> Purely from the amount of interest and review tags and the whole "v14"
> thing, it doesn't look like this is very important to anyone. Not to be
> to flippant about it, but if nobody else cares, why should I (or the
> other x86 maintainers)?

There are several downstreams already using this as a part of their
overall system security, one example being
https://www.qubes-os.org/doc/anti-evil-maid/

It's all giant out-of-tree patch series (in multiple projects; Grub,
Xen, iPXE too).  Ross and others are trying to be good open source
citizen and put it upstream where yet-more downstreams can benefit too.

~Andrew

