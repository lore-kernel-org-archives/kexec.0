Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A33CD6E55
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yVlCXZe8SHDSOJUkKVBaYBikNvs5G4Pkl6SfmcOaAr0=; b=qn5781Fv/GJNVvvXBes5qVm6dG
	yIRi9ETrwe9H2hd56x5ikG1/WRhbVyEp/YU6FQCV0/aG3REEbqR+GQueqsgvETB9wWMQbBo/+3WLZ
	0MfonigJirffqwpyc19uEDg4msnM+DsYfJBfAmPv/CDtE2DiqgAeyKOxFXUXz85JTk0ixx+O7zfgT
	eUAo3HmsfIlwHWttogrr4Py/6P3fvM78xhRLFHPUwOp7csw8sLS7fr/s8IDguk+k+0znnt1f4ceJf
	PvxOmJPHYAIu0YnnqvlOdxUNvayr6wbDNmnjP2rKoL5JDrzISKZmdKJoUnzjEPzENl94v44mW6+bv
	4lY7E3iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcI4-0000000EAt5-3s6U;
	Wed, 03 Jun 2026 03:29:12 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcI2-0000000EAs0-0Jid
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:29:11 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-8ce9df31840so25831876d6.1
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457349; x=1781062149; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVlCXZe8SHDSOJUkKVBaYBikNvs5G4Pkl6SfmcOaAr0=;
        b=I7ctJhQOvWg7VEMacWCvuMwiuP2Kxed/VV6gt4smLnIuECkbjrmi8pW0/HotZlRsX/
         Lzvy0zoUrT1/rB7cqDpHCRj+aKpw/NfaxoA6B2avPBuRHOZ8AUsnT8HMOc6ss1q4+/xd
         7gVqe8BZbTpKSqvM77WcVe7kcIhmcw3BQRCjPHktfGvX63Z04644Q1su7md5e1sqwds9
         74cMrK/ZsELRTIGFNczKnyG3INqDeC7kFCrDlkSj4qxOe6zJ3E1ZtwS6LP0p8kSFVzFd
         73O95k3elNtscL6QqAcpzCjtHHxunH44HSQQf2pVNCRnlGBJejdJKVhmpmwkK4/PvQLT
         tZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457349; x=1781062149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yVlCXZe8SHDSOJUkKVBaYBikNvs5G4Pkl6SfmcOaAr0=;
        b=V0CdbQEO7kmC5KXr0Wn97lX2kLRznhY9IGAHYiobTx4Yz4hRaVarFay8nL5HgKE2Zo
         P3rJ5R1g8phORV5Huml2Exlt54bJxGslGd1IYHjDq6u7ZBkfQE6JV4v3zWbAbznS8MJP
         KHXKXp+An+AiCkBGOA+SaNS6bgfGhnFTiXkpV1eeq0EMDqGGO8F8t1sG90rmZqkr3aCO
         57jHPkOISrPzG7GPrK+eD5Gh3BCS+DBH58l5ZYrVKAUafo3Rt2Aw9bjTzzlBR/nFrzDA
         7Ma1zdMUv7gbIG7YBiaaVCkTY55pzc9ADmQ6/iOzA4/5b4+QP67KKFe5PTs0F4GC9OuK
         4ciA==
X-Forwarded-Encrypted: i=1; AFNElJ/9PwiK16xoRuWIzC3TFHB4X03YuS1S4EJrLEwQXkYcyqksyk2yDUwtLnhvLG1Y+1PdxEoZug==@lists.infradead.org
X-Gm-Message-State: AOJu0YzT5+v63+DHTQqiv3SaxLGB7IMJe3CYvdzxbAN1UbKFHyGEls7i
	tfxYNHEWc7QwCyXoLidPc4y7SpOG0YSGpAWLenPVlk47xwruixJHflTTsgBoStzIyzo=
X-Gm-Gg: Acq92OEB6cBTYuwX2Om8oxUwWrvbjTwPwVZteE1z2qfFqWGPt360ARw84OAmEJdQSTs
	l9xFtMGVxlFWuX7P8V8zQTeXeug4druPDLwNeHoMWLhl2YIMiItXKVlMZHlO/o8LCJAYMNfn9Uf
	Xx2fWe8nzxG24zh2zlsrZuO5s82i1KMSoQwOqqTcoDhTQOoahOqOGVuMNrrgKZucpX6bskxF7B+
	fPi9uXbAeoUr2f7eOu1cNxeE76EMxrciCw1afkCM0rydQ85V70f1K3w2Qxu1LmsTptnMgasB9zl
	Qwav23c1H97lI3tYf1pxzkglcpr4Sn6cYmgpcKoIc30Q7/hgfqW7MS7gBpBLI8akJC0XtPJeAhT
	o7WmKVC5lP+e8BGsf6IhcP7v6EZUx/oUqHd72s8Zg2jl4CzP5T1hOWeJU3RFNPyPsa0nIEvjqSE
	9HyvEuw3abjx3DHwJ/gQDoc4pYGFO37QeLIO5DTzO1p7ZWo2oOUzxr6DbEbFT3FQ==
X-Received: by 2002:a0c:f09c:0:b0:8cc:dfa6:3333 with SMTP id 6a1803df08f44-8cece028a1amr19783726d6.32.1780457348680;
        Tue, 02 Jun 2026 20:29:08 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm9244566d6.45.2026.06.02.20.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:29:08 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v6 01/13] liveupdate: change file_set->count type to u64 for type safety
Date: Wed,  3 Jun 2026 03:28:52 +0000
Message-ID: <20260603032905.344462-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603032905.344462-1-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_202910_137498_AFD73DC1 
X-CRM114-Status: UNSURE (   9.98  )
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

This improves type safety and aligns the in-memory file_set->count with
the serialized count type. It avoids potential truncation or sign
conversion mismatch issues.

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dd53d4a7277e..ae58206f14ac 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -52,7 +52,7 @@ static inline int luo_ucmd_respond(struct luo_ucmd *ucmd,
 struct luo_file_set {
 	struct list_head files_list;
 	struct luo_file_ser *files;
-	long count;
+	u64 count;
 };
 
 /**
-- 
2.53.0


