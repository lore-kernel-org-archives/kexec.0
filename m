Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945B606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JSgZ3x/1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=P2HyGofg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hDAVKUxd5qtHRxyEIWChofvlPqSC6zajAOsizwKxViY=; b=JSgZ3x/1Q2xVYRddxl3w2fYAu1
	yW5fUF4SjEIpSORLPHKw0mek3zsloc9mdF/Mn4d37E19kynsFWLLyvdnKGvuRNKB/MQ2dux4SF1w4
	noh46FXDJ5vBNUD3VCA6NNMk0GZNyLd0p0J90LFPzC8z6KCaLNdGWPFG62OjNcpF++dM3TLLkIyzD
	UlUoMEw+Wo5TiUSGIpLMTa3xIQwxhnMonzgEdgut0XtLfuEQopj7sAO7YpK2NUHSDqD6g2O+r1glm
	H+oBt+0nZ8M5CgNhdmlMR5OUnSo8PwVPIrYBkDYZLue4tDPqUGQtvV7hEC1P3kPuYUUR8j/IQlNJA
	ZCXIRSIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTYqE-00000007q1t-3uN3;
	Wed, 18 Nov 2026 06:08:22 +0000
Received: from mail-pg1-x562.google.com ([2607:f8b0:4864:20::562])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTYqC-00000007q0i-0HdQ
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 06:08:21 +0000
Received: by mail-pg1-x562.google.com with SMTP id 41be03b00d2f7-cddc250d815so363264a12.2
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 22:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794982099; x=1795586899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDAVKUxd5qtHRxyEIWChofvlPqSC6zajAOsizwKxViY=;
        b=eiC9qk+bVXYIGEEtWYZeSarhgmCF4R+CsEiQFxN/8qbrGNFm3zXeliTqm+1aGQlTEj
         dPD/RcsXGOHODV5Mx2bmkFBj/APLDkwq4ZB3scBhKDPzEAqgljYWzC9YnYNvQZhCI9qI
         kYHMYdvGrQ37OO6zqQ9dqP9HZ2r/4AqrVABEgMPHg8sYVdN0q90WAXgXFXoXzczDVWiw
         apEja/dkpWssJnuAPUMciPpSu1aNWYauc8fOyWVZFD8GS5Fjc0klQwJy5zc1sairnpoK
         BVjHKTT3TevYJPlIgdeZm2Qt7AfKQ9VB8fFXVDBjp+I0WldGJK2N7UuJJX4SDXYZ3yGD
         jFQQ==
X-Forwarded-Encrypted: i=1; AL+hErHUbV0wyNuds5QTcBbAWtXsFTxHjYYPn6POfCNX2aiZ4RJwQIY6MqqgdBZ/m+2qqyYDw4NzDA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/ZY45T7a1kfwDkUSEX7E8vQ7YIcLZAOxMSJS5C5uAaR1UVGY8N
	pptvrQCZB4y6wpcoK72TuK3u0coiAIJQGrzYv5GWRJqWq9rEWFlx9zDabTS8CwnSISzY08vMNQS
	xJsinob6uA497xfgE1IXIfTDqYVKJVaWHKuKueStYejur8AzX5+FCCYYxRjKPTVU5wPaQkg7I95
	Z6azOcxNNTHiQE2d+p0twB4HfHxJKiSBhrOtn6Oraf1QRlTPFKG2cCUC8R7XK69nuLE55FKCpnp
	bgBzhQNu2g+
X-Gm-Gg: AZFdTZcyrRbPdxfy2nx6nwGpODmGSj9pVtGa6cKkUnYJ46W7+qJ08IktxVCaVgQWzuy
	FwD0DrWpuuIYP9d6A8DZtGU6rqXjRc4ygnSmkQmgKVd+0Fx4You1eEyoFsvDf8FTU0GqU2PwRpJ
	f4/uATsLx4lSJ+TMje9cTpXA7sjzzAeCj3X0+l7TV56w8beWeqa2Oon3cWAmTWELaYbePE0J25u
	aOTSSzYVsiG9EnUzxsfQobliw3BiaX48bK3Hm9ms+INkiUO8YqXj5TVVWL3yXeeOXvU5inSTtN+
	/y8i2SfxjqM3tRfqQfs8jRKODBIFG0IpD5N3zBQ63QqKkQwSt9A6I/Hm230oF7u3MNAvBhnly6O
	+AoaqP0yvtsl6M3qNCUhx1/yZroZnhFqZ/JB9MSFXoWqU2tLh6mgF7Aj3XaWbXB7tAZX4c0czIu
	RcAKacnpOEiw225M8aAxZzzjRDgQGFV9KE
X-Received: by 2002:a17:90b:4b:b0:3ad:4a8b:c703 with SMTP id 98e67ed59e1d1-3b3d0764a41mr1725840a91.19.1794982098939;
        Tue, 17 Nov 2026 22:08:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3abb84fe8sm3504832a91.2.2026.11.17.22.08.18
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:08:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7d2d8e6fe02so422567137.3
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 22:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794982098; x=1795586898; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hDAVKUxd5qtHRxyEIWChofvlPqSC6zajAOsizwKxViY=;
        b=P2HyGofgL9DX+ATANITzSOl7HonuRLeODUE4zeLb+EcNsrpycu4+lqnjjM/djGgcxN
         2ZlqNoxna9W8jzwDR0tvf6Gmgjl7+4h9NuxmUFlpTOKxuj37am9r21GHGY33U5+bwPfA
         cAGlAmXrGRTWxSGlbPNL/9Df1Al0o0n/LFuHk=
X-Forwarded-Encrypted: i=1; AL+hErEUulTVK7Zr3qIWoz+9ZvCEFQ7nqySSRbKLbi/ldtKcGbDqp9nUe8BRoVS+M06O9YtfruKqng==@lists.infradead.org
X-Received: by 2002:a05:622a:50e:b0:55b:8632:6d42 with SMTP id d75a77b69052e-55d5a539184mr26035361cf.23.1794981730209;
        Tue, 17 Nov 2026 22:02:10 -0800 (PST)
X-Received: by 2002:a05:622a:50e:b0:55b:8632:6d42 with SMTP id d75a77b69052e-55d5a539184mr26035081cf.23.1794981729786;
        Tue, 17 Nov 2026 22:02:09 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58ff0065sm14886841cf.5.2026.11.17.22.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:02:05 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Date: Wed, 18 Nov 2026 01:01:50 -0500
Message-ID: <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794980455.git.zack.rusin@broadcom.com>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_220820_115557_D0EE8B83 
X-CRM114-Status: GOOD (  19.33  )
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow administrators to disable host log transfer on ordinary guests or
opt in on encrypted guests. Expose the boolean recording policy through
kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
Zero disables recording, nonzero integers enable it, and reads return
0 or 1.

Register the sysctl only after the logger is ready. A registration failure
leaves the internal default in force. Document that the log is sent
before kdump, and that disable_panic_notifiers_platform_list also skips
it.

Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v4: No change.

v3: Document the platform list ordering and the disable switch, and fix
the short section-title underline reported by Sashiko. No code change
from v2.

 Documentation/admin-guide/sysctl/kernel.rst | 20 ++++++++++++++++++++
 arch/x86/kernel/cpu/vmware.c                | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 608055d7ccc4..be2d5aa52362 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1680,6 +1680,26 @@ entry will default to 2 instead of 0.
 = =============================================================
 
 
+vmware_record_panic_msg
+=======================
+
+Controls whether kmsg data is written to the host's ``vmware.log`` on
+panic. This setting does not control the separate VMware guest-crash
+event. Writing zero disables recording; writing a nonzero integer
+enables it. Reads return 0 or 1.
+
+= ==============================================================
+0 Do not write kmsg data to ``vmware.log``. This is the default
+  for encrypted guests.
+1 Write kmsg data to ``vmware.log``. This is the default for
+  ordinary guests.
+= ==============================================================
+
+The data is written by a platform panic notifier: early in panic,
+before kdump, and also when a fatal oops enters kdump without a panic.
+Setting ``disable_panic_notifiers_platform_list`` skips it as well.
+
+
 warn_limit
 ==========
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 0c6f7248a665..8c8b6dd7c3e8 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -33,6 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/sizes.h>
 #include <linux/static_call.h>
+#include <linux/sysctl.h>
 #include <linux/wordpart.h>
 #include <linux/sched/cputime.h>
 #include <asm/div64.h>
@@ -260,6 +261,16 @@ static int vmware_log_rpc(const char *buffer, size_t length)
 static struct page *vmware_panic_page;
 static bool vmware_record_panic_msg;
 
+static const struct ctl_table vmware_panic_sysctls[] = {
+	{
+		.procname	= "vmware_record_panic_msg",
+		.data		= &vmware_record_panic_msg,
+		.maxlen		= sizeof(vmware_record_panic_msg),
+		.mode		= 0644,
+		.proc_handler	= proc_dobool,
+	},
+};
+
 static int vmware_panic_log_notify(struct notifier_block *nb,
 				   unsigned long action, void *data)
 {
@@ -311,6 +322,10 @@ static int __init vmware_panic_log_init(void)
 		vmware_panic_page = NULL;
 	}
 
+	if (vmware_panic_page && IS_ENABLED(CONFIG_SYSCTL) &&
+	    !register_sysctl("kernel", vmware_panic_sysctls))
+		pr_err("failed to register panic log sysctl\n");
+
 	return 0;
 }
 early_initcall(vmware_panic_log_init);

