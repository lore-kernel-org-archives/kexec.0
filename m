Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07B0C27C65
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=y8aKPtCrQNSGh00Eb9Z+YrhtM+1oL1pUPJ4lZ4Ah6RA=; b=LrSa8fEiww9u5q
	gA8/b3I+s1LVnkQPspwaYvW+tTIhXN9Txbhsg6lMdij+n+VnDZh95hujmovyZdX5VPX30FAb0KalF
	KReAdcDuvMvdOyClIo/qUV0kBmy4zxvR/chtClYq6h2cSe4Kj/QC7D7qX357e/t44ib+yikHckAn/
	GUS55AXJY29R/EU2k6Pg3NTx8xS1ulhYgtn8GNQZny8iE9IV98hEMwGr9nDRVS88BAUOrwoomBCoG
	3aVJPdckvmHJzhI1RcSnacvnzjaHm6vfFMqaV3Qs0GgtnEF/nxSC/RX2h4iq+NRBZaJWfh1DdOlco
	aOROIs0NzpyJFDVlxXpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9g-00000004cJm-0zhY;
	Mon, 10 Jun 2024 10:21:36 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGc9a-00000004cET-3dtr
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 10:21:33 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a6f177b78dcso121916066b.1
        for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014883; x=1718619683; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwHIHsN6FOqMaJ0QvL4YUcdXJqzusyELWmCpBOJ4s7U=;
        b=MV/twibzaZcbC3H6nGYqNNggt2Wn2lers90xwNhUNF8BnOj6Bw6Wli5BcNNbmwb6ZP
         1uANueKEs4+hLNxYXp1fnyCTUjOB+AEr4z+Uub8psH2EGIWak3QkcNWNMWt05/yC2bF4
         j7CJoKcu+PYftxusyhN6FNZjYDBc0J40NqPrrWFWvqs0OURVe+0EYf3z+EwbP35FQx3+
         zVFJi3ppGeVRzU/WjVR3B0wW3HhDI7J41ZKZff8/hoVCnuKFYPfPePnFW++fPw030WjQ
         aWYYc30d+PIm6gFCiz7NC1bKbel1KpKs3Dj87XtLarVsJ2gcb80EYAfnQ+0m13GJvbax
         Sa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014883; x=1718619683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwHIHsN6FOqMaJ0QvL4YUcdXJqzusyELWmCpBOJ4s7U=;
        b=mg0PPYtsWqjt2JKPOV+H/CphFQaoC2W27n1GnPMkr2ZMEgd9rGueCK8wU3X2GSuMdd
         eHgLj+R7CjbLs7+UU1M0/h6xF8om0fQZnn+SpXzz8PEGuZroOIaeh3uvcXWpaYEhP9rv
         4wbwCM6EIDDl+upYSQX0Vv0rvr+u8yMuyTHAy0VZ+1v7e/YgxJvwJR+5A4O39D34xlkO
         Iq9VmcRO6lu7atYL4iHi2pL4Df7rNIYOmfx/egZWanAH8Vdyv6H/z0VfkwUQNK6IMX90
         y1hy/wn95d43kuHCz+lnU7UYN6thUYgqwsB++PsufBGaUhLTPYO1t0V5ElszfvLzcMHA
         g8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0QwtxOgnGmVaQy39+FfmHhYOI+UvsGtWKGh1cGay0t8Uq4PAKe559VPMvv0vrAWdkOlMTfEPXl87olIwakDSE0dmhd1pMF7ra
X-Gm-Message-State: AOJu0YwktePsEnOiB8VQMPW/Sy5sv/VXOerh8VE0yVcytsjJwLOoMQgC
	zdwu7kxdvmwvWmq0H0/6849IeXnvfSmo+dJM0TKLm4ynctXm84HtoiuU5jR48nk=
X-Google-Smtp-Source: AGHT+IHYtZnMWrJ0IkdZ+MyDgpngsD09lt7KGhzA4zeGHE5BqNwD2tXuke8ut6t0IoCcbB5ZC+9Wmg==
X-Received: by 2002:a17:906:f198:b0:a6f:e36:aba8 with SMTP id a640c23a62f3a-a6f0e36acd5mr316798066b.33.1718014883287;
        Mon, 10 Jun 2024 03:21:23 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:22 -0700 (PDT)
From: vsntk18@gmail.com
To: vsntk18@gmail.com
Cc: x86@kernel.org,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com,
	ashish.kalra@amd.com,
	cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jroedel@suse.de,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	michael.roth@amd.com,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de
Subject: [PATCH v6 00/10] x86/sev: KEXEC/KDUMP support for SEV-ES guests
Date: Mon, 10 Jun 2024 12:21:03 +0200
Message-Id: <20240610102113.20969-1-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_032131_087056_EE42412C 
X-CRM114-Status: GOOD (  25.03  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Vasant Karasulli <vkarasulli@suse.de>

Hi,

here are changes to enable kexec/kdump in SEV-ES guests. The biggest
problem for supporting kexec/kdump under SEV-ES is to find a way to
hand the non-boot CPUs (APs) from one kernel to another.

Without SEV-ES the first kernel parks the CPUs in a HLT loop until
they get reset by the kexec'ed kernel via an INIT-SIPI-SIPI sequence.
For virtual machines the CPU reset is emulated by the hypervisor,
which sets the vCPU registers back to reset state.

This does not work under SEV-ES, because the hypervisor has no access
to the vCPU registers and can't make modifications to them. So an
SEV-ES guest needs to reset the vCPU itself and park it using the
AP-reset-hold protocol. Upon wakeup the guest needs to jump to
real-mode and to the reset-vector configured in the AP-Jump-Table.

The code to do this is the main part of this patch-set. It works by
placing code on the AP Jump-Table page itself to park the vCPU and for
jumping to the reset vector upon wakeup. The code on the AP Jump Table
runs in 16-bit protected mode with segment base set to the beginning
of the page. The AP Jump-Table is usually not within the first 1MB of
memory, so the code can't run in real-mode.

The AP Jump-Table is the best place to put the parking code, because
the memory is owned, but read-only by the firmware and writeable by
the OS. Only the first 4 bytes are used for the reset-vector, leaving
the rest of the page for code/data/stack to park a vCPU. The code
can't be in kernel memory because by the time the vCPU wakes up the
memory will be owned by the new kernel, which might have overwritten it
already.

The other patches add initial GHCB Version 2 protocol support, because
kexec/kdump need the MSR-based (without a GHCB) AP-reset-hold VMGEXIT,
which is a GHCB protocol version 2 feature.

The kexec'ed kernel is also entered via the decompressor and needs
MMIO support there, so this patch-set also adds MMIO #VC support to
the decompressor and support for handling CLFLUSH instructions.

Finally there is also code to disable kexec/kdump support at runtime
when the environment does not support it (e.g. no GHCB protocol
version 2 support or AP Jump Table over 4GB).

The diffstat looks big, but most of it is moving code for MMIO #VC
support around to make it available to the decompressor.

The previous version of this patch-set can be found here:

	https://lore.kernel.org/kvm/20240408074049.7049-1-vsntk18@gmail.com/

Please review.

Thanks,
   Vasant

Changes v5->v6:
        - Rebased to v6.10-rc3 kernel
   
Changes v4->v5:
        - Rebased to v6.9-rc2 kernel
	- Applied review comments by Tom Lendacky
	  - Exclude the AP jump table related code for SEV-SNP guests

Changes v3->v4:
        - Rebased to v6.8 kernel
	- Applied review comments by Sean Christopherson
	- Combined sev_es_setup_ap_jump_table() and sev_setup_ap_jump_table()
          into a single function which makes caching jump table address
          unnecessary
        - annotated struct sev_ap_jump_table_header with __packed attribute
	- added code to set up real mode data segment at boot time instead of
          hardcoding the value.

Joerg Roedel (9):
  x86/kexec/64: Disable kexec when SEV-ES is active
  x86/sev: Save and print negotiated GHCB protocol version
  x86/sev: Set GHCB data structure version
  x86/sev: Setup code to park APs in the AP Jump Table
  x86/sev: Park APs on AP Jump Table with GHCB protocol version 2
  x86/sev: Use AP Jump Table blob to stop CPU
  x86/sev: Add MMIO handling support to boot/compressed/ code
  x86/sev: Handle CLFLUSH MMIO events
  x86/kexec/64: Support kexec under SEV-ES with AP Jump Table Blob

Vasant Karasulli (1):
  x86/sev: Exclude AP jump table related code for SEV-SNP guests

 arch/x86/boot/compressed/sev.c          |  45 +-
 arch/x86/include/asm/insn-eval.h        |   1 +
 arch/x86/include/asm/realmode.h         |   5 +
 arch/x86/include/asm/sev-ap-jumptable.h |  30 +
 arch/x86/include/asm/sev.h              |   7 +
 arch/x86/kernel/machine_kexec_64.c      |  12 +
 arch/x86/kernel/process.c               |   8 +
 arch/x86/kernel/sev-shared.c            | 234 +++++-
 arch/x86/kernel/sev.c                   | 376 +++++-----
 arch/x86/lib/insn-eval-shared.c         | 921 ++++++++++++++++++++++++
 arch/x86/lib/insn-eval.c                | 911 +----------------------
 arch/x86/realmode/Makefile              |   9 +-
 arch/x86/realmode/init.c                |   5 +-
 arch/x86/realmode/rm/Makefile           |  11 +-
 arch/x86/realmode/rm/header.S           |   3 +
 arch/x86/realmode/rm/sev.S              |  85 +++
 arch/x86/realmode/rmpiggy.S             |   6 +
 arch/x86/realmode/sev/Makefile          |  33 +
 arch/x86/realmode/sev/ap_jump_table.S   | 131 ++++
 arch/x86/realmode/sev/ap_jump_table.lds |  24 +
 20 files changed, 1711 insertions(+), 1146 deletions(-)
 create mode 100644 arch/x86/include/asm/sev-ap-jumptable.h
 create mode 100644 arch/x86/lib/insn-eval-shared.c
 create mode 100644 arch/x86/realmode/rm/sev.S
 create mode 100644 arch/x86/realmode/sev/Makefile
 create mode 100644 arch/x86/realmode/sev/ap_jump_table.S
 create mode 100644 arch/x86/realmode/sev/ap_jump_table.lds


base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
