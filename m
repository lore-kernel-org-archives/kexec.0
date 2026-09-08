Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F41C79F82
	for <kexec@archiver.kernel.org>; Tue,  8 Sep 2026 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i+U6lKJy3E9UudZt3FknVdHylx4G9kfIGWhaOGKfOa4=; b=eadCL+JnOaZlvDKVkO/wlhVr5I
	NsbIBdCxHvLsZX1C+4E9ibTaBt6IZLLtl67lv09tLxT2KkPa2IluiqZB9cF/4GiUh4ujFi9rwYBg5
	C7R6a1coVwBFTWUCJP68uIQaEG1epnHruSNkTqBdVwO7/b0IogHyEBAfnK+UKFNUkFNqvVkS4+rYM
	4eaa/pNjcUcUR8+Og4zAGSqCdb/LDdpYEOt7t9x9HDdkdQz0c838zOe1mtocO7aHz9XDmef6aTJ6f
	qzHe2wT1SXzL0+E08rjNoEEidqsbBvav/VBfSEb/6tZUL/b7Kjl1UYaqKymmrhkOJ7EWsvLFuNXMr
	2qOTwhtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40ES-00000009w9n-0ohW;
	Tue, 08 Sep 2026 18:07:44 +0000
Received: from mail-vs1-xe63.google.com ([2607:f8b0:4864:20::e63])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40EN-00000009w7v-0fUh
	for kexec@lists.infradead.org;
	Tue, 08 Sep 2026 18:07:40 +0000
Received: by mail-vs1-xe63.google.com with SMTP id ada2fe7eead31-7855bfd6ab6so1367321137.1
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 11:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890858; x=1789495658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+U6lKJy3E9UudZt3FknVdHylx4G9kfIGWhaOGKfOa4=;
        b=lSM9nunlzEVRi01OcFGUTOu0uf1woJNHA/Lo14i+1T6YHS4Z8yF5NI3tIF8MM4TJuN
         L5+RbzUP0/JDy3ajPw4pBdtAMRKhU6YKpmG5yMIMONGmg3F1vjaPMNc1U6/rhCfVxzWR
         Ch55biVvG6MDOZoaimXCcYhmLPv4EBMR3qHh/4Ns9czevR9S/zPDeQbfiAcjwRXufplU
         cw3JAAwx3GfhhkLx3JzTQ8JQb2hZoAkqpgfyRmM0SYWGcgPbssKa6u5HGQP3emGbGOYX
         HRPVZoVnSzgRI2M7c4h+3f2Detq6F/GnsJi3p6Ym3QhwBsrbWlQ6VXsXKwkSVC8aAnXP
         xqVw==
X-Forwarded-Encrypted: i=1; AKwUvBw0uB9fkIDB3q+TqHLn2uV3ibppeGNpmFYBEEDlWzlcUmy/huFVDOo41h0EkcK1Hi5RZUrftg==@lists.infradead.org
X-Gm-Message-State: AFuF++k6QnRZnn5UqcJAdM51MmFbTmU76hQCtxRLpNjc96dJKRCjYUa9
	pButtBKMg3z1DMNlX1e1KhcMDOU+qTDd4xvjGEk6e8NUWLabmlAAjWWg/bIn71PlSi3e948UKph
	7whvivxmC+DXo7/YBBSlI/tc8bbenhMfbIMwGY3maqJyY89DygpGKNO2fxer/LUws1PoyRceqcQ
	A/MpaY2bYC/erQG6fHp8JYTtWEHgcCPgaRppE1X7ZXHSxl42erxhvrrdS1UNrDEFNXr364jkJWq
	lnzqL3pYHEr
X-Gm-Gg: AYBFou3444e5/76c7EbwdsQ7/OkXSEExdyb5Ai5zKoBU/k/Fy85hNoyjY52NJ/GbZcd
	O1JpVzMRCADVEL2qOq/eWZxrYsbOzf27k+AvhiaW7rOhbVj3b90NZS4nrYj2PenszWJApxLewLn
	ecDTI8L8QtAV8W0y554zTGDjuRqYRz4ba99G+jqHU9lxTa1leWXKzSvWE9kzgDf2b6qozZli+1l
	ECnrvLLCQewyDs3vexE693Z9fg0JIUxHbq//X3d2+gtlNkr28Nkv1frEDE79TPLqfG5KYNkjTw9
	Wz5vq+5WKZOixx0GFrJc5l91rUbk18yUApv/6TSiLUTCkSvFMj2JpJZItZjrrhLwgSEDseFUo6q
	tPtlScFRj3h3vT9bS3l2hanFpfSOfuNsA7jtUY6BdNwONjA/5AxogyGa/dkXo1VnQYoeGYKySv/
	Xj5gXZCPPw39vZNNGQ7cea86Fr002JCb/fjsg=
X-Received: by 2002:a05:6102:5346:b0:777:ab3c:b88c with SMTP id ada2fe7eead31-78a4aa9948fmr11589368137.8.1788890857757;
        Tue, 08 Sep 2026 11:07:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-78a47bc2104sm323647137.23.2026.09.08.11.07.35
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 11:07:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90ce8ad8002so92420406d6.2
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788890855; x=1789495655; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+U6lKJy3E9UudZt3FknVdHylx4G9kfIGWhaOGKfOa4=;
        b=DGnJj5O0guTM/IyfSEDJjBruTYpKjj1t4yJ/jobpfTp38AcFwcY65lvZXQDqxdehdv
         fCkPOshYCPB8P9FcqCqG1zeSZv015XQwarEPOU1a7KLYOd1tm9qV29GqSeWjhXFQKfrD
         JlQiFclBD5LvsHI1SByDKjfZ3QffUr+j+6QJY=
X-Forwarded-Encrypted: i=1; AKwUvBykPJG7cgCvUgWRF4b0VYZll4FXsj3UnmRT1UFFYAJvfXxF6YerZTsJlVZEDTYg4QSLT/H/Qw==@lists.infradead.org
X-Received: by 2002:a05:6214:4905:b0:90e:7e02:cc3f with SMTP id 6a1803df08f44-9103ef88ddemr25982276d6.18.1788890854677;
        Tue, 08 Sep 2026 11:07:34 -0700 (PDT)
X-Received: by 2002:a05:6214:4905:b0:90e:7e02:cc3f with SMTP id 6a1803df08f44-9103ef88ddemr25981186d6.18.1788890853962;
        Tue, 08 Sep 2026 11:07:33 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm27114866d6.20.2026.09.08.11.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:07:29 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Joel Granados <joel.granados@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 2/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Date: Tue,  8 Sep 2026 14:07:14 -0400
Message-ID: <03e5c9855e9578b00abf8da69764f1b468597218.1788414671.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788414671.git.zack.rusin@broadcom.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_110739_213060_9D49A789 
X-CRM114-Status: GOOD (  18.74  )
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

Full panic text is useful on ordinary guests. Encrypted guests should
export it only when an administrator opts in. Reporting a crash does not
require transferring the log.

Enable panic recording by default for ordinary VMware guests and disable
it when guest memory encryption is active. Expose the policy as the
boolean kernel.vmware_record_panic_msg sysctl and document that it
controls only the vmware.log transfer.

Register the sysctl only after the panic buffer and dumper are ready, and
only when sysctl support is built. A registration failure leaves the
internal default in force.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 14 +++++++++++++
 arch/x86/kernel/cpu/vmware.c                | 23 +++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index b6328cd0f43e..4577e935ddcf 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1690,6 +1690,20 @@ entry will default to 2 instead of 0.
 = =============================================================
 
 
+vmware_record_panic_msg
+=======================
+
+Controls whether panic kmsg data is written to the host's ``vmware.log``.
+This setting does not control the separate VMware guest-crash event.
+
+= ==============================================================
+0 Do not write panic kmsg data to ``vmware.log``. This is the
+  default for encrypted guests.
+1 Write panic kmsg data to ``vmware.log``. This is the default for
+  ordinary guests.
+= ==============================================================
+
+
 warn_limit
 ==========
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index bf59653d6e07..3848811550e9 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -31,6 +31,7 @@
 #include <linux/efi.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
+#include <linux/sysctl.h>
 #include <linux/wordpart.h>
 #include <linux/sched/cputime.h>
 #include <asm/div64.h>
@@ -255,6 +256,19 @@ static int vmware_log_rpc(const char *buffer, size_t length)
 }
 
 static struct page *vmware_panic_page;
+static int vmware_record_panic_msg;
+
+static const struct ctl_table vmware_panic_sysctls[] = {
+	{
+		.procname	= "vmware_record_panic_msg",
+		.data		= &vmware_record_panic_msg,
+		.maxlen		= sizeof(vmware_record_panic_msg),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+};
 
 static void vmware_panic_log_dump(struct kmsg_dumper *dumper,
 				  struct kmsg_dump_detail *detail)
@@ -263,6 +277,9 @@ static void vmware_panic_log_dump(struct kmsg_dumper *dumper,
 	char *buffer = page_address(vmware_panic_page);
 	size_t length = 0;
 
+	if (!READ_ONCE(vmware_record_panic_msg))
+		return;
+
 	memcpy(buffer, VMWARE_LOG_PREFIX, VMWARE_LOG_PREFIX_LEN);
 	kmsg_dump_rewind(&iter);
 	(void)kmsg_dump_get_buffer(&iter, true,
@@ -283,6 +300,9 @@ static int __init vmware_panic_log_init(void)
 	if (!hypervisor_is_type(X86_HYPER_VMWARE))
 		return 0;
 
+	vmware_record_panic_msg =
+		!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
+
 	vmware_panic_page = alloc_page(GFP_KERNEL);
 	if (!vmware_panic_page) {
 		pr_err("failed to allocate panic log buffer\n");
@@ -295,6 +315,9 @@ static int __init vmware_panic_log_init(void)
 		__free_page(vmware_panic_page);
 		vmware_panic_page = NULL;
 	}
+	if (vmware_panic_page && IS_ENABLED(CONFIG_SYSCTL) &&
+	    !register_sysctl("kernel", vmware_panic_sysctls))
+		pr_err("failed to register panic log sysctl\n");
 
 	return 0;
 }
-- 
2.53.0


