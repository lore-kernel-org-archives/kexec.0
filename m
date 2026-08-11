Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331ABC5B56A
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 14:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rVhz6t6uiOZc1DDgF6HOTd7wvK1RF7/iSTLQV7TuFds=; b=YN8TwCwnTVg7uBjT8lRy2Je572
	VPf4QUHXFBIXMfWk/DD+4WCT7gw9DidD/0X/Q3eKFzu/mcVhKnDJvTK05EQuck/LEJcHUzenE8kml
	54ZuvSC8z6gqMCGPToz/BWbcE/nz+Y++n3OyyiQ2uXMMq58yS5YAW9gnAA0jo8jvm+sllAhi+/jA3
	MhOYaC8BaQ+x0CQCToIu4DAayg4U6ntsLw7cv1gwKkXPkDSt+QaNrG47sMndVsLhQ8sNZKuTMcxpN
	VATI1O9YYv3DeCqrJI6j2yK+k1j4RiO7mK2ffQ3ODO4Relwj3+1IekGg1ieS/AJF+BsMR4nGjCrqA
	hhDXvxgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtnmS-0000000EFWb-3TQ5;
	Tue, 11 Aug 2026 14:48:40 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtnmP-0000000EFW9-3TlW
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 14:48:38 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so68020465ad.1
        for <kexec@lists.infradead.org>; Tue, 11 Aug 2026 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786459715; x=1787064515; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rVhz6t6uiOZc1DDgF6HOTd7wvK1RF7/iSTLQV7TuFds=;
        b=Z/XuOHevzk4HXG+AzKug16yKsRDLqu3ISH+l/kJK9D3XIeP6jCLlkoRupO0mKokMIJ
         GOuA+rGmocIa0ypUrMADShq4b5/1/acYnrgCDv0FIZZAJ2JxzNIyT0OOmg+PXvS+UZZu
         rBKsLtmMIV5Ey78HOx/2udBJWQlYfPttHqfi5VaqGQP8DAH9PF8ULpicYbCDq/MLJcoZ
         5dvW2mo1S966gQSDbNfT0grHTqwwX9/lnB/taKCJu6jLeGRHDn11prq3+KF7T537BB0M
         SvJRlugldKtCb45lZjcP4GUi6krUA2P6EegOfwGI+mAQXR9lwY6yeghR1CqTCEdVc46h
         9lTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459715; x=1787064515;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rVhz6t6uiOZc1DDgF6HOTd7wvK1RF7/iSTLQV7TuFds=;
        b=KU/chhJnathSSYZv8yxBSDrq375pzXwO6G/HjzaRU98BZmlEHLZA0klO0/DrnE9mI4
         ptFqx5u7vQJBDTuBOEYRDVUekGoiEJ0ZT0MPQddKX5FEjdZUW9tDqz70G1VZ8ae+COQO
         DNxJ3bn82PTxoCDV12gX3dahx23JJCDBMUVNz+20oWqTuteG9mdZON5lHF9I6iyP/X0G
         Pd+E7BKkViWJWHZs9VNhMN6a3WYLJ9/7UNKURGThHukXgut6THdgPjToeqTuQUVmuFhQ
         81neDGQoJoGypzaB49uK3OP04crj+ZPselFmwzbtDnHKeUM0Oem2UKGQfyFAXIQu45qV
         SS/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqQ9p/hFv8QLn3d499YlKCNky/zD4q8EoxTPOQYzU9JyJY4Ra3C/KY4gDXa5D9VXjLSBgq7lw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5n47J1xPMJinItkdQWWmF6xKZabj/wPcuAztcR+v75/g/TUOA
	1+Y4x4Z5Fmcjx5uG/XflnPmn5FG/J2hkaa79i8LAn0FVHEHL7FbqIXVD79839XwiWv27m9wgU2l
	fJn0lHA==
X-Received: from plbje14.prod.google.com ([2002:a17:903:264e:b0:2ca:eea9:9845])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d488:b0:2d1:1a18:4d0a
 with SMTP id d9443c01a7336-2d3177a2163mr42800725ad.9.1786459715153; Tue, 11
 Aug 2026 07:48:35 -0700 (PDT)
Date: Tue, 11 Aug 2026 07:48:34 -0700
In-Reply-To: <9huzqzk4zt3n.fsf@tarunix.c.googlers.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-2-tarunsahu@google.com> <anpXjM_lg_UTpl0q@google.com> <9huzqzk4zt3n.fsf@tarunix.c.googlers.com>
Message-ID: <ans2Qvo0453cc_DD@google.com>
Subject: Re: [PATCH v4 01/11] liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
From: Sean Christopherson <seanjc@google.com>
To: tarunsahu@google.com
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
X-CRM114-CacheID: sfid-20260811_074837_869761_E1213759 
X-CRM114-Status: GOOD (  18.49  )
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

On Tue, Aug 11, 2026, tarunsahu@google.com wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Tue, Jul 28, 2026, Tarun Sahu wrote:
> >> Introduce the LIVEUPDATE_GUEST_MEMFD Kconfig option. This option
> >> enables live update support for KVM guest_memfd files, enabling
> >> guest_memfd-backed memory preservation across kernel upgrades.
> >> 
> >> Currently this support only guest_memfd files that are full-shared
> >> (INIT_SHARED and no support for private_mem).
> >
> > Why?  Specifically, why do we need/want a separate Kconfig for guest_memfd
> > liveupdate versus KVM liveupdate?  I can _maybe_ see a KVM-wide Kconfig, but
> > even that seems like a stretch given that (AFAIK) hypervisors are the one and
> > only use-case for liveupdate.
> 
> LIVEUPDATE is used in many subsystem. It is possible to enable
> liveupdate and kvm without enabling KVM_GUEST_MEMFD. So GUEST_MEMFD
> preservation must depend on CONFIG_LIVEUPDATE and KVM_GUEST_MEMFD both.
> LIVEUPDATE_GUEST_MEMFD Kconfig is wrapper on both of them. It need not
> to be visible in menu, So I can make it hidden. WDYT?
> 
> Also, KVM VM_FILE preservation and GUEST_MEMFD preservation both depends
> on LIVEUPDATE_GUEST_MEMFD in this patch series. [PATCH 05/11]*
> Which is wrong. So I will update KVM VM_FILE preservation to depend only
> on CONFIG_LIVEUPDATE.

Or just handle it all in the makefile?  E.g.

diff --git virt/kvm/Makefile.kvm virt/kvm/Makefile.kvm
index d047d4cf58c9..e6f098498795 100644
--- virt/kvm/Makefile.kvm
+++ virt/kvm/Makefile.kvm
@@ -13,3 +13,8 @@ kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
 kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
 kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
 kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd.o
+
+ifdef CONFIG_LIVEUPDATE
+kvm-y += $(KVM)/kvm_luo.o
+kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd_luo.o
+endif


