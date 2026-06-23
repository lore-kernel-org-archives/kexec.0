Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C75CDB471
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rUCXLhb0bwQI5jAi3AeGaL2pacxrrvJDt+WvFjr4LkY=; b=jhX/iZh958LFdJTH3COnvWKJix
	t4tiQGowt2ZWkFjuTPr1yxzU5JYxIl9oesViNiu0BLJ/U4TMwBjBachm3V/Mxb5kZC7qUMJ+Jdee5
	ZV8p2pT/0h3KxvQk8IBbDsObCsiUnCsqcxi502cdCQ9abrACN0FSdcoX1BMCA9QaVdKMNG3ZNBG43
	9cvCyQIkK/XEVgB/Hges4FJ+G7qPPshm876Gvh1JcIlzPKeqbd9YbtFBv06+L1/lC67GjnGv1wJAo
	WjLQWIfmsQTEEZOWNhnpGR5J9a07wCNM4H8+/Sy+1IYXwLOSqse+ZxvtOT6hMOXEedWDCpmf3eHEF
	BVgDozEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc4Dk-00000006eY9-2tt7;
	Tue, 23 Jun 2026 16:43:32 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc4Di-00000006eXo-3Shr
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 16:43:31 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2c73cefe192so62465ad.1
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782233009; x=1782837809; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rUCXLhb0bwQI5jAi3AeGaL2pacxrrvJDt+WvFjr4LkY=;
        b=vD458pTcyEp5GS2yG9iKZZUmEBVqakXX5ghk0SbqyZdI4+JCWkqLRjOS0tJM1CFaVC
         ufc5jooAIqXv+WG3oDnbZCicBo7zuYZtICOqaC7iyMO6fBxPKDGANrHRUt4qGHb3U5HK
         Wik0nQw7ShqmuG8ENEegGkbPau1VUuF3qtIhT9T1oyD2ZZ0WjEhVXfEvGSIzZijnz6Zd
         /wLRvrEAghDAdC4N7lC9S/c2w6armnym+rAaDB2nnimYQjDVRYYbPa6oTOb6C1EpPj1t
         VK939sMicYdigPSYUesq2GaksnQ5HVKoSU91tloGGR+eM5zKBWZmstzPiggD7BP2UaMC
         c//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782233009; x=1782837809;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUCXLhb0bwQI5jAi3AeGaL2pacxrrvJDt+WvFjr4LkY=;
        b=fvVqjK6lMSxgZLsl4nlhCkfqCt6l42ipv6Fw33ABQPETpicQ53BXEbFdMnOI1JQam+
         OZ4qvLZpN7wVWVnVgGIvA/8C85g2F31Jy5uF/oszDVP7hhhdUzg1FuqzS2LrXOxUCCzW
         jSklJNhuvore5RCYwS61jtxnl5nFQ59PdUkSU/h2xxbAQ7M+uONO4Ykz/mq4BwRU0+Es
         uHdKK0EFrS+xZpVP776lRypRp502+cRfsgCdIFw+p2BZqOhGrCeYmCsCazWVQwq49hjH
         TmhoMfcW+5QCKkBtdO73WOYBoi6+22ib9JmaUQp/LGXo6DIzlHUZsF+T35S+TYxy+xf/
         EKiA==
X-Gm-Message-State: AOJu0YxqvHn97Fc7wmHDxN/n4+bxDOKjBodd+z2lnTee0Am5c+ijcxYg
	RseB8X8mdkpycRNar2BtlIFkZImwYJ5Q9eGPqOp/KkIknxzbITBvl0LU7siRwn9EVA==
X-Gm-Gg: AfdE7ckLjSpOmNl9VrlbwBpQNP0gBGCf9XZyCvabmkCYPqaWMN+fvuFO0aYQyM+c1jV
	TULJnWLLdR9FzuF/Hz6qTyrwQ/lNJIkEx305q8QRX0SosWKlm4QBAN1ZB/9VrxgqVmDiYNVTnb8
	mJwFtYNZACCiR8eL7rJBKXu/cC2bCyX9rLk3KDtXXBEGAc4y3vmq40htEpNjgFZk//7DQyafHaX
	Id6lH5OSh98DdyRCXjH5dncR01SjgsCgWDztOPHAwcEp8/KbVT7ZvfbDLeKDf9hRO4gZD9n4nLQ
	YiZrTcRdohJ6ikU4cgrqRhhs9aRGpJTUJYbaoYyhsjVWvHUNmy2xcw9kgj5waftKDXw5DIor3kg
	qAQE7JLtgOTW1KI6f5ecGmxS3Zf0MKocPgi32Jde6V+STRQQnK+xWbaR/4YVN2C2Ve1adJDy1kV
	ocVXnU6CtagdtsF2L37925PqvB0//JC+DBZKqA+QOIrUkatBPlxmGG6jCjTbr4Hzot7vInIc78U
	F9z6d3M
X-Received: by 2002:a17:903:320a:b0:2bd:6dad:7ccd with SMTP id d9443c01a7336-2c7c7118b8amr2140445ad.25.1782233008303;
        Tue, 23 Jun 2026 09:43:28 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6c5dbsm10669159b3a.12.2026.06.23.09.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:43:27 -0700 (PDT)
Date: Tue, 23 Jun 2026 16:43:24 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 04/12] PCI: liveupdate: Document driver binding
 responsibilities
Message-ID: <ajq3ohoU2hJfhsp5@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-5-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-5-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_094330_871609_95D07A21 
X-CRM114-Status: GOOD (  14.84  )
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

On Fri, May 22, 2026 at 08:24:02PM +0000, David Matlack wrote:
>Document how driver binding works during a Live Update and what the PCI
>core expects of drivers and users. Note that this is only a description
>of the current division of responsibilities. These can change in the
>future if we decide.
>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/pci/liveupdate.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>
>diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
>index 96c43b84532c..4f2ec6ffdd16 100644
>--- a/drivers/pci/liveupdate.c
>+++ b/drivers/pci/liveupdate.c
>@@ -70,6 +70,22 @@
>  * preserved. These may be relaxed in the future:
>  *
>  *  * The device cannot be a Virtual Function (VF).
>+ *
>+ * Driver Binding
>+ * ==============
>+ *
>+ * In the outgoing kernel, it is the driver's responsibility to ensure that it
>+ * does not release a device between pci_liveupdate_preserve() and
>+ * pci_liveupdate_unpreserve().
>+ *
>+ * In the incoming kernel, it is the driver's responsibility to ensure that it
>+ * does not release a preserved device between probe() and
>+ * pci_liveupdate_finish().
>+ *
>+ * It is the user's responsibility to ensure that incoming preserved devices are
>+ * bound to the correct driver. i.e. The PCI core does not protect against a
>+ * device getting preserved by driver A in the outgoing kernel and then getting
>+ * bound to driver B in the incoming kernel.
>  */
>
> #define pr_fmt(fmt) "PCI: liveupdate: " fmt
>-- 
>2.54.0.746.g67dd491aae-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

