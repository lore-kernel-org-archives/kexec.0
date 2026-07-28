Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A095C54F4C
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 12:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gVnIMBasyGsCgYKzJa454oI7ZPXv6Y6JMFDgs68eV4E=; b=L97lbEYeFe0ucrQ5qqZKb0JCga
	TE7Io5cWW+rUbXEQHE1T08lRf/6+7KIwlaHEmxhrHL+SIBhYwnq7Nq3L8wRvW/lRsuQ28OxGtLld6
	41gJM6hB7o+kTfxJ2d10hGci7yz4kngBa4pFx7WByRRRiNNDTf2ehxh+QItwktFAAO6juQ/9pnDGI
	O+0ULvmFaO3+skWAQlqFaSS7m1ZYFYodVbuFN82wcvBK6itKTmy9vMLkFfvWO61nbmTO5vZ2DOIUh
	gDs2qiRA3LXxsUnbLlm/7HsPrn7EPfW6yQiSq9rd/zMRND9I+H/1O/b7PVlcM3l+Xji2bTWQ365ud
	ntHE9K1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogex-00000005CfA-2sl8;
	Tue, 28 Jul 2026 12:11:47 +0000
Received: from mail-ed1-x546.google.com ([2a00:1450:4864:20::546])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogev-00000005Cdn-0XwR
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 12:11:46 +0000
Received: by mail-ed1-x546.google.com with SMTP id 4fb4d7f45d1cf-698557ec1e9so3044201a12.1
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 05:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785240702; x=1785845502; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gVnIMBasyGsCgYKzJa454oI7ZPXv6Y6JMFDgs68eV4E=;
        b=V69WWeJ4yAbH6dnlS063ygb9A6QmsI4a7yMtG86fjVjXNdlt/hKUW7csu30rGesA/3
         7qmuiyV4+QJFrxzlqvvJqqKto3oTrEtTFeRlDO4WdqxtDIuFlBf8SLOydWSg2MC0neB3
         de/H2pzbLrcZcEqpg404NV53k+H9JNglwQP/ydaPbW0Y8Tb3kg4BNWGmNs4CRsKbAulw
         my2Ge2kWdD3f6JDa/vf43FnYsZQiDxBRSwX0uC9DHoY43jUkUk7S/nMNrrj7oF5PC8+x
         cCNOONf6TFvFgkTVvRq8PScXE2uo4cozmT04Wrhet1q2m1Wjv68tyZo8MojGDrNbwCZv
         J3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240702; x=1785845502;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gVnIMBasyGsCgYKzJa454oI7ZPXv6Y6JMFDgs68eV4E=;
        b=rvTX/t8QaWq/IGEw07N6Jhp7W9U8uf/d7fy2QrSUzxZPWe027bGZkbBzTyhfm2gG2r
         Qvqq5CT9YOc5XFWJqruaOYOvGqll+KjhkwGhdjLshNuGnBgBdpFnVttwEKlXgTdwF/Zc
         stKUrz05Sr1IVf3LY63Cy0tBHiSGzdhgJ3D2jTNDnNror60zMQX4lxeJ9tVU4Yt93PJO
         Hq8sz4nc3DQz/s9WXjVbqrHKBK0RX2i2V7rCw3MfSMItOJQ81r1X3TY1+lGPM4LSUyq9
         O18Ll7CuxHcBvdRULz53D4rUO/p5emL00DCAtgiXxVTX236QQaZV+9vwFRCXP4sfHBwL
         jhUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZY5gV3ZxJCd8UnNVHZMZzsQYCUncMe0UZylTyZcvVzis6V18sPozybhWA/O1JwFU+Q5KxQA==@lists.infradead.org
X-Gm-Message-State: AOJu0YymYR//sNFihq+twNVd5RxaafhjXl0Vz6TzEe4QPfw64lXFREPx
	0MVbkL4DxWwaMcxRV6yWFdey1kdpQlcRzS+89C9y9nwLWuukwNCQ3vBml1jhJGyki0WzL8AJ5eE
	rQ0tGRgO0Yu4RVH/FHw==
X-Received: from edfy21.prod.google.com ([2002:a05:6402:a3d5:b0:698:3510:43a])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2b93:b0:69f:d5a9:c957 with SMTP id 4fb4d7f45d1cf-6a034a765a3mr1074401a12.35.1785240701982;
 Tue, 28 Jul 2026 05:11:41 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:11:28 +0000
In-Reply-To: <20260728121138.1103610-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728121138.1103610-2-tarunsahu@google.com>
Subject: [PATCH v4 01/11] liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
From: Tarun Sahu <tarunsahu@google.com>
To: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Tarun Sahu <tarunsahu@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_051145_176496_4C93B0F5 
X-CRM114-Status: UNSURE (   9.75  )
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
(INIT_SHARED and no support for private_mem).

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 kernel/liveupdate/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index c13af38ba23a..2490f9a9b838 100644
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
2.55.0.229.g6434b31f56-goog


