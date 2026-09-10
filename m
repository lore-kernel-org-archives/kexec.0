Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAC8C88E40
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 17:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ixa+0zFsulp4+PuCSm+LSQ3ZbsxbILCT0CSEEhgLf5Q=; b=UBlacl70jmboDCyoCbRn+0kcjc
	G/4XUZjfI4yiXdAqereBAIuMPBIUX0IzqZd5+4OEJ1ukMTlKAcsCL36BBOioWanJ8tVR1SORYaog/
	GCP7SWgbjZ1KkOkl4sjekhRtPEq6uPhM4OXHLSC0hK2I+04mTGLR9pJx5xtcUwCFR1QAroqq/2YaT
	RaThvtD6wZoKyf5dsPxFNLoArg2oVRMtlLWDdi+9tLPDa4915JVpnV6vH95LEx56fLjnqzNIfvJn8
	DrD8pC9e3ACjd7OYEBSU4QiZtuWxxSxgJL10WO/8Qmo9aLlmCxo/Wf75caMkpHKRZxWJRBhja73Ls
	tWzgwJXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ihu-0000000F5AH-3C51;
	Thu, 10 Sep 2026 17:37:06 +0000
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ihs-0000000F59O-0tYB
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 17:37:05 +0000
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2db22383e8fso511575ad.1
        for <kexec@lists.infradead.org>; Thu, 10 Sep 2026 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789061823; x=1789666623; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ixa+0zFsulp4+PuCSm+LSQ3ZbsxbILCT0CSEEhgLf5Q=;
        b=TqaQ8gm7QmtVioBeQP4kSZ2G/lI/HPduAM/i8prarKh+ZwtBkEef2igLwZRNHUkiUy
         D9K1wZMFkxoPlbQgAmSRJxDqyGYJ46fRfmmc+fiY55stdAbqWO9sQyn028ZpsnTKAlJv
         WZzqxenuUrv2pQtjSW4QRvCWSgwRjsV4o6bGalsa/ZbU0Tkb4AYv2fdSvyYfVYd4AsD0
         rrIbG5UmNCTIqVaPZKirUhkaS4Hzb+jW4jNnQkMfp+/bb79g/UnyPYUKdktPA5EWcwTF
         A5HYP1WaGGr065zcgHOsu7b6lWEoJeW1HzxQQ/dElljkEBX5uXJLYKITljQOuPa/8i4o
         Ax3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789061823; x=1789666623;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ixa+0zFsulp4+PuCSm+LSQ3ZbsxbILCT0CSEEhgLf5Q=;
        b=QzQnnL8ex6a5EOBHCS/k5s5d1wlcwzwIUOPv+b616pQhChrIn+ZYHnQl68fV0teixM
         DCoMJGtMctLVcJ9pnrq5wPQM0tn7mkrA6TRxdvQFefA5sXdVVOJ9rI7TS5/mo03oP2td
         qQODJEVgBJ7MXmbLUzPfAHpDMMjQ2eSqt9Fn2FnEGO9cvoJ99jTyGBKMAvczAWpMAXSu
         WtuU4XLItlZwyIMi99nFWiTyLc4XAlypuwTKbgHO8S5+xcuD9h7LcZ6TBOJ/ilWQK/7v
         6GtUFO8oMAsdXdZILK/w3ieb4j9mCb63FifV/ozM0NdGl5tKOjdL/0wGikDSYIGJ7PJa
         1Ysw==
X-Forwarded-Encrypted: i=1; AKwUvBzkFcuiaWax9j0EX4FfrSc8U2DLqRH0nZGyti6EMZslxTrUSR0leRPXE6qV1bl+uVfGG6Jz6Q==@lists.infradead.org
X-Gm-Message-State: AFuF++l5tpS9zwK10QDAv8otuM8KX/aIHzXgyawpnSGJsBB+MBtByrW1
	s/1w82h8PPedoQZuRmn4nU/gdFmZvedZkkPXaTqZJHtkCVZvL3cnVIjgSCGByRdXVoywBTtg2Yi
	AHWEAABRAepnzYg==
X-Received: from pltt1.prod.google.com ([2002:a17:902:d141:b0:2db:1aef:28b4])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:38cc:b0:2db:3734:cfa4 with SMTP id d9443c01a7336-2dd0e8a0ef6mr59319305ad.5.1789061822647;
 Thu, 10 Sep 2026 10:37:02 -0700 (PDT)
Date: Thu, 10 Sep 2026 17:36:58 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260910173659.1945246-1-skhawaja@google.com>
Subject: [PATCH v2 0/1] liveupdate: Add documentation for file dependencies
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_103704_251632_EE4B8C79 
X-CRM114-Status: UNSURE (   7.66  )
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

I sent out v3 of liveupdate_get_file_incoming() and
liveupdate_get_token_outgoing() series to add documentation for
dependencies.

https://lore.kernel.org/all/20260820191854.1642931-1-skhawaja@google.com/

But since v2 of that series is already merged into kho/next, I am
sending the documentation as a separate patch.

Changelog:

v2:
 - Rebased on liveupdate next branch.
 - Fixed documentation.

Samiullah Khawaja (1):
  liveupdate: luo_file: Add documentation for dependencies

 kernel/liveupdate/luo_file.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)


base-commit: 945d61765894dda2f0344de50cb1ade2e51b66fd
-- 
2.55.0.1032.g73a4cd73de-goog


