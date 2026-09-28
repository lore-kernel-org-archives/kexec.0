Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7703ACA5FA3
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:In-Reply-To:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=XTXwhsF8AcRcGjqkzQMs8H/sViDT+fzkXUdVh0YIfzY=; b=jmya+JPweuh91U
	UZpFWboPm16GH73g2+w/bYDts9lhXX/RD3nVrfHDZRNF/n3XBDWKns2ui0KMWR7CcAOA+oKtQjdbb
	gQ2/ckAjO8Otd9RD0DvXpr+EALwkSNrf9qfPr+SECOaubtKPV5RXHMPZOFLdoeTBc5yXzyIUqFMWA
	zY3vNkZ6n+VS92wnIRdJcxWAjrNll3o78e9uEHUcOaPDy3rG2MdeLuuVdm9W83+CQvBuCdcKKKfEU
	+ogHukqvoBYyO0PULdqSSKYqz3v2pxyet/NNvCrsM5mwH28V9AYefN/V15TdqMrsptyLlb1aFlmQk
	81esC26WWIubtaVhkU/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBI9Z-00000001ahs-2D86;
	Mon, 28 Sep 2026 20:40:49 +0000
Received: from mail.mainlining.org ([5.75.144.95])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBI9V-00000001agH-1ojK
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 20:40:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790627944; bh=XTXwhsF8AcRcGjqkzQMs8H/
	sViDT+fzkXUdVh0YIfzY=; b=o4IepKep6aL5Gn8OMN2H+roJCulhBQaHidvMc3YbVRHWNQG73T
	shcwi8UodkgoYBHucuES5txkKErrgEC2EBXR1brfrkQUrn8LxV0aKM+d/HBPBPEDCKYQoXzQJHp
	pTQnPtP/Z5vgRjE9JmslorWgLac4rsFdoPWtZsNWqw9154+isNLOj1K7t8D5XYoSciMEqLzHXgq
	BYQQNFFcby750VLAK6oMC9L85/CLUVlsz295cieC1PsxoiceBJKehSnQ5o8dTtMbKS7uJ+bic6y
	4XqXkb6h8MBjrDPGnTEyKrkyAeOe058YVVjfxeb/RdC+H173ZHP8i7c5/beZU0KqBig==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790627944; bh=XTXwhsF8AcRcGjqkzQMs8H/
	sViDT+fzkXUdVh0YIfzY=; b=MirD7g56upz4FD0IWQYpOMGx8rHUxzc3Y10D1eiNjtgb7W6UeW
	wL63Nq0YkvCURXNsU84xKjkJa/nRIKOiI/AA==;
Date: Mon, 28 Sep 2026 21:39:05 +0100
From: Bradley Morgan <brads@mainlining.org>
To: zack.rusin@broadcom.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/6=5D_panic=2C_x86/vmwar?=
 =?US-ASCII?Q?e=3A_Preserve_crash_logs_before_kdump?=
In-Reply-To: <cover.1790014793.git.zack.rusin@broadcom.com>
Message-ID: <364337F4-8127-4693-BB85-E0657B634B43@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_134045_648944_8F71FDCD 
X-CRM114-Status: GOOD (  16.00  )
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, kees@kernel.org, dave.hansen@linux.intel.com, ruirui.yang@linux.dev, stephen.s.brennan@oracle.com, bo.gan@broadcom.com, hpa@zytor.com, pasha.tatashin@soleen.com, corbet@lwn.net, brennan.lamoreaux@broadcom.com, x86@kernel.org, joel.granados@kernel.org, alexey.makhalov@broadcom.com, mingo@redhat.com, bcm-kernel-feedback-list@broadcom.com, tglx@kernel.org, ajay.kaher@broadcom.com, baoquan.he@linux.dev, john.ogness@linutronix.de, senozhatsky@chromium.org, virtualization@lists.linux.dev, rostedt@goodmis.org, maaz.mombasawala@broadcom.com, bp@alien8.de, skhan@linuxfoundation.org, mhklinux@outlook.com, rdunlap@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ian.forbes@broadcom.com, rppt@kernel.org, akpm@linux-foundation.org, pratyush@kernel.org
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 28 September 2026 18:55:34 BST, Zack Rusin <zack.rusin@broadcom.com>
wrote:
>A VMware guest may have no persistent storage or working userspace after
>a crash. Preserve its newest kernel log tail in the host's vmware.log
>before entering kdump, without enabling every panic notifier by default.
>
>Following Petr's suggestion, add one generic panic_pre_kdump_list with
>VMware as its first client. A set-once helper covers panic() and direct
>crash-kexec entry. Fatal oopses can reach kdump without calling panic(),
>so patch 2 adds that call after capturing the original registers under
>the existing kexec lock. The late panic call follows sys_info() and
>precedes the kmsg dumpers.
>
>Patch 3 adds Guilherme's suggested escape hatch for debugging kdump
>failures involving early callbacks. With panic_pre_kdump_postpone set,
>the list runs before kdump only when crash_kexec_post_notifiers is also
>set. This can omit hypervisor crash handling as well as diagnostics.
>The late panic call remains eligible. This policy is a separate patch;
>I can omit patch 3 if it is not wanted.
>
>The logger preallocates an 8 KiB buffer and bounds its register-based
>RPC transfer and retries. Michael suggested increasing the buffer
>because 4 KiB can omit useful stack-trace context. Ordinary guests
>enable logging by default; encrypted guests must opt in. Use
>bool/proc_dobool for the sysctl as Joel requested. The potentially
>terminating REPORTGUESTCRASH event remains a separate late dumper,
>suppressed whenever a crash image is loaded. The v1 assignment to
>crash_kexec_post_notifiers is dropped.
>
>Tested on VMware Workstation and ESXi with ordinary guests, and on
>ESXi with SEV-SNP and TDX guests.
>
>v1:
>https://lore.kernel.org/r/cover.1788414671.git.zack.rusin@broadcom.com
>
>Zack Rusin (6):
>  panic: Add a notifier chain for pre-kdump callbacks
>  crash: Notify pre-kdump callbacks before switching kernels
>  panic: Allow postponing pre-kdump notifiers
>  x86/vmware: Add a bounded pre-kdump log sender
>  x86/vmware: Add the vmware_record_panic_msg sysctl
>  x86/vmware: Report guest crashes after kmsg dumpers
>
> .../admin-guide/kernel-parameters.txt         |  14 +
> Documentation/admin-guide/sysctl/kernel.rst   |  20 ++
> arch/x86/include/asm/vmware.h                 |   2 +
> arch/x86/kernel/cpu/vmware.c                  | 250 ++++++++++++++++++
> include/linux/panic_notifier.h                |   4 +
> kernel/crash_core.c                           |   3 +
> kernel/panic.c                                |  28 ++
> 7 files changed, 321 insertions(+)
>

All the panic changes and crash_core changes looks good to me!

Reviewed-by: Bradley Morgan <brads@mainlining.org>

Tested basic panic calls with Power10, in courtesy of osuosl:

Tested-by: Bradley Morgan <brads@mainlining.org> # Power10
 


>
>base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
>
>
>From mboxrd@z Thu Jan  1 00:00:00 1970
>Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
>	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
>	(No client certificate requested)
>	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF64E3243
>	for <linux-doc@vger.kernel.org>; Mon, 28 Sep 2026 17:56:08 +0000 (UTC)
>Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
>ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
>	t=1790618169; cv=none; b=b4BojE7kyzKnMqCq3yQBsgTjfamCuHeSPBiM3mTeE4v6X5jd8GsgUy8HFjfb6vnu2FsurVAocpFTMaJi8sVvzC7bBtKNDJpFDvZCNqdO4XHY7wznbp2hC1z0LbTBYGMbRHtCk4LvgNFrpWDHzU9DrGZf+1d8PQJtrrUWMR3fWB8=
>ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
>	s=arc-20240116; t=1790618169; c=relaxed/simple;
>	bh=qHuvSTbzKTQ99mPQxhPgubTCtOl/pceEwTRUqIC9LiU=;
>	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTXEgGo9/aZOjjBWf/3/aJE9bzE1CX9s/OSrb2hi9L/KTuxvuIv8F7B18Mj6GgYbZIaXobZhtwozeHdFf9pWY4NmLIXIxMlQiB06cvRkp4UYghm/h3KZ3r3B3EPB6W4Zm/qFIUpvsrOcMQBhLX0ulM1Nh7jAkRnR5+Dr4TccEps=
>ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass
>(p=reject dis=none) header.from=broadcom.com; spf=fail
>smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com
>header.i=@broadcom.com header.b=AMSyqTvg; arc=none
>smtp.client-ip=209.85.216.100
>Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
>Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
>Authentication-Results: smtp.subspace.kernel.org;
>	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AMSyqTvg"
>Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so87593a91.0
>        for <linux-doc@vger.kernel.org>; Mon, 28 Sep 2026 10:56:08 -0700 (PDT)
>X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>        d=1e100.net; s=20260707; t=1790618168; x=1791222968;
>        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
>         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
>         :subject:date:message-id:reply-to:content-type;
>        bh=KmmJxySPwG38CbqK+KUDBFApZhpWarF4JpRDp51PqIc=;
>        b=Jpd/MIj5ewElR34jOfbzVz6y0phWWOuuetH2AMAqSfkw9wo88gnxd8iiGSrwGXb/K8
>         LxiFGW7Gk1/qfXeNKTtiT3pDkujiBk8rYb2hZ9gxVSorRYSYgPAO2EL16XTvbxLgG6YK
>         3FeqkS0hVSU1tdYNfgmZnbEIc2b/RyU4JI14RYidz/e/0W5GCoeMbf3A5MEjESY87AVb
>         Nmwd7ohydW1mz6nApfHFyC6Dnyk8weLtbSVES1jsgb3+ivuTwzujcnvHLoxLcTveo38M
>         /QCQT4LKda0z3bTRNmSUIPrz9XLziXq3W4D3R+fZgS7Ae1bSJihAy/CQ8TsXISh1sea3
>         /Y5g==
>X-Forwarded-Encrypted: i=1; AKwUvBz1cco3gfH83tEf5iTZWgGV7lvOGVAz8sAyGJ4O8VTok46+5cEwqveCnVBIA8QHt65rA8D83p9YKyk=@vger.kernel.org
>X-Gm-Message-State: AFq9FYJJ9fgQVETjiY5fbRpzunCNQ3yHlKk8Ilzj81eoAlnuoS+Dn0Ka
>	McHcsKEBsXysl0ErYrd3UsPTH5PvX2dq9oZLqcmv4M1H2ZZYdezUd/B+B5ApLoXVYyVqwwaKkn1
>	WhxVmBuVCVdWdMiAn3Vi6H3YMgDwkYBQIrAbekUmKYvA8WvWr8eMC191fp1XiUxJ6rhpIfeSsVp
>	NTAsl3Yon3avlK5XQfKHI5gtnaNCTFriKugUOmHPEPXyu8F41SwzaOR5uWzC+zjBz4Vodbmgspr
>	ROsqbvKBTG0
>X-Gm-Gg: AYBFou2P8ZN7jxBSC+9O6FmDIlcBFoArokAtaD0KOTfPh/dbNfovO55NTXigG/qTx0i
>	zW8kFxJ9y8047OYcs7z6GR/iFk/FwAFBB5zgqFHnosJpMNBIX2v+4Kwpu9gjKkmULOJP4mIajIu
>	dJfq/+pAXglXwFTJ+9jxVi8wPktojt/Kb99zzSZdC2pJZ1qGv0VNdQR3aD5YFUJSBFcy3BkabjL
>	sk1IZGxFfeKEGoAO9jrL5qKeIm3f6Ql5otkpaV9x52hh1iOyQ0Xd1UFFrUB+dYPtR6W5bYD0hSO
>	5TbTBiupR7Fk/TU3eH1D3LCTwxJdUmWXGODfhDogaAZUtfuQraIYelR1Lue5OSP5fGKHMw5FPyo
>	iFEAWZ+eQ1MJmXkr4N/LcVUr5vNjYToRFimPtfJQ430PQig2taOVcTvxn7B2m7O6JMTg8qajAW3
>	a/HyZmBnzcwByWASw8uS+bX2LuCwxtV9OO
>X-Received: by 2002:a17:90b:28c6:b0:3a0:34a4:187e with SMTP id 98e67ed59e1d1-3a49c120f78mr7983a91.15.1790618167517;
>        Mon, 28 Sep 2026 10:56:07 -0700 (PDT)
>Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
>        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a498e35c74sm34226a91.3.2026.09.28.10.56.00
>        for <linux-doc@vger.kernel.org>
>        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
>        Mon, 28 Sep 2026 10:56:07 -0700 (PDT)
>X-Relaying-Domain: broadcom.com
>X-CFilter-Loop: Reflected
>Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3282d5302ffso156936eec.1
>        for <linux-doc@vger.kernel.org>; Mon, 28 Sep 2026 10:56:00 -0700 (PDT)
>DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>        d=broadcom.com; s=google; t=1790618159; x=1791222959; darn=vger.kernel.org;
>        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
>         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
>        bh=KmmJxySPwG38CbqK+KUDBFApZhpWarF4JpRDp51PqIc=;
>        b=AMSyqTvg7YOAaOo4sIAY0pcRYwHSW0cH09GjKbqzO4apiMMUre94O+4j1U12+P2RKc
>         thNFz4BDgQu1JWPb2Prmfj0x/3+gp1f5TNhwJdRBccsEH9Kg8d61iKzddQPkLXzvvA2Y
>         czPVjFz5/L4SBh9PoEC0hHpQAKBZzbU0jsBOo=
>X-Forwarded-Encrypted: i=1; AKwUvBzwJDvlo2QB15OMSgAG9uvXCCuZffODLbFe+C46K/WtKOc+COVpbcP72cSKjfHL1r07WxDFnjfUXvo=@vger.kernel.org
>X-Received: by 2002:a05:7022:ff49:b0:13c:e1e2:fc86 with SMTP id a92af1059eb24-14b2d993e47mr201594c88.4.1790618159182;
>        Mon, 28 Sep 2026 10:55:59 -0700 (PDT)
>X-Received: by 2002:a05:7022:ff49:b0:13c:e1e2:fc86 with SMTP id a92af1059eb24-14b2d993e47mr201547c88.4.1790618158548;
>        Mon, 28 Sep 2026 10:55:58 -0700 (PDT)
>Received: from vertex.localdomain ([192.19.144.250])
>        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.55.53
>        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
>        Mon, 28 Sep 2026 10:55:57 -0700 (PDT)
>From: Zack Rusin <zack.rusin@broadcom.com>
>To: Andrew Morton <akpm@linux-foundation.org>,
>	Petr Mladek <pmladek@suse.com>,
>	Baoquan He <baoquan.he@linux.dev>,
>	Mike Rapoport <rppt@kernel.org>,
>	Pasha Tatashin <pasha.tatashin@soleen.com>,
>	Pratyush Yadav <pratyush@kernel.org>,
>	Dave Young <ruirui.yang@linux.dev>
>Cc: Borislav Petkov <bp@alien8.de>,
>	Ajay Kaher <ajay.kaher@broadcom.com>,
>	Alexey Makhalov <alexey.makhalov@broadcom.com>,
>	x86@kernel.org,
>	Joel Granados <joel.granados@kernel.org>,
>	Thomas Gleixner <tglx@kernel.org>,
>	Ingo Molnar <mingo@redhat.com>,
>	Dave Hansen <dave.hansen@linux.intel.com>,
>	"H. Peter Anvin" <hpa@zytor.com>,
>	virtualization@lists.linux.dev,
>	bcm-kernel-feedback-list@broadcom.com,
>	linux-kernel@vger.kernel.org,
>	John Ogness <john.ogness@linutronix.de>,
>	Steven Rostedt <rostedt@goodmis.org>,
>	Sergey Senozhatsky <senozhatsky@chromium.org>,
>	Kees Cook <kees@kernel.org>,
>	Jonathan Corbet <corbet@lwn.net>,
>	Bo Gan <bo.gan@broadcom.com>,
>	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
>	kexec@lists.infradead.org,
>	linux-doc@vger.kernel.org,
>	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
>	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
>	Shuah Khan <skhan@linuxfoundation.org>,
>	Randy Dunlap <rdunlap@infradead.org>,
>	Stephen Brennan <stephen.s.brennan@oracle.com>,
>	Michael Kelley <mhklinux@outlook.com>,
>	Ian Forbes <ian.forbes@broadcom.com>
>Subject: [PATCH v2 0/6] panic, x86/vmware: Preserve crash logs before kdump
>Date: Mon, 28 Sep 2026 13:55:34 -0400
>Message-ID: <cover.1790014793.git.zack.rusin@broadcom.com>
>X-Mailer: git-send-email 2.53.0
>Precedence: bulk
>X-Mailing-List: linux-doc@vger.kernel.org
>List-Id: <linux-doc.vger.kernel.org>
>List-Subscribe: <mailto:linux-doc+subscribe@vger.kernel.org>
>List-Unsubscribe: <mailto:linux-doc+unsubscribe@vger.kernel.org>
>MIME-Version: 1.0
>Content-Transfer-Encoding: 8bit
>X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
>
>A VMware guest may have no persistent storage or working userspace after
>a crash. Preserve its newest kernel log tail in the host's vmware.log
>before entering kdump, without enabling every panic notifier by default.
>
>Following Petr's suggestion, add one generic panic_pre_kdump_list with
>VMware as its first client. A set-once helper covers panic() and direct
>crash-kexec entry. Fatal oopses can reach kdump without calling panic(),
>so patch 2 adds that call after capturing the original registers under
>the existing kexec lock. The late panic call follows sys_info() and
>precedes the kmsg dumpers.
>
>Patch 3 adds Guilherme's suggested escape hatch for debugging kdump
>failures involving early callbacks. With panic_pre_kdump_postpone set,
>the list runs before kdump only when crash_kexec_post_notifiers is also
>set. This can omit hypervisor crash handling as well as diagnostics.
>The late panic call remains eligible. This policy is a separate patch;
>I can omit patch 3 if it is not wanted.
>
>The logger preallocates an 8 KiB buffer and bounds its register-based
>RPC transfer and retries. Michael suggested increasing the buffer
>because 4 KiB can omit useful stack-trace context. Ordinary guests
>enable logging by default; encrypted guests must opt in. Use
>bool/proc_dobool for the sysctl as Joel requested. The potentially
>terminating REPORTGUESTCRASH event remains a separate late dumper,
>suppressed whenever a crash image is loaded. The v1 assignment to
>crash_kexec_post_notifiers is dropped.
>
>Tested on VMware Workstation and ESXi with ordinary guests, and on
>ESXi with SEV-SNP and TDX guests.
>
>v1:
>https://lore.kernel.org/r/cover.1788414671.git.zack.rusin@broadcom.com
>
>Zack Rusin (6):
>  panic: Add a notifier chain for pre-kdump callbacks
>  crash: Notify pre-kdump callbacks before switching kernels
>  panic: Allow postponing pre-kdump notifiers
>  x86/vmware: Add a bounded pre-kdump log sender
>  x86/vmware: Add the vmware_record_panic_msg sysctl
>  x86/vmware: Report guest crashes after kmsg dumpers
>
> .../admin-guide/kernel-parameters.txt         |  14 +
> Documentation/admin-guide/sysctl/kernel.rst   |  20 ++
> arch/x86/include/asm/vmware.h                 |   2 +
> arch/x86/kernel/cpu/vmware.c                  | 250 ++++++++++++++++++
> include/linux/panic_notifier.h                |   4 +
> kernel/crash_core.c                           |   3 +
> kernel/panic.c                                |  28 ++
> 7 files changed, 321 insertions(+)
>
>
>base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
>
>


--- Thanks!
"I'm not a very positive person" - Linus torvalds

