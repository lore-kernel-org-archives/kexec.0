Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C5DCE8D4F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oAQesQhs6e+PTptufLvrkGE1DQZP/NgJYpEOzUVqdGc=; b=Cg+BxPY1lED2335ov4Xzu36WPU
	B0WZUxohMcV7B5bU9U27Q2hxzMV8Rhwtpmql+x2a+QVfGZzCeRFXFXtax41HFP661vM/026i6MWMz
	gQ5290BoZRErbN0+MhqdrSLvspuqElI5lgOv08VpWJzfADYwzhpjXhWMedow1XA36Nw+bhfr23Fm0
	M9YCCzuCQjm5R4x7K8Fy7fsbBQYqpwHw0UFIKzHPNSJfGAhdYXsxvEN3XTLHgQWjVuhmw4AjdAhEM
	TVOpfiEGQyu/yERyOt5M9C8EFtaO9iNDE82EUKTFAS5Ooo6WvPgt/2Ns8SsQd+k3oSSNTw85MGygn
	YNN6j3wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7v-0000000Ccu1-3Zm4;
	Fri, 14 Nov 2025 15:54:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7s-0000000CcqF-1xcp
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 15:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=oAQesQhs6e+PTptufLvrkGE1DQZP/NgJYpEOzUVqdGc=; b=F28APjQVcfrwq1It7k85UjxTOM
	pxaYLyRS+rmj4tSVrqyWTe5h3skmJXckofRbKlS24IbQJ09uMCt5GFfZ/dZ3Da25sqzwyN60z6gLS
	9zAtWfyRvgHM8Yv5q5g/M2Hc7pZTyRIHn5WrhTfX7jQ+/cnYC2kJVVgGYEZfyipnLWd4WKffVrFkn
	0mGPw2UuRX47T0yEDBJWzzjy1AL7qjRzVZIsm8wQC330M28ScCIgM2USpdDa9PXixzoW0MAUHmx4A
	vIbSygV/Js11qWW3QUU57wcqFDi2OKHqv6YNuLSU67BYrSuX32uiUkkTwz+M48zRQwVUjHmPgM9d9
	/v8Grrnw==;
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJvGA-00000002tBe-0DjL
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 14:58:48 +0000
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-63fc6115d65so2074819d50.0
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135651; x=1763740451; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAQesQhs6e+PTptufLvrkGE1DQZP/NgJYpEOzUVqdGc=;
        b=THsCCtZiX3+FDEH4XQzvciJAvuUzxE32i8KSV99QgThe8qSoWDCc+eWsjtvcLhBk4G
         WaqNNOgO1s6X1YcAnG6+O+TvAkMqdepgl5S6xMTYSSpoxPhkdbznS9NNFi/vbXrBa49w
         atjAEEdimtsnXfYGoNgmtbpqbIMXggrwnvtnA3RaHzfRIut4rsxWC0SZTwCQOIQesAJD
         Qr4mzUkMiEZeWLSHlmCK4y9aOmyU36m4kxSFeNtiw4f7b7T0L5w4Cv4KmhY4fBN6zUyX
         2s14afqfh5PEnxvkkVujXahrkcU/BH7bzhYWViuJLmuQBHX89g9m37Sq3NQw31cK7Wo4
         YfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135651; x=1763740451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oAQesQhs6e+PTptufLvrkGE1DQZP/NgJYpEOzUVqdGc=;
        b=r3j2bjAVqgAyrR6A+/NZ1cZkRBUjFTeU9rw5LwaKS17Mw9Ou8UdQU9/miNgshntRuE
         wLOty8XoH+WhwNEg6uWjta5Gou1rUtYEjGyIdkGzh1si6souj5qSsHo64JDO7fBzVYqm
         j6Ey3MHuFw8wiTzFDGP1Ku2Oxpa5TnKrbgQZws3tco0ojapJf0/FURzXsoscxaZ0LEVB
         LsP/D4TcPlfmmOUiy3O/g2p2rGbUJEirEphxtKgXmPrUzvx4GpGwuVbEN+nf4iGrId/E
         /h+YC1v3JVVpwrF3JSvgvv4YzbqTbOknmux2XDCVP5opuqNFWXlw82LddHzwGR4QhAhy
         ksuA==
X-Forwarded-Encrypted: i=1; AJvYcCVmM8/wX9ibELHgzrTBP5Wo7auxjKEmFxIJX6XrAFAJFMiE9xR9lL9UgOVnevIoOoRhiYqP5A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7vK1JcvZhJXQ9P7C86wTeiXp28A6wZAdoqTPZBnZJxcU0i4KN
	7plojDHYccdFusmgQRl7bu1D/yd8Ouv4zdHjaFBttsIoBiQNNa7ixNkDZAXzJCbHBIo=
X-Gm-Gg: ASbGncuKGJ1LeKaagAXDFb/cwKX7mX20a1CCeZrqk7KSIoMeXnqYH1eE6Rh5xbaxPvW
	RZLs4LcplvhFsLv9igs1ETeuaG2sRZREb6yZjtyzjrbakxWjoU7Q+miU9POun8V3LxG548/pOeu
	DxBKd+IXdb+ANprF6xsMSA9ZNWSVf3KXFW6GHKrXxbUcuK27xiUNO5J356zf0xFXfBLjEHPPHtU
	CIW8fPpZY2CJD+LBZDd0p6cMX47J2TX3+gByTLz+uzHXahZUMw+v3o4BmkSWWj1mP7Dic8cv2wx
	gRy39AHKNKXRPNBif6hiSu1k9bBekam0RhLjb+L0Exk0Uml48utbN6GuggF9Jr3zhh1Gq5/A/Od
	UrxgysOg9HI5rLoBQgoswAC3obO1uqOY1Cjc7ZSfaHI9wYN3xCzUPyRV4qHW1ziCkcz5ukRpWV0
	ogWGOcq9C5PuZzpdKKWpTJw+TA+GLW4c6/s8jjcvz+Phn35LkahsE5gnKZ/XQy1xL9giFHDFCRS
	a3nLt4=
X-Google-Smtp-Source: AGHT+IGlvukkElqwWxXv7Gpk1y3f7JDTm4WbhlGwLIf1Tn2iiPc/ZeTFQ6+QGmg6hTPSZZWz9TZhAg==
X-Received: by 2002:a53:d013:0:b0:63f:b952:dfef with SMTP id 956f58d0204a3-641e7280bb1mr3380829d50.0.1763135650981;
        Fri, 14 Nov 2025 07:54:10 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:10 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v1 08/13] kho: Remove abort functionality and support state refresh
Date: Fri, 14 Nov 2025 10:53:53 -0500
Message-ID: <20251114155358.2884014-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_145846_152223_A66338D9 
X-CRM114-Status: GOOD (  14.54  )
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

Previously, KHO required a dedicated kho_abort() function to clean up
state before kho_finalize() could be called again. This was necessary
to handle complex unwind paths when using notifiers.

With the shift to direct memory preservation, the explicit abort step
is no longer strictly necessary.

Remove kho_abort() and refactor kho_finalize() to handle re-entry.
If kho_finalize() is called while KHO is already finalized, it will
now automatically clean up the previous memory map and state before
generating a new one. This allows the KHO state to be updated/refreshed
simply by triggering finalize again.

Update debugfs to return -EINVAL if userspace attempts to write 0 to
the finalize attribute, as explicit abort is no longer supported.

Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c          | 21 ++++-----------------
 kernel/liveupdate/kexec_handover_debugfs.c  |  2 +-
 kernel/liveupdate/kexec_handover_internal.h |  1 -
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index f1c3dd1ef680..8ab77cb85ca9 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1145,21 +1145,6 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 }
 EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
-int kho_abort(void)
-{
-	if (!kho_enable)
-		return -EOPNOTSUPP;
-
-	guard(mutex)(&kho_out.lock);
-	if (!kho_out.finalized)
-		return -ENOENT;
-
-	kho_update_memory_map(NULL);
-	kho_out.finalized = false;
-
-	return 0;
-}
-
 static int __kho_finalize(void)
 {
 	void *root = kho_out.fdt;
@@ -1210,8 +1195,10 @@ int kho_finalize(void)
 		return -EOPNOTSUPP;
 
 	guard(mutex)(&kho_out.lock);
-	if (kho_out.finalized)
-		return -EEXIST;
+	if (kho_out.finalized) {
+		kho_update_memory_map(NULL);
+		kho_out.finalized = false;
+	}
 
 	ret = __kho_finalize();
 	if (ret)
diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index ac739d25094d..2abbf62ba942 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -87,7 +87,7 @@ static int kho_out_finalize_set(void *data, u64 val)
 	if (val)
 		return kho_finalize();
 	else
-		return kho_abort();
+		return -EINVAL;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(kho_out_finalize_fops, kho_out_finalize_get,
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index 52ed73659fe6..0202c85ad14f 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -24,7 +24,6 @@ extern unsigned int kho_scratch_cnt;
 
 bool kho_finalized(void);
 int kho_finalize(void);
-int kho_abort(void);
 
 #ifdef CONFIG_KEXEC_HANDOVER_DEBUGFS
 int kho_debugfs_init(void);
-- 
2.52.0.rc1.455.g30608eb744-goog


