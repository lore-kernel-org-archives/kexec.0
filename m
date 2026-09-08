Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD681C79F99
	for <kexec@archiver.kernel.org>; Tue,  8 Sep 2026 18:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r+VLJNR2ClH5aaw8GL8jeSbQjtC7qAwKNhxP9YK5biY=; b=SeDHKqxc0QBcKhuW2z3etEh0Wt
	DtIkO2N/3HrIFXuLqQzRrBObRh3epkELemV92rJz/eqvjMbiedmNcnsq0Z28Oe7bMqwhduNOKWOmq
	Vssa2OzrU34WgohENVwnCV6g+NZcqLmpiED3eSCICM2+60/vwqOhWEFQ93Ku9Z0U/vPjbtdAaWD8P
	6s+wE1uli/f0ySqSxa4cY1m+aT3hicGogM8BFGbhNqVZeGwZn5zodYGpUtU/fYadMhBTMzH2Zl8jT
	ticaVn1u+x4hFILCIV0a6azZ6f26hsHzD9/WE9yxlGl+IkcsFcWJg+77UFuBmncc0nV2G8xeOb3Wy
	rP6xpPlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40EI-00000009w6F-3Rx0;
	Tue, 08 Sep 2026 18:07:34 +0000
Received: from mail-oo1-xc61.google.com ([2607:f8b0:4864:20::c61])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40EF-00000009w5K-1M3V
	for kexec@lists.infradead.org;
	Tue, 08 Sep 2026 18:07:33 +0000
Received: by mail-oo1-xc61.google.com with SMTP id 006d021491bc7-6bd07679624so842422eaf.1
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 11:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890849; x=1789495649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r+VLJNR2ClH5aaw8GL8jeSbQjtC7qAwKNhxP9YK5biY=;
        b=IZ/sjRJR7W5NF1cs9vqK14ZpzkDaSCZkByDhQHHaVqJW3kaqq6ExdZ5ZH4wMJ6d8TY
         irkcubktDd/RqahDSyqhiG2Lac1Pdiq+DOjttCQJatM6izmZoO8Cvj2d/NJUNzoNPoMU
         jh9I5FJrbcBhIW5nBlnUy2PEvrgv8NV9PjRlQUaYLEXpsmW7qncqAKeCOquFbN+qu91x
         q7iSvEV9nh17tLT02CDKqt4ZbkAyCgi+UVfVLME9QE1uXLreT++DTBzeru+p7wQj07c0
         gAvfsDZ5qlgcle+W1oZMwNJP5hEa9GllpqFuwtQLkXL2PxxqZ2jpFXTBTOrvrc/tjUcb
         bWKg==
X-Forwarded-Encrypted: i=1; AKwUvBxlw3aTh194r+FuptkDUyILjje9m3JTPANEEWHiqSvD2sv5hLBcvEmA+gDK2hcctV88pIuWnA==@lists.infradead.org
X-Gm-Message-State: AFuF++mLFMR7rPRn1rl1rEQyjpF/1hhlwj96IZ4UtlElqxMxDrZadI2S
	gCEDkhJxzzUqRoZKfgXEV5fa0j79/BaoOgTLrB5qOSuB/2C9jttdDN6lgL7ZL4olMQhoaFKACsJ
	N94FS9keL05dIQTz0XgAmT8zmxzbYkRecUW/p5rK9vh0niHQ/D++K57Fc6uvvsXMBbseaTqF1GV
	BuklehEKm/ZcJNzPgi4EjoonJV+f/BZUPupNdFc7Hw9ltApXjEUJYfkajJ0IJIOkdbbkWyTDW5V
	uceqEU9cJie
X-Gm-Gg: AYBFou2gALEK+JQ1jikUgrBV+Zwf79y9ljhp/d2vO5yLjcCluBo2KHW750i8qooLxE2
	CTE1gLEzHJi93JRgyp1a5/iCVbDKw3cSARpzobd2tEZrC8fhp2ahszI4qZ7FO9KNv7jmyx1dSpH
	p4Ts3Bl6GUz49k4rxtpqYUsMc3vAF4VdpP9e4wesSm+B9x9s+DowonhZazx0XdwTSyJJqduePLQ
	vDVSiESbpK2GZ+DuPfo6IGVD16wfsUgLkdcHQ4GqKEZ11zMeOGbQ5qLlSwF2sJWP1a7ceWzUUdH
	rkTRNKlSZkm2hrlsCxr1iDBz5zdFe3GtQWGwqm9vvrS/NEDu8OvHMlMnQG3yU2+MEgA71bLGLhr
	riVvwHfVvtBXCaK0604WHASNzsxaoifXg6YzaFSj+kom6QNnclGQwnkyDNmRKa7DGSrJq14gDqY
	NXUwab0DYHn6h/RyE/IhpQ1J8YJEW8vCbA
X-Received: by 2002:a05:6820:201b:b0:6b7:46fc:1d0 with SMTP id 006d021491bc7-6b746fc0280mr16791935eaf.47.1788890848880;
        Tue, 08 Sep 2026 11:07:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-475523da584sm223082fac.1.2026.09.08.11.07.28
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 11:07:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66c73057f18so3394756d50.3
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788890847; x=1789495647; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r+VLJNR2ClH5aaw8GL8jeSbQjtC7qAwKNhxP9YK5biY=;
        b=NovQvU+p+0nWUkHf2hTsMDNFM0EWYws11BC/4quGduV08XZQeCiuIJG3yHKY6tGFgK
         VhKQs3GRSlVihg6Y0RSSR8fpWIAclXC4dYScowX2muYNNet7TbNrvUsRcBTH4pMmpdmQ
         P8seUPqFCLxkj/b73stWgwiHLLtPfk1ywo69I=
X-Forwarded-Encrypted: i=1; AKwUvBxehHicJ34QgIVdv8eQokezpcJ9g1uKLshL4rEt260+GcxKv/Je+vWPe7HNdfI1Ofx1bS1qow==@lists.infradead.org
X-Received: by 2002:a53:e8c5:0:b0:66f:c1be:84d8 with SMTP id 956f58d0204a3-66fc1be866cmr7220604d50.70.1788890847347;
        Tue, 08 Sep 2026 11:07:27 -0700 (PDT)
X-Received: by 2002:a53:e8c5:0:b0:66f:c1be:84d8 with SMTP id 956f58d0204a3-66fc1be866cmr7220569d50.70.1788890846854;
        Tue, 08 Sep 2026 11:07:26 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm27114866d6.20.2026.09.08.11.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:07:25 -0700 (PDT)
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
Subject: [PATCH v1 0/4] x86/vmware: Preserve panic diagnostics in vmware.log
Date: Tue,  8 Sep 2026 14:07:12 -0400
Message-ID: <cover.1788414671.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_110731_371511_ACDC2B5A 
X-CRM114-Status: UNSURE (   9.92  )
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

A virtual machine may have neither guest-local persistent storage nor
working userspace after a panic. The host's vmware.log remains available
after the VM terminates, and a production encrypted guest is the only
component able to export readable panic text. Hyper-V already provides
this class of host-persistent panic reporting.

Add a panic-only VMware logger that copies the newest 4 KiB of the kernel
log and sends it with bounded low-bandwidth RPC work. Ordinary guests
enable text transfer by default; encrypted guests require an administrator
to opt in through kernel.vmware_record_panic_msg. A separate late dumper
reports the structured crash event after built-in dumpers and suppresses
the event while a crash kernel is loaded, because a configured VMware host
may terminate the VM before the reporting hypercall returns.

Patch 4 makes panic diagnostics run before kdump by default on VMware
guests. This follows existing platform uses of
crash_kexec_post_notifiers, with Hyper-V as the closest guest-reporting
precedent. Unlike Hyper-V, VMware exposes no capability bit for this
behavior. An explicit crash_kexec_post_notifiers=0 still wins, and patch 4
can be dropped without affecting patches 1 through 3.

This replaces patches 2 and 3 of Alexey's v2 posting:
https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/

The intended merge path is tip's x86/vmware branch. Boris please review the
VMware transport and policy. Petr and John, please review the panic-only
dumper use and registration ordering. Joel and Kees, please review the
sysctl. Baoquan and the KEXEC/KDUMP team, please review the 
loaded-crash-kernel guard and the default in patch 4.

Zack Rusin (4):
  x86/vmware: Add a bounded panic log sender
  x86/vmware: Add the vmware_record_panic_msg sysctl
  x86/vmware: Report guest crashes after kmsg dumpers
  x86/vmware: Run panic diagnostics before kdump by default

 Documentation/admin-guide/sysctl/kernel.rst |  14 ++
 arch/x86/include/asm/vmware.h               |   2 +
 arch/x86/kernel/cpu/vmware.c                | 245 ++++++++++++++++++++
 3 files changed, 261 insertions(+)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0


