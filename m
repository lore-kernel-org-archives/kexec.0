Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E96CD98D2
	for <kexec@archiver.kernel.org>; Sat, 13 Jun 2026 01:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cu/yolJajqpUi6JPaZqDIqNimARDAvp56AZs+065qLg=; b=D3ICWlPKt7qEtHOsLJpowafJKS
	HXq9yvlYksUvWoMJRsMdaN6Htd8gMC8VY/4sGjK+jkt30rDE6C/ylD2AkDfPlxP3NMSD5tDkJUGks
	msRK7KhhDP2AFTT4kI8NrqGirMClW9xJFQQQCnaNKfQvbqkVp4zIIDAJuK8S+bQuhkQSn9iWV0YEg
	IeZfM3fsy5QiBZV9VAEPaQ9gjO+FWHbo98RlymtJaFmX1zjg5enm6IVJ1JAWcLAxR7YdDYYEK2lwu
	1Qrs1JIpX3dHXUPpaAIWdf3qywp6UfASg3s4+hNj9gHeY3dg9qR2LkcpM6cwEnFbaR5nRH9sTz92x
	X41wntDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYD7n-0000000BtGD-0hVR;
	Sat, 13 Jun 2026 01:25:27 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYD7k-0000000BtFZ-0ZLc
	for kexec@lists.infradead.org;
	Sat, 13 Jun 2026 01:25:25 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c8584e3fc96so806667a12.1
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 18:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781313922; x=1781918722; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cu/yolJajqpUi6JPaZqDIqNimARDAvp56AZs+065qLg=;
        b=DVm/XP2zDrPHx1EOeZpXVsi1ltrQpJJWoJJuji7nd6a5vSpXcuK3i8JLGFuj4pD8Mz
         ZttnuJWSBnbcVJfbwvJm7URqGRjIPTmkHv1t5yNnw4w/tqSZgsPqdrV2RJijWM/527at
         LhvDhPfby7QNEgtslF5cVN+4JvE6iuhE6K6QwAWgEwrOee+hUrxPpv7rWV7r12ts5cyW
         RR7rApY2B8iEI3jiHl8LChMx96pqPuh4q/YPAPHHI6WSunAIuAi4zrSIUDXs4z56bfwF
         BN56ajJ74V2ZoBZZyZaynnHBFPK+TgfyOUEwYehDWe/2OK4Ip8abWN3XJh3m21IvIX8x
         Xshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781313922; x=1781918722;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cu/yolJajqpUi6JPaZqDIqNimARDAvp56AZs+065qLg=;
        b=sVzBZdabBaixa7wVVIAoLrQDSDDM3L5U9Uc9DCBM/C/GhpeDqPiuxg1t0h52Fx/Eo0
         gOpTaMiHBd3SySyCx6Ic5WIzLEma3ZDqeak7cWetCUKyRnVpBrrt2cfGRp1tJt3HBfyC
         8bIUnjWUQ8/SU8hfEU7nd295DvXGzhn9/FC0bYMupWoHY0yotwlvHQiIrigo+ulErQE9
         MRUMfnyhkV+d6TQLoA8xoBjn2ofeMA3rtFAcO2XwK1bJWdJjnGSrO4758bTySQjvFXiv
         O/c36fr7SohuDwl15f4D5XUIMifoDqC1Qkm9pqJCw83q355OroCnpg9dGauv02Jh34wq
         5Lcg==
X-Forwarded-Encrypted: i=1; AFNElJ8aiMc+o5ZWwHjnSTarLwpHGd/IZyerXJFQr5okp5KMv2XA9USyizMje2PkmJ2eiyrI2RbgCw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzOUqz+7gxaWD8bjxFCGW0GSGqvlaIaJOb3obMTdoKS2RpK0Kp2
	YhzlVF4Jna2pfMSER0vhtwpMBlPo+NjKSqdKvu5a6w/8LkqJky6ssArHnXe1GQkQnpnuJgehpwo
	oZ3mdHg9pUDnk4g==
X-Received: from pgce10.prod.google.com ([2002:a05:6a02:1ca:b0:c85:81b8:dc5f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7106:b0:3b4:7c33:296b with SMTP id adf61e73a8af0-3b7963cf4b5mr1901418637.32.1781313921702;
 Fri, 12 Jun 2026 18:25:21 -0700 (PDT)
Date: Sat, 13 Jun 2026 01:25:19 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613012521.835490-1-skhawaja@google.com>
Subject: [PATCH 0/1] liveupdate: Add internal APIs for file preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_182524_198681_657A4CC1 
X-CRM114-Status: UNSURE (   8.01  )
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

Live update orchestrator file handlers depend on the preservation of
other files. To make sure that the dependency is preserved, the file
handlers needs to fetch the preservation token of the preserved
dependency. Similarly during restore, a file handler wants to fetch the
restored file of the dependency.

There are two known usecases of this,

- VFIO-Cdev preservation requires the preservation of iommufd. This is
  required by the IOMMU preservation series:
  https://lore.kernel.org/all/20260427175633.1978233-1-skhawaja@google.com/
- guest_memfd preservation requires the preservation of kvmfd. This is
  required by the guest_memfd preservation series:
  https://lore.kernel.org/all/20ae20f9d1a198b289444ebb4c824314cbba1bcf.1780676742.git.tarunsahu@google.com/

This patch was being sent as part of the IOMMU preservation series, but
now it is being sent separately.

Pasha Tatashin (1):
  liveupdate: luo_file: Add internal APIs for file preservation

 include/linux/liveupdate.h       | 21 ++++++++++
 kernel/liveupdate/luo_file.c     | 69 ++++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h | 17 ++++++++
 3 files changed, 107 insertions(+)

base-commit: 34e8f02817e31826e76bb2ded48bf28fe921f20b
-- 
2.54.0.1136.gdb2ca164c4-goog


