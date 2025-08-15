Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267F5CA0EE9
	for <kexec@archiver.kernel.org>; Fri, 15 Aug 2025 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aoEbLDIBvIED/1Ge3yK9oelt843+Qxf+G9/P7ezt/24=; b=xsurZZHhk7xXhXTwKkoblZ7U2D
	05kaXRqaAqRWFaI3zsGfX38pLMWuuN9Nbu3nA8mCjoqOgjiAII3XNEy50L5EKR82Zz7bGyiKgwK4K
	l5fMmUoBS42PSoMB/X2XQAj8URZqtcnH3r8sQJhNnALZT2IUsF5JOuDb2XOWJkoKG70pFHqojP+ID
	3YSXJ7cqA0BLcLCYaPuY+2dUfTcPTbzSbxMM7J1gTN6EOtX9UlZxLw792T4KKoQ+MvkQWdjdqtU2j
	Me+Jcq/Y2P4ucl0hqE+SoK7X1RH7fFoT6DZ0UvTYnfH5YB1wOtDsMBJ66EkYfx+k48KjjNIyGPfFp
	1byb3mdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umvfD-00000002kvu-2Aa6;
	Fri, 15 Aug 2025 14:44:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umtLD-00000002RRs-19h4
	for kexec@lists.infradead.org;
	Fri, 15 Aug 2025 12:15:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755260126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aoEbLDIBvIED/1Ge3yK9oelt843+Qxf+G9/P7ezt/24=;
	b=PdItEpAC3BAJz4c9r0PYR3NIr5kuTFHBPs1blCRsaFQM7QJZ+Ld/5W8oEU7UGswxCayNJV
	8WqKkn43MiObUdoR3FNbEho50RgGqG0EGQCfktHH8ap99R+3p/rQ2npArF4cyIfyY+7muD
	be9XCjKl2wkm+DEAljEzAJZbhQLn/TM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-zsMpD3kfMZqqNFNwS7_0wA-1; Fri, 15 Aug 2025 08:15:24 -0400
X-MC-Unique: zsMpD3kfMZqqNFNwS7_0wA-1
X-Mimecast-MFC-AGG-ID: zsMpD3kfMZqqNFNwS7_0wA_1755260124
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581c62faso18975655ad.2
        for <kexec@lists.infradead.org>; Fri, 15 Aug 2025 05:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755260123; x=1755864923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoEbLDIBvIED/1Ge3yK9oelt843+Qxf+G9/P7ezt/24=;
        b=MZiXLdZKpUAcswey/vH/QU6BSwTPagYAx8Pcq31FbNBd8SEHjrKyFMcStSgv4eoypY
         C8OBALj8WOn5AgpRcYjej8jDKMwHxyNSCkPBW18nGL/UdssR9+WFh2xG9/GXl3AK2MJC
         Dsnl6IXkzsqAZJ2MhqgTvCmqHS0ORn1foFXth5HfcS1nc5CIKaw66wTSs1ilK/sZhLWO
         OepPvZRC3NiRLygWiE+vSLVqndBZXOeIIBeF43Hl5syFDQkxIljwiGjrtYEIf6h150hc
         4K1dTlba1d4FyPRMqPC5C8SodLFpm4+ac/1sXdK4pxFXpjJbtWZjZBw78zD7AO1vr3fT
         Grcg==
X-Forwarded-Encrypted: i=1; AJvYcCWk6h9PLuZLqu+NdsQSBRGUfEU9LkI27p6JT6qIjDVRXw6M5jFSf2GWne5fkU2/YKea0/xc/Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxWSruGDZ2i8WCCIpV5bJs8a6upGbGzSUXnlnBvSGKoNfbKziJW
	eSjUut11k1gxUGvsEeRw9LLGKeSVsnGREc179qMiTGfzQZ4yf/wxdOsxFN/yVs5Usi+Ai3JMjC2
	4zQWW/48EMJzFv9SniTVksIkK7vAJ+ZXflziWrIv/26775dtm3as8m+ATyzU4oArGmBJwU7c/Kq
	E=
X-Gm-Gg: ASbGncvAdpnN5KwiM2JjNFMTa42M/A2gqXJVZaXfm8pIUuGj8DyjMPdDitglUrIuAQr
	XYyS5Erubxqx0F7g6fXj5nYv47TTebGzlzqDCwpDGJa7ICcp4ezk2Lu0o/+TzQMK4poGk3IyDgr
	XiTi3qXc+kG/FPJBEMABrYoGwe8lht4NNL6+6Yni4IIcKhq/xOcpctQ36f78Sdrkaf29iSf6Bb3
	pE6MjjSsB1avJIlzdVG9Q6bNsp+y5w8WiKUkbIGQDoRFEnV1ZwUn52vUr0NVqk5ldiIlSXoYxiO
	5PIv0nVxnCgo0PPem5Rn7DVeL32tDRJltrUl0/pJ6jJCkIdYbg==
X-Received: by 2002:a17:903:906:b0:240:49d1:6347 with SMTP id d9443c01a7336-2446d8b1ef5mr28472965ad.35.1755260123357;
        Fri, 15 Aug 2025 05:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEGS5d2wzwEmY71Sxbu2mJGMdxqpSOcx9nx9YZK43BD2pagvwbnN2eEpAtX7LvuEgnSJ4lNw==
X-Received: by 2002:a17:903:906:b0:240:49d1:6347 with SMTP id d9443c01a7336-2446d8b1ef5mr28472675ad.35.1755260122913;
        Fri, 15 Aug 2025 05:15:22 -0700 (PDT)
Received: from f37.llcblog.cn.com ([2408:8212:9001:a40:5c04:f864:9735:818c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d74bb8asm1157463a12.31.2025.08.15.05.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 05:15:22 -0700 (PDT)
From: Lichen Liu <lichliu@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	safinaskar@zohomail.com,
	kexec@lists.infradead.org,
	rob@landley.net,
	weilongchen@huawei.com,
	cyphar@cyphar.com,
	linux-api@vger.kernel.org,
	zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	initramfs@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Lichen Liu <lichliu@redhat.com>
Subject: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
Date: Fri, 15 Aug 2025 20:14:59 +0800
Message-ID: <20250815121459.3391223-1-lichliu@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xBh5SaS0UqcL0OKULN4b1rb9aGlX89c00OteDanNNq0_1755260124
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_051527_392001_E052D03C 
X-CRM114-Status: GOOD (  19.87  )
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

When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
By default, a tmpfs mount is limited to using 50% of the available RAM
for its content. This can be problematic in memory-constrained
environments, particularly during a kdump capture.

In a kdump scenario, the capture kernel boots with a limited amount of
memory specified by the 'crashkernel' parameter. If the initramfs is
large, it may fail to unpack into the tmpfs rootfs due to insufficient
space. This is because to get X MB of usable space in tmpfs, 2*X MB of
memory must be available for the mount. This leads to an OOM failure
during the early boot process, preventing a successful crash dump.

This patch introduces a new kernel command-line parameter, rootfsflags,
which allows passing specific mount options directly to the rootfs when
it is first mounted. This gives users control over the rootfs behavior.

For example, a user can now specify rootfsflags=size=75% to allow the
tmpfs to use up to 75% of the available memory. This can significantly
reduce the memory pressure for kdump.

Consider a practical example:

To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
the default 50% limit, this requires a memory pool of 96MB to be
available for the tmpfs mount. The total memory requirement is therefore
approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacked
kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) ≈ 220MB.

By using rootfsflags=size=75%, the memory pool required for the 48MB
tmpfs is reduced to 48MB / 0.75 = 64MB. This reduces the total memory
requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
smaller crashkernel size, such as 192MB.

An alternative approach of reusing the existing rootflags parameter was
considered. However, a new, dedicated rootfsflags parameter was chosen
to avoid altering the current behavior of rootflags (which applies to
the final root filesystem) and to prevent any potential regressions.

Also add documentation for the new kernel parameter "rootfsflags"

This approach is inspired by prior discussions and patches on the topic.
Ref: https://www.lightofdawn.org/blog/?viewDetailed=00128
Ref: https://landley.net/notes-2015.html#01-01-2015
Ref: https://lkml.org/lkml/2021/6/29/783
Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-initramfs.html#what-is-rootfs

Signed-off-by: Lichen Liu <lichliu@redhat.com>
Tested-by: Rob Landley <rob@landley.net>
---
Changes in v2:
  - Add documentation for the new kernel parameter.

 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 fs/namespace.c                                  | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..0c00f651d431 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6220,6 +6220,9 @@
 
 	rootflags=	[KNL] Set root filesystem mount option string
 
+	rootfsflags=	[KNL] Set initial root filesystem mount option string
+			(e.g. tmpfs for initramfs)
+
 	rootfstype=	[KNL] Set root filesystem type
 
 	rootwait	[KNL] Wait (indefinitely) for root device to show up.
diff --git a/fs/namespace.c b/fs/namespace.c
index 8f1000f9f3df..e484c26d5e3f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
 }
 __setup("mphash_entries=", set_mphash_entries);
 
+static char * __initdata rootfs_flags;
+static int __init rootfs_flags_setup(char *str)
+{
+	rootfs_flags = str;
+	return 1;
+}
+
+__setup("rootfsflags=", rootfs_flags_setup);
+
 static u64 event;
 static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
 static DEFINE_IDA(mnt_group_ida);
@@ -5677,7 +5686,7 @@ static void __init init_mount_tree(void)
 	struct mnt_namespace *ns;
 	struct path root;
 
-	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
+	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
-- 
2.47.0


