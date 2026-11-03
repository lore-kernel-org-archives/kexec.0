Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347DB606D80F
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=11lC8K7x;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iiG8CCqB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=o3gZPUQLWwPhGV6D4A+78sPcL2sUrR6F9w4Qn0I0nOg=; b=11lC8K7x62gQen
	oD0wewvDWzq+M3MS1rR+6B0abyZcSth5qRg9ZmnwYSKrJZhjX/DBLraNqi7liQAXpGQAYg77sSE7Z
	gES9VP5tBPE1fDokQlL6W/8nPeOijtyfkTGk9YqZ/30LT0IAJGQubf1VX8mVQSPngFrkE8hRishe9
	7MUlU0k6Pm5XWAH6QL1sEmKhOcKUouj6MW+OvAajIUbRKuzvHkMTmq1AsH/5aa6j6L090GECfth3f
	ZIL5AtRXz+BEVmZsoeD7FjiaMUdy/zaVhGQucYPfOaFpSjeUbqVlnoN4DeTbGdonmPvtnqn7MNcqA
	uzwdfBVh11wwcOQ2aIEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9aZ-00000001UIK-1cAW;
	Tue, 03 Nov 2026 08:09:51 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9aV-00000001UFc-0iWx;
	Tue, 03 Nov 2026 08:09:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793693381; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=o3gZPUQLWwPhGV6D4A+78sPcL2sUrR6F9w4Qn0I0nOg=;
	b=iiG8CCqBa/RrPbbDC6xfxjAXrR/xIXBquz/CjKjtOdTcuOS56kKcqjxymuNzcQR+/v3OLS/XX4fj6/85TdZiiTTNlbvcQqSvnMgu7EDNRUC3YgykClcDbF3cI5OO4xsS9bJwmhE7oWjnnAEGGzqr0d3K5vzdonQBXhZ5OhptIQM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XE27L.Y_1793693380;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XE27L.Y_1793693380 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:09:40 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	alex@ghiti.fr,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	graf@amazon.com,
	shuah@kernel.org
Cc: guoren@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH v2 1/5] kho: Do not translate the handover FDT address in is_kho_boot()
Date: Tue,  3 Nov 2026 16:09:22 +0800
Message-ID: <20261103080926.2079-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103080926.2079-1-cp0613@linux.alibaba.com>
References: <20261103080926.2079-1-cp0613@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_000947_374025_8159AD55 
X-CRM114-Status: GOOD (  11.26  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

is_kho_boot() only has to say whether a handover FDT was recorded, but
it asks kho_get_fdt() for one and so converts kho_in.fdt_phys with
phys_to_virt() just to throw the pointer away. Both callers use it as a
boolean and never dereference the result.

On riscv64 that conversion is not valid yet when efi_init() reaches it:
setup_vm() leaves kernel_map.va_pa_offset at 0 and setup_bootmem()
assigns it later, so a handover boot that came through UEFI panics in
linear_mapping_pa_to_va(). Only debug builds fail -- without
CONFIG_DEBUG_VIRTUAL __va() degenerates to "phys + 0" and the boolean
stays correct -- but the panic also goes unnoticed without an earlycon.

Check the physical address instead. Nothing needs the translation, and
architectures stay free to bring their linear mapping up whenever they
like.

Fixes: d6d511639185 ("kexec: introduce is_kho_boot()")
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---

Tested on qemu-system-riscv64 (virt, -cpu max, TCG): edk2
RISCV_VIRT_CODE.fd/VARS.fd on pflash with OpenSBI fw_dynamic.bin below
it, and a GPT disk holding an ESP with grub plus the kernel and an ext4
partition as rootfs.  Kernel config is riscv defconfig plus
DEBUG_KERNEL, DEBUG_VIRTUAL, KEXEC_FILE, KEXEC_HANDOVER and the kho
selftest fragment; the outgoing kernel gets "kho=on" and the kho
selftest init does kexec_file_load() followed by reboot(RB_KEXEC).

Before, the first handover panics.  earlycon= is needed to see it: the
BUG precedes console registration, so without an earlycon the machine
goes silent right after kexec.

  KHO: found kexec handover data.
  efi: EFI v2.7 by EDK II
  kernel BUG at arch/riscv/mm/physaddr.c:47!
  epc : linear_mapping_pa_to_va+0x1c/0x1e
   ra : is_kho_boot+0x18/0x28

After, the same setup keeps handing over until the window closes, 29
consecutive boots and no BUG.

  KHO: found kexec handover data.
  KHO: exec from: 7.4.0-rc1-next-20261102-00005-gfca49e548231 (count 29)

 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6f1f55fe3181..6ab181de345c 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1643,7 +1643,7 @@ EXPORT_SYMBOL_GPL(kho_restore_free);
  */
 bool is_kho_boot(void)
 {
-	return !!kho_get_fdt();
+	return kho_in.fdt_phys != 0;
 }
 EXPORT_SYMBOL_GPL(is_kho_boot);
 
-- 
2.50.1


