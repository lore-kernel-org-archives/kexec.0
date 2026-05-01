Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBB9CCFA13
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 23:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jiUX46+NTllWWWm/iG69SeYyuO0SCDfaLB55TfAIGA0=; b=Jwv0GVPzh7XCByjU7eKEs5jZUF
	nuf+rP+wion0XTZiD7+HkSVNK1M0ViR8cQKbDpwrZJG551FToyWLLihn14iIZ5upbadkvFny/pDnY
	ZItKVPU1P3Ms0lK01GiSzoHljgHMTHbWVSveLXyyJk+KM4DJ5Mi9qSRnmH7Rur2jL8PD9ooW7uIka
	u3Shr7tlUnTQGaBDTWv2j0nn0rLg8M3oKv4MAfxYBukG94LZrqhkKZiWZ4HlXalaqLVW8GUyus2Fn
	+no+gTt8dz++UahsToU4dA0u8SYVj6SELhDF7xAJJST9HwAsde2VVDonOI45bgQ94s8K4j9nRe+j5
	rEG9rA1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxXq-00000007qup-36SZ;
	Fri, 01 May 2026 23:45:18 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxXo-00000007qtx-2O3V
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 23:45:17 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso1544498a91.0
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 16:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777679116; x=1778283916; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiUX46+NTllWWWm/iG69SeYyuO0SCDfaLB55TfAIGA0=;
        b=ku23Cs8ZzEjyKbOyYmg5QXLJ0bbPMXov0P+uzRVRkD/LbIaTMd/Zf9g7dmkrNZ7ARh
         R74MB2vq/iMo1YlCn6nuKwzBwKpHr7yUFBD3TrhtbB4r9D+EUzZ2pI36frVD4yKJ7MEP
         Uz256oQLCNKXUHaUJOkiudkBAoHgVYY8iOWYdY8CK3//XFxI/Bmf03YpNIYkbjglCAQy
         vPk6XEoFCXCoU+b1lpNDYJOLOllUoVYONhKpbXX2iCznuPQK+hIvy0wdLUG3LO/j5R1i
         fFdJv/4nNrapug4+6p/ofyuL5RpyAy4rbDMqbR7onEdPr9HTBHrTDJ1VH1h7q1M54YvD
         eK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777679116; x=1778283916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jiUX46+NTllWWWm/iG69SeYyuO0SCDfaLB55TfAIGA0=;
        b=BishellfuvGKhDqt26osVwWx2Zw+F+CvBxNvtURndHL+aQCxC5Wzwo7RKKlCuCz+JH
         bdlCkDvnyO7J7gqp382fSCBptGrd8zpfYLm792hxpyKzrwCROOvyJkWxn6nUNKUAgOsG
         TmEfFgLBZN6SONkkICvjlVUW417dhWozA9wnvFU2pYzFfh7MNFMqesQKrho1WqF0Cuuu
         PR0FdzhbHnCJvhjPbirmI4rvXBIMP1gStSeLnzbs9E3xZTvEQ/kU16Rko+Sb6jdYdKPD
         M9TvkSZkagE8tnew1gZ8KPC/qs0fiT+kxcEOS2zUst2ylu0ooyIehAqdUC0L9ijM93Rh
         li7A==
X-Gm-Message-State: AOJu0YyXwQTcvHlD9OHJgIFEl4EEW7Z4sUQ9VCeGU9LTn6VHsVMk/eHX
	pnzLqz+Zqiwy67Vef2BBgkhz8rKOwU70G9TyAsLG0SZaoT/pe+OpLoiB+3SmU2ad4jlx1w==
X-Gm-Gg: AeBDiev4sW2ruLmCJ3AsZT6xFQP7kan9SRvNrrEEiOB7NcPMuFiRpBRlVSl7SlvNzOA
	5Q4XpbnGKBQ2del0Xdv7ut+6kD7aOlyq2jROtr7V1FZsGeGvqyaOn0SJ268MgTK7hftL2salde0
	yM22FHKS8OvJ5dQaGa6/IDEJm5jwfUDcjc8D8/97Rt1eMs0EZN7XlqpdKv/AqdDBViUpwSdGHzD
	WRKGWdC6o6ADird1oZjZAJv5RcDX4zyqHC3KuwgXtu4RMlDXBe4ikr1DTExwrPGsL8FbaKqX5lj
	bH3h9p6OlbjTe8sywzELqUYw1YRQ2c6NpIYYOdVuEoMc8bjMlWJyOmER6UDbZ4+V531VCaBZ221
	3qBUy6btlvXRLbPcqr/i2YnBQ1FsCUpRQ7mhXG0F92hnYbz1TJfziBQj3sUs0bkd8XPnEtDGTGf
	Bk/W1qR92vXoN2n4fPwGf0N1Y2FpZSj6GSS/LwozpQ
X-Received: by 2002:a17:90a:d2c7:b0:35c:29ba:bf92 with SMTP id 98e67ed59e1d1-3650ccefbebmr1107684a91.5.1777679115612;
        Fri, 01 May 2026 16:45:15 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f3c5b75bsm1386232a91.0.2026.05.01.16.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:45:14 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Coiby Xu <coxu@redhat.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 9/9] Documentation: kdump: Add arm64 and ppc64le to encrypted dump target support list
Date: Sat,  2 May 2026 07:43:38 +0800
Message-ID: <20260501234342.2518281-10-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501234342.2518281-1-coiby.xu@gmail.com>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_164516_608915_C2EEC60F 
X-CRM114-Status: GOOD (  11.37  )
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

The encrypted dump target support is now extended to arm64 and ppc64le.

Fixes: e3a84be1ec2f ("arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel")
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 Documentation/admin-guide/kdump/kdump.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 73f2e9500c60..8708ef394212 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -572,8 +572,8 @@ Write the dump file to encrypted disk volume
 ============================================
 
 CONFIG_CRASH_DM_CRYPT can be enabled to support saving the dump file to an
-encrypted disk volume (only x86_64 supported for now). User space can interact
-with /sys/kernel/config/crash_dm_crypt_keys for setup,
+encrypted disk volume (only x86_64, arm64, ppc64le supported for now). User
+space can interact with /sys/kernel/config/crash_dm_crypt_keys for setup,
 
 1. Tell the first kernel what logon keys are needed to unlock the disk volumes,
     # Add key #1
-- 
2.54.0


