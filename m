Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260C1C5B570
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 23:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/9OrpqxZWhRM/HFUiR8JGN523y//wB+NGc5onZ0jOJQ=; b=waLYGIFIBAG3QiOss3IngWnt3L
	0bocdEXZlR70oG8qd6E0Jn3HmLG8eqJdrSLX76FV1+QtUU2j6owcjJzy/uDMhnBl3e5TdMniPtq8y
	eeQ77Eb8jZyQA4p8yJ0icuTFmGgEOE7N/2KrOip2RyyMyEV2ZexU61L0Ymelxc27lxRe8rvrdSYts
	yYbyI7FxLOYSHbE3CO4JhTqicXWvPZdlXbUdsObJenMqoY35wg0ONc/1k/fI/LaXDZ3XX5H/8+nfK
	ROdvxpitnjAujcYB+a7bjkZjv1l4h8tkcBYB4+vBJ1614S7qysEOnX4slxfVcnnOm+ihPtSPqaMfI
	wgvHMz3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtZ3c-0000000D0VK-3ngb;
	Mon, 10 Aug 2026 23:05:24 +0000
Received: from mail-pf1-x447.google.com ([2607:f8b0:4864:20::447])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtZ3b-0000000D0TL-1dBQ
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 23:05:24 +0000
Received: by mail-pf1-x447.google.com with SMTP id d2e1a72fcca58-8486c3411c8so3423876b3a.2
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786403122; x=1787007922; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/9OrpqxZWhRM/HFUiR8JGN523y//wB+NGc5onZ0jOJQ=;
        b=irg09hW6muiIH4nErAz8dW9CWbUYAOV8SeS8MJhuIt13ZRQQ1sV6csTlV2YkMWm+Vi
         CA264CjLstJIIYYxAReZAiDLpd2w6liegdCaLLMAoHmutoy9vt7T7GEwN3aVQZ3bmd20
         Z48Pjhru5H0jEj8aYv/Lxc3MOV7DsWI7ozFTcYDIpmmq6EIlXaWPFRcyZjBNhI/f+zSu
         uIC11USGYumup01QNcW8XFNwZ6ZNH9464lfwq2/SR9W7AWOtKGELzKwCp3kRMfxU/c61
         I/fkHn2Yny8fNEK25KWGJ0sxYcObswooLxXjL0GWyh06ABzRdl+U/dk7C5Fn2Ds9q+J3
         /gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786403122; x=1787007922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/9OrpqxZWhRM/HFUiR8JGN523y//wB+NGc5onZ0jOJQ=;
        b=HaY+1hbMgEqptgSyct19uTBSOn5DuWgAFdFpi5OMNVxKW7JQqjxxzyjb0DoS/ZWAfa
         Yd2mD2rv9Zb95tiXa/u7XVMsvFnpxZpGpIkWReCxonzHZ2oq6Rn74TjX3IO7zacsMrO3
         ZdGBOg8T3mvU9Uhw4l7vv5wHv6OpxEpNaIzLNAVH9AF17sjRAh8n2ZgrdUVj+Q1oBcT6
         7f/yZqd0P194XJwnA2ZqNZEsTsrrIDC4+eYhhfFGht8LCHmsiPjekuHdFuRPVzKwxKTe
         zXvlDkp9hEAaeIGjQdKPQpk42yNWYdlyHcXwA+fAlxtXEDijjSkhf01C9fGMUTKzNQ1o
         bzew==
X-Forwarded-Encrypted: i=1; AHgh+RpmICwv9h08sMDo+7wFIr12MM59gurZYBP9tlRuYQmA40xVFAr5yetwIHKdhqlKwMvjwvIaNw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxKV+YWtaqi8Pz2PcJTNX2iCA3BUaAWUGTyW/X7l/E9IyI0nrD2
	44TvwYIBp02T3X0jekRXvOuE89apVCNRC7tixxGhoWj+XNVd6CGhx8U4VoDspotbwwVpJbsHO1K
	yn92XfQ==
X-Received: from pfnv2.prod.google.com ([2002:aa7:8502:0:b0:847:7765:a4c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:420c:b0:848:2f2c:b2c8
 with SMTP id d2e1a72fcca58-84f9c95f809mr5850968b3a.24.1786403121703; Mon, 10
 Aug 2026 16:05:21 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:05:21 -0700
In-Reply-To: <20260728121138.1103610-3-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-3-tarunsahu@google.com>
Message-ID: <anpZMemVz5yC_WLo@google.com>
Subject: Re: [PATCH v4 02/11] KVM: Introduce kvm_create_vm_file() helper
From: Sean Christopherson <seanjc@google.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kselftest@vger.kernel.org, andre.przywara@arm.com, michael.roth@amd.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, will@kernel.org, 
	vannapurve@google.com, maz@kernel.org, fvdl@google.com, kvm@vger.kernel.org, 
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, alexandru.elisei@arm.com, 
	skhawaja@google.com, aneesh.kumar@kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, kexec@lists.infradead.org, 
	suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_160523_433577_CECDD76C 
X-CRM114-Status: UNSURE (   8.92  )
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

On Tue, Jul 28, 2026, Tarun Sahu wrote:
> - Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
> - Introduce kvm_create_vm_file() to wrap kvm_create_vm() and
>   anon_inode_getfile(), providing a unified VM file creation API.

As Ackerley pointed out, changelogs that are literally a list pretty much always
needs to be split.

These also need to explain *why*.  "providing a unified VM file creation API"
isn't sufficient justification.  In general, all of these changelogs need to
provide more of the "why"; I can figure out what the patches are doing easily
enough, but in my speed read of the series, it's hard to figure out the "why".

