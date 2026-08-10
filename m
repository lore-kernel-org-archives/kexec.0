Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7164C5B569
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 23:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FpMqKDZdeqkAxP+HMbo4Vf8RyrsMvHYCAM3HPa8Xz3s=; b=dOhKcFeroa9+9WrUq4FFZxz0ip
	cA16Au7qU0VPbQfTrFHKZ49yas6sGZbT0uLSyKy5KnyxCw+6T9eKkaDwhFg+maClBkwA2SZ/OmI3p
	YObM3CT58v5R4KTM6Ukm9m9No/LX+w/HVM3TLkXPpsDrQkVyhyo70FbokbiyfNKxqpgLyJfmXrJrR
	Jl6IgeBZULBUHEIiBaI/kb9ajY7oCBhJJaiMbKs4Mvr0eo+z/7WgAJNONPMiTRux64wOiXVoRgwz9
	QgKfIenM8PBX3JsTrHmwJnWacshOtTaZUgOQu1D9IelDK4LOwQJtPkfU6jBTOy7sHGj14IGAm8tMj
	GNK5XE2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtZKv-0000000D1tT-1vYV;
	Mon, 10 Aug 2026 23:23:17 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtZKt-0000000D1t7-0Uvv
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 23:23:16 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso3261185ad.0
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 16:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786404193; x=1787008993; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FpMqKDZdeqkAxP+HMbo4Vf8RyrsMvHYCAM3HPa8Xz3s=;
        b=rrfya708+zc3qIONKNwJKcBmHlqxyd4Ri9nQidlY5LJaoaTRk2u55BvcQhIWLdcvO9
         5NM4aGRwJDJe4FuheEG3PQw0ZInwvl+W9O6T6OLA4cy0N3EwpXYkrvTh1DuGzOcr9/P4
         0Qg8e0QM3y9n+UOMC/VQLO5bwpEeMbFzDqJLT1HufN1p/OPMzp9tgu0xmy5tOukcI97S
         64mlNsZn0CDnkZ6Oyar83K9ghYYEEa/cdGGgJeg+6daZA+6HKnu6Xq+VGvQbtNsYCw2W
         ubdN5hxONWOk/KZiqwd48OPAasjCIRgDAj93fzIzleMVfphc6LUhvQWgAwWspqmHs3MG
         iIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786404193; x=1787008993;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FpMqKDZdeqkAxP+HMbo4Vf8RyrsMvHYCAM3HPa8Xz3s=;
        b=mvvpCE4yhN4OVdhdgc+6bCg/2Ra6FdlMubLrhVpuWwU59x5ZLR+BQu9MesVArHCl6r
         j2VMid6LzpVvj5pKKrkGhOnk7UiYQJVoEkrbLzF98ZjwqtWC5ArrkaEUyb+8Hy6V1a/n
         wzdHsFQ1UbVWgpL34Vm7DT2KrOlsFK9/gZ5uiU/ulyCcovrGTTMVDt6lGaaoIpthhyNO
         2/Xf4KFS5vyczif0EUM0Ng8Mwm7lJWPTYzYl0uZ2W2YOr6QjJqV1ofzaJg8nrLSL5dgo
         CJtUMQZZJN6eezhJT+MJqbl/xfAtITUKBWgAoSyqqMO2yWHpg5kgMy4tNglum3iUvL7a
         /xhA==
X-Forwarded-Encrypted: i=1; AHgh+RqQplKHrm42QcLLxSuRFyxPlrLy6gU54FXYYBJxwpEE0MjQU7lu+F/98/vxOdhN+Zbb2LrKsA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyGxFWhe5V/XWNzxCqc90HfEHDrVrN4o8TpvwiTVeYBGvxHwjCb
	ipbEtuTd9I0vm846Fs02I0ypvRubvT7RwG8KSqWgix4i+lEXuDgtpHN+zGWCrqyIM5OUerpwitn
	9jHkW+w==
X-Received: from plkb4.prod.google.com ([2002:a17:903:fa4:b0:2c0:a516:2c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fdad:b0:2bf:9760:b94d
 with SMTP id d9443c01a7336-2d0ca7fd072mr611571635ad.15.1786404192685; Mon, 10
 Aug 2026 16:23:12 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:23:12 -0700
In-Reply-To: <20260728121138.1103610-5-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-5-tarunsahu@google.com>
Message-ID: <anpdYD1UaO0ffQgi@google.com>
Subject: Re: [PATCH v4 04/11] KVM: Track weak reference to vm_file in struct kvm
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
X-CRM114-CacheID: sfid-20260810_162315_184605_A134B303 
X-CRM114-Status: UNSURE (   8.67  )
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
> - Add a weak reference 'vm_file' in struct kvm under

"vm_file" is effectively already claimed by vm_area_struct.vm_file.  *If* we go
this route, I would very strongly prefer to take a dependency on "vfio: Use
file-based reference counting for KVM"[*].  I'll poke that thread, we really
should land that one particular patch long before the s390-is-arm64 insanity.

Empashish on "if" because this all feels backwards.  It's not at all clear to
me why liveupdate goes directly to guest_memfd, but then requires a token associated
with the VM.

https://lore.kernel.org/all/20260731130902.654679-2-seiden@linux.ibm.com

