Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA29606A337
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tkU1u9gt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=C2VFL0nq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=h/7KHZgrDOM2tA+GxXk56HAD/IPswfxy6WrliIOncNc=; b=tkU1u9gtUWbKMOYYbe07uKMPyK
	dudCRbkkd+8mMhr2p/tzVnMVlHWCMnVJ12v1xAzg5xtISvnq6QpN57eXr7zHgj8zCGeXaWow07SIf
	+5qejCrY0zbWpcOZiJEooMXA22zn52hXdg0hcXmYV3SQ84FrsO+5J8e6rGnyZ4ywxic9iERLMmcOG
	0G9VTZCt5nIqjFSUNXkZ0vT1Q50uxFhbfbXHjwav0oB24K3QQ7tTrtHQA3ldVXZobDt+o4CO5dKJY
	3yYsUnvacbFQUMPmfYNxC9YkD8/Hv31Dr16RsjWmZp8N7WIcPXULdMxgi2pP6VHnsWfTkBNOIkNs9
	SH8ZNsvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQIEY-0000000HS3d-0kYh;
	Mon, 09 Nov 2026 05:47:58 +0000
Received: from mail-pj1-x1064.google.com ([2607:f8b0:4864:20::1064])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQIEV-0000000HS2l-2fke
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 05:47:57 +0000
Received: by mail-pj1-x1064.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so245951a91.0
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 21:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203273; x=1794808073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h/7KHZgrDOM2tA+GxXk56HAD/IPswfxy6WrliIOncNc=;
        b=iBBloSMY/4aPT1Y9EW4LE0Yv7Nk74W+xSR9cwkbugwX9JixHSPeMTx2SV+TNb/mcAk
         h2UlcRvjTFMsgtJ86N+rED3opXYmq0xpn31MOPUEp+q7RfBRY7qbrFerwDa7vE41GPTF
         P8Uwkv68t0PndnIabVpcukbKNdH0+kLlf5piDbYCNOlcvXOwAxzfH9XXjJvovtTLRUnu
         DKVFls83O1DVLp7MFjKWsjERZ0ys9c0H1p+F2ntR87uL67FhwyRTSaObrFHopCWuxumn
         nR7Xw8pFv01CDyVXQwYAo8JlstWJeK4c4G3/Cpz/hEkrW7gfXOcYb6EyxxjcPC3tVLaB
         AV+Q==
X-Forwarded-Encrypted: i=1; AL+hErF5y+df1i/X4urllFl95HvwinxVLaKZjF38wVj1CN0DLVigoFDTR2JJkczFqOn579gsyru2Lw==@lists.infradead.org
X-Gm-Message-State: APuU4Z8Rey3JEzyCWQRf6xa/gRurxhHn9NZoMfEtU67EmAQ5OsL4YeFJ
	YNiq6J9NQQnh0Dq3OXl9OYi3UAcHoTaecQmuxTuTdaB0fMX0N54+pxlKmpIBEhGcRAZ0ma3ALeZ
	hnvh/NxJXJVBlJE1ypU/Vfd25G1WOaSOxwm79xhyv2dFT9S7ea89ouxmiqptDsAKrH+sPL11jGm
	izYJAM2IfoZ/6w/0YAIrKGYkqQLoSO8bNW+5Bq3RiIdTqJdjM+9fzMBUijNSPpiiz1Vv8nVzQHw
	90hpPq00Z0I
X-Gm-Gg: AYBFou1f0ke0T7KX9e/kDczFoE7mucxnD0NULaZ854AB43d86QeBWGq09MyW9Sf2sW2
	txzdGhg1Gllr6rmpPWmNsHM4dKGUPigO+QV8b8YoNAh5e01Rl7iAYHZ3WjWbRLD5uGlJ8rN5LGl
	J6q4YKstcCaO91MJda95EhlPYqn+nsuI60du9+c68MV8+4ElQVZBxyMyVp5zRWHxaBWD7QBvJEE
	x5M5EOjuwiCOgDmCwt83hrpwNDrL47pPhU/vx86Bhc8JLFqzQ4bstMmS018lZNDCB4X8gKGQVtn
	FHB7nvH56Unh0bh+d+yVdXNBQCn1a621bCpmcOahG74+f4yD2yjNAc2ZJZ8c1phVO3qb4RTaXtx
	k75VFansGqUUH6Z6gFIMtj+Z4uNJDM8BjpWVt4CXSh0WfzqPmvUu+HsahdVissBtD1CH4i1QIBv
	t6O7kRkBr53Yu6YUHm3/f6+sf41Ysp/Ckw
X-Received: by 2002:a17:90b:3ecd:b0:3ab:c80:9365 with SMTP id 98e67ed59e1d1-3b12d3e71d8mr3065811a91.42.1794203273215;
        Sun, 08 Nov 2026 21:47:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b12744d264sm2690418a91.0.2026.11.08.21.47.52
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2026 21:47:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36fa5673fccso2687373eec.1
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 21:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794203271; x=1794808071; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h/7KHZgrDOM2tA+GxXk56HAD/IPswfxy6WrliIOncNc=;
        b=C2VFL0nqMFSM0Js5K8fYSkqF8HM/ESeoDuPuyE5v2ur0hbotIwHxQyxM610qbwpFxu
         UdGP88zB3z2T3aQw9UQj3K9TFhSNvGf3balGWdpMvZoG3pQiRJlF/PN7nMeRlLdOpr15
         NILz08cWVUnZPPKPPH7jaCzDfJXNB6X3lBCEY=
X-Forwarded-Encrypted: i=1; AL+hErGrOsr7uV3PKS0VECPpXN3cevsfSZzIhrsWpksdQz8dXbdVK5YwTFQcs15wUuxFAcCJZ/nLew==@lists.infradead.org
X-Received: by 2002:a05:7022:1407:b0:145:287:ce91 with SMTP id a92af1059eb24-1b39fe87be0mr5170873c88.14.1794203271457;
        Sun, 08 Nov 2026 21:47:51 -0800 (PST)
X-Received: by 2002:a05:7022:1407:b0:145:287:ce91 with SMTP id a92af1059eb24-1b39fe87be0mr5170811c88.14.1794203270668;
        Sun, 08 Nov 2026 21:47:50 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm13745136c88.1.2026.11.08.21.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:47:49 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v3 0/4] panic, x86/vmware: Preserve crash logs before kdump
Date: Mon,  9 Nov 2026 00:47:36 -0500
Message-ID: <cover.1794201807.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_214755_710008_8AD7B7F0 
X-CRM114-Status: GOOD (  15.17  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Bradley Morgan <brads@mainlining.org>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series lets VMware guests copy the end of their kernel log to
the host's vmware.log when they crash, before entering kdump. This
preserves diagnostic information even if the guest cannot save its
own logs or the crash dump fails.

Using the existing panic notifier list for this would require
crash_kexec_post_notifiers=1, which also runs unrelated callbacks
before kdump. Following Petr's suggestion, v3 instead adds a separate
platform panic notifier list for callbacks that need to run early.
It runs before kdump and before stopping the other CPUs. It also
covers fatal oopses that enter kdump without going through panic().
The callbacks run at most once, and the list can be disabled for
debugging with disable_panic_notifiers_platform_list.
crash_kexec_post_notifiers, the existing panic notifiers and the
kmsg dumpers are unchanged.

The VMware log sender is the first user. It uses a preallocated
8 KiB buffer and limits both the transfer size and the number of
retries. Logging is enabled by default in ordinary guests; encrypted
guests must opt in through kernel.vmware_record_panic_msg. The copy
is best-effort: kdump and reboot do not depend on it succeeding.

The separate VMware guest-crash notification, which can cause the
host to terminate the VM, is a kmsg dumper registered late in boot,
so it runs after the built-in log dumpers. It is suppressed while a
crash kernel is loaded.

Changes since v2:
- Replace the pre-kdump list and postponement parameter with the
  platform list and a debugging switch to disable it.
- Run the list in vpanic() before the other CPUs are stopped,
  instead of just before the kmsg dumpers.
- Correct the sysctl documentation heading.
- Rebase onto v7.4-rc1.

Tested on x86-64 guests on VMware Workstation, ESXi (ordinary,
SEV-SNP and TDX) and QEMU/KVM.

Platform list proposal:
https://lore.kernel.org/r/ateYxCu63pRY9EGq@pathway.suse.cz

v2:
https://lore.kernel.org/r/cover.1790014793.git.zack.rusin@broadcom.com
v1:
https://lore.kernel.org/r/cover.1788414671.git.zack.rusin@broadcom.com

Zack Rusin (4):
  panic: Add a platform panic notifier list
  x86/vmware: Add a bounded panic log sender
  x86/vmware: Add the vmware_record_panic_msg sysctl
  x86/vmware: Report guest crashes after kmsg dumpers

 .../admin-guide/kernel-parameters.txt         |  12 +
 Documentation/admin-guide/sysctl/kernel.rst   |  20 ++
 arch/x86/include/asm/vmware.h                 |   2 +
 arch/x86/kernel/cpu/vmware.c                  | 250 ++++++++++++++++++
 include/linux/panic_notifier.h                |   3 +
 kernel/crash_core.c                           |   3 +
 kernel/panic.c                                |  50 ++++
 7 files changed, 340 insertions(+)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

