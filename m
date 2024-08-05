Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2540C3DA7F
	for <kexec@archiver.kernel.org>; Mon,  5 Aug 2024 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zx0JMLg4Ye4Rq/Ww6g7L1a9chtKC8Mh7qzVsNAj6oDw=; b=eDRIeNdAhFKCUG
	G+k1ZBAZ4Mp9niB67C+gmPdUb9hbqft+x76Qp6QMB+CZ4BVOEOT0Ky3ZlSOyOhUh7ECqZmLaE9KoK
	4wUVna1wBdIiW2dlghwn9B1TzukZXrBfnfEZNFJQRpfctczbDxSH/BmYrDA//rA+xC4SqbEgnLtxu
	PxPcEVTXyLgWmNEG2fP7abEc7vFyVeDLbCHgo02XBeb6JPpRhe/USZIVXO6CV42lUd7l/XqlGmGox
	6BE131WXXSMiYzprw8683b7dVjho7Dwq2VNSPk/dlSy4dH7DaF+a+WVVYlbehNHD1iarjkcwyJPAJ
	vudRxZ75e3EVqevUKIZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sazSu-0000000GH6Y-0Zh3;
	Mon, 05 Aug 2024 15:17:40 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sazSp-0000000GH5r-0cWT
	for kexec@lists.infradead.org;
	Mon, 05 Aug 2024 15:17:36 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a7d26c2297eso1337988566b.2
        for <kexec@lists.infradead.org>; Mon, 05 Aug 2024 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722871053; x=1723475853; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xW+L6kNIuFioJ5rjDKnCuxYZ724u5jfAfcF4VZ+PAvE=;
        b=JWxEYJ9vpCUykcyl5yK8svuvanfRuTqbZ6c6vTQmOiWda6iiNNh78f9//WUz4q0cdK
         wdK6FX++WY7A4m9PvuLjfFmhEfP4j/uqAEenG9c+M1LQLJZ+L6KagkOGmb4iVX9zSwGG
         JJhh490cuXygaLeMzgrvyXE86kk4fmAnyeNx1JJr05Ag4dO7wHqkaHACAdj5Rb1MsXs8
         hSQzKzrQdGHiThP/lPX2ub9GpoP4NqP+CPQNpWiJNE6dgWDi7nDxvYCaSdflDBiSY4WZ
         +1F7UuZBctyQYpu2R6oaDAg9p5j2C8UEowh9M6eFF9U0IJliv3vozx/AU5PNz71ycE2M
         t3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722871053; x=1723475853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xW+L6kNIuFioJ5rjDKnCuxYZ724u5jfAfcF4VZ+PAvE=;
        b=YRDx+QAWZ7VcUhA/ZK20s6lS4C29wbsRvsgZk+jpn3AcUWVn0G8NeIoPZm9cauyTeW
         Fp5JfVclHf4grKM1TXKc3vn9xQFq50VSpC9nOmMNvy8IN+m9LoKehGT9w7QQD02K3bmz
         L3eKX/R3uohcl8YjGtGhbMtPaEtrBGVPXdlO78xVM10yaIARSS/BOBYaV+4g5kOSNqDR
         UR/fjscMBervhCnG37c39Zt05DJOgiy6JpwTRZM3fpmAr2eCeQhejDs6smIaiFpXzIzr
         Z++Lnl6SfLV6mZK2plIrA/fWeyMJ2fcfybWJA9q4jqpoid8bBTCUYCereg+8FZswS48H
         neMg==
X-Forwarded-Encrypted: i=1; AJvYcCVbYYZ3Luqh6keJLv3D4xVNcUOZUMrOheeYuP0hJP7gnxjyAtHj41Ay7mj7+oW0hw0ZYQcDfFF3QjFWWVxp/OhqFx1mJfWWYvfc
X-Gm-Message-State: AOJu0YwDrftbcdpO+kckhWRgKhs6fJI5H2R8xOQ0C0C+9i/MUqO7qF+K
	heLwbPe7jFAPS7vFkNO9dL9tjOcxo6dyw0X23usU8kDLyLsgCBxfvUh1yquPguI=
X-Google-Smtp-Source: AGHT+IG5voRnVt4VBcz9JPN7Wlg0F9fRCCmBXH791ZTtO6sf86pBUCsbXkJzE1B1Mo5tTAsDDSmBwA==
X-Received: by 2002:a17:907:2d29:b0:a7a:9226:6511 with SMTP id a640c23a62f3a-a7dc4fb0ddcmr969429466b.31.1722871052866;
        Mon, 05 Aug 2024 08:17:32 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4520fsm457910266b.110.2024.08.05.08.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:17:32 -0700 (PDT)
From: Petr Tesarik <petr.tesarik@suse.com>
X-Google-Original-From: Petr Tesarik <ptesarik@suse.com>
Date: Mon, 5 Aug 2024 17:17:20 +0200
To: Petr Tesarik <petr.tesarik@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Sourabh Jain
 <sourabhjain@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Baoquan
 He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Eric
 DeVolder <eric_devolder@yahoo.com>, kexec@lists.infradead.org (open
 list:KEXEC), linux-kernel@vger.kernel.org (open list), stable@kernel.org
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
Message-ID: <20240805171720.3b661180@mordecai.tesarici.cz>
In-Reply-To: <20240805150750.170739-1-petr.tesarik@suse.com>
References: <20240805150750.170739-1-petr.tesarik@suse.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240805_081735_223839_6B5D6ABC 
X-CRM114-Status: GOOD (  17.13  )
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

+Cc Eric DeVolder (current email address)

On Mon,  5 Aug 2024 17:07:50 +0200
Petr Tesarik <petr.tesarik@suse.com> wrote:

> From: Petr Tesarik <ptesarik@suse.com>
> 
> Fix the condition to exclude the elfcorehdr segment from the SHA digest
> calculation.
> 
> The j iterator is an index into the output sha_regions[] array, not into
> the input image->segment[] array. Once it reaches image->elfcorehdr_index,
> all subsequent segments are excluded. Besides, if the purgatory segment
> precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
> the calculation.
> 
> Fixes: f7cc804a9fd4 ("kexec: exclude elfcorehdr from the segment digest")
> Cc: stable@kernel.org
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  kernel/kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3d64290d24c9..3eedb8c226ad 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -752,7 +752,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  #ifdef CONFIG_CRASH_HOTPLUG
>  		/* Exclude elfcorehdr segment to allow future changes via hotplug */
> -		if (j == image->elfcorehdr_index)
> +		if (i == image->elfcorehdr_index)
>  			continue;
>  #endif
>  


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
