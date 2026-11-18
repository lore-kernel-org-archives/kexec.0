Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93079606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yhwx3wwC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=PAABP9eX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=AxEJOEfcnyLje8ZmMvx2AZyT7iZftuKYAFChF/A8Hek=; b=yhwx3wwCQLraMK0JU+UMeED86f
	v/zhZZjwl8S5kwAyzU59mi4GVkrMoYUYQUW2ksC/juNQ4XZuWtLV3IoTj7rSgCnSrwVlb7uCYCBx7
	CcG1bO76d7BYE6uDCB/Z1Txfkfkpec8/hZLDrSlTL5tAAeagM0hb+QfyGIcJwlC5vu4v1daJM+Rde
	Ld7latbqN8f4R5qxupdNPqYMF7KT+6VyBmR7IkssoQV9g70Sa6egUk/nnUqaxApTj0qfGnmKT9gPg
	f8VbJ0XJQmLCnsnB+IxHeJ7ZOS1gtbni16fBYSyX0HE1uIRSCaJLM76ulEFPpCRpBXFuhQfQOqL8F
	qJgtRKPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTYrm-00000007qM9-1HnS;
	Wed, 18 Nov 2026 06:09:58 +0000
Received: from mail-pf1-x463.google.com ([2607:f8b0:4864:20::463])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTYrg-00000007qKf-1EH2
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 06:09:56 +0000
Received: by mail-pf1-x463.google.com with SMTP id d2e1a72fcca58-8b4c8b51b58so400408b3a.1
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 22:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794982191; x=1795586991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AxEJOEfcnyLje8ZmMvx2AZyT7iZftuKYAFChF/A8Hek=;
        b=Qp5HhAeKU1x+li6rdKPODfPewl5ePthRJExjomPJB3V0fb17nQ1kxbvpABq6/4Fq5B
         OBPTQkHf6d7deAheO8/ndGRY+U0Vc8nkjnxANpKcZe4Sbw7l3ZCBz1S/gE15Lvf80eR2
         Ulx2NQPs9HvsgmhISgtkXMUXWxI33F0PDvvCAVhA/8LQva9dWLM5N8GA7t2wh04Sc5Dk
         EwOZM1lAYSPYMkJshkZkZnDpoyfyd5zVGQPNEMEgW8DnjYfargG5Gsp/azN4/xoSkDhl
         ZHxyULmWl6e1GhIG1cfMrKKhB2oQGPYq7/Dt+B0IeRan39kZ8s5pQcy5RHMYtZJ67L/C
         54EQ==
X-Forwarded-Encrypted: i=1; AL+hErHC3h6Ejo9ax6NUdcbQv0G6J+bL2kKWJte6OYOnQq0c1kZIPUdwM6XNbxpyK3viFjG4+c2xhg==@lists.infradead.org
X-Gm-Message-State: APuU4Z85vTVhVxl86DmsGptmU/HJf/Gqf7mR/mgf1aVR6EA2vDL+eXqI
	MNeqWHtc571w4X4+04JOPTbqkY8ZFgNnkhDP31Du340Q8wKieb9ws8POoqlr8YfhIocoC4beQfn
	S3VxWIlfQZd4U1QPT3SlemqhN88cN7xmSzWcPHegT9fmMkZcwFMJqRwn8IGCW8k8VtimOStqanv
	elBZremZJpCMFoU4zLIttLEHOq7jpPJLPP2LEhWb6ug5WdSqiHQv41+9/tlI24AcWibV6bCKTz0
	rqsFBZnRDhz
X-Gm-Gg: AYBFou1kpeH43CwUbTAU8btJuowHzXmZCJfjy0TGPIK9VNSi73sNfyCE1IDAKyV0TaV
	/qC3YyyeK74MDOw3cWMieFN+OnZynksBLKrro4EanzSuXzWWvaXj7/NJogsG9cYOwU6RUCt3gkV
	Txt+lyYNlUU6VZn1ZtzuqWFlHEiLWQgHfLHBquEg0Dyrsb6Ww8Z19HCiGJleeW+byqT50l+3JrH
	gGBU9xuxgAA2OqIvKUWejeM8ELqQ5QO39EU0PA/otOXQDU2dz9bG3QsFrw1e7+mr+5NUeErx5Iy
	ScHkFLYCmjbR/oa7IECCL1ISOqv1H5dpNJhuqy2K/z4fl1d2Dy5ILWWsJaOFZjFhahORBgz5xLG
	9iQ3HPtnoBBLYF24OgQb/quHsZmwuvqHBhujSIFIY0zUyDpUgxOb7Jr6NDWKiLfqSevcOEwo8ZG
	wErdLR5kQ44P/aOZRD/fd2qcyI4TYEyeufCSo=
X-Received: by 2002:a05:6a20:7f8e:b0:3e2:278c:297a with SMTP id adf61e73a8af0-3fe86fce08emr2056794637.6.1794982191309;
        Tue, 17 Nov 2026 22:09:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cde3c4aa680sm10607a12.25.2026.11.17.22.09.50
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:09:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-370230d93efso2543166eec.1
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 22:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794982189; x=1795586989; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AxEJOEfcnyLje8ZmMvx2AZyT7iZftuKYAFChF/A8Hek=;
        b=PAABP9eXy7Vmxdam37LrZzWdY0IrPxTyQOsJEMvb9kEwyPln8jD9w/SAqgOpswA+df
         NlUd3qXQJunoHfldsKiTmTyYQBJXDC5WlGehB/AcoUmaHsxA6THgUIx4wMyA0qihwWIS
         6XvU3oymk6O7bliH0zYFn0zVNj1UojASNQRR8=
X-Forwarded-Encrypted: i=1; AL+hErFOsEXfyWorRQgFcji05gof5nOhw8y1IUykXHYzhf/RIgyP61RSd8n4G8M4o/vM4S4/r/5V5A==@lists.infradead.org
X-Received: by 2002:ac8:6f0b:0:b0:54a:755d:6fcc with SMTP id d75a77b69052e-55d5a2c46b1mr26201531cf.4.1794981716704;
        Tue, 17 Nov 2026 22:01:56 -0800 (PST)
X-Received: by 2002:ac8:6f0b:0:b0:54a:755d:6fcc with SMTP id d75a77b69052e-55d5a2c46b1mr26201071cf.4.1794981716159;
        Tue, 17 Nov 2026 22:01:56 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58ff0065sm14886841cf.5.2026.11.17.22.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:01:55 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v4 0/4] panic, x86/vmware: Preserve crash logs before kdump
Date: Wed, 18 Nov 2026 01:01:47 -0500
Message-ID: <cover.1794980455.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_220952_339471_8FA3614E 
X-CRM114-Status: GOOD (  16.36  )
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

Changes since v3:
- Call the platform list before taking the kexec lock in __crash_kexec(),
  so a callback that panics on a direct crash_kexec() can still enter
  kdump (reported by Sashiko).
- Rebase onto v7.4-rc3.

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

v3:
https://lore.kernel.org/r/cover.1794201807.git.zack.rusin@broadcom.com
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
 kernel/crash_core.c                           |   8 +
 kernel/panic.c                                |  51 ++++
 7 files changed, 346 insertions(+)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3

