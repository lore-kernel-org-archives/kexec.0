Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85673C79F9E
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NMfJCAHR4nbef25SYQadjU02CUOu7/eAubuekR/5WSw=; b=0zmHr/d7AfM9vBcuLg6PUUzKWC
	g9u/wdvdU2v5qWD68auDU9cVWxL40wGOI4ykj6NrmOC7s0f4AQnF1/9D7vMqpxbNHQsULCOgVKWRZ
	IidmTWELwQqsSYE0BLnUKjKQJ6JOihHUudZOjVTirx+JVGyzB+nmAKm1F9pJzrg2MNtiMqfGGFyzy
	Zu73DSr4ehTREE8N+1PbfIGGK05gYMcjs7wbMTtzF32mFMNMb3Yq4x+gVb+OeHVZoZvYF8XMhpTSL
	mi7LvdUDjbBFczlFKTBw0SOBl2B+LvunZOV1xN15YGSnFd0sl4Y0kd+oekm1OOc9vhKDCTkoqV5fu
	/2vfFtcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46JH-0000000AVBg-4C7U;
	Wed, 09 Sep 2026 00:37:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46JG-0000000AVB3-3EuD
	for kexec@bombadil.infradead.org;
	Wed, 09 Sep 2026 00:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=NMfJCAHR4nbef25SYQadjU02CUOu7/eAubuekR/5WSw=; b=Q4GHce3mybgRbOACRns+YgNp2R
	SmZ5TlEojbo8cRYFOYMIjwSmQYygB/CcJLUGeEB+mmiaqoJPD4qAHcV0WAlp/OKUV9gaMpD299BB/
	XlDeI30SZpHA1cXHhC+Khu+UewdsmYJGikIwCb6G9Fp9Xw3XOx2GO1BqEBYWO6V8XgdpeYIRRxzfE
	Kbsp8OpaZ3LugjFwdmNmh6pRy3cAYmP8gGNcnISq7AxK4WKUjvrldDwj5Xpl0ayXO6XXD8PBMHTgC
	LnUWZ/7wvGClJJkvV6PygX45pwKQ5//t+TtLu1Ll+m/BvQxEDO+PVaHhpsoNwLJoUJAiTZ5nzZJhP
	+BAvHVeg==;
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x46JC-00000000YIR-3UDZ
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 00:37:05 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-398b3d66515so5159808a91.0
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 17:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788914220; x=1789519020; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NMfJCAHR4nbef25SYQadjU02CUOu7/eAubuekR/5WSw=;
        b=fJAdUSbYML0SSv01PUf4rUSBdpKBCaOTLLrSpC7zCrjx0OW94GncH02mLPR7mb+6jA
         Ew1P8yet1XhjdWRt9VdLQVlNhCe8C8czm7ulmvEK1a/TBqKh3FXTa8DHmGCPKmH29zJO
         nHNyh8e0wT+ksKNJSAR5IB/uvJlGUH7QKToJp3chmVNxIn8v+TRzukEMdOrh6UImlSsb
         ooHdQPfkuqG952tdGUW4nUOKd3I5xOq9RbUqmaTwRYT/j7dHYN8CQsAJ8dY2MXiUAnIx
         FFklyWKdBpoTL2cElp3xMozgEzx2QRobgmamt4a1l3Jc3VEqF6PphOrAipEB+CBch8d/
         WmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788914220; x=1789519020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NMfJCAHR4nbef25SYQadjU02CUOu7/eAubuekR/5WSw=;
        b=j38CYv9lq5DJWSFLmXHU411UwNw3hIedTfwozt8TbERAQkKc6QyDlaP6ugfDK9Gn0X
         37G+bMG0wB2lMPRQlAOxL7KgwxhJsNmA981DIJvNPVm/T559h7HSk/0P8lbDqfyU9YxA
         fpCiFirQqhY3rRsYLOR+SKHfFeyoCtET6ufHswcvZRPkYqSZnMhs0mqZiEiD7PsC2lfl
         /TWbXLmp3R/5v9IfEwkbnyyquDd/14sEpZqZc/Ru4e81SqZyRDpqVZADfZsCyE52tvKl
         omJq8z75Z+s/rWNYbC/pGK3IpPR/Neyfaz4HImGBkq2wfylCEOES0jGrV1rnbujuit+n
         P+rg==
X-Gm-Message-State: AFuF++n2KEwWXCuufQMaoG+/3x0v7C7nX3Ou5skGRY+PM5z0WpYp4Jho
	euPZnOefnTOveY8hR51nP7/hixE5wXDpzAmCQlg/4PK/wgvCI6eQ+B/1WiM+M1rnHYc=
X-Gm-Gg: AYBFou2NWOLuPPXaLbEdFCzHJj5WlluSmlZq2JkPy/eMtRv+InVsbrET+933UPHnL6M
	KkBPIdtBJgU0qF5DEOq/peXqLhN5cpF00+6jHMp3T+H83h1V1xAGCQBGlxSk/oAngD4DECz4SD6
	RoEH9cJ5L/BSW77BDeK8uiOh3kEp0raoHsr7MoZSUDjq11+dNPE5Vik/HzIqS9VvUmhKOyS6t+5
	VfI3Yxw1n53lbQrwRs2F10YAdlfq7yISP99itVSr5pJmmkKI8B4thTXqHApq9uN2cXagkASWREe
	n6Q0hoOTF/e6FQKnHf3gFNqJBnVtiBkqqIxP63MRhB459tU8z3krYkCgIwnIib9hkcfFmU2hp5O
	8GKrrnfL2o3TGRAVLFcEWOBo8Il5d1YjdkvKx4s2foJ47MZLJsiQjmm/tfPsKdlbU4BEnbBC4iB
	bVBDM/FlIfWT9uAoD6gcv1M4P8Lse73MFuGYuzQ8PvIMRjzRGYSqww8Kug4ID5jj0p8Y0PzSA=
X-Received: by 2002:a17:90b:544b:b0:398:c8ef:3644 with SMTP id 98e67ed59e1d1-39b26203e7amr45538678a91.15.1788914219921;
        Tue, 08 Sep 2026 17:36:59 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:1b67:ddd8:990d:9d6f:13b8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacba5sm36402826a91.12.2026.09.08.17.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 17:36:59 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jinjie Ruan <ruanjinjie@huawei.com>
Subject: [PATCH v5 0/9] Bug fixes and enhancements for kdump LUKS support
Date: Wed,  9 Sep 2026 08:36:42 +0800
Message-ID: <20260909003657.1570544-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_013703_155118_F889F3E1 
X-CRM114-Status: GOOD (  16.33  )
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

v5
- Changes suggested/inspired by Sourabh
  - Fix mistake of unlocking a not-acquired kexec lock
  - Only acquire mutex lock when is_dm_key_reused=False
    - Patch "crash_dump: Read the number of dm-crypt keys from reserved memory" 
      is now a prerequisite patch for 
      "crash_dump: Disallow writing to dm-crypt configfs during kexec_file_load syscall"
    - Release the configfs mutex lock early in crash_load_dm_crypt_keys
      (previous released at the end of kexec_file_load syscall)
- Address the memory leak issue reported by Jinjie when ARM64 repeatedly
  calls crash_load_dm_crypt_keys and also rename
  kexec_file_post_load_cleanup_dm_crypt to crash_dm_crypt_cleanup for
  readability


v4
- Changes suggested by Sourabh
  - Add missing newlines and show the return code in logs
  - Return return code instead of count in config_keys_reuse_store
  - use kexec_lock instead of mutex lock to ensure serial access to is_dm_key_reused
  - drop helper function crash_hotplug_support
- Add Reviewed-by tags from Sourabh

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
  crash_dump: Read the number of dm-crypt keys from reserved memory
  crash_dump: Disallow writing to dm-crypt configfs during
    kexec_file_load syscall
  crash_dump: Free temporary dm-crypt keys_header buffer in kdump kernel
  crash_dump: Only use kexec_dprintk during the kexec_file_load syscall
  crash_dump: Improve readability of config_keys_restore_store
  crash_dump: Check the function return codes in
    restore_dm_crypt_keys_to_thread_keyring
  crash_dump: Disallow configfs/crash_dm_crypt_key/reuse if crash
    hotplug supported
  Documentation: kdump: Add arm64 and ppc64le to encrypted dump target
    support list

 Documentation/admin-guide/kdump/kdump.rst |  20 ++-
 arch/arm64/kernel/kexec_image.c           |   1 +
 include/linux/kexec.h                     |   6 +
 kernel/crash_dump_dm_crypt.c              | 171 ++++++++++++++++------
 kernel/kexec_file.c                       |   2 +
 5 files changed, 148 insertions(+), 52 deletions(-)


base-commit: 28924df2a08f440c73991b83028032c901de2ae4
-- 
2.55.0


