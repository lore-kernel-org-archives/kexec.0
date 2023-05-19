Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9706BC77B7A
	for <kexec@archiver.kernel.org>; Fri, 19 May 2023 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Do76KXzAMoS+kZb8B+CxJQpbjAJWg3tiHLfQH9RmGAs=; b=wnATYLXR7mxdkR
	DerwqyJKmKJrjTiHe0GCJ4w4kA7oBoHbGg6L6JFloZVRFFOymjuxVaW41SGMMMAGdtx7N7uuRWMcm
	kBkejFkubihcqI/Rc+ChQ9rMn5ViO9sJycl1KgAUnAQ7UzEMx9QopBlFN4MMm720iaM1hpeGrH+DK
	AYOfkCX1qat7gYQaJdIwTbwogMFL4zmIuTQYtQ89tbTFfl8hIHA2XeBSB8BvZbTh+FX/Nd/Nw1u5o
	61Hzu+zdB1wfhEKg71fe5X9iYrVq8nO3khIKpBrly9+7wq+OtVbw3n1GgaPwucL0xv7hLPRoBXKpR
	3pYCOFLX2tH4zoy2u5VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q02DE-00GcZF-24;
	Fri, 19 May 2023 15:40:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q02DD-00GcYM-0Y
	for kexec@bombadil.infradead.org;
	Fri, 19 May 2023 15:40:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=BD6qB7twnufisotyY5nBfpaakG3WUms/sLLcs5/qPcg=; b=Ik2X3UC5o6Zt0DGk6J+P7j5tA1
	HPzpqTyz8SYmpEiaF7uvGXApcVPpkurEMU4C6SYTjo41LDkOkN32g4VbTZ5L1gipGwD459s3yG32f
	Sp9xBNw2MRS5aOdhnEv99OnxxrrgTfNDNa4uH0r40/yfrQAt+ueHBudYjdWyEvvRKasl17fBI600h
	unwcoYdxqpbkmhrYlHXc5gl8xlXj0rxlGJi1kAVGm5qFkFclDNJIgR8NAdlexJmiyckztoQhQ9xP5
	hgO7TKcgVfUZaGaDHNbuvWeWTmYxxYjF75/9aXAZU7t26oGbUyKFdJwQALnWD0k8L3SuaWRK0TOGe
	Yd23ojUA==;
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q01PA-00FvxT-2b
	for kexec@lists.infradead.org;
	Fri, 19 May 2023 14:48:30 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96f588bc322so181697666b.1
        for <kexec@lists.infradead.org>; Fri, 19 May 2023 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684507706; x=1687099706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BD6qB7twnufisotyY5nBfpaakG3WUms/sLLcs5/qPcg=;
        b=JDuBiVDj8o8HaMzkIB840oZkGv5wJJi7TNtUIrYqKhMie/96QidOGQDjQXE7b5+5S9
         tK8GWP5SEiIeHDVPjC3T2ENDFCeYqLi5SHh6A0hgK/rjIefTVUgKtRZiA8w7MSYtyRXh
         R0aHFCTNuZeLm/jFjl0vcQ1z/eRP+0aN//K8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507706; x=1687099706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD6qB7twnufisotyY5nBfpaakG3WUms/sLLcs5/qPcg=;
        b=JJ+yHhV3icBpe74a9wlXqG/Zj2ULnneIH/bVipGQmhR8pQ2GzcxG38Lk8o1aNLQdNw
         NIfHhPYmy2+ezrIMAMRhrDTRT6SJzq7n+gOlggZzAPFTAyfc5kUHyM+85YqHx7T5aYZ1
         fC8U4q1dEPp3Ta1fJ1rc+uXrzzBlBhEm8nTuJasgc34eg3ikc0tSAlH5a/ZNiF7dqGF3
         eNWNaIdW36/K8HXWlmq2ov2Pc93lOj7rIYO541PzmstMjArzji4p7JaR3v8d6h7blHtY
         yyWgg+2xH4Mv0CAH8Nc6cxKlmc7eiogEEiN774YHMAK4CZBDIUkD+2f4tUwir6xAoULn
         UJ2A==
X-Gm-Message-State: AC+VfDzigEi8LGBqCgh0Y9rb9hhDfTh7hmn4U7sSEUgwIQU/uFhT2TL6
	xtRYJNXU0OdKe8YcoOcnBTGVKg==
X-Google-Smtp-Source: ACHHUZ6OprUYGsS72ehmUtvrfFocAu2GyTDDqdde/uRgkGX7E/HjFZLPkMJjnA4KZkxfiwtIcIB0dw==
X-Received: by 2002:a17:907:1609:b0:94f:1c90:cb71 with SMTP id hb9-20020a170907160900b0094f1c90cb71mr2302378ejc.65.1684507706237;
        Fri, 19 May 2023 07:48:26 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:62fd:274b:c2ab:69bb])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090680c200b0096a68648329sm2349437ejx.214.2023.05.19.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:48:25 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 May 2023 16:47:37 +0200
Subject: [PATCH v7 2/4] x86/purgatory: Remove PGO flags
MIME-Version: 1.0
Message-Id: <20230321-kexec_clang16-v7-2-b05c520b7296@chromium.org>
References: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
In-Reply-To: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>, 
 Philipp Rudo <prudo@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ross Zwisler <zwisler@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Simon Horman <horms@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
 llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ZdKmKWLc9TEOfphmrnN/WwYYNZStN7R/TxB0+Zjd8HY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkZ4wxpLapFX/30sji37lAIaagKHpP8BO2TaX+/
 sJHabfFQk2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZGeMMQAKCRDRN9E+zzrE
 iBOhEACRW3xOCPLHp71KLmHTYNCd71GtWrKjkfxklAL33OghFmTvUpYrsF9LpYB/m7hEcL/ThHl
 hL85+iGqortM23o+IHkavb1dGe2lPjzhRrAlOP3VRhZdMb4Z30GB9soPtsVB1wTkIHAffgMXlXl
 OX9TTvAAdTwiK3QpxHsQTI7Zrwd7j4F5PLFwLvF1EJ5B9vHk24k8qUliTckaIUupc8s90pL+blD
 76ekelf8r6J/OuHnqjwfBNPIN+L5PKM1Qnvc+nhDbVClbug/NZoYEOQncnJUQzy4+pPlgWMhh1n
 jSBpPsZLhRFaaAvgOmnCFcJ4QK855FrYlgSZ62gNGa18oujDvo8M/P3rMJl+ZptFWkJHg4ftqjk
 d2p50qqwa36cAZSdv5xiIorPYJAvQcKnfbLTa/33NmhdJsRmYKEIBmzoJJMVV1WM2GQ1GoS3iqQ
 xsIbbnRtyfu5Oj+092A0UrmjBv44l9VFL0GioJ/h1dybPyj/xRudpeipiBI5UHl+PsrthS0eXyR
 BEhiiCDkPPQVspdv9HGVTw7RtC+jrD2P59F2ZJdHKAj43rczvbjLU1aFhLmXOsvEzExQ7jdyhrD
 dtwIMAsWCKWuA82FW3a1RMjpQzwZn57XSc6vVKzBJhtayoAZ/RnFP3+dNNhzAJAuESXOXu/+Yc9
 KoQnpw6oiVlAnVA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_154828_997717_25B28AFD 
X-CRM114-Status: GOOD (  10.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

If profile-guided optimization is enabled, the purgatory ends up with
multiple .text sections.
This is not supported by kexec and crashes the system.

Cc: stable@vger.kernel.org
Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 arch/x86/purgatory/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 82fec66d46d2..42abd6af1198 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -14,6 +14,11 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib

-- 
2.40.1.698.g37aff9b760-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
