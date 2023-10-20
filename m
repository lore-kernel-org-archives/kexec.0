Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357E4CDB474
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=LvsT7tVGlkL4pTj0IZzMZ1zbXfmzjILEVQIdywLBbWM=; b=5D1PGogzpbUkdL1TIHe1AjANDt
	6GIaG003FI5Jv+j0KwdlZHzRE7oXhbYcuEgYMtVLiIQGZzvS9EjWn9Bv24ME4bs5blnXk5ov1ByhX
	8/WrnGLfbtgbpHLNnrsCrMuyb2JgsZgTEyJyY1odMQmRwvbqT3KMCjh6fLML8JVGW5++xVsCf9m6a
	frCsZG9AnQgm7Jy9GTnPD2NOp6dWno0j7a2qguR6IuKliIlQcvVSqbDLnrNcNnEur5PuEQQKyzn0t
	5jqFDsEOY9EpEVLBa91sxUxOAPexc2kz1MKeNr2PgOCVmu8oQRnFlTFJU8uY9zdWt09N2Y53/xwSN
	Nm4A2vjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrTv-002c8Z-10;
	Fri, 20 Oct 2023 15:32:11 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrTs-002c82-1o
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 15:32:09 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c9d4e38f79so8013195ad.2
        for <kexec@lists.infradead.org>; Fri, 20 Oct 2023 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697815927; x=1698420727; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X28nqJeYL84cwkoy9Ukz+291k+i+3AkqmrCU0I6FmGI=;
        b=vojzkweGkKMcs9/Hx06iXJW7f+pW/Qqw7T1nk4Fhz5Ycv5kWbU7TdjIA0YV8i4yb9R
         ur/fLINSIl2r6c0XguKrYVDosBvzSJuEUv/909nxuFvXZO+qdSX7JhjOijbCKCzyBfq2
         1zuClAz7GPZpgfh9AAgMvkdip3nZ3TZZaloXgqqBLfiP/TeZLa83Tv2jhYW+mFuV3ttx
         G/8oXBSmjZ22eptXAXmxiIIxMK6Ev16SGiCQT98Nzm82rvQBVS1KnCSo4LqJVECkiWSa
         M88QGehxaK590LAkvoNulHlx42iekAYkxHPNoxb52sPy6QG4vNWZb/zEk5fIDzsWaEPN
         nmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815927; x=1698420727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X28nqJeYL84cwkoy9Ukz+291k+i+3AkqmrCU0I6FmGI=;
        b=uXa0kMVZAFBsbjBV9o1xi4hYnJ4DAlD1LssChGP0SWuyZwCOKuynrsOAqyF3kaE3Ov
         EUBv/L1UzVUCIAFjvzIEKkJWZF7im+WJ7OGUyENB6PGZcXHCvOG0XmTNIevn9TJVMDxF
         +nI8D57Bh168F4UBpksH6Me9A1jP2zFTYKDLnHr6V/95RcodLficx+msP7i7h0yKynco
         vt+Mq/bsiPISIk/Oygq3Zvl4amvchajMn75WNSf/M8lLf4lPsPhvrioiXbon3QVjgN1K
         lW4F4dKqqIX7kXVGCQL3roX7WGWcQ4kvCtQ/06WYvjMXALYRmmRrPtJw0cbqu+2PYdAN
         qj9Q==
X-Gm-Message-State: AOJu0YzyvGApa2V2onH+gQC9i0gG0eJYwxgcCaoYbOSvNDNhJzq0TlZs
	XLrltoKQl90xHGAGlmhFRZuIUrjVoOQ=
X-Google-Smtp-Source: AGHT+IH2aSPsxsO7CwyUlO4VocEfaDkvgJ7FypQ7zwjBiO8wnvZig7O+kXIj+6lirvDOUIZvueCzOsujUuo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e214:b0:1c9:db23:706e with SMTP id
 u20-20020a170902e21400b001c9db23706emr38706plb.5.1697815926809; Fri, 20 Oct
 2023 08:32:06 -0700 (PDT)
Date: Fri, 20 Oct 2023 08:32:05 -0700
In-Reply-To: <20231020151242.1814-5-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com> <20231020151242.1814-5-kirill.shutemov@linux.intel.com>
Message-ID: <ZTKddZEUyL3QQB6_@google.com>
Subject: Re: [PATCHv2 04/13] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
From: Sean Christopherson <seanjc@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_083208_604100_AA39DF55 
X-CRM114-Status: GOOD (  10.27  )
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

On Fri, Oct 20, 2023, Kirill A. Shutemov wrote:
> kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> present in the VM. It leads to write to a MSR that doesn't exist on some
> configurations, namely in TDX guest:
> 
> 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
> 
> kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> features.
> 
> Do not disable kvmclock if it was not enabled.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
