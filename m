Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4768DCD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 18:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ue8RpWElOJWTzQpGzar1fgpzJp6JMDiEfdJn24IqziI=; b=Q+ui/pXKQZb2ZWJZg2PLp64HAk
	4va8AiGs5+pA7F0G2xKHiVmqbZsGeAKDjJHI0e0sPI9BXy5tAHi/IPAgmpBtdWGQ6+M6AKj20n9on
	17PSQPk6315SMJXwND6syDPiLU7P/dtS7hRQGz66YEMZ680FjX5z8uX6gYMm/flhngBv94tchccx6
	W0MTiUQ689pgC1/Kfu1QaG4iQafQrQjJBSDfXeAlUYFYxWVnru+6/UXVuMuBmyd0I4UI+C98qFdSm
	RZqN3y6dzZoVM2HujcVDhZSudlvd4qy1Nuw3nhY5ZzOgFNqFJgZFdEpNESXGHoKc2cyItK+2rlVHc
	r7Lcd4cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKgrc-00000001l9O-3dym;
	Wed, 06 May 2026 18:20:52 +0000
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKgrb-00000001l8w-21hy
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 18:20:51 +0000
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-65c7492a2ceso2189693d50.3
        for <kexec@lists.infradead.org>; Wed, 06 May 2026 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778091650; x=1778696450; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue8RpWElOJWTzQpGzar1fgpzJp6JMDiEfdJn24IqziI=;
        b=KvVVmb/e0IikcaOo9AJnWRjdFEpMzxo/FGTB/sK0z5DqtOd0EwYpZWWMnzuHvuA0mW
         Lces/0uxJmV9qvUfASft0MucSTgbsFdfihMUP+agyb7RFcWOw4K23kDGlExbuW6j1OLw
         0Ps9kp5D+6EwVXj6lIc1GdjwAhjl2V/VhgL8BG2Nd6u7wCtOgwQDROb8xf+aWsLbvLhG
         G8E8DxLoDZD9Ii2usdd7oJXkrHW/t/6GVUYVx2N7mDQf+tuHP/o6w8jHr491ehKibEQo
         swgRfC9194Ww6aDB7cARA+J0SyPQKkco1/GABLwkJUHKS84ndCC/UvigpgOUykuS7b9R
         qihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091650; x=1778696450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ue8RpWElOJWTzQpGzar1fgpzJp6JMDiEfdJn24IqziI=;
        b=N/0sTEul/xCj4EmnnNbAlKYaw5TyfG/aX4gAcNgu2wI6u+vQZevT1KPuxgE0uRXrU+
         92xTmh765beCC+DlDt9X+G9Mn1ARJrL+YhEVNZcZMGNJ1P7QeVIgrUpvXoR3qrq8JRo+
         us4CRl0KLl70NgfGfxKa+c1N0UH12RGcfTRYwPiRk+u+svUGwGbGpe+pLlV8XpSEwC/I
         NqrzKTN8U6Hd4Gd1A2/HE+Ha/DM7+BMqwEzAEtpXbEx+9X5PuzRYxDwdL404Eri29u38
         7hxtHZcN0NkQcKHGtJqjuy/elOa9zXhUm6kNuHvOiAvrW/YWz8t/Nv0l5QIiGJgdLu0J
         w00A==
X-Forwarded-Encrypted: i=1; AFNElJ9htTOtt7mIv9yWSjH3mWTmveg1VrO3t1h3TZI7ZN2QJkBU+BPcbRTAtYs2SXDhIyxpdHcFog==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZS8iYx3pCY4J7UmTdeQyVpEm2EQpV1tiMbVA6ydXdT8TzZwbt
	hKBzavG/tkx31QriUOckU0N0uYxpw2MTufxVt6RKEttggPzjczFQYEfwshw4Z3P59Sg=
X-Gm-Gg: AeBDieuj8BCrAWBGNL11a+RGXNxJ//RPk5eUNBvBd0OEHqDJeH4TgR92ZrqVu/NrE1P
	9ly4gS884Eyy91/BdpNvPFVonSXTYXVL1h3+COO4FTwJuOjyz2lF9Qg7OxiqCsP6YJvd5Dgkxqx
	4CGI+KG3xBw+hFJX4XFNGciOoC2eqSHFGmnXs5GnIz2JKnsdHvgbQrgyKCdrHYzFhV2MRciflZW
	Xmq6Ju9PYaDkeL3A5/MOKxa2o+T0k+s0EgnzZFxOyL9A/S2q8PI03QArQzqeMZzn+DihNotVNdz
	lGL3efxyufAyFyxJ8W7fihKtsyRGgg6S/COeidqpdKeKqiBXR0kIc8J7zVQqtgVtQ7+tF7Un9uO
	O+dURDGC4nVCN4Oy5LRHzzv6Xj+R72twMq7M6M/SF67j7dFeTgEOcsML8bHuLamQQi0ZjCb48nz
	m3myfkAOZQfLxbq6215vI75oeUTQVG14UNGy0fDjFfB9hv6sUpUOLwIHTyR/a0EYSdR+XBzFXue
	i9FRE++0k4jW7x3RXDoQpnbkF5bE8jFtjWwGbPP8zZ3tZ0tMciGfuk8XVff
X-Received: by 2002:a05:690e:4401:b0:654:6cd0:f96b with SMTP id 956f58d0204a3-65c79cf0597mr3598241d50.5.1778091650422;
        Wed, 06 May 2026 11:20:50 -0700 (PDT)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c7af9f8e7sm1389917d50.13.2026.05.06.11.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:20:49 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com,
	changyuanl@google.com,
	mario.limonciello@amd.com
Subject: [PATCH v2 0/3] liveupdate: serialization safety and race fixes
Date: Wed,  6 May 2026 14:20:40 -0400
Message-ID: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=pasha.tatashin@soleen.com;
 h=from:subject; bh=m05vVKwcBsXuT9wz7QIzEMSInuOTC578ENDk+r34blM=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBp+4Z3c0D+XpYi6VubNAAFYjxJmiLLxeKkGeG0q
 Ve+c0QfVEWJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCafuGdwAKCRC7dyhM23N6
 3gtED/9AH1OD0iu7KRB44/No6yLpmYAfKN96w4BZ7rlCykWxr4qFFaxI0L5a9VLCh2S97yz1/bb
 Zi0BODW3Bu6XNAC/jDR9TFSqYVUMpZfrR0041jj4aX9QDBCi5Q8uSbNIBZayt3jdu2pE3Lyi7um
 55Aj4d54qD5mHma+O3j2aA+L4fbPxrB+D55MT8A2e4ayRFIwZcAbITB71399LcAWizEDYBKXeAU
 yr8mbMn/as9b9R99762WJIiNXsTXQzbSfCp4Cgabb/Upe7raCjpRpYTkCNTL2YqqfY9trpXECUw
 pCPTLNe9HasqymbyBMkiYHrF2VaYa/KPY5+5gDnegxDedUD6Sbc3Gpe9ZGY7TymYcWWbVw2HmSI
 Vf8LcJt2VovMWhhXR8uAzgI0ro7GHXRVEmr2gW3q3O4DvLcUJvoDVjmVlKnDUtBPnvoo6YcEzxi
 /7OB8pcL9pBLstnWQNPc1UQFUBAG665rEbqlsh+NUCbaOHVIR0EVRR6sq6mUV0jlE9fx1Bj106v
 REmN/PC1a9Z/GGaBqNDjhkD4YcCX/6HBQrq5+MIIyH1Z7javZQvc+9tAbzUYcfCu6hCJhBd6If9
 r0JYXPk1bdRv5w9SRuhthsD0r104yMoncJv6T/riSnrrhiqYYcqjXqjZPvYH/41NS2VED6LmVYr 3I1BQSSPlrNAb4g==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp; fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_112051_531373_F4E7477A 
X-CRM114-Status: UNSURE (   8.71  )
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

This series addresses several issues related to the synchronization
between the reboot process and LUO session management.

Changes in v2:
- Added a patch to skip KHO data for context-preserving kexec (suggested
  by Pratyush Yadav).
- Dropped the 'rebooting' flag and manual session pinning patches from
  v1.
- Implemented a locking approach in luo_session_serialize() to prevent
  concurrent session mutations and release (suggested by Pratyush).

1. Skip KHO data for context-preserving kexec: A preserve_context kexec
returns to the current kernel, which means the 2nd kernel does not use
KHO data. Passing KHO data via setup_data or devicetree is unnecessary.

2. Skip LUO serialization for context-preserving kexec: A
preserve_context kexec returns to the current kernel, which is unrelated
to live update where state is passed to the next kernel. Skipping
serialization avoids unnecessary work and prevents sessions from being
left in a frozen state upon return.

3. Block outgoing session mutations using locks: During the reboot()
syscall, user processes may still be running concurrently and attempting
to mutate sessions. To prevent this, we hold the session header's rwsem
and each session's mutex indefinitely on successful serialization. This
effectively pins the sessions and blocks concurrent modifications
without needing custom flags.

Tree: git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git Branch:
luo-reboot-sync/v2

Pasha Tatashin (3):
  kho: skip KHO data for context-preserving kexec
  liveupdate: skip serialization for context-preserving kexec
  liveupdate: block outgoing session mutations

 kernel/kexec_core.c                |  8 +++++---
 kernel/liveupdate/kexec_handover.c |  3 ++-
 kernel/liveupdate/luo_session.c    | 12 +++++++++---
 3 files changed, 16 insertions(+), 7 deletions(-)


base-commit: 7b0b68b2b95606e65594958686833e53423f58f2
-- 
2.54.0.545.g6539524ca2-goog


