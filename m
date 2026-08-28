Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40721C61DC6
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OdqcuxLBofKH7FXK3RTAjXinFT0H4y3pa2mHUjRRidU=; b=yeG+nGUdXRMiG/gzKsIWtAjOUS
	VrAtKpnlzZW9WBvgGELTCYVghsjMYkjdYIlW6D5wV27UdJWKLkzsS73J7veGfFhAjoYHWxcQA7C6d
	Gv2oOOqOIkWuLr+HeuiJvCNmLsk+y1DGHfeIElC7GUasdvx9Hf7+av20IgCBELtB56R+Q4IdCUZCI
	duxWtR5a/l75XHiP9Zsx8xC5E9vYhVdysPdaStnaJtXIn5QJD20CG6sCkulqYnD4/QlhCOZWY/nhv
	OP4AwCHcxVkX5hkSmAeiCDrxMqZKPy4iHF4nLOHM1yRguvRFsi/o1Aj79wjny+d2pZng5PMWXES9O
	Jaia2VDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsGq-00000005LLY-15pB;
	Fri, 28 Aug 2026 08:49:08 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsGn-00000005LJz-32TF
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 08:49:07 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2d7195706f1so8636985ad.0
        for <kexec@lists.infradead.org>; Fri, 28 Aug 2026 01:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906944; x=1788511744; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OdqcuxLBofKH7FXK3RTAjXinFT0H4y3pa2mHUjRRidU=;
        b=tCqKGuvLjNaj7473airyNrapfcR37KaYkFVmF9EZd/Ktvutu4uEyvsSxcwCgkqJeMJ
         fIG7FC8K9qGyYjcU6Ig/UgOCLBDzXI5y0XzHW1Xsyz59F/2xz70sXTTmMJKWcVrfzMiZ
         n92kCH0DdOO80NA8f4P/p1suO7ft5e9bdt8EIbW07resIID+eH8O6hJS7SfcK3G1Ekhz
         szEymbFsF3IhJEVEgARSuN/rvYe3aiN2bZaCLswT8+fVP2sQdOFCN8NZpZB6rLqDid1W
         IPbVANm9dTJmZ8vzPM/7iHBoba6e1cpT0HPPLkk/CVGCGLC9zIKlqBIp98DMGBJI3t+C
         hLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906944; x=1788511744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OdqcuxLBofKH7FXK3RTAjXinFT0H4y3pa2mHUjRRidU=;
        b=XiOlYd0MUxxH96YXNfHZTngU6QDpUlK5/7aZ+TneS5fsv5ZKEr5EYG/snQ5dWg7Qpr
         abUmx/wSNWCt6NVvmctT6vzFKzHx6q3uZfiP6R/MydnHZ+5hGS9wVT78ksQA5mwyUkFG
         eTsdyw4zMq1Sd0VWwr3ZICb8iUuv2LR29mNLC6Brxqfdn0I+6i4aVmY08AmYSdK1H3H7
         OxvrCA9jGXL2LlUd0pc5tZHTHpODGsOAnSKfvh3EW9Fb0pDPqlPOl/CEN6mUL8g9OThs
         ZrgUk71p2FqhQw58em8YVPsVjiM8ZRgoavWzISpTYpKixn3iKQVHKU9F3nBScZO2SkIF
         eAtg==
X-Gm-Message-State: AFuF++k1/EuoG/V7vH5s1gdBNQ2lABPXHiIIHiHw/zgvu62lA+d/lr0k
	oALyAWAOwkUqiwhOJE7Gl2UI8AyMzNBW5Iw2EXptOYu+Z3VCi0HtIlYPTMSvaPjJR08=
X-Gm-Gg: AR+sD106pQ3OFsZ5/vR6KGQ7xZ8u4TgrjJgIGTmdG9VTEGj7yqvsZ77zNB7X/uVIv1/
	I+ETEUZnMOGICik7dr4lU0Dv6nYeM0L4Jf6g34kL8bgjcjyIbTDwb/ISDpdw1cUrltho6h+iS0a
	UyFC+xJ6/uZfR/DxL8XT3xH4tnWUY1Vm0yDvXJZAn3aUJk26i26tlwGd7VHsyrixst4SB2G5PEa
	gBTzr5ad4nD99fvYdqP2CW02TnL+tSdFovKhJkINVJuNFNtmNWH+jI7eZeypLRiezY4kpT7wnrU
	+aRyCfJa2QSrNJGc0HDRA89iJrb/xShDUB/or+pVbcniQO9afLDLbarrfx6kVhYwEBoJyoRXUnc
	WTV0G/9Tk5CiYJ2s8eYXSYig6GNWQqSUr9y2X/3bK0+Ibu/JKX5At3ZATzzlKmT9JDGWtMMxeun
	rw/+Zy3ZuNq2vVUDi/IYKPpOJDWcAmpr0W/JspE9e1Vgir+ZcKWfqO1j5Hy5lQ3ICBt8NLmg==
X-Received: by 2002:a17:903:4683:b0:2d6:efc5:c82e with SMTP id d9443c01a7336-2d74dc10522mr25424485ad.1.1787906944375;
        Fri, 28 Aug 2026 01:49:04 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:a97:707e:a14f:cfbf:3e23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f8094dasm3908391eec.13.2026.08.28.01.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:49:03 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>
Subject: [PATCH v4 0/9] Bug fixes and enhancements for kdump LUKS support
Date: Fri, 28 Aug 2026 16:48:46 +0800
Message-ID: <20260828084900.1496839-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_014905_764714_0B928653 
X-CRM114-Status: GOOD (  13.19  )
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

 Documentation/admin-guide/kdump/kdump.rst |  20 ++-
 include/linux/kexec.h                     |   6 +
 kernel/crash_dump_dm_crypt.c              | 174 ++++++++++++++++------
 kernel/kexec_file.c                       |   2 +
 4 files changed, 150 insertions(+), 52 deletions(-)


base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.55.0


