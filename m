Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A503C53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 03:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OUX/j6sp52Vt4JXvM+Ymh/ITq0VM2JiwvV4bvngUPVA=; b=GOY5PGHCV4C7XFWUxsNvObUnfz
	KFjjk1rpKnLbK5sM1OFMBz4s1RdMGVf3y2j6aRpdJgI9+qADnbNy2Qfx5H36WAScLNzUCKBc1d/+I
	sUhVNbB8oGmh1WbyhDKFbpLhwQ7q64oS6qrigU2qIhh5qZrBvd33AYNPm1P+QPjwSkfG33LjBpooY
	Un9rnnCtH9LrkjMrSon449LZG7nOndL2uDQpJZxpeL53S+P4EWKjNB//MeZYgUO16Hg1vT6syRsuN
	u2va8CEB/E8odWtOKDLqnN2oZg3PV+p4RRHsRhFKuhzBRDHwV8PUyWjA1F7lZXJdgej6pgFRWWIo2
	SsyLGzuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6L-00000006lL9-3gsS;
	Wed, 29 Jul 2026 03:37:01 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6J-00000006lKo-0SDY
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 03:37:00 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so243906a12.1
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 20:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296217; x=1785901017; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OUX/j6sp52Vt4JXvM+Ymh/ITq0VM2JiwvV4bvngUPVA=;
        b=OODwg/PIX3KTyxeTO+8voNTE+glWyjA0wxQN3QxqkT5iVTFeyg2KskmPXCpxUbmuIT
         yBrDcZh3K9RRR233YehaGXAGERfCd+8OK2oBq7wFVMJLii8seluqm/w6BjsgXRIFa7Ep
         ZboytmqiJ5pbi5b4qUcuIuEl9LvKxwzftuhArD43+JjKxpISu5FN9KYZ08g6Wjk5rWtX
         3xCR+e/0C8scKg+umW1HAgtVOJi+RrC4NXoaVVeGWZT2tuHLdK8H0eRjgN4aTvPC4Kam
         xPREHYPJqutwp2Fex1O+p/pwb5OJC/MXMxSr1ewPTliv/kyakcFbmg+FA8TcWCRAnqCD
         l9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296217; x=1785901017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUX/j6sp52Vt4JXvM+Ymh/ITq0VM2JiwvV4bvngUPVA=;
        b=Qk/nSw+XY1030aXitQ2eLxGagtlfELYnNJoQWwjL3ZkP6bQ5gN8tgMiaJl10bXA/Qr
         0eHMyDnukVRmO043EJSjnbPSF15Qr8582W8D/2rkWowj/DutYvtKigGcHLP7/Vvswkl4
         VSfp5RXrePlhWs4N0GoQFtWkq6qzhGsealf24J5tEUEF28PV6gpp638jDUfVlcZevyHa
         olzdjAdyS22aJ5Bdw7VJrQk3gNzRThjbbSJErop+zHgLCshpn3Jt1J2nFCsx3y9BWS3z
         QTvwGiEHorzYau0t4VTVTaT0n0rhL2l/NNSPY9YDZwysJZjTbX+nX5llu82Za54cl4li
         +oNA==
X-Gm-Message-State: AOJu0YzW2ULX/0Un+d8cgJQH/BKLDlxeHA48f1AbfxEsAjq18JpUGjSx
	tfDp9SSGhNDfJGl3Xr4I5hKP9I37pap/7v/wWxu681NoOu4kJP9RA0dvxm6PD6RDqTI=
X-Gm-Gg: AR+sD11AXp5cpFVy8dXPdEEtYYpCB6bk0u0b49YLWZcLulgEPrVzajk2SYz1Q+qEn3x
	5M5vsfYVXb7cuxhIhC1y+kFhFONG8mwfvck8fjbYU3o9/PKhlOWVIs6KxRHnjrS6WrMwcG8NZR6
	ClJGEni4NiJRZ9XhVVmI0LB5YxAZuAkkprUzx195DUubrCX88nTss50BgYesmpxc8zUAlPWuA4Z
	kPVvBzrHlbC4Ufz3qTeh7qfksv68DjwRajIqLPCFWx+NeY4NfYWiunpUogEF8q9LgXYF5qaJSKR
	u+ZGg0uEHaexmMbUX5qfXLu73H1hrcmf7Ugt2EUOh9bTDK9UnZH8HAiXorLvMTLUw+HBHJ7HEZK
	XpnA7oK9/vkm7BuMQOwhDQohhP/jUn5tW37kS1pEoeyqyytsnp7+CkHtGO/rZqxlrNOPVsbjjPv
	Os78q+eYXN3O4tIbDTikDOjLQuutwc5YT9q+6WpWgiUlg=
X-Received: by 2002:a05:6300:2703:20b0:3c8:e313:8d55 with SMTP id adf61e73a8af0-3c8e313941cmr692468637.75.1785296217385;
        Tue, 28 Jul 2026 20:36:57 -0700 (PDT)
Received: from localhost ([2a09:bac5:42f2:1e1e::300:30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb8250ea9sm290263a12.12.2026.07.28.20.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:36:56 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>
Subject: [PATCH v3 00/10] Bug fixes and enhancements for kdump LUKS support
Date: Wed, 29 Jul 2026 11:36:40 +0800
Message-ID: <20260729033654.311541-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_203659_174894_42361745 
X-CRM114-Status: GOOD (  13.64  )
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

Hi all,

This patch set brings some stability fixes and improvements to the
recently introduced CONFIG_CRASH_DM_CRYPT feature [1][2] (which is to
support LUKS-encrypted device dump target),
  1. address several memory management issues
  2. fix race conditions like configfs writing happens concurrently with
     kexec_file_load syscall
  3. improve configfs handling
  4. update documentation 

To help kernel bots test the patch set, a dependent patch [3] already
applied to the kexec-fixes branch of liveupdate/linux.git tree [4] is
also included.

v3
- Changes suggested by Sourabh
   - more robust check on crash hotplug support
   - use configfs mutex when writing to crash_dm_crypt_keys/restore
   - warn the user when keys have been restored
- Drop patch "crash_dump: Release reference to a keyring at correct
  time" since Guangshuo's version [3] is a more complete fix
- Adjust layout of documentation for crash hotplug support
- Check return codes of the function that
  restore_dm_crypt_keys_to_thread_keyring calls 

v2
 - A different way to address potential double and UAF issues
 - Address several issues [5] scrutinized by Sourabh based on
   Sashiko's review feedback [6] on v1 patch
 - Other improvements like logging fix and doc updates

[1] http://lists.infradead.org/pipermail/kexec/2025-February/031850.html
[2] https://lore.kernel.org/all/20260225060347.718905-1-coxu@redhat.com/
[3] https://lore.kernel.org/all/20260704112509.3717884-1-lgs201920130244@gmail.com
[4] https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=kexec-fixes
[5] https://lore.kernel.org/all/972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com/
[6] https://sashiko.dev/#/patchset/20260403100126.1468200-1-coxu%40redhat.com


Coiby Xu (9):
  crash_dump: Fix potential double free and UAF of keys_header
  crash_dump: Disallow writing to dm-crypt configfs during
    kexec_file_load syscall
  crash_dump: Read the number of dm-crypt keys from reserved memory
  crash_dump: Free temporary dm-crypt keys_header buffer in kdump kernel
  crash_dump: Only use kexec_dprintk during the kexec_file_load syscall
  crash_dump: Improve readability of config_keys_restore_store
  crash_dump: Check the function return codes in
    restore_dm_crypt_keys_to_thread_keyring
  crash_dump: Disallow configfs/crash_dm_crypt_key/reuse if crash
    hotplug supported
  Documentation: kdump: Add arm64 and ppc64le to encrypted dump target
    support list

Guangshuo Li (1):
  crash_dump: release keyring reference at the correct time

 Documentation/admin-guide/kdump/kdump.rst |  20 ++-
 include/linux/kexec.h                     |   6 +
 kernel/crash_dump_dm_crypt.c              | 189 ++++++++++++++++------
 kernel/kexec_file.c                       |   2 +
 4 files changed, 163 insertions(+), 54 deletions(-)


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.55.0


