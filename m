Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7374CD98C5
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 12:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GiuA0JHLa9l58ogicvE0m7CrCNTFlFcY4pqZqBKpS2I=; b=Y2ZRrQrdWckQLyRtGQpKhqidrQ
	RU5q08Z6SdvFp8fTT7qDa6GDBpoeeu+W01kDpsV3pxBTpVh6VQR0+psp01otqOSBannr4W0Y7P8ir
	slu/7wdEjKbU2i9Mkbf+YlN3t/t1QN/7dkgQbEtoNR6SSgvravEgkq4XuSgnsamR2bp/hj4SzpeeP
	VmQfGnG3RXh/DG+ne2XTKyLwVMYSCW/XMUc8+WJG4YcX9UtbfvwVUsEzsqx8TWnpwGq0+AsfaM7KF
	SeJcgynFvy9olcRQig/lKUDuhxKANsXjU8iSci0VEDiWmgUfoi4dRivpWgG4ZtgQEgyKi/61kMzKn
	qMaPV0zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkGI-0000000CzLd-43MT;
	Sun, 14 Jun 2026 12:48:26 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkGG-0000000CzLA-3DF6
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 12:48:26 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2bf22c18ad3so105385ad.0
        for <kexec@lists.infradead.org>; Sun, 14 Jun 2026 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781441303; x=1782046103; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GiuA0JHLa9l58ogicvE0m7CrCNTFlFcY4pqZqBKpS2I=;
        b=pEULJrQhtBiXn/kccSxCjb5SkqTKWanC5mW/HNlTyLZ7M+A5MxTezse9UvhguE61e1
         SdD/gJtjiXWc3c+OqIs8TnDpOXcqG4jMZgOUxcUEgBVCcxY2lJ6HqOACi4ub1fE8Y493
         A0pviueyQnwiTmBSKzNVl0G3+/5u2vpi+LX4UU6W5CVpD2jSOkyzinDyG8OQ3R1GDCNg
         95x4Rp0cGwMB4vonqwkBkE5/O7d3oo+/1QRGnIsuxUh7Ym6lPjeFIqa2fyfaOdhPBiZV
         Of19CHCwuYq1jTUa/v5mOini3KD+KUi1yMhHZiVxeHADc7Y62MD2jEbwGzkZnvxgnSWI
         WVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781441303; x=1782046103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiuA0JHLa9l58ogicvE0m7CrCNTFlFcY4pqZqBKpS2I=;
        b=IAMuvBhu53s9P3nW21U4M6fOSMnGeEpEJU/nwziwHZIDZJ9SboCOOaDwpAj52fYkqc
         RnXvtPScFBIT25yhph1CNT+mx+Aap/vDupq2sZBslNhZ2YXFU1gSHBaVsTrg5fys8Ccx
         vzjKDqzlMbHZvS66/MVSAVY/lrJr/iNkjdp5Gd5WIThIO865eeaLeag4Nf4DXogBYlIz
         wopHLWTdxxTC4+L9PqRfVZTaFo0R+f/BiFE8YzgGbmeTKD+EMKlRvY7ucIELMvFP9v33
         WbTcnHanO/No+5D256qip320kGDnJ6zWbWQPHvIbxnhi8Z8qT3WDpRD0ZqX4RCS6vc5H
         e6qg==
X-Forwarded-Encrypted: i=1; AFNElJ+iNpj2lCMw7Byihx6Mq93AiQ6Nv61o45pSjuoCLkTGl8XgfI9ks745BswPh1Qbh7KwUrRPkg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxqGApQDhbu7e4z9jLluem5u3esk6QWezWaR2VkPJn0J5aqA/ho
	b0rIqeNS3f1wvu/1SORtai7h6AO2hxXlfn+C9K7fJJAvbwIwDmgGMzD8itpWHZHeBw==
X-Gm-Gg: Acq92OF+V5gIqwG2iwxXirkN1pXLXE6ygULu2mdTwHJ6vCi5eJA5+Ae2/YxzhwYxR02
	4uPw+/NIsR60PRwRHtTsO2mpBm8l68o0y9CP4hjuoSqJkQ7TsSDaVpenELVKgNaBtFiXufAvS6g
	Lp5IAcZXHCYTbzWMKGq9bfBeOf2goTWgpERZ//+XiBCihTmgXm4sDj2JmH4qxDWYusAp9Cjyv01
	6jX3oD59RkDaZEzbAlx1//I2ngeEzn9e6LvOYeWjntKTQcA1WcZIwpu4N4tH8Tuba0gbESP/cWK
	vNPZieWvuKaW1cihpaEZtVzwulgf4wEVcDRLjcsPzHp/9+a2MIiOUGojF+5cRo4XmDSmknzRUz2
	OXG6TiNf2/LtbpqCCi0KBqPX69focTIYcDUccp8e/x05rUjriq1he6Lv02eP7/1gZ9+WGXcqr71
	/w3RXElPms665WdhlNMA19CIjLL9sVsoVjZdaFSBmxbg26iJ1ZohLAGxDA+uxy
X-Received: by 2002:a17:903:2ad0:b0:2bd:7e8e:ad56 with SMTP id d9443c01a7336-2c6650c0f1amr2373205ad.6.1781441302378;
        Sun, 14 Jun 2026 05:48:22 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86651adc16sm6026664a12.31.2026.06.14.05.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 05:48:21 -0700 (PDT)
Date: Sun, 14 Jun 2026 12:48:16 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	David Matlack <dmatlack@google.com>, tarunsahu@google.com,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>,
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] liveupdate: luo_file: Add internal APIs for file
 preservation
Message-ID: <ai6jEE67rXInZy-w@google.com>
References: <20260613012521.835490-1-skhawaja@google.com>
 <20260613012521.835490-2-skhawaja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613012521.835490-2-skhawaja@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_054824_838361_936F86FA 
X-CRM114-Status: GOOD (  19.91  )
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

On Sat, Jun 13, 2026 at 01:25:20AM +0000, Samiullah Khawaja wrote:
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> Live update orchestrator file handlers depend on the preservation of
> other files. To make sure that the dependency is preserved, the file
> handlers needs to fetch the preservation token of the preserved
> dependency. Similarly during restore, a file handler wants to fetch the
> restored file of the dependency.
> 
> Add APIs that allows fetching token of dependency during preservation,
> and fetching the restored file dependency during restore.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  include/linux/liveupdate.h       | 21 ++++++++++
>  kernel/liveupdate/luo_file.c     | 69 ++++++++++++++++++++++++++++++++
>  kernel/liveupdate/luo_internal.h | 17 ++++++++
>  3 files changed, 107 insertions(+)
>
[...]
> +EXPORT_SYMBOL_GPL(liveupdate_get_token_outgoing);
> +
> +/**
> + * liveupdate_get_file_incoming - Retrieves a preserved file for in-kernel use.
> + * @s:      The incoming liveupdate session (restored from the previous kernel).
> + * @token:  The unique token identifying the file to retrieve.
> + * @filep:  On success, this will be populated with a pointer to the retrieved
> + *          'struct file'.
> + *
> + * Provides a kernel-internal API for other subsystems to retrieve their
> + * preserved files after a live update. This function is a simple wrapper
> + * around luo_retrieve_file(), allowing callers to find a file by its token.
> + *
> + * The caller receives a new reference to the file and must call fput() when it
> + * is no longer needed. The file's lifetime is managed by LUO and any userspace
> + * file descriptors.
> + *
> + * Context: It must be called with session mutex acquired of a restored session.
> + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
> + *         found, or any other negative errno on failure.
> + */
> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> +				 struct file **filep)
> +{
> +	return luo_retrieve_file(luo_file_set_from_session_locked(s),
> +				 token, filep);
> +}
> +EXPORT_SYMBOL_GPL(liveupdate_get_file_incoming);

Thanks for modifying the comment (as discussed in [1]). 
This looks good now, along with the EXPORT_SYMBOL_GPL.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://lore.kernel.org/all/agr6yoyYYq2QFxjL@google.com/

