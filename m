Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D155ACD98F2
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3NnqtfMpo6SzkdI4Y/HSdjjWo3N5TymmoO6c1c+A8Gw=; b=Khr6Vaon4wb+BBI6y1g/k+siuZ
	uvASB1Key8BHZ8rvnntZrrTt+mMDlaO5rmBs1F4YfPFZi2CvoP8dVCUDt0fk4WYdBzGwxEYIkm2OM
	fI4eyJ/Kf9dIp8oavJ/+cpeOl9JKL8SYooHTazjm9zTLuYycTPdk/XzjBpcqBqmdhU/vCDZqqY6EB
	ErgRm4iGPdabePacPlcpK4zbG+NIPXpt9CaNANIajMMz8ccaF6xYrWPM2/2xBorGJWv8veDy+aMPY
	Sp0KD6wsROTZYQmw8YxfdrR17L8WoZUkNPAdHhLXYk5rw5dVKEN0tzyy5iU972sT+5BOFZaMjNAA/
	gg74+BIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjhi-00000005JH2-2eLS;
	Mon, 22 Jun 2026 18:49:06 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjhg-00000005JFh-2aS2
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 18:49:05 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-bf481a6e4e6so524557166b.3
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154142; x=1782758942; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NnqtfMpo6SzkdI4Y/HSdjjWo3N5TymmoO6c1c+A8Gw=;
        b=fevgS2C6lctM3jBXiFbnvhBKN//FozzL/zemOAmZKXY2UAcbzV0R+SurCcbnCmEpLD
         iwsx4Y0AK4MOvivkEnxQTGxV7jLfLy9zxT4QgQ22EpKXGkoiS1713mvLjYuVA3StBV3c
         tt6zxhh9gAbfNFNRGtBHURIPq0MMXHR61RXcG743AyIbrrvtuUc+S46yttASWLlgAtuZ
         TaYH/5yA375SElrtEYXpg1YiFK9zQ/gaPPYYyQeA+WskGeZAbvCNSsuA0RYvGu/jWRnv
         ulsc7xboKA7sIcGmqa+7MS2CzB/Ku+IJekfwaHgMntR3DV8nbNdTfXjaVPAklxOMeRxm
         TqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154142; x=1782758942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NnqtfMpo6SzkdI4Y/HSdjjWo3N5TymmoO6c1c+A8Gw=;
        b=el9Dw800359MNU0PDRcZObvbuDiKsisakv1HXCKZd7C/jyrNMLZflNgMGBfD4+1Z2r
         izncpAbPQjlfhz07FFvMEoUCNC/NNN9lj1Cc5Cui/l81tWfkaYcCjX3iEn6MmQxqgHMr
         RatfGMKdQx/bUJ/dI3IRbqja0EvosKVn59a8AGrGysKVHn8a0nKIQDAompuElIuZyTb/
         hCoLFUJcpvgXlEIWxMQdoHNuA0rZqcmWpN2yYl9kwljLGjbkwG3fcutbEE6DGLZBtiUY
         NazKDz1Ghk3x+yYtwCLyoNk0YZ37UiYCe/r+ym18vdiliKNLV66/4R87ZZaqx79dzbSv
         C5bA==
X-Forwarded-Encrypted: i=1; AFNElJ9sd52j33cS2l8Bb+zMIqVPl9Roztb/Wm7/oCsinlnWq+Ov2Z88r+FuqixCs03wTGpdHEJ8Uw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyd6bq9USgsRRKDjTH0v3XvrICEj0UH+0KXPIcVK8JWmCby3BlX
	FPKNN1WpllQozGbtMwYlhizTQ/4rkD0mrebNXUCSzvRT9qJvGExFEyqvcKwdib+4qtf3tDUmguR
	jQhelgy2LP4Lb6rMeGw==
X-Received: from edh3.prod.google.com ([2002:a05:6402:5043:b0:697:8dab:813a])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3548:b0:695:837d:529f with SMTP id 4fb4d7f45d1cf-696e5221662mr7941415a12.20.1782154141503;
 Mon, 22 Jun 2026 11:49:01 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:43 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-2-tarunsahu@google.com>
Subject: [PATCH v3 1/9] liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_114904_658827_0FE9E1B3 
X-CRM114-Status: UNSURE (   9.13  )
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

Introduce the LIVEUPDATE_GUEST_MEMFD Kconfig option. This option
enables live update support for KVM guest_memfd files, enabling
guest_memfd-backed memory preservation across kernel upgrades.

Currently this support only guest_memfd files that are full-shared
and pre-faulted.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 kernel/liveupdate/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index c13af38..2490f9a 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -86,4 +86,19 @@ config LIVEUPDATE_MEMFD
 
 	  If unsure, say N.
 
+config LIVEUPDATE_GUEST_MEMFD
+	bool "Live update support for guest_memfd"
+	depends on LIVEUPDATE
+	depends on KVM_GUEST_MEMFD
+	default LIVEUPDATE
+	help
+	  Enable live update support for KVM guest_memfd files. This allows
+	  preserving VM Memory backed by guest_memfd file across kernel live
+	  updates.
+
+	  This can only be used for the guest_memfd that are fully-shared
+	  and pre-faulted.
+
+	  If unsure, say N.
+
 endmenu
-- 
2.55.0.rc0.786.g65d90a0328-goog


