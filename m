Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732ECC87FCF
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 01:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C4HQvGM6gCq5UjAgrjI0OpaDtFtWs4L4CZMG/k70A2M=; b=u0yHgvGQH7wRHcGaf0NGFwbf2y
	098G/ISzyt8QOV/LHX5ViK5Bpl5ZWeIEeA/T2OX4oxtIAE8QBneyp+AEJGj2lyOZkfgyBLb1/RLdk
	nDHpLsCFxsGmuB9zK/VXJ1F2oRjp6/R+pAJfwszeuZBGTTbdQBNZVt1UBqsUnlYb/r6e+E+x71/75
	0Ezb6nAMB+gZcJZusxdPLV3q0NlToDzISLhEqL6EY7/1LJEf/kmdfU2P83UXYSXxjTNN6ZWS5rtWj
	wkVK4VjSk1IjraQA5RKaro1i3J5g17d+YSH/x2e4Zn2q4Q0eSe6MlgzxfcWrrj4APZ8zzU+nZy5sV
	3GizD+Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukCKB-00000001p2v-0ah1;
	Fri, 08 Aug 2025 01:55:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukCK8-00000001p1u-0AJZ
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 01:55:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754618110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C4HQvGM6gCq5UjAgrjI0OpaDtFtWs4L4CZMG/k70A2M=;
	b=f32LtwbvXclX48lIqZqV+O9J9mSvapUu1P4nHc0kHhJCZS4frygtgrYuw0cOn2ooXx1zLa
	/5nVNc6yIwxIFWus7pO/SXFfNO9f4Ebtq5orQjIOo7BekDAAZl98QWFMmddm2lN3Aj7H4D
	juXrCdgI8F7w9TelFMFkb0YJxe9jQSQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-DHg2VpGXMiuhIkUEacYAfg-1; Thu, 07 Aug 2025 21:53:18 -0400
X-MC-Unique: DHg2VpGXMiuhIkUEacYAfg-1
X-Mimecast-MFC-AGG-ID: DHg2VpGXMiuhIkUEacYAfg_1754617997
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b26e33ae9d5so2969741a12.1
        for <kexec@lists.infradead.org>; Thu, 07 Aug 2025 18:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754617997; x=1755222797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4HQvGM6gCq5UjAgrjI0OpaDtFtWs4L4CZMG/k70A2M=;
        b=fadZI7uB0HsGEc5rs4JNmQ8VTCNm8UyaRuABZTlH4RAHo1OZ209elYCPYmDkq1de9t
         VdnDZx54ME3cLfmYHIm1OZl88sI6SwdO3t1PpSkL7EDnlumNr8Q85Hb2UUjXgZ4QbV5i
         dczOIBEM0jQ8EuM8EsefDQw0fOWuS5K8iP2Acga21OzwHjM4C9AKipT9acA5NSkYUemr
         biJsyoKK4XMrKCVO9BOeocYMe9vWQZbKKee3W8bwbeUTiWFYkRURhYHKs5C9j8p6zTU8
         voSSXJOYUwYnlzTM0Zn4XkFMm9GABgK0lljjClLVw9r8xMpZCBLzzEuFzQ0J0ELjOkPs
         x7LQ==
X-Gm-Message-State: AOJu0YyK9l1PyeVgy3CewYAB1+pwH/ayZHnvK5ZPcGoHbfsqwwrPwY6R
	y7cILec94WuJr/pK378X3R3s+nBGyeqgypEP/t6jpDXZS/ScMpjQcFPttul2hGWuzDWd8JA/mG+
	TvP3U1hMyAbDlkMAKTQhtEcqvtAjDd+yPu0C3P7BJVcSLE63nEjpFyvYfGlw3M6E43dtVAjTNDa
	U=
X-Gm-Gg: ASbGncsK8kJihUSCog7QKUmAKNETm4hIyYXeXlNM7pd444vvJP0Jr+TvvDh58vcnIbP
	uevvlQ+HL8Sykvt7zStQekQ04Y9uJlZjHJU6ts/SIvfPpT0B1Tzc6mXe1DAQrSteVTvU1rjzN9q
	7L4Xe8v3Pt2bjItwcUlTdOEgNpE6GEV0eGW04GO+MF0Y1ucrs3aPT+zxaYbNHkO9EP83n7ODEEc
	xRA5aJw7L06O+wsUWJtN0EPqWx8ZhTYdGDNtG/KInjvbF7E1xVxWyt3WelBhP0DMQMfJ3Fm2zPV
	xBQ8ToNlTPhC1eZqeNEv81fnVme0yXB98GbggDM14Pw3+5uTJg==
X-Received: by 2002:a17:903:98f:b0:23f:f96f:9de7 with SMTP id d9443c01a7336-242c22fa800mr17636715ad.51.1754617996949;
        Thu, 07 Aug 2025 18:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzC3BF1Wywtk0aqa949HqgY/0heAREy/DrGTfFtCkpL8S7xC6IQT6f8gsYFcsQ3Ak6gssjzw==
X-Received: by 2002:a17:903:98f:b0:23f:f96f:9de7 with SMTP id d9443c01a7336-242c22fa800mr17636425ad.51.1754617996551;
        Thu, 07 Aug 2025 18:53:16 -0700 (PDT)
Received: from f37.llcblog.cn.com ([2408:8212:9001:4210:b99d:5e23:c671:cb6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769e9sm197365815ad.111.2025.08.07.18.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 18:53:16 -0700 (PDT)
From: Lichen Liu <lichliu@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	rob@landley.net
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	weilongchen@huawei.com,
	Lichen Liu <lichliu@redhat.com>
Subject: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
Date: Fri,  8 Aug 2025 09:51:35 +0800
Message-ID: <20250808015134.2875430-2-lichliu@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bY6lE-1nwjnz-sjVATktcM64VkMsaypkbumGsKwaemg_1754617997
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_185512_149069_8B9A924A 
X-CRM114-Status: GOOD (  17.90  )
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
---
 fs/namespace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ddfd4457d338..a450db31613e 100644
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
@@ -6086,7 +6095,7 @@ static void __init init_mount_tree(void)
 	struct mnt_namespace *ns;
 	struct path root;
 
-	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
+	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
-- 
2.50.1


