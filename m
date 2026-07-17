Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1527C4451B
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 22:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fK1sV5PaPmcS6UhZ86Rm4HrquxZKQdzLRmcBNyv2BwA=; b=J+aPiyho6ZucJC4kUR1wpqjvi2
	+m8Xv0VQexpTE6JzZZQvxn+yJwXhF++BWG9Eqs4NVulVWEuuDYQYaI0iPWFY6PckeGqGITxhlARz8
	O9xzHP7oaqcdgkCoRZv4Ous/IH7k+veImmWvVI37STvdjsA43FPuqD8D+ziDq0UeadqOlXniP1z4d
	V7QZpNKlzlYatWCfUfm/WHVqZUqAoqwXmznWeeg15GbZcU7iwnK7694DutgDdFhQnSuAKIq0ybbGK
	rYSJsMkbZJQvQbcyGb7KHkS/QVdfq2TGkRh2oq9BO0N661idNitsjdJMA3RNpduNQt+Zr8maTUDV+
	jtCdgW8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkqj8-00000003Jn6-1XEx;
	Fri, 17 Jul 2026 22:08:14 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkqj5-00000003Jmi-3i1o
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 22:08:13 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-92e7c6ec9dbso400281085a.0
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784326090; x=1784930890; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fK1sV5PaPmcS6UhZ86Rm4HrquxZKQdzLRmcBNyv2BwA=;
        b=McnSrEsb5oXx4FD245yqaxB4fjtT9wgZCljgDldAs/OVRUeIffSv96YjZ564ZPjVH6
         k5ZRx/+oGQf25m9zz9rMMaQnn2eT7XbhzFlMQMSxg6s8txg1l5o7LEZRzMfkH6r79s45
         aak5m62Okvd33VTtC/2piP1oFT75aUfuPikoCdoL+bb4b0qN33A9rAbD8BF0tvQrcUnB
         euwpd8IPyh60H1GsVJWHmtQktkQEgpWm/Jkbfe5ohZbkeSx2xBVqnXnA4/LYcm8+TFKg
         j7zeoq0BWKFkghAafTawXWY5JL3UQhnStYC+MsLHDH2Woj37Sd7cR8abadweM+nG2pjD
         eCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784326090; x=1784930890;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fK1sV5PaPmcS6UhZ86Rm4HrquxZKQdzLRmcBNyv2BwA=;
        b=b2eKdMdGV6Y2qK5ssH90I+3kD/QUiI5WgR/NYSO0zXREtWZi+EPsVMEocWIBVB3zb4
         0XxaK+JlRYFB0B3KxDZntoNMrHAYG+WEuhhdhZbZ1otxC2wWvn6ilxw8MFWPdL5NUwjb
         ef48GlliRhsTDLFfNkzdIrQN4rj0NZyTsAuWAAZaDz37Dn7JGf1TSSUnj1op6JkFv91j
         cLYnhRevuHFXuLXREBe6QlBqgpQqOlY9g1HA1qXio08guUYW2/nwhfvNFNdmGcUXk8wV
         fVjMPc6dZEkqQu3GrbMkb4h5UMsMl8435BQgHlheiV74U6Wobmjw2Bzb2UkLGmlv6GE4
         pWJg==
X-Gm-Message-State: AOJu0YxdELwM9xTerQ2UtxUkameW6uKNm2T8puYmpUikrHd/dM2Le+On
	I0QmLgs/C1yY14w538ASx4t6KFmyaCWV8O4ge0gEp6cwbna614FGk6nW3jniRIi5X+7S4sXy5ln
	d5TaN
X-Gm-Gg: AfdE7cm+b/Lj8tJClIWmViZ1EcBCAslIitizDPPK45qUtGs7eC4KxSDXFuGF/d3wzXz
	tLTdCCCEX1VyZLmsRcCLernyHvW6LkdknfJ7e90mlLr/SGy7HfgeUGnwbVO+QXg0LiTr5fqQSW8
	z8UH91vrHsDef6a6VpGW3yB7WUj178ZGYfzntjL86BXwHaoWgZNq8L+9Jt3eouHCzE/K3mohGvK
	XLzxnjjjQkV/uXf6FzNGTXqQ9cTWcxyQ+5K2hF8ld1OwAPNP3KZ4XxIretBhN5+tzp6fxBw+VIJ
	RQrVi1m7nv2rcixNm/Bpcv2uz82LrNm4IeKUd2Zc2efwA67xmutk+7s2JRUBSU1lseZ/xbKjaGo
	6MCvQT4ZCENtrheD1xsusoVtVXkKX2nqPnsToD3ctm/+tqsdcB2+OD2bILFzCCX3hoypyyhh5/m
	ClYouxbDjro8EKn67QOFBcqBiuq+VLFWxRRAl+CeM=
X-Received: by 2002:a05:620a:27c8:b0:92e:fe10:333b with SMTP id af79cd13be357-930b41f9901mr535269585a.65.1784326089627;
        Fri, 17 Jul 2026 15:08:09 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52e0f87sm257411385a.7.2026.07.17.15.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:08:09 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 08/12] PCI: liveupdate: Inherit ACS flags in
 incoming preserved devices
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260710212616.1351130-9-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-9-dmatlack@google.com>
Date: Fri, 17 Jul 2026 22:08:05 +0000
Message-Id: <178432608536.189683.17937493816735356455.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=669;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=JvD6d52JVF0dw9KaC8NTS7eMJsBpt7DQsADyzRVcQlc=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWqfHpXPLQRJGmFv5A4z6Gn3ZGKfCiLrGZFJYE
 58dLVR/0DiJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalqnxwAKCRC7dyhM23N6
 3nFoEACAMT3npwEDLawBzNMz5alv6oFvn/SKvY0p3N9N7lfY9rerg7LRUYRvEVf+TYGrtjTjgKC
 XpMxGn6W9G3uCTaWP5/B5bUX9iOkHNBgeZ6CphGCWTNjgxntOYpHpXDUfUe5vPEuaB21BCKb00H
 /boplL+neL6/tFYPnWk3feYN28FvkiXpJa1w4bpLVUJaV81/l8du0RTTTendMCT/iM8CsQZFdKg
 XXIz6uulPu+EUEn6yHi0dt37WyEhuB2i4QzJS7uIqv0vtEHW9bjIe+yE1X5rEFCk6hEkUnkdHur
 woH+mrGI2xscTu2d4ymvl8mB7IRj8Tvl5mo8nEk7zAitJ0JSk6lRaDJGAY+C/PTartb0wpNvWUS
 Gm2Q/v//Ntjm1RUidQSBijxhimUnnhQ9SBzGFES2gijkXQBcf5d1679whVMjGNvppPHjwZsUXIk
 3RrGudA10XpLugTQr9B1GBQ5s2vwBRInivaoons7l4QpXJIUGxpApVRvlWVOEVrWZQbvPeMdtie
 +m7b7s30saS2X/yoNfNTf047Kms/LVNpUJrlS9iMDqANRGlM6iW4RW9XBPfzzcGXbKG9WkwuKQi
 BE/iu4Slr8z89z2CsULzwaGdgTjJivJg7eBPhDcDQQRw22q+lpeFRl5CGf/7I69oEYVuQ6o4QG5
 jAh5AuDVak+U7JQ==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_150811_958994_BBCCBE86 
X-CRM114-Status: UNSURE (   7.17  )
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

On Fri, 10 Jul 2026 21:26:11 +0000, David Matlack <dmatlack@google.com> wrote:
> Inherit Access Control Services (ACS) flags on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
> 
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change across
> a Live Update for preserved devices, as changing ACS configurations can
> split or merge IOMMU groups.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

