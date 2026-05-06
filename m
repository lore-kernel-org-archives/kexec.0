Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D012CD3439
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 04:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nO62YzM+gXHSIxJJundtS8a0zPZMa0Cda+jCjV1GrmQ=; b=P7CUEdQaLEQGTamQXXs7kHQyGo
	SRxsELfqzmynUVxXY4N0Z5gLAKddgCEYamuUPT8Q1Iz5Q2vaIF/vS8KsQvLCVVPWkAYu7c/sH51Hn
	WEYmM2T1IcpbfQPdjs+tcqp0EJpFJFIkOBhoD3ib4BnZMdysEH06ksqA8MHccGh32aiY+DushKlli
	TCODHSvA5yugWImFZBa5yIe0Q6vk8JcT82Sp/7XBSftzIJ5MldVJEXa70CiyFmw6Dif9v7HiZ8FA2
	eO65BLlSIaI2yZr2vHUMct2xz6zUBheImIQouPgMtNZoAu3S3cXFkCfBuRTOQZtmJ97iNep8ct60x
	h94tCEFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKTvo-00000000hww-24nC;
	Wed, 06 May 2026 04:32:20 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKTvk-00000000huZ-3Knb
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 04:32:18 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-7bd8cc5ad52so25748907b3.2
        for <kexec@lists.infradead.org>; Tue, 05 May 2026 21:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778041934; x=1778646734; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nO62YzM+gXHSIxJJundtS8a0zPZMa0Cda+jCjV1GrmQ=;
        b=D17nesKSkBwCOuvjk6S1Lw+0EvCJOMLOo+5R47ABGuKDl+kS8VYpHNJNDqn96UisZ2
         oywV8LcLZM7BWK5nkLOt8VQog2BZwZnMwLY1s7jC/nzSjnUTUSFiDJ2Z8onfSZkQFFIP
         Zstl0TcrFxNoAMyDOSuwQ//S4bDDz+Z3u0qO56Y/bkOfcxhg+PZeE8/41zJTYMTlnTLG
         VD7ZxOZG75xK6sKarS64BsL7d1Y/sGLMI/F2ip2lv0mkfURi4Jxu9dp/uOBFcomymqRu
         F2X3t6+uXonf/DZ6yoyMGeSDOmchn2To+0M7J2OtibrMpWDE8CUyRFOSA3GlToy0AR/o
         lvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778041934; x=1778646734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nO62YzM+gXHSIxJJundtS8a0zPZMa0Cda+jCjV1GrmQ=;
        b=mSHeSOBb2nosnp1U+sNOKanskvnPqCOln8wR+7BRAKMFFdcyBvfWeSN0CgRqTvaP4L
         dNkq7QatrDOlg48KtvIGUQDOVPUdYskKkwUmgC/j0d4WgP8sta1hfmbVQ+u3lsuJRDGq
         doEs0rFrWLc9WbHjxrE2ffGNnfKBuRznExsDxv+5ksjPbAAfvwGOwLWqqfj/fZ2HD9v+
         eVvKKh8vsPorjeFaJVLKAGfN2dzFE+MhZLkHtZ7rXT8KWMi+nXxsuFNNKCzAZvnl167+
         XxewAOefbDaZ4ZKL5AE9FXNJNtfJtxlh/w2NJsybxy3f1d2HhWN6ipO24EDg/wIHgGj+
         me2A==
X-Forwarded-Encrypted: i=1; AFNElJ8qgeFIGAXZMFDLpCngEQvhENG1PHp7AYF+dz/nPYOG7aLT0Xg+8z8MD/7eeJivNHWZJhqLoA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyYYvAQMqtIvHSXmoiHKt7oCv4GDEtv1L9QujOWW7fDT1TVm0T/
	OATXOX4DIgl/sm6vkvCItyHXPCGaxRlu66PH2Oe0mHjN4bBg1iJWcgimjhhxlyigES0=
X-Gm-Gg: Acq92OFVPjNioWKdg/+t2gnBNVVb8xKaIQ8TcUFxOSt+v/Y6h+K3O8eicvnDQrCLfpH
	m+WhU/PXrfJHi+wPIlAAJKjFieYSHk6yp9s6cLuKFRLd0cHDGLBzrlVEF8IuIJaQWsBwoNtzBwI
	RsRk2qccJdJ0GNYIVyzPAIfHMlwcH1j8FyRd1vmJLWnKaFM+2N8KUtlzQPFVJEYnC7Txv1jrhZI
	Tksj6YwB/ZcH93oL8iVcFwT5OkltbDBF5ydjARkYiglPXDkb4Q+3zeQB6BWFk4JAexBOrc6CHPY
	45hPHvrVQkdfisNADvvYx+gbl+FSzWniSnbZ+u9AgYGMDtTQQF0WbYTN13IjB3vemL5vcbnphrG
	usN41xlAekAC0VsEGtto6itBhcLKRYHnNfje0dwpaSGpPBIbG7WAgT4xvsRZOROsSXFnRg+L1Ud
	2FUohl4CGDpNGhGvSQ3SZ+8KbFzLEKgj8Eby/qfQoTX/QuU3AAEQKMv7iPjkKtM4XFEui6bBdkS
	YdUlljtr/lh5enqIotVvvLeg1+RZRDy1/rd0KOjCSQ/7PGkGwyA9UaoyZ5m
X-Received: by 2002:a05:690c:f:b0:7b3:9175:30a4 with SMTP id 00721157ae682-7bdf5dd1267mr23769767b3.15.1778041933955;
        Tue, 05 May 2026 21:32:13 -0700 (PDT)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66838851sm73436997b3.23.2026.05.05.21.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 21:32:12 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	liaoyuanhong@vivo.com,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v1 0/3] liveupdate: serialization safety and race fixes
Date: Wed,  6 May 2026 00:32:01 -0400
Message-ID: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619; i=pasha.tatashin@soleen.com;
 h=from:subject; bh=ysJb5OjSuRAfwNSM8dh2cNCxd3OeYBw/rtTcmBwmmZQ=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBp+sRATFvT9a4WUCV7UMYqZiEC6NWK2RCn+9d7M
 bEJi6aoMNOJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCafrEQAAKCRC7dyhM23N6
 3sewEAC52yQHIYPPMC5meU51RQ7IVJ29hUjkEEk5rA0aGumxsqgk7oO0osLLRoNvAABXwmt+lf9
 /RAW6reRJFRPt27qDaxyj190p4t3VBlyQJ4fkLc8MfaUMdShlY0rb9B5wkieT23wzG4YY+Xlh5f
 qNFnTlYU25pzAqwWaBd7dLwSqpBSEs1LtKRZYtpaxMftls00FBOmrQ4aqyJwEWCFLVyayYcmvc/
 zxR2/aWSIC5y1VGTDMYo0Ltkdvq8z+Zxjpm3FpCpni2V5E/SJ2y2PcjNU4mlXdZzqoH29s1laGG
 1PhYuCavryypBD1srqWYdBzzPgrlgKP3Xvrrc7CaGCKBvxh8664lSbLaAKcEMMGSx1BJ982PTr6
 uPRFTn9gTg2e70jNgBfBa8dgMcCqyzMUVacjdf7ES1iJl4Rng/WG4rj/cjunjB4SX+tWWS+8aeJ
 n+MO25ZuLNckSfbPfiO0+hm7xQWS1t51ADH+1TPqmZKk+DgLqiP4+UsUpua6tvxxZkXlCB/xkJe
 vmQKkwJaipr9G9Xb8Z8drI0LTlfEdSy+qsENjmBiYEh4P43LGo4A4WEoBFIV1Uo57Qj57Inwt6q
 4np8bipm2qSjh1Gbapvtc9lHKHXop+SqxTDeHOD1KQyETnYceb2jQ7+1LP+P3pZkn3kPjMW+Lly RD3X/XiIhO0wDTw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp; fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260505_213216_849960_AA84827B 
X-CRM114-Status: UNSURE (   7.21  )
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

This series addresses several issues related to the synchronization between
the reboot process and LUO session management.

1. Skip serialization for context-preserving kexec:
   A preserve_context kexec returns to the current kernel, which is
   unrelated to live update where state is passed to the next kernel.
   Skipping serialization avoids unnecessary work and prevents sessions
   from being left in a frozen state upon return.

2. Block session mutations during serialization:
   Once serialization has started, no new outgoing session mutations
   (creations or file preservations) should occur. A 'rebooting' flag
   is introduced to ensure this.

3. Pin sessions and handle inactive ones:
   Ensures that outgoing sessions are pinned by taking a reference to
   their struct file during serialization. This prevents race conditions
   where a user process might close a session while it is being
   serialized. Inactive sessions are cleaned up and removed.

Tree: git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git
Branch: luo-reboot-sync/v1

Pasha Tatashin (3):
  liveupdate: skip serialization for context-preserving kexec
  liveupdate: block outgoing session mutations during serialization
  liveupdate: pin sessions and handle inactive ones during serialization

 kernel/kexec_core.c              |  8 +--
 kernel/liveupdate/luo_internal.h |  1 +
 kernel/liveupdate/luo_session.c  | 90 ++++++++++++++++++++++++++++++--
 3 files changed, 91 insertions(+), 8 deletions(-)


base-commit: 7b0b68b2b95606e65594958686833e53423f58f2
-- 
2.54.0.545.g6539524ca2-goog


