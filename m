Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29287CA0EEB
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=axTNOUTQVZZZxxYvV2Ucn/Ve6zfD/t7Lm0soOa7g4cs=; b=BIZknkPAQEt9jePr5Kb1jyLYMi
	Y2iYqbVBfHxDgVVUOf665fmaF038TPEjHUUhAMy1RZlkJxowVY0Wi1uIg+A0toSr6t8sMr7gmwlnL
	Q0WzG1njHPCxouxK4pIZApBRSA3rPYGIqXfl5Z5n/rDg/CDq1quZySo8YCtMMJPPmWTPbRx1LmRn3
	U+MSPL8/VAB1lUxgxocXZxqpL5pFgQpc7Q1TxKkC0/6n5Pn0gWaQHqx5WbDDtHInqoYuMC3Z/V+5O
	HHvXpTg+eeP2i90MqHzXAOvwodKIyZCrSE9e1IOaps1GfvJa0uBk3Ry41VqLD9YahxLMZUZ45OVjw
	hs38v3wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up7Ew-0000000HMNE-3c6Q;
	Thu, 21 Aug 2025 15:30:10 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up3Gw-0000000Gj3l-16LP;
	Thu, 21 Aug 2025 11:15:59 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7ae31caso165829766b.3;
        Thu, 21 Aug 2025 04:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755774957; x=1756379757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axTNOUTQVZZZxxYvV2Ucn/Ve6zfD/t7Lm0soOa7g4cs=;
        b=s4Gx8aGfUU/QnBFVtQA5vmJopJtiwIwASqucpWmlh0allFQb53nbAejrVVrCzAEby1
         cpV83j6hT8Y8KYWS4P9qnsCiESHh+UMNCz+hPubItINMe6wLuef1h8xJPqtBRG0PIQ+0
         O4v7R1nPKg0WUOFmpg/rXrg6BR3cmA++z9ZTdXYIOhcTbkucNbExWOT3rtkkaQJ9EtN9
         HUGacJVXLUwCy9OCpTDCE+t339QqsF3+z9tpBT9q85HHvXYS8HLAcrMPdNCz4jxvTrxg
         rwsms6g0Kbq1fjt/Ry7qGNAnf9WAGLLYR5Bkk1rGQvSe+quzE9melPRnPLuWaem+JU7c
         NLIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVopoVBS6idsdyxJBJVPQy5preWrrGwTtuod5yMVsPTqQeQZYrc4BGuCi0qIGJ3jHHpI9D/u/Ka07fxqRJ54zV0@lists.infradead.org
X-Gm-Message-State: AOJu0YzIPrPAWzxcJAt5ShkEhVi+HMETY7Vafthoz7nJttsuw4UyXCjv
	VVpH3HXbeElThA0E+dzRkjrHZ/T7iWabq7qU6400QpN3tWIvVjRXYPhU
X-Gm-Gg: ASbGncvbyGfUkWgZLMxli2LPuCz2Xr/3o3ykclGkYHyq4kpT+uf3NeBIMdjZQGERACr
	C5FaDiMZAsW2+TZ8RTHOIdwkdbKYzzeL0rekr90FZL+LcqAMkO6bLup4M7cRbP2IlkKldxDh/i3
	N40KSfoZyf9XVKQThkCGfizV0W75dEYLC/LMlJv5mB7dK1998dkEH+v8fX9BZjYEGXe2zFCt+w4
	8kPywIvcHMtm5iy6t6t2CDGlfkiDKBqlm4Yhyrmx61x5umyCZu3KeYXSERbXzxz0oyYD55WyRBU
	/Oxdky2XxK9ZVMP8ei8IBYk9e2wtDrgMBN1Dfq9qU4jqDav7ZE+b5ILtukXayvJFTdlLbFBkZUl
	XqIeUrsMn5fdJVGkvIueEnZM=
X-Google-Smtp-Source: AGHT+IH7uKkB4TPA3GI29kWft+2WfvQbVTEYpnr53DPMR4wVW9z+xmrLVH5anbUFBjplHLTY2Uec5A==
X-Received: by 2002:a17:906:fe44:b0:ae0:35fb:5c83 with SMTP id a640c23a62f3a-afe079f445bmr205983166b.28.1755774956383;
        Thu, 21 Aug 2025 04:15:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2ba366sm369932366b.19.2025.08.21.04.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:15:55 -0700 (PDT)
Date: Thu, 21 Aug 2025 04:15:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/8] kexec_file: allow to place kexec_buf randomly
Message-ID: <oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3>
References: <20250502011246.99238-1-coxu@redhat.com>
 <20250502011246.99238-2-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502011246.99238-2-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_041558_300087_B9058AAB 
X-CRM114-Status: GOOD (  16.15  )
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

Hello Coiby,

On Fri, May 02, 2025 at 09:12:35AM +0800, Coiby Xu wrote:
> +static inline void kexec_random_range_start(unsigned long start,
> +					    unsigned long end,
> +					    struct kexec_buf *kbuf,
> +					    unsigned long *temp_start)
> +{
> +	unsigned short i;
> +
> +	if (kbuf->random) {
> +		get_random_bytes(&i, sizeof(unsigned short));
> +		*temp_start = start + (end - start) / USHRT_MAX * i;
> +	}
> +}

On arm64, I am getting the following UBSAN warning when accessing
kbuf->random:

[   32.362428] ------------[ cut here ]------------
[   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
[   32.362649] load of value 252 is not a valid value for type '_Bool'

and line 210 is your `if (kbuf->random)`.

Basically kbuf was not initialized in arm hosts, and probably has
garbage.

I am wondering if we should have something like , while the support for arm64 is
not done:

commit 2608bd8c26b62a9a7cc50106e93d3a1ffb1e1188
Author: Breno Leitao <leitao@debian.org>
Date:   Thu Aug 21 04:11:21 2025 -0700

    Initialize the random field of kbuf to zero in the ARM64 kexec image loader

    Ads an explicit initialization for the random member of the kbuf
    structure within the image_load function in
    arch/arm64/kernel/kexec_image.c. Setting kbuf.random to zero ensures
    a deterministic and clean starting state for the buffer used during
    kernel image loading, avoiding this UBSAN issue later, when kbuf.random
    is read.

            [   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
            [   32.362649] load of value 252 is not a valid value for type '_Bool'

    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 532d72ea42ee8..287b25e674d76 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -76,6 +76,7 @@ static void *image_load(struct kimage *image,
 	kbuf.buf_min = 0;
 	kbuf.buf_max = ULONG_MAX;
 	kbuf.top_down = false;
+	kbuf.random = 0;

 	kbuf.buffer = kernel;
 	kbuf.bufsz = kernel_len;



