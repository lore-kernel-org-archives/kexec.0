Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4366CCD98C5
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oLWNaUJaCrsl1zSP87x78jJvGSQywThTy/hKOOZov1I=; b=3DEORIep90NLx8HTSup7PINM3V
	O1XXPHFZStp4uAnApvIGTolVgVqQGFvkahw/hHCaeOTP78VCeKi6ZU6AF2nYsDXsGimLiHxYbcoY9
	c8XVl3pLm8Qan9wEaJMuJ5BG+T+xFGKdDAWrtLij140CwvnWZSiAfs+RdVW6wwKoMfkLPC9BqfHMN
	BLObIypL+G6Za0NQWvd7i69OrG4l79BqOAsIko+jBB7dsOXzMLhF+d4myettP4BeC4o57OCb0Hlj6
	CvAFIv55BRXvUlZEmb0oeTz/AN1uzNbIx37L6XclwenP2/EoZmsrgDMCu0LVUgy1vEYlH+9YnKZLg
	U03kL8yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYlLQ-0000000D3jv-3pB0;
	Sun, 14 Jun 2026 13:57:48 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYlLO-0000000D3jY-0ZtX
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 13:57:47 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-9157b94a07aso273093985a.0
        for <kexec@lists.infradead.org>; Sun, 14 Jun 2026 06:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781445465; x=1782050265; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLWNaUJaCrsl1zSP87x78jJvGSQywThTy/hKOOZov1I=;
        b=KywsrzsmTJDidKPqmXNUNKntNbREuWwimUJ7AElXpb4l3gGFZ4Kctl3sQDeKOPAp4c
         B3xFleSnG+1P5aZH/ygtIxxbgPvjHc8qrFOevzYrdiJ4MKxdaLFZ73g2J/mGjO63PcL8
         zEEcn2x8a198VEug7pOX8Wfr+qsun7LtlHCRCh+1uSz+vdB5yOaW79brqKCW8AULNipW
         Y3XlgM5DFHx+S8/snn2Vjp1arWITlY8x6Mj6E5d3UCzRQPIkJ/yY6m7lit5Zk6SHl79R
         aifglfzgQxuASguz7T4ztZ0clc0DyEbhEyT01vw6Z/azt2eEcOoRRjE3SfYqJ9u/Cl/z
         bNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781445465; x=1782050265;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLWNaUJaCrsl1zSP87x78jJvGSQywThTy/hKOOZov1I=;
        b=L3tJ0vt6sbd0iNo3unp3rfbPQoSuUozx7rx0AWlaeEqqU8ywgydfqJoSzS75iK6Xuc
         qrybu1UPYy1wRmZPinsDkkR27C3SBMgYPzraBiwwlWLtQUr9Es/GlaH+XxzOgwDUUn5W
         oWD7jpEhTngaNHrr9ojIqxm+ZHAQo+faFn/V1uxbFGrw8FMgRm2BTxL597magoA6zBmA
         qKmZn+ZuIl8u24v34uzgzSHNLzmpzVrlDAx4bh62NAirekPuWZ9g/I9tN9NdJGQysE89
         z04w4j7LKBi0pKHO/7jMkQzlq2dfHQI5OkDDAj5AfKfL9p1a+SAIoAN7fl3RCVKQwFtd
         o6vA==
X-Gm-Message-State: AOJu0YwPxlW0i7UoJEpXYx1OahQi3ufzKZPsVbK/9rb0yn2DgCJx04Iq
	Sk+7Xjtx9naKFMOrNr/oYAdNnwfCQLuHdki0fmzsmi6P0dS8a0hzkrrctmuJKM/9iG4=
X-Gm-Gg: Acq92OHOS6gGxpU80guO1inm4t/odfboB/9+MGUtBfDJZMWzEPpR+IRrhSXoVpwjSEx
	lmo15nMhGCijr+uDcJLzCKvJleYMJxXJFML5e0Swum2hCnhK/KqU7V62ykq2CCLRcJQAHPB6ldo
	BpUu4l5O97XPhj5/U4T8+KjGX+EdNezhCNBrYKHYZaPJDIb6xyuKVTkdOsP2KIcRPcsyGUqbI/g
	JQsTQRKEY7um8blcvqq1Im0whuHhhRsChX+D7+5c0t383Sn/nZk8eh6pFZwoxYh8gp2Zsu/FrOh
	/5iz/J/dlKDtigLC+/hGOFC4PtoY32UJPn1YyWwaCS0OI8djHFUblPeq2jKsy1Un47+cpNKs647
	bPmYkFMMpWrIKhpg2fiNIN2QT0ai3NaCgUelO5Hgf6yiTAXzXs1CUw4qQ4SWSk9iv+bF4ULC1AD
	FBOk0iO2IFEt36mA6dr2+vxuCFl7rWqqKMsx42cE1rkHtTpzeqI2xR3kDT+ZB3
X-Received: by 2002:a05:620a:2894:b0:915:cf88:1e3e with SMTP id af79cd13be357-9161bd3bcccmr1479704685a.41.1781445464857;
        Sun, 14 Jun 2026 06:57:44 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed7f16sm753609385a.1.2026.06.14.06.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:57:44 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
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
In-Reply-To: <20260522202410.3104264-6-dmatlack@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-6-dmatlack@google.com>
Date: Sun, 14 Jun 2026 13:57:40 +0000
Message-Id: <178144546090.1266136.8524338598480624580.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=irEWipl5ns1PQEI0PQ7c6jRmzsY6W3c0XtAe+hBan18=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqLrNWjYliGNG1cbbcQyjqFHpsESyctol2Ow44V
 DNNc7IHDFWJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCai6zVgAKCRC7dyhM23N6
 3kjiD/sG69As1zhiS1Jh7oTEbv0MuNGQBkOQh5lHVUPS0gj+oBdU0SL1qDkUsD/9tAvcLQXxhY4
 /QEBcSzMRn2+VM2nH5sCYgMn00iu1wLRgHbnApGT8gEYefLC6tqiTimjXxxYEZXpQz9ApF3QtQ7
 uQ7fuxVwij6aGg2dzzTM5o+j0r7I05Zok88+cCVU2rlO6EuoInjgmjv65Xe6oq+Ds1zxZqhOecx
 ot6V9j27xklbNWnMVwGIEJdBHXJhF7LIartFve0H3o0TexujPaYa6bopI9KtSCGp9zJTyA0pQpK
 gNj34151bnveyddJ8hiUhPtMTv79KN5ncUVS5aJfGxPn/aFWbtqxiiOp0eU2mnJqh/6wNrM8cQ/
 NUoxJmWLdWzpvK3xaAUQMjvhqW56TPer7DfuxcsKhmOK0edcg9c8QgScp5vl6gu85NR4OeFHf1B
 kKZPXsYx8Wp75O5nb7T0vLt0ObMjKLsM03C/GOUWMQVcDp44U7NhXWs++LiuSgyzxtbuoRturS1
 ao58aoq9qHw1Gk4BTfu8Cxz4xPVAEIaydrmMgiamFRw3PAZUYr1WUIZUIQbwfaGlWx4ERcVXuLY
 aXr04c4Tx1rxrNZMN32g400K0heMVZ+AZvJQ7vrmDVSnc3QEXEoOT45iZ03sYksa0HWdCPAbLBt
 te2BUIp8i7sqexA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_065746_210759_9036D531 
X-CRM114-Status: GOOD (  11.07  )
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

On Fri, 22 May 2026 20:24:03 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 4f2ec6ffdd16..2421bc218916 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -103,7 +118,7 @@
>  /**
>   * struct pci_liveupdate_global - Global state for PCI Live Update support
>   * @rwsem: Reader/writer semaphore used to protect the incoming and outgoing
> - *         FLBs, and the references to them in struct pci_dev.
> + *         FLBs and references to them in struct pci_dev.

This change does not belong to this patch.

> @@ -396,6 +411,72 @@ static void pci_liveupdate_flb_put_incoming(void)
>  	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
>  }
>  
> +bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
> +				      int pass)

This function requires a header comment; it is public and not self-descriptive.

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

