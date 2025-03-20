Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DF4C36000
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xP/wBPgQrPgKUTmsFzSczlOv6V7nkKEHtL+ADvSLveg=; b=Fkt+/IUnlmd5OVsHFW7F2Mk3X0
	bm2L0cvsLcU0rKeKYjkZSolJO09RsHbELYQ8M7vZH1k2up8lGIoBqyGekxkiz3vXM9XRilNv3wt+3
	/Jzi+XBtyaKCIf6xFtBXVU7kdEszelLuPAfLqyhABcMbM6KHAQYjGLV4mRCTkjptDl/oHUR3fwX+j
	xQpI6lny4b9lxW+IYSOdeG5cDeJD6QOhaN4/dRNk8f8aJmsmu4LyKKJUO65XGr2ix5a/p/HbD3ipr
	SzoKk30Yt5gIIzvEweARmIfE20P2VsxBhigw4r3DQs1o3Cn8IY4K6o/e/TlPG64G4IrukF6rh7RLn
	/DzYLt5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvPLW-0000000DSmi-3VH6;
	Thu, 20 Mar 2025 23:30:42 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvPLU-0000000DSll-2I5L
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 23:30:41 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2ff799be8f5so2253518a91.1
        for <kexec@lists.infradead.org>; Thu, 20 Mar 2025 16:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742513439; x=1743118239; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xP/wBPgQrPgKUTmsFzSczlOv6V7nkKEHtL+ADvSLveg=;
        b=Cs4qAcKrAhY+MCtKGv7AgkFXi0UK/y0p7r3Kl3MG33+SMkRONMXp56IEzGjOtRjh7O
         2Qi/tMHRMGS1URar59Zt5yT09R4ped+gMKglgdj71gS4+dNlsUf8vT2j0bk57eDwvRva
         icnKD1i+A+UEUmOCKceB2KyXGRSocnnaJKb+mrURnl7coac2XMSCSKXwZy85LKfO1M9o
         eXca+lSgo04MrnNOUO2UYJ6oUMoHqhLjRoA11g3p0Tm7/fNPD3xVcFpNM0lWA/GnyjjF
         iEuuGZwXwnUwaDu87Zo9jf6YS4TXl21/idbikXHbtmnZqDqNQF03r79sUrR+Vsi8f9YR
         oZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513439; x=1743118239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xP/wBPgQrPgKUTmsFzSczlOv6V7nkKEHtL+ADvSLveg=;
        b=aSOjliZDvbJkFEM5NX4odT0pb/lID9cU6GJRWlyOXSa9LgshrgvOKQKZy6m/EfXVYk
         5OxcgjMw5cyk1Wp+VaGODrK+paM5eRhFGzoeI8kM2Y7T4eU+37ii7Q40xRmMlfb7l7au
         flo+vG7Wh8Bo8A/pxK/E/yqo3aaFYz/9CEw6tVmiS9ROMsmZ4KiBusv7nC1XtF27Hs2e
         ykIrIRpwWSLCesbJzfRVVIOhXYk67gGw6HomXlseOsgP1XEdEYvwt4/Ewb/k1IJjhHy9
         ZfIWLwp+pTT+hIjZRzNGIcxHuP1qOrUl9+0dhStJWVhV5AlTsXM9JiDYOJTrFL0BFSTu
         Jqiw==
X-Forwarded-Encrypted: i=1; AJvYcCWdHRmi39LiYBYT+6sbZyuKDTzZ+9MoMG0+9sBzTLZCVN9ZAMa7NTSkxpei47RSrS+EfLS1Ag==@lists.infradead.org
X-Gm-Message-State: AOJu0YyaY5ZfeifZcBsUM/gPwNX/LnHHqwO2gwINftM6kTOwGlBTssSo
	7or02l2ch+7Yrc5tAOAXceQDkCiKT2/R1ausjgbDe4hZPn6Og/NcnuB5MZrK8u9upmYBzAr+Job
	zljTy4wFUsf0biNjrCg==
X-Google-Smtp-Source: AGHT+IGbmtH1MERfzGXAl5vYkqkNbYTkv2EXQg2sVuptsp1X//5UG00UaPWxnKS/ywcODQ4038/Q7eALZzjdmIbU
X-Received: from pjbpw15.prod.google.com ([2002:a17:90b:278f:b0:2fc:11a0:c549])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:384c:b0:2fe:7fea:ca34 with SMTP id 98e67ed59e1d1-3030fefe329mr1442133a91.32.1742513439279;
 Thu, 20 Mar 2025 16:30:39 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:29:56 -0700
In-Reply-To: <55a5e3f3-1b3f-469b-bde0-69abfff826e4@kernel.org>
Mime-Version: 1.0
References: <55a5e3f3-1b3f-469b-bde0-69abfff826e4@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250320232956.327827-1-changyuanl@google.com>
Subject: Re: [PATCH v5 12/16] arm64: add KHO support
From: Changyuan Lyu <changyuanl@google.com>
To: krzk@kernel.org
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, changyuanl@google.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org, dwmw2@infradead.org, 
	ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	rppt@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_163040_580418_BE8F5A0B 
X-CRM114-Status: GOOD (  11.34  )
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

Hi, Krzysztof

On Thu, Mar 20, 2025 at 08:13:24 +0100, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 20/03/2025 02:55, Changyuan Lyu wrote:
> >
> > +/**
> > + * early_init_dt_check_kho - Decode info required for kexec handover from DT
> > + */
> > +static void __init early_init_dt_check_kho(void)
> > +{
> > +	unsigned long node = chosen_node_offset;
> > +	u64 kho_start, scratch_start, scratch_size;
> > +	const __be32 *p;
> > +	int l;
> > +
> > +	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER) || (long)node < 0)
> > +		return;
> > +
> > +	p = of_get_flat_dt_prop(node, "linux,kho-fdt", &l);
>
>
> You are adding undocumented ABI for OF properties. That's not what was
> explained last time.

Thanks for the reminder! Sorry I missed [1].
I drafted a PR to add the documentation:
https://github.com/devicetree-org/dt-schema/pull/158 .

[1] https://lore.kernel.org/all/b1e59928-b2f4-47d4-87b8-424234c52f8d@kernel.org/

Best,
Changyuan

