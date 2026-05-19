Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92008CD4F5B
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ST4xr8elUyY4XVDi/DfkePwZ3bJPhuT8td7WsE6XkjA=; b=rMz7QC1o/y9YdJniOcT82oepwb
	fKIQZRIRpjHeNvJvrGF/atfWrYC4hzjCW4SK6hJfYYM10glwlYH5FMCENDqStmTtfs6dssEFDBUeH
	JB0JTvO21U6e1jXQbQgrp/uu/F+LVJKpFbeW9Nz4mbRzUT6g4ro3MxCyO07DExJ/YO7OKB/jcofzD
	wawBh8lFYdNrEPlGaLzvRP0JHSQ31+4vemBAmN9yQl6TxBIugmR5xM1ckQ9cYXAnOSus5dq8c4KKo
	voytGZazliFyaHvr0TcgzEJIvFBc11nSLjbP5gHnOPxEt5IVAjsGWmX6cXonz/F8rmnqqF2+2udyL
	uWju3kpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPMOT-000000023ne-2hqZ;
	Tue, 19 May 2026 15:30:05 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPMOQ-000000023mK-4Bi3
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 15:30:04 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso3145536f8f.0
        for <kexec@lists.infradead.org>; Tue, 19 May 2026 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779204601; x=1779809401; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ST4xr8elUyY4XVDi/DfkePwZ3bJPhuT8td7WsE6XkjA=;
        b=A64JMks/VEcXmzA1U4rynyel9fODiDcFl6s9dEig83yZX2C73pY1jPYKWuwpiWc1ea
         ZT2CBZ0QHK7jTW+AY69xKziAOfDRWfTH48ZI8dx7hw6fd/ddWjqbZcNSNs++JNFLQVe/
         AejDeFzuFSg+zAK4yykVs+D0cGODK5Lhgo8dyc4Bm2zV5cHh7LYSweW77tQyxfvkmcLY
         gBIZjTC36atE9GjbGWiaJKENgf/I2mUpQcebGy4rcFYZGdkyKvu7keWzeudYzTig5wlt
         nfADDQeBOaSF00w49VpcH+CRuesvqvhnVD+FSWup8bUFOXdviYrDwgwpz/jko+v+ZMdg
         0ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204601; x=1779809401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST4xr8elUyY4XVDi/DfkePwZ3bJPhuT8td7WsE6XkjA=;
        b=qKSOe5/je4q/NKkin5UKJokXwhIoIP42N4NtwvM3FHt58hfgsobtII7l4adbLmw9Ae
         V//TPal6KZlLxIqeWdm9kxoTVib9Fi/j5O11PNZZtR2+HQNbJ4ufGEVPVSmIN59exqBN
         wI1hU8oakGoJ3F2jq2rx+oWYnmY8GksgNoQtaux6k6QJP9ci6F4CwYAB7foZAGeTvcHj
         QatVTTupJuSEwNwHbAiAl6X36tJWiOFp6k0xTfZdjDq6DHL887s0g7S/s1yO/fMwa/BK
         769c3PUAPbnBgrnPXP83r7E0B5ggiqk1BhFWe8qPOMqvyDmhxA37VCqqNaXrFOauSpit
         4Tiw==
X-Gm-Message-State: AOJu0Yx5wkAAPwiwc8TFDT7dZbyF5IkPYLJ3gw8RL+b9Ocir4ENiHYw+
	9UiLr2PJQLfcacdv+JwbYaotO5Rbg4/Drq2qS2M5b65NsMw6DR31VNEqW7iRCw==
X-Gm-Gg: Acq92OFoo6V77m/94LaeUO5Wx/cxSay2q+oRwJiwhuKHf9e3AFMAJwgaFTm/wfJoSFP
	eO1f81KmDD1cPLoO0kssXDrsfMEQvXdEP8GWC5MRynqmFU2q8pYDvN+pkbIKtgwKnj42l8vTRzP
	Q1RetWy145LHWq05td+0Mc6TVFIw8KI4+xL8znyhz4d6gqA5Z8vebuquO0lgLbu2pN2XcreWChm
	w2OZvx10U043HJ5AZcydfg1Vgr6XhdTwSmJt1l678+cao5iLn9ACByLGtlYuke1xAMWqSHOxkef
	NRh4yiEO5mOHWwPOXJnUdOF2EUm06I+MX6ApgrQlE3gVwtCFf576kntuh4njbfKFEqallUDrwT+
	ISNYTPgphd3W4aZVzDt4Chh4LD7PCukSlRmMH+7zJC3TErcH5htQXKUcDZOBdPaaw4gUSZY4hbr
	vBo5nTQMeaqIoDS+gUu3df4cGAWJvm
X-Received: by 2002:a05:6000:2dc5:b0:449:cfea:ca91 with SMTP id ffacd0b85a97d-45e5c5a6368mr32201223f8f.37.1779204600468;
        Tue, 19 May 2026 08:30:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:5670:761c:bfe8:8866])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45da0a19c2dsm47458473f8f.21.2026.05.19.08.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:29:59 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH] liveupdate: document systemd support
Date: Tue, 19 May 2026 16:28:39 +0100
Message-ID: <20260519152957.548119-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_083003_055472_D4549C3A 
X-CRM114-Status: GOOD (  10.28  )
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

From: Luca Boccassi <luca.boccassi@gmail.com>

systemd v261 will add native support for LUO via the file descriptor
store mechanism. Add a brief paragraph in the LUO userspace documentation
page to inform users.

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
NOTE: the external links will mention LUO after the next release is
      published, which should happen within ~4 weeks

 Documentation/userspace-api/liveupdate.rst | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
index 41c0473e4f16..f6efc32fb40b 100644
--- a/Documentation/userspace-api/liveupdate.rst
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -14,6 +14,29 @@ ioctl uAPI
 ===========
 .. kernel-doc:: include/uapi/linux/liveupdate.h
 
+Userspace Integration
+=====================
+
+systemd (since version v261) uses LUO to preserve its per-service file
+descriptor store across a kexec-based live update. Services opt in by setting
+``FileDescriptorStoreMax=`` and ``FileDescriptorStorePreserve=`` in their unit,
+and push file descriptors with a name into the store via
+``sd_pid_notify_with_fds(... "FDSTORE=1\nFDNAME=foo")``.
+
+Services may also create their own LUO sessions (via ``/dev/liveupdate``) and
+push the resulting session fds into their file descriptor store like any other
+fd. systemd detects such session fds and handles them accordingly, and
+hands the re-retrieved session fd back to the service after kexec, using the
+existing file descriptor store service interface.
+
+For details, see:
+
+- `File Descriptor Store <https://systemd.io/FILE_DESCRIPTOR_STORE/>`_
+- `systemd.service(5) FileDescriptorStorePreserve=
+  <https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html#FileDescriptorStorePreserve=>`_
+- `sd_pid_notify_with_fds(3)
+  <https://www.freedesktop.org/software/systemd/man/latest/sd_pid_notify_with_fds.html>`_
+
 See Also
 ========
 
-- 
2.47.3


