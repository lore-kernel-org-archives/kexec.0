Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1551FCA0EDC
	for <kexec@archiver.kernel.org>; Thu, 14 Aug 2025 15:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CEmT42RQmaz79iSpEMVnY8SNb8kz15ad1uYq26SL5aw=; b=tRJYrz2PKoDvefdxqN7dFhVJLr
	Q3lZPg5nT/e4v4YezCXESuDBoMUj+9saqQewTBYQvIwxEFgsIo5WW1BOT1Ti/NyfJKGvY3HNkpwDz
	AXY/0FyNh0FVdYKRJWkYWN3w3xE3A5u8qyWl+bgf2zzLveRDeARRcALqb5CFmmcaRjpftLgXg58FU
	zexhZZGpoyz6imtj0wb8ViDi3EPTteUGOEx4N9tgBBDg9IC0qmhM6CpbDGI4RYkGnQ4dG+UngSHKt
	Yq3gwfSs+TjDXk+JDSzRBWH6XMSIcC27GJ8b+LjmxDQU752dFViRabXN3YmK+g/7DQTlvP3rL907+
	AMMhn17Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umZvU-0000000HRfD-1ucw;
	Thu, 14 Aug 2025 15:31:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umVMd-0000000GcU6-1cR3
	for kexec@lists.infradead.org;
	Thu, 14 Aug 2025 10:39:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755167958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CEmT42RQmaz79iSpEMVnY8SNb8kz15ad1uYq26SL5aw=;
	b=h2LXt2ogwT+r32Npyoy3tw4PnCCuX1EhkMpTpbgydS1cOw6kXyKnLLfHbuvny2WQbbvNvx
	fdKBG316TUiUoMGTfod/MjNCk7MuCaDh1hAmtKCPrd0hUwkrH0d7/dDzDsYy8IVpeqhV9x
	g0UEv+hXRLL9x7ifbigm+JGl4bNMAfs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-brpUMtOQMqa5mhw_v7vPwA-1; Thu, 14 Aug 2025 06:39:17 -0400
X-MC-Unique: brpUMtOQMqa5mhw_v7vPwA-1
X-Mimecast-MFC-AGG-ID: brpUMtOQMqa5mhw_v7vPwA_1755167956
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737a7baso549688a12.1
        for <kexec@lists.infradead.org>; Thu, 14 Aug 2025 03:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167956; x=1755772756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEmT42RQmaz79iSpEMVnY8SNb8kz15ad1uYq26SL5aw=;
        b=j7ooix4IkH//eXPM45mC3jBZMDTAyXRvFtAEqapgVABMJu5Mz+p8CPgJ1G+eaeusW6
         cO4lNzOpjLoVxfu05I6nicDOB+l8TvhWYAIDCPGA6fa0WXzCy7dCQ5p1LqwczHggwMlr
         SudmSKmRnKl/oqNItorLkXtvJHKBPTOBT6k1VOtUpC6eKFOYbRo19EejAlmbaGIfIqvc
         5ViwG0shw+U+uSZEeXxWOwqIL1PMl/Jh36/xicFKHuFqEt9fVLa+MzT9an/DNJS3krRj
         IFC67UUv+pzyeHr9Oyv7RD/hJgf4+9nskNs8PnBYaos+RDEmLkkzbl/gKXYF+N2cQops
         Bcxg==
X-Forwarded-Encrypted: i=1; AJvYcCU/I8GfTxCJKiFrQngV23apZh0VJfQF2TtqwA4t2/VEiQR3di9Yq++QWELC0BjEcXH6Gxn54w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz2GHKrScy7Y7mHAFVhydgtpVRFqjLMqnoswAyN7nf8/9ZmkBu/
	ldnO+1l/2kh2apedUC258hsDJmnTqHqHoUVS6YbTSpxrzsnu3Uy1LnYKsvQmzMmjANIYCBz0Nqq
	WUwmJ+W7tud7I3GwT/uMHNnqYw5MXs1XWazRKvZemN1kqCh3sKECAtM5V9Om4Iw==
X-Gm-Gg: ASbGncva4TLGsA3u/6o1tOL9ak7sQAYGPVQiks72CV9+MDLXjcgycFKYpzad02BP8eb
	5Y+Shw5Ysu9WWutgWFPJ3ZUR8G2EjMHfH7zgkLb3ydT6wnjOZyYO8BujBMapnQWbPIrqG0QcFRG
	KfBbMKYilmyYnJxhWTWmTMOg+K/xcj/n4CSg2gPGSQ171OK7KAaVjY5s68HZP4vtsCbX/Nr9Gmn
	6MAjGzY0W+fdUO67VNP0G2VUSratda5lciKTJJd0TXEvCuImSAlE+vZn8u9tUxgjEaEPiaM8I6y
	Fu9lJmQvVV1gULzWrQqW1dxAR6QL80/g9l9/1i/1Ub4yUvp36w==
X-Received: by 2002:a05:6a20:3943:b0:23f:fc18:77b0 with SMTP id adf61e73a8af0-240bcfcc4famr3875744637.17.1755167956021;
        Thu, 14 Aug 2025 03:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0qcRzLZjEIlriBSOpvCVTTIlZIky5VrZnbpwFkW4qbY9gLvkwJS1z02pXRiF8AX+jnTsQoQ==
X-Received: by 2002:a05:6a20:3943:b0:23f:fc18:77b0 with SMTP id adf61e73a8af0-240bcfcc4famr3875724637.17.1755167955635;
        Thu, 14 Aug 2025 03:39:15 -0700 (PDT)
Received: from f37.llcblog.cn.com ([2408:8212:9001:a40:5c04:f864:9735:818c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f6eesm34424189b3a.22.2025.08.14.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:39:15 -0700 (PDT)
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
	Lichen Liu <lichliu@redhat.com>
Subject: [PATCH RESEND] fs: Add 'rootfsflags' to set rootfs mount options
Date: Thu, 14 Aug 2025 18:34:25 +0800
Message-ID: <20250814103424.3287358-2-lichliu@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ia0aIIeHCrMUQkDM1TJ80X_KZcXQO27TAozX1hhQbn4_1755167956
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_033919_497426_619CCDC1 
X-CRM114-Status: GOOD (  18.88  )
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

This approach is inspired by prior discussions and patches on the topic.
Ref: https://www.lightofdawn.org/blog/?viewDetailed=00128
Ref: https://landley.net/notes-2015.html#01-01-2015
Ref: https://lkml.org/lkml/2021/6/29/783
Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-initramfs.html#what-is-rootfs

Signed-off-by: Lichen Liu <lichliu@redhat.com>
Tested-by: Rob Landley <rob@landley.net>
---
Hi VFS maintainers,

Resending this patch as it did not get picked up.
This patch is intended for the VFS tree.

 fs/namespace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

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


