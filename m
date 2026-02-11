Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E01EB597B
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 08:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=G1KvghMrg5FQLYtugCrRlvN5/+TeaaG+RNwvPgguvEY=; b=UeqdLO1c/MhQHf
	wqPyHpcaCFq3jGQXBwl6dckW/qrpQXVjiXuqpEztttT3FCkBmilLkevGvHnlOOf57/+eKd+BSotu8
	Y4urO0FT+5+NGyLesqU9OPp/vQM+7qj5AF3yf1jIr0E4w7rgE6P5/XzOibCJ7UQY08MggzACCtO5B
	xTPUI6m3UeVClYG2+NAgX2v5LtdwXgw+LRzWs7B/8pGa6xU5HBH+NJo4HQM2Zu225ZDdDgcJIqPka
	KGFo5D7nvyTW0nvJYGWFlaDUSi35reKUjGKrDWDy4wy4S6LgqZJGcF6BgP3lDYOe5oLZDB09hBzbn
	crVQ7Zr24qfrU8O2YTHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq5WB-00000000O0B-25Vu;
	Wed, 11 Feb 2026 08:24:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq5W8-00000000Nyx-1wkH
	for kexec@lists.infradead.org;
	Wed, 11 Feb 2026 08:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770798249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G1KvghMrg5FQLYtugCrRlvN5/+TeaaG+RNwvPgguvEY=;
	b=RoLDxS1t2M1rg5JM2bTEhKw3w1PhNwBmcsmmYM1j4K4xBMqBRQ8a71LdKmRYISXWgHcwL5
	ccoPWzgncTk4+03q5R1LLu2VGaUsXD/2ZTNL70o7ist8/4kWF20WeNxjP59WL/zKoSR/CX
	CqbC7TLIdl5aN4/aruIVDio9hjMxSNA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-lvOAjQbVNl65aWJc0cHQIw-1; Wed, 11 Feb 2026 03:24:07 -0500
X-MC-Unique: lvOAjQbVNl65aWJc0cHQIw-1
X-Mimecast-MFC-AGG-ID: lvOAjQbVNl65aWJc0cHQIw_1770798247
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad6045810so15371345ad.3
        for <kexec@lists.infradead.org>; Wed, 11 Feb 2026 00:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770798246; x=1771403046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1KvghMrg5FQLYtugCrRlvN5/+TeaaG+RNwvPgguvEY=;
        b=oQ300d5r7Vs5af2BllwbiVdjAkVAu5ep+BRVY54E/jy2J4RpHS4kCrmzxvroV885kl
         oCt0xZGHUzqsprsmjh2grl+IdK/hBOrGOxAbNDdbU0XQN80aMBud6OIp8AEhKSvhPldL
         A9/Sj9l1zfaBXmki76cEkSY04xekLOFKf5mVWuOcOqWMRuQ5yyOu7fbyG5UC4XkjcDDQ
         uk3rpRR7HtnQRMoHa9PUC8bWr9vILnrHCQpRs3dJHGTLf+Kl4mJqzIkbC+SYASrGJGsb
         iSncL/m06Ltba8bApT9s2sBzjM5rKQlf5psVU51Tv1M+n7QjIILl7v8UNCBFUiMDsxrP
         ykig==
X-Gm-Message-State: AOJu0YxyBTqjsWm29sBTTN2he0r8i/YUbAtuBYLnIICLJ0IubYY0U6qj
	FTsumqG2MrUTtfDwHkmPVoDbt9hRIA4oUeOM1np8fg3uAD2fxm4Srh/aLoUmXvyJ4TMeaEzLNuI
	9ASfLCQCRy7dbdMZYZv7gciviN51oJf9N9OLPSokQbqhkYIEZijBHOm+TRKq6mqg6RNecfATkCk
	TF4DjQYhDm+ObCAYHvcUorHHqMLMm2FH9MXUnQzPCUumc=
X-Gm-Gg: AZuq6aLTy+kz4OmoQc/ViWaqOwxRrbVWUWt2wPpMF8V2nt8qLUOC4ir6S4ues/IBGvS
	HDBd9vDvnXUDyhHP0bikeoD/tbg3s/JVosHGrEY1pDXVG4R9xj3UpLkBrtjBP/KzVgYPPGVwL4f
	siX7PQnhTCZr88eqlW6acVBiMWQQrn3Upg17AXBLPf2Mv8yUiglHChV9k9E43a0sHoop/YV48+b
	vXP4HlFor4UYYfeTU+QW553jbFNDg7vgQt56i4IMLS6lBs5EWyxF1DLfMmH0wHwuet6736XeiEi
	5jOtxZPrWg3gem4jmXgfm1F4xd1kE5lqj7tc1SQHUZy6POg6ss8PSkfEeSs6h3G8nc/qLTgwUQA
	nUuhHx1SZaEsI
X-Received: by 2002:a17:903:985:b0:2a9:cb10:42d with SMTP id d9443c01a7336-2a9cb100bcemr122999185ad.61.1770798246267;
        Wed, 11 Feb 2026 00:24:06 -0800 (PST)
X-Received: by 2002:a17:903:985:b0:2a9:cb10:42d with SMTP id d9443c01a7336-2a9cb100bcemr122998855ad.61.1770798245566;
        Wed, 11 Feb 2026 00:24:05 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ab0esm15186415ad.9.2026.02.11.00.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 00:24:05 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 0/2] kdump: Enable LUKS-encrypted dump target support in ARM64 and PowerPC
Date: Wed, 11 Feb 2026 16:23:58 +0800
Message-ID: <20260211082401.2407853-1-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cKLpE6Ip-_mnOt5aIP59WM3idtT6sQRm7_xt7yIVr6U_1770798247
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_002412_564853_10B92F75 
X-CRM114-Status: GOOD (  11.40  )
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

CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
device dump target by addressing two challenges [1],
 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump.

To also enable this feature for ARM64 and PowerPC, we only need to add a
device tree property dmcryptkeys [2] as similar to elfcorehdr to pass the
memory address of the stored info of dm-crypt keys to the kdump kernel.

[1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
[2] https://github.com/devicetree-org/dt-schema/pull/181


v4
- Make arch-specific code more succinct by printing more logs in
  arch-independent code [Will Deacon]  

- Also use device tree for PowerPC to pass memory address of dm-crypt
  keys info
  - powerpc v2 patch that passes the dmcryptkeys kernel cmdline
    parameter:
    https://lore.kernel.org/all/20260106074039.564707-1-coxu@redhat.com/

v3
- Delete the property after reading it [Rob Herring]

v2
- Krzysztof
  - Use imperative mood for commit message
  - Add dt-schema ABI Documentation 
    https://github.com/devicetree-org/dt-schema/pull/181
- Don't print dm-crypt keys address via pr_debug

Coiby Xu (2):
  crash_dump/dm-crypt: Don't print in arch-specific code
  arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel

 arch/arm64/kernel/machine_kexec_file.c |  4 ++++
 arch/powerpc/kexec/elf_64.c            |  4 ++++
 arch/x86/kernel/kexec-bzimage64.c      |  6 +-----
 drivers/of/fdt.c                       | 21 +++++++++++++++++++++
 drivers/of/kexec.c                     | 19 +++++++++++++++++++
 kernel/crash_dump_dm_crypt.c           |  7 +++++--
 6 files changed, 54 insertions(+), 7 deletions(-)


base-commit: 2619c62b7ef2f463bcbbb34af122689c09855c23
-- 
2.53.0


