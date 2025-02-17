Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA81DC021A6
	for <kexec@archiver.kernel.org>; Mon, 17 Feb 2025 04:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/V2mmoCanQT/pwcWtV0/o0PvfX4+qGd2AcVlqml8A+o=; b=MOjbQDkAUjZc4P6fc1beXFz+RZ
	IvhO8hx91C+i6DArfAq+oT53m2tqL49RwvCw+tUjgRJVdSrBHd4JHw3xKwNO9FlboEHqawpsGr9FP
	x+ghCsAMy1SjUZ7UitfDp9JIR/7cm7p1Xhju5ivWrJ5hsBV6ICFsG8VxQTtr4713Wv7zmJzoue/YW
	mdklZ2aT4XiwDydAEDr/c1IO5J6qTKhJW2tEOHTJytXfvqI52UgQmsE9D86Am3Oolb4OL2m6u/7mF
	It6Vnv7od+oViVGw2L5pCitWUXNTAbTCyYNob2iFqyhmO80gHye/0Eu5s1aPm16z6hESI7f2za+gF
	ifMvL/fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjsNL-00000003BWJ-2Rfd;
	Mon, 17 Feb 2025 04:04:55 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjsNJ-00000003BVm-0tmf;
	Mon, 17 Feb 2025 04:04:54 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-aba868c6e88so360774666b.2;
        Sun, 16 Feb 2025 20:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739765091; x=1740369891; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/V2mmoCanQT/pwcWtV0/o0PvfX4+qGd2AcVlqml8A+o=;
        b=YghMIsSrPG7ZgZGUMwKMHXvUM+d81IT6DyEqTm2vOSsEFIq4vXAchDw+La9bH3PzYz
         tqeNxam2+ohJ9fMl6bAgxJnfAWJ8sNV0ERPacI9+a5WtNYPPfw+7q/Tfzn0ABBg+AZOm
         zvI9IOS1/d8ZIc3pgL218OqXK0eAobHlAjCC1rQHtuAARJ5IMouKihxVViBXhJS4Vuuk
         3sxY50qYKH0Z9IstfZrIxF0vlFTla+GKBVWZSjUj1yVfBg8DvQgIdFJpXD7sbLo8sCgx
         BxaSLcFkiGqWG+s21GqjAA1J4Bc154c+SQn9nklhImuoNZb+oE8kAjDuacnnj1fW+o9A
         024g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739765091; x=1740369891;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/V2mmoCanQT/pwcWtV0/o0PvfX4+qGd2AcVlqml8A+o=;
        b=FhSkeHizbJZUfEQ/Jooa4g17mtVes1rj1GJgWWNu66Pohc46nLAzFIJq16ntfuXoOT
         wxAoMg/UeHuYLtUlXBWUPfEfzo5UDJNQK4VCD0uLd/Q12Q+8aHkj5eywgvPUJH10hFuB
         tgHHNqtexRinVKxe149thQvh4LsXFwFzQtynxZL3mlqwUYJiFR07I5z8SZ4ZSIRQBS3b
         DBbwwergF+uAo2mH0K2vXqb7KfMuL2jrvglXDJlm+6MIiA2OKY4bbSRN2riyYe2W0pPW
         GXsBXKt2EnsEH9hQCB2xTaOQLYd0ZORVzypQnJR+u768gBFzLsBMF8cgFYjEvHaA72+d
         pTNg==
X-Forwarded-Encrypted: i=1; AJvYcCX7z2rlyqg5IBQr9tqoi6NT2ClguuKGOcN/95KnpKczyVvRPXGvjl5i//Ymk4c3g5frgHvlOQ==@lists.infradead.org, AJvYcCXE1dBtZq1QJS0fDJRbT85C791WJL3VyT5KdDtY7MLkvsUvoQbZGKYDFXr5zczWACnT0ctighOGeTeKnxeQ5d5sFw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxHUv6Yo+H7TPFf5b1Vo8QN+dpyRGPnIkvPy8vms5yGJVQEXG9f
	JCC5tYIZlC7McugAs6YCs1CCLfqBFnl1/JLzactG045jkW5HqQbb
X-Gm-Gg: ASbGnctFulvcIGl6EKXUVNeI04hel1mobAwNNl6dTNN/bl0m9yPW0LwJUjoXqh41GVc
	zEzltv3ONAhh0c4qWRcSKdUUUXXU7SOxCUiaW84NJUcHsHG2C702SeY0YGj/dpMX3ieNez3zeWr
	zZ/LGUr4RqKPBzXMbHtRqVJKZvQUg1ZC7fjbvwJC9eEonl6HNWlLthoFba3ajkAFYx3MKGFQkTE
	cnePhc8XRoIpTQLaDcOFQi9WflOFRjkJvop4NJoB/VVtRYtjUMKCMQZex3toErVkmdCq/WsBjxB
	+WK+pDhHTDSoVpo=
X-Google-Smtp-Source: AGHT+IGMLRPGsc1YpdO8muFNdeSP2zhH8Ioro7wmde7M2ghBjV9zkhB7Y03DXnpBI6WgZUsZLU2s/w==
X-Received: by 2002:a17:907:2da0:b0:ab7:c4db:a044 with SMTP id a640c23a62f3a-abb70a7a647mr781879666b.8.1739765090766;
        Sun, 16 Feb 2025 20:04:50 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323202dsm806661766b.6.2025.02.16.20.04.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Feb 2025 20:04:49 -0800 (PST)
Date: Mon, 17 Feb 2025 04:04:48 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 13/14] memblock: Add KHO support for reserve_mem
Message-ID: <20250217040448.56xejbvsr2a73h4c@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-14-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-14-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_200453_255009_223863AD 
X-CRM114-Status: GOOD (  18.76  )
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Feb 06, 2025 at 03:27:53PM +0200, Mike Rapoport wrote:
>From: Alexander Graf <graf@amazon.com>
>
>Linux has recently gained support for "reserve_mem": A mechanism to
>allocate a region of memory early enough in boot that we can cross our
>fingers and hope it stays at the same location during most boots, so we
>can store for example ftrace buffers into it.
>
>Thanks to KASLR, we can never be really sure that "reserve_mem"
>allocations are static across kexec. Let's teach it KHO awareness so
>that it serializes its reservations on kexec exit and deserializes them
>again on boot, preserving the exact same mapping across kexec.
>
>This is an example user for KHO in the KHO patch set to ensure we have
>at least one (not very controversial) user in the tree before extending
>KHO's use to more subsystems.
>
>Signed-off-by: Alexander Graf <graf@amazon.com>
>Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>---
> mm/memblock.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 131 insertions(+)
>
>diff --git a/mm/memblock.c b/mm/memblock.c
>index 84df96efca62..fdb08b60efc1 100644
>--- a/mm/memblock.c
>+++ b/mm/memblock.c
>@@ -16,6 +16,9 @@
> #include <linux/kmemleak.h>
> #include <linux/seq_file.h>
> #include <linux/memblock.h>
>+#include <linux/kexec_handover.h>

Looks this one breaks the memblock test in tools/testing/memblock.

memblock.c:19:10: fatal error: linux/kexec_handover.h: No such file or directory
   19 | #include <linux/kexec_handover.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~

>+#include <linux/kexec.h>
>+#include <linux/libfdt.h>
> 

-- 
Wei Yang
Help you, Help me

