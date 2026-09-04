Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B87C79F82
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Xi0GrjNtf+j3mFnPowGAqEQrMP8mYt8469qIGDpsVtE=; b=vxjk0JG3wpar8K0LNqlEp6xxvr
	qWvLTsFtHFlgmO7/dHtwhBTuPLOtnDhhxYz163k1urWxWo0iuMhMb6jWTMZ4nnp7eZdJ3/WBUNnwH
	orevAdIPVrgbpkRwexDEiS233apS0ZJAVe8fS28yJOJoDwi8IlmVODptNx28cktGvYa9p/JSsngck
	bq2guump5Az4kQGsKrHCaQvjJjMoA0Bt0Z6fs4/1TzeSEU8Cz9E01tQNCmXtusqsYIrTgafB5jeZ+
	R6ZLHC1s3D/QRZ3DEW6BATEf8w1gy/myfOYakkqI7TkU8CcTisJPrLZssoP+Wv28re0Ib2ftLOHXJ
	xdb4LI7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2c2t-00000003Mob-1IZf;
	Fri, 04 Sep 2026 22:06:03 +0000
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2c2p-00000003Mnx-2EcP
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 22:06:02 +0000
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cc1c1cc5206so1780340a12.3
        for <kexec@lists.infradead.org>; Fri, 04 Sep 2026 15:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788559558; x=1789164358; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xi0GrjNtf+j3mFnPowGAqEQrMP8mYt8469qIGDpsVtE=;
        b=fypq6VR9169TEx1ilOn53IQBj3F2lBWH8HTlLSc3aChB6hQbBHMDqIdikhugC585gx
         4znMf030VLPAYVSWDY4JZ6oqp0srl123BPSndvdbfoQWGLa/pZrhzIZy5FVfzlnJUFKv
         E5chFeE3qovc2ZGwUOlKnPgIZrKdKcxhVvf/URBdLIONXC9xiHNTjZtUNZoG0iK5WRGs
         hfE6aSPrEvuaaYvBwlC3x2U0SZoXArQJLFLRCmcKu20KZO8BoMYPNa8DsR3zgn2vCh1c
         TcBEmdo0RLVd3mxh5AgmUmOl/e5m6ArlUBXr20KfUsb2MwrhYQaebp1WKGIRVi6xK6Py
         459A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788559558; x=1789164358;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xi0GrjNtf+j3mFnPowGAqEQrMP8mYt8469qIGDpsVtE=;
        b=DzDrl8y575QpZsfSD+C5EPwPV2F+CYfBJQjXOI1pzdjp0JDS6aaw/XS3ashqJU9UFC
         Jy2EshXqa1TKNNzlIpzDumo7n0ij9js3nl3w7EYZ3i+eRimJ+r4zenTj+m/u3Ub9OQaw
         +PNMzYXo6dwDT0LkRXwlUjKHpkFNPRnTAdDspF3TdIGPvxuUwJU8vKpM2W7QeG0PxeBG
         Yhn4Z58XfkXG0Ts87pCWEwMxSKTcKq3lW4oe1+/CeohSlimBXarGRuT83PAL2qS8pR8c
         nzWDzMSc0pWrH5gWMBTyyIXApSv+CA1lZGuqNgIOCv0TS1OnRB8r3mL2u3aHAs0ysTl5
         dBRw==
X-Forwarded-Encrypted: i=1; AKwUvBzNdkB4QOAus7pbH1oWrrgSE7pHfmjWy/aUiULHjZ6Cd6kL2lHcMxuoNtYMbBy3wRen3Mh/dQ==@lists.infradead.org
X-Gm-Message-State: AFuF++kS03Zqd9AwcBVnaQssPtpbRjsc2kijFdWrIAmpULm2+Nux2ole
	tZysBH+QQsE6QjFessG9iE0oQ2BNKx5bWFxAve5mM9Y5ykXO18ZFpv6ccq9wXRK7m8g4AxuCCxH
	r9rx7SAeW8RCxvw==
X-Received: from pfdr13.prod.google.com ([2002:aa7:8b8d:0:b0:85f:2b12:262a])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3021:b0:857:727c:a1f3 with SMTP id d2e1a72fcca58-8616907fefamr12452673b3a.21.1788559557820;
 Fri, 04 Sep 2026 15:05:57 -0700 (PDT)
Date: Fri,  4 Sep 2026 22:05:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260904220555.589752-1-skhawaja@google.com>
Subject: [PATCH 0/1] liveupdate: Add documentation for file dependencies
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_150559_572330_47C3B1C8 
X-CRM114-Status: UNSURE (   6.59  )
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

Samiullah Khawaja (1):
  liveupdate: luo_file: Add documentation for dependencies

 kernel/liveupdate/luo_file.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)


base-commit: c65687600ed075d237a204755d99ad538db34b47
-- 
2.55.0.1003.g10538fe699-goog


