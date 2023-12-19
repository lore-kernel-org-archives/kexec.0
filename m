Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFC1C46CCD
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 10:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HbUJ1c/10SqeZF4Zht0s60IWeSS118woUcWbMPi2nUc=; b=hBCdUF8uOrEYfS
	QTH4tbD7yvdsWuqC1dzMtpL2oac/BlDANlCkrONnaDr9LBKY2iB+s2r/xnN3hPXqB9wr8bUjq0aED
	+xRWvTB3VBl7gBy1zjiwz2mfZdSUNocLFpUjnxsmIHUcp4way+BHsfV5p4cuoF7UU85+ZddDJla9b
	ELoj+N6WZNzS18NgObg1uWUWFwXSA41/bTfe7A8S5iOVNgw8RSGuDfEubrs+xkqnq0bujpS3hiSF6
	0j+h1oxcqKVgz04WzdOXizIwazPn/p3/fGR0qp4J0bwbXiJ8GIsMiAzx/gDjQr1LkwQsFy7m45pCM
	AXOthO+NR2D3FwxCL1aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFXVl-00DarH-0S;
	Tue, 19 Dec 2023 10:39:41 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFXVi-00Daoe-1Q
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 10:39:39 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d3ac87553bso10487665ad.3
        for <kexec@lists.infradead.org>; Tue, 19 Dec 2023 02:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702982375; x=1703587175; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXUONicHDrcXn5yOmVQBBsRw7TDnkiEQtlJXRIcG9Q8=;
        b=B7k69f7FOcks5sG1PhltG7MHQ4no8SnU8gpdWboYfKWE4RT8m3kHYq2W2AfC6nwa4b
         HRsdhvSrkgD2IVkk3aPEIK6AmkR4H2kUqIDAxJzag+1R9q9JcB1mXe99rqaV0kFYAfRU
         vUTa5lO8QEhgD5TeIGbFsczr6hgboJwokVgwfe8b8rc2yB741oRPHR5TAo9oUc5vYG6O
         zxOuzYzx9KenRUFPYa8lQbJT7M1WwQmCgPlkjyLzpHNNhBT9T+nA2w/H22N37XmHVrsJ
         1iHnFTOHHMnLC8vukhqyv+dMKOGPNK4wZgrjGGetH4yJZF70nVaQz2Gm4kX5spDqPUcd
         s3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702982375; x=1703587175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXUONicHDrcXn5yOmVQBBsRw7TDnkiEQtlJXRIcG9Q8=;
        b=KBiwMatjUpZQKBMm7FDVfSTpK3B2mzLp2IS0c/dJqJ1D2v+jNvB8mDR6Gu4gwQdFX4
         sjS4QQNDRNAXs6//LQWjyjxkGrwRzT7od/uITOExKdmRBuK/dvMC0xWO60EZDbO1p2N0
         MrHEWJCa2BwefZju3Dlzipy3TB8MbGln3IfmQd+F7twjXiw1oRA69nXopsqXy20MysiZ
         ggrv2zAntOHrSutxcpbJDd+CbgZAfBVinebTtbguO0HvLLSZNHzxBclnqAUN5YmTSZnG
         ayEV9q50wQexjQnxC5CY9HFURBIEFJnX+u7xs2Xl4OJURGcPaapr8q+PREmRzMByz7WY
         FZig==
X-Gm-Message-State: AOJu0YydWOXgGoZFwpondHmeaW4+gw2P1Szt6BlED0GMUwcUq3LavzXZ
	6Kn899Kxa71Xr9OJsL3oP14=
X-Google-Smtp-Source: AGHT+IHzn7jtRZjLFf7llLDQqbmYYVqic2LjPkkfsmtJexRIP78IR7QcPLBoMzDzJU7tNKmPDJcZIA==
X-Received: by 2002:a17:902:76c7:b0:1d3:45b7:bc26 with SMTP id j7-20020a17090276c700b001d345b7bc26mr5472819plt.54.1702982375065;
        Tue, 19 Dec 2023 02:39:35 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902ed1500b001d3ad367fb4sm651369pld.155.2023.12.19.02.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:39:34 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: fuqiang.wang@easystack.cn
Cc: bhe@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vgoyal@redhat.com,
	ytcoode@gmail.com
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Date: Tue, 19 Dec 2023 18:39:28 +0800
Message-ID: <20231219103928.98465-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3765549d-892e-4102-9b56-9add1d0a8089@easystack.cn>
References: <3765549d-892e-4102-9b56-9add1d0a8089@easystack.cn>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_023938_476760_C54BE477 
X-CRM114-Status: GOOD (  12.30  )
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

On Tue, 19 Dec 2023 16:55:16 +0800, fuqiang wang <fuqiang.wang@easystack.cn> wrote:

> Thank you very much for your patient comment. This change does indeed improve
> readability. But as a combination of these two, how do you feel about moving
> crash_setup_memmap_entries() behind vzalloc().

I don't quite understand what you're trying to express.

> The image->elf_load_addr is determined by arch_kexec_locate_mem_hole(), this
> function can ensure that the value is within the range of [crashk_res.start,
> crashk_res.end), but it seems that it cannot guarantee that its value will
> always be equal to crashk_res.start. Perhaps I have some omissions, please
> point them out.

Because elfcorehdr is the first one and only one that allocates memory from the
starting address of crashk_res, and the starting address of crashk_res meets
the alignment requirement of elfcorehdr.

elfcorehdr requires 4k alignment, and the starting address of crashk_res is
16M aligned.

Therefore, image->elf_load_addr should be equal to crashk_res.start.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
