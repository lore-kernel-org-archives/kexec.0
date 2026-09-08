Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2B0C79F9E
	for <kexec@archiver.kernel.org>; Tue,  8 Sep 2026 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rb9I7ysehn3T8EdRE3wvUpvmDJ0lCancFwS1A6o0B9Y=; b=x7hXQQQC005tUDjviRiRdPUWZ+
	Bx/t5BCZfhkvgE6D1uLHYk6q7R7j+wc/5QqJfPKbS+1QAkF4DrekjyDfjVqZCrYV7UN8ciqp+KYF8
	E9xS8UeBGUCDGzm0PfJfP+VET4f4lhb9w8D/ADIROrQLVYHnYX00PBoCZFSKNW8YwhEk8eyih+Ihj
	vvHCbPoC/K95kW+H6dqiI/xBZMDH1Y992yC2Aconbpu2mz8UhDKTilUo2J7hJVEKVx5VABWaYG1zc
	IHQL8yuB2BLrccp4A33h8ltZgw08WXFbh6qUerTHi2QMsgbRkDMctCbRdfmtaXGV7LHV2cXTuw3lg
	FXz4xC4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40EU-00000009wBX-1ABi;
	Tue, 08 Sep 2026 18:07:46 +0000
Received: from mail-pj1-x1063.google.com ([2607:f8b0:4864:20::1063])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40ES-00000009w9o-27sR
	for kexec@lists.infradead.org;
	Tue, 08 Sep 2026 18:07:45 +0000
Received: by mail-pj1-x1063.google.com with SMTP id 98e67ed59e1d1-3964e480f76so5655805a91.1
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 11:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890864; x=1789495664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rb9I7ysehn3T8EdRE3wvUpvmDJ0lCancFwS1A6o0B9Y=;
        b=rCgAVM1MJKAG9g9rdmJwcSzdcb3T4jWKsMGxBUyZH59NifI/mQdh1emNV1IAi9pshI
         VSa8TDPoA0c5nO/B1t95C8wei8HbzO0GzYweS1W1qsj8UfkFxOScsMkeFqmQNeefRG37
         ih2KALIhCzJYPbnc5GWMgDO7JDg3P2rVG1wXjJTq+ZanWrSQUPDFEKGzxLggk1OLLuOT
         WmNf4Y9UlfJHhvC8WeOx8/n2vl0a4jNa5/vY9BWGwkyZ4imOBPusSe1B2B6nPXJuBSVj
         FgQajb+kMAdZmRCIuDHwZVTr5jNoL63BaQOwhhyMe7xxOTG5UTrJ+/OQmDyUV2xOtmoY
         9nRg==
X-Forwarded-Encrypted: i=1; AKwUvBymLuUx/pqoa4MVWV/s8pqvM7UPO3IoR8RYErCzcOf5phcRXLO7csOXDzNQrzaz1G/Kq1i02Q==@lists.infradead.org
X-Gm-Message-State: AFuF++lEiii+tuSjti2Pjv55WTw9++HQC+PiHLOgFnM4G6SOvZfEHCOP
	ueQ+nFmB4XazT7TRNdicx9LvWGfirlmDo/xdfXCHecrBWifTFo/umSjoe6vYw2ICs9WFRRaxqxr
	aHzuEqCfskATpeV9lFEfUZchXBFStd6ftQ8VgZjerr2A+anJPMsK6SZUT0CWu2Ufs/AsHBwv7/Z
	9iq/G9wPogvPnD18MN0ejeBsaQz4X1mjBK7903Gnn9JfbszrJIcyZ9Mm+wd82AgB1hkXymlHLE5
	n70xRGKDA4K
X-Gm-Gg: AYBFou3tUkfHxVRF7K9KKewNv4FjL5Hoq3dR0tyHimbZ1nFR/Vz+21VXcIcnmT4kNTU
	brx1tln0FnojEEb9myY/j+RcXAF0NuMZofYi8ivrwDogLkw2ihYApBJzyWfJgFnV0C5UE78JrpZ
	lFnzDUMS25BfdR1xT3Q2AAuDzhIlPrGUDDcDFJJ5bNbSJVT64sDkiYwvKAGA4uXsZgZ6W2tF3jl
	VowoZm4beV1WZd1/rBq4YLibjl4X4xdvl6mlP3RLoGipMC4vnzUHhWMsanY9YG4oltEppUM1gVx
	VEB+VtyvFurp0QMbQ+RLFVmftoUcCXDid3xPuwpBgvDidtzUzKCXf+ZoGAn9jRYsKiwNybPNzux
	fJiUfffHWuZXu6saJ/6uHNxz+I5U3l31bLSVAwKC6Z1LQNLv0sNRybdZrFf5zGYwmn8S9wTNJ2N
	r1QABRORlwB4AMgB4tOE8BQ0aFwU59T+7D
X-Received: by 2002:a17:90b:268d:b0:398:bdb0:adb7 with SMTP id 98e67ed59e1d1-39b261e1beemr49103792a91.16.1788890863600;
        Tue, 08 Sep 2026 11:07:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39b28c68f8csm8522494a91.5.2026.09.08.11.07.43
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 11:07:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66f7d131b55so516671d50.0
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788890862; x=1789495662; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rb9I7ysehn3T8EdRE3wvUpvmDJ0lCancFwS1A6o0B9Y=;
        b=avA8iSCRdphymYC8I2oUxncPm/CD2bfMaiWQHE/bScURLBdp6TNE8j02aKv/7AYsx6
         XlFDFRxG1KBByiKJQsdbTNIvvDH2LHcFxsUK7koS4f6T3Jo085dQHcMlUhWtaT9OOMjU
         LjD+P7zCXblHBvrlZ+mr3f2+eja8+BCuxgIPw=
X-Forwarded-Encrypted: i=1; AKwUvByRk4EcTCiYXL+OCYIynfk9YIhxUJFEhAUi+Dbwzt2LloOVUvHSZ51f/nQ5pcj5jukQQldpWA==@lists.infradead.org
X-Received: by 2002:a05:690e:1b44:b0:66f:9e32:fe1 with SMTP id 956f58d0204a3-66fb5921a72mr6969458d50.10.1788890861951;
        Tue, 08 Sep 2026 11:07:41 -0700 (PDT)
X-Received: by 2002:a05:690e:1b44:b0:66f:9e32:fe1 with SMTP id 956f58d0204a3-66fb5921a72mr6969419d50.10.1788890861415;
        Tue, 08 Sep 2026 11:07:41 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm27114866d6.20.2026.09.08.11.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:07:38 -0700 (PDT)
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
Subject: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by default
Date: Tue,  8 Sep 2026 14:07:16 -0400
Message-ID: <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788414671.git.zack.rusin@broadcom.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_110744_549394_C3D241F9 
X-CRM114-Status: GOOD (  13.17  )
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

The core panic path enters a loaded crash kernel before running kmsg
dumpers, so the VMware logger cannot preserve the panic in the host log.
Set crash_kexec_post_notifiers during VMware platform setup. setup_arch()
runs before ordinary core parameters are parsed, so an explicit
crash_kexec_post_notifiers=0 still overrides this default. The 0644
parameter also remains writable at runtime.

VMware exposes no capability bit for this behavior, so the default changes
for every VMware guest. Running the logger first adds work to the panic
path and can reduce kdump reliability.

A full log transfer uses 1027 low-bandwidth hypercalls; three checkpoint
attempts are bounded at 3077. In vmcall tests, a maximum-size transfer
took at most 7.47 ms; three complete transfers comprising 3081 calls took
at most 21.58 ms.

The crash report remains suppressed while a crash kernel is loaded because
the host may terminate the VM inside that call. A future report from the
crash kernel or kdump userspace can restore the event after saving the
vmcore.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c21fc835537f..d88c625d8389 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -646,6 +646,7 @@ static void __init vmware_platform_setup(void)
 {
 	u32 eax, ebx, ecx;
 	u64 lpj, tsc_khz;
+	crash_kexec_post_notifiers = true;
 
 	eax = vmware_hypercall3(VMWARE_CMD_GETHZ, UINT_MAX, &ebx, &ecx);
 
-- 
2.53.0


