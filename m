Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCAFCA5FA2
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KmmJxySPwG38CbqK+KUDBFApZhpWarF4JpRDp51PqIc=; b=lFCJjbn7l8aTpC
	dd6gPK3uYY2h25cSKErhRAkExHzGfsqUjiBkU9L7ddONs1L9cI9/Ir2BRUy1ypL0bFhKP4zlYfdkX
	gA+4Und66+g91/P+4xmHImqOfkE74c4nswf6xxrNlyO3VdyMb+FUk9AIDuobrs9hKc4POHaLU/vKG
	p9RRYZrvBvfjhfXbCs2/cAbT6s2DFe0WouZIooI+5B93Yv8WNlqqK5+Eqz6LXpMANylXI4m4HqRyz
	I8pAL9371vVZr+K/z+67P7OYQ0igpDoASH44GU3Ekn89iQnApite1SQnS1mTKyCMqGgdaIDPti7YT
	xHsDa6DcOs48tzxi1PhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFaA-00000001FHr-09Bk;
	Mon, 28 Sep 2026 17:56:06 +0000
Received: from mail-oa1-x61.google.com ([2001:4860:4864:20::61])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFa7-00000001FHM-147b
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:56:04 +0000
Received: by mail-oa1-x61.google.com with SMTP id 586e51a60fabf-48f69d8f72aso62212fac.0
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618161; x=1791222961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KmmJxySPwG38CbqK+KUDBFApZhpWarF4JpRDp51PqIc=;
        b=0rKbbc7V3VBP+rtjHB+znbGV7VTsrWOVgRuNcIX8C4GSfgwKPl8uZQomvk5bqFe2UT
         HS8WAQr+2DNMn4ryPROoDITOwGN4POSjFGia3wgmXVowMWh565w/1IxTXn+uWbLhvG/g
         yMGaQUJ2BA37GuWB8Bu7TWDOIEY9DKEwldxpya1tjd6lo0Um+KeMZxZa5KPoU+c3uMbU
         qCUzm0apCvM7zt+iOL2FuUKTCgM4nulIX6GZsvLeBtmHEHF2epHbBqc/jW6igMnDizWF
         ptoCAO0xBgzjM3uGIVMDVgS85WF+9oXE3QNU6EvH1UB8A0XxHqcbVEp6jD0LTup2ZbOo
         DBUA==
X-Forwarded-Encrypted: i=1; AKwUvBxh2WdcBSBGMObIBdRo4rI2qBm/6cdgdJB18ToKSNApe/OSogkWFe8J6yU3BdTD2VvfXoS0wA==@lists.infradead.org
X-Gm-Message-State: AFq9FYIOC4EK581ci289kNly6TyK97pR81+bkNF2oeaaxdW/fE8eGkps
	BArlCKvciAoJdYpsRwAhoeM73WJSBMcnt1BwE3P2qQJDxf0YoNEK/70WWQrVDF21fgTm6x3NWwV
	M6OpoJVC7hwZBw6QQH2jkystEE1TjJ7Tqvxd53uG4Ok3350xrIvp8EJ4CZbqE1xlLS65Hf6vbUB
	xzG6Tik4fhTwuBvA1tCsf3U7umx9ISn8izVAFCc/RS7C/Y2n8Cq4rrk8NF8SeH87I1XGTrr6jm/
	+avsQJ9j1Cj
X-Gm-Gg: AYBFou3VDZJlkaBEM1H/cv3gD2iroG+iyhbaj1PcnWQSvE7KQr4UxVSmTAx37USigMY
	IPHLCCCb456HoVj9FUhruBzoYlbzlIWkqgbebLF2VBP9LE+nivtK8rhgl6ttQhf7ry9HQxxrosE
	2kvrfBEUI83z/eOEn6aYUDI8xrRe6T+W7VKfh0GV2AUvC8zgvSl6Qjev3kptLYIQYT0c/DKMMXA
	Gcx1JyTTUUVtwWVTKfVXXLqFWXGDVW5v4YO1nrVDabKgb8dBxNhLpmwayhADTj0/4aFRs760i6M
	96VjiFtazoK9R9EE1tIxG87aWR/oPG1stMliVsnbBCJMHS3smcy3GSCmbFmtrjdiW9VrVVqUeJR
	w+VASIi6axf+hXWyJaLfpIOCEAAYkcD1rbJKVql0snyPI6eMda5XYBd4ZWY74sWd4FduTmiMFOA
	y59uYeba5CtgEOjWvCvNr+jAb+E+rjf/sF
X-Received: by 2002:a05:687c:218a:b0:48f:e0f6:bff2 with SMTP id 586e51a60fabf-4997014a314mr105058fac.30.1790618161290;
        Mon, 28 Sep 2026 10:56:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4933500e3e7sm1124085fac.4.2026.09.28.10.56.00
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:56:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3425098ae4bso139822eec.0
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618159; x=1791222959; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KmmJxySPwG38CbqK+KUDBFApZhpWarF4JpRDp51PqIc=;
        b=SE8fjykxVKPsn1GlWg2maSQDJxa0WACIMgRCeGp7EIDlV7zA0f4KgUibIVbonZAVqo
         O4kk6ztbIZtB86cvP0RSA34JerlGLAnaTPNEbumwcn0i/XZhq95m2VDKLzgMWpwi+K7Y
         dzI4TbmQcajepKlG3zVDwWsDM/kkauEfOqIts=
X-Forwarded-Encrypted: i=1; AKwUvBw/HXEyV4BQgGuEqbrDSgtLqML8cTudHVmGRyvy7R8ROUuLf8e3uR6YlJOB7xAkXrekJuxMZw==@lists.infradead.org
X-Received: by 2002:a05:7022:ff49:b0:13c:e1e2:fc86 with SMTP id a92af1059eb24-14b2d993e47mr201596c88.4.1790618159186;
        Mon, 28 Sep 2026 10:55:59 -0700 (PDT)
X-Received: by 2002:a05:7022:ff49:b0:13c:e1e2:fc86 with SMTP id a92af1059eb24-14b2d993e47mr201547c88.4.1790618158548;
        Mon, 28 Sep 2026 10:55:58 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:55:57 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v2 0/6] panic, x86/vmware: Preserve crash logs before kdump
Date: Mon, 28 Sep 2026 13:55:34 -0400
Message-ID: <cover.1790014793.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_105603_306810_9AFD7D8F 
X-CRM114-Status: GOOD (  11.86  )
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
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

A VMware guest may have no persistent storage or working userspace after
a crash. Preserve its newest kernel log tail in the host's vmware.log
before entering kdump, without enabling every panic notifier by default.

Following Petr's suggestion, add one generic panic_pre_kdump_list with
VMware as its first client. A set-once helper covers panic() and direct
crash-kexec entry. Fatal oopses can reach kdump without calling panic(),
so patch 2 adds that call after capturing the original registers under
the existing kexec lock. The late panic call follows sys_info() and
precedes the kmsg dumpers.

Patch 3 adds Guilherme's suggested escape hatch for debugging kdump
failures involving early callbacks. With panic_pre_kdump_postpone set,
the list runs before kdump only when crash_kexec_post_notifiers is also
set. This can omit hypervisor crash handling as well as diagnostics.
The late panic call remains eligible. This policy is a separate patch;
I can omit patch 3 if it is not wanted.

The logger preallocates an 8 KiB buffer and bounds its register-based
RPC transfer and retries. Michael suggested increasing the buffer
because 4 KiB can omit useful stack-trace context. Ordinary guests
enable logging by default; encrypted guests must opt in. Use
bool/proc_dobool for the sysctl as Joel requested. The potentially
terminating REPORTGUESTCRASH event remains a separate late dumper,
suppressed whenever a crash image is loaded. The v1 assignment to
crash_kexec_post_notifiers is dropped.

Tested on VMware Workstation and ESXi with ordinary guests, and on
ESXi with SEV-SNP and TDX guests.

v1:
https://lore.kernel.org/r/cover.1788414671.git.zack.rusin@broadcom.com

Zack Rusin (6):
  panic: Add a notifier chain for pre-kdump callbacks
  crash: Notify pre-kdump callbacks before switching kernels
  panic: Allow postponing pre-kdump notifiers
  x86/vmware: Add a bounded pre-kdump log sender
  x86/vmware: Add the vmware_record_panic_msg sysctl
  x86/vmware: Report guest crashes after kmsg dumpers

 .../admin-guide/kernel-parameters.txt         |  14 +
 Documentation/admin-guide/sysctl/kernel.rst   |  20 ++
 arch/x86/include/asm/vmware.h                 |   2 +
 arch/x86/kernel/cpu/vmware.c                  | 250 ++++++++++++++++++
 include/linux/panic_notifier.h                |   4 +
 kernel/crash_core.c                           |   3 +
 kernel/panic.c                                |  28 ++
 7 files changed, 321 insertions(+)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780

