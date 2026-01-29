Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5B4D73E8D
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ibCvH5eZEobsLpnry66xHV5xBXd91tAWSqhhlaOXScs=; b=GeaXWSL4G442aJTzxENLP+J8Ss
	9T/ApBoKdQLYhQ0+CUNICafTou5ug444x0MY2OjwDnUkKoNAQa1KdvlC24tf17paxBFBQuOqmLJdD
	sHFzj1IkmGSsKDTwAxg0piu0Mqx+KlYMGoxkH/Ka3/f29Y4gFpTqSjJumKitxIjJ5WkTMM6CDTUKL
	Oz7YYDP4AhSW1ai86yl8uXe4L9M8n6P1E7Q/nAqA5v7GKAVPl0r88xoTg2JpdGCq3t0Svu/pyaVan
	68wvTm4tkSE6NSCYz3IK0uRx4AM5v6LP2IXpx+d8POf8MxkesJIrde1NU1uyV5PdO1xQh6fU+cdKQ
	a/Orkv5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWf-00000000fUG-2eOj;
	Thu, 29 Jan 2026 21:26:05 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWY-00000000fJM-2pC2
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:26:03 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-34ab459c051so2563730a91.0
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721956; x=1770326756; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibCvH5eZEobsLpnry66xHV5xBXd91tAWSqhhlaOXScs=;
        b=S72zNWsm7pQX2mwxHLnZmYg28jYp8dTLwd3REmACWy3nDc1ERDxtR7XqWKQLVF364p
         BIu2Oe5pyAiYaVxEPivFEMjFXdX7dR6ZN8ZG+MzbYTluWBwsLp9555T0WcuYZQwoCcn9
         3QpFB3GumI+Kg9MXyarRgp7doGUGqLLKrm71//2yFuORAr5sb2iDZE4hIlHZu+wujf/f
         iEECrgtSklOBjDw4gALi7JPacKyWxifYGsBWHt4XaufXytRv/s7aaIHMNKQycGRuwLBm
         UG7ZuXDoTOI3Id49haiD6xTDQn+MJEvRpSdDQUeh3sNSV3dkdcbnaotxwImkXYBSbizY
         gHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721956; x=1770326756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibCvH5eZEobsLpnry66xHV5xBXd91tAWSqhhlaOXScs=;
        b=Mh/JZ+VzcLIPc5TfyxJwqprAa+YW/FYzym41s6Iwex9RdqcxYc1ohl6I5x/Wtvs77D
         L6ElT40VJfWKDUB4XzJA7eQtDiL+WI2N8jv3K/ibmRnvZxdzZj2BDYT9TJZbU459OFHF
         uS0E/Sf96GP36PNZulfc8b+N9RDwB8kIzy5/MuAzc+4aqLkIScqgTBpcak0ViZqc51N2
         tUcOCrsN6b1MZUvACY83D+gt5S87YZfwJIAr/eV1+c4xWr/NFeF1BIoRv4HSrz9JERya
         B6DDxeW1GPt0YLf3fQxln3rG6FjOP23ORFKaJ26iyb+8Iow8yRufeeUnl87rOz2C9F0l
         6qsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGE2HodtMKh3gINOt7NSfQMZCacSMmZZbcqWefy0cCHSzpJkIk5cwSQtdmDX4+ZcMaP58nmw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxggl/fDH6rqFP9utjSe1xFWIbl9MvSW8u0sRePSskYVg5QF3eZ
	S70n5beYi5lTzq/FqPNTnwsb8IQB32ICjIO9o0lyo+yxozQNn27lK5TQGQ8rTqUtYgVNH/03JbT
	tzxHHszqMImyIJA==
X-Received: from pjbpv18.prod.google.com ([2002:a17:90b:3c92:b0:33b:ba24:b207])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3ccd:b0:352:bd7c:ddbd with SMTP id 98e67ed59e1d1-3543b38af32mr802532a91.23.1769721955711;
 Thu, 29 Jan 2026 13:25:55 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:58 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-12-dmatlack@google.com>
Subject: [PATCH v2 11/22] docs: liveupdate: Document VFIO device file preservation
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_132558_734987_4FEAE9C7 
X-CRM114-Status: GOOD (  18.36  )
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

Add documentation for preserving VFIO device files across a Live Update,
as well as some generic file preservation documentation. This
documentation will be extended in the future as new types of files are
supported and new dependency/ordering requirements are added.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/userspace-api/liveupdate.rst | 144 +++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
index 41c0473e4f16..dbf1e4aeddd7 100644
--- a/Documentation/userspace-api/liveupdate.rst
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -14,6 +14,150 @@ ioctl uAPI
 ===========
 .. kernel-doc:: include/uapi/linux/liveupdate.h
 
+File Preservation
+=================
+
+Files can be preserved across Live Update in sessions. Since only one process
+can open /dev/liveupdate, sessions must be created by a centralized process
+(e.g. "luod") and then passed via UDS to lower privilege processes (e.g. VMMs)
+for them to preserve their own files.
+
+luod::
+
+  luo_fd = open("/dev/liveupdate", ...);
+
+  ...
+
+  // Create a new session with the given name.
+  struct liveupdate_ioctl_create_session arg = {
+          .size = sizeof(arg),
+	  .name = SESSION_NAME,
+  };
+  ioctl(luo_fd, LIVEUPDATE_IOCTL_CREATE_SESSION, &arg);
+
+  // Send session_fd to the VMM over UDS.
+  send_session_fd(..., arg.fd);
+
+VMM::
+
+  // Receive the newly created session from luod over UDS
+  session_fd = create_session(SESSION_NAME);
+
+  ...
+
+  // Preserve a file with a unique token value in the session.
+  struct liveupdate_session_preserve_fd arg = {
+          .size = sizeof(arg),
+          .fd = fd,
+          .token = TOKEN,
+  }
+  ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg);
+
+Files can be unpreserved with the LIVEUPDATE_SESSION_UNPRESERVE_FD ioctl. They
+are also unpreserved once the last reference to the session is dropped.  To
+carry preserved files across a Live Update, references must be kept on the
+session files through the reboot(LINUX_REBOOT_CMD_KEXEC) syscall.
+
+While a file is preserved in a session, the kernel holds an extra reference
+to it to prevent it from being destroyed.
+
+Only the following types of files support LIVEUPDATE_SESSION_PRESERVE_FD. More
+types of files are expected to be added in the future.
+
+ - memfd
+ - VFIO character device files (vfio-pci only)
+
+File Retrieval
+==============
+
+Files that are preserved in a session retrieved after
+reboot(LINUX_REBOOT_CMD_KEXEC).
+
+luod::
+
+  luo_fd = open("/dev/liveupdate", ...);
+
+  ...
+
+  struct liveupdate_ioctl_retrieve_session arg = {
+          .size = sizeof(arg),
+	  .name = SESSION_NAME,
+  };
+  ioctl(luo_fd, LIVEUPDATE_IOCTL_RETRIEVE_SESSION, &arg);
+
+  // Send session_fd to VMM over UDS.
+  send_session_fd(..., arg.fd);
+
+VMM::
+
+  // Receive the retrieved session from luod over UDS
+  session_fd = retrieve_session(SESSION_NAME);
+
+  ...
+
+  // Retrieve the file associated with the token from the session.
+  struct liveupdate_session_retrieve_fd arg = {
+          .size = sizeof(arg),
+          .token = TOKEN,
+  };
+  ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg);
+
+  ...
+
+  ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, ...);
+
+A session can only be finished once all of the files within it have been
+retrieved, and are fully restored from the kernel's perspective. The exact
+requirements will vary by file type.
+
+VFIO Character Device (cdev) Files
+==================================
+
+The kernel supports preserving VFIO character device files across Live Update
+within a session::
+
+  device_fd = open("/dev/vfio/devices/X");
+
+  ...
+
+  ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, { ..., device_fd, ...});
+
+Attempting to preserve files acquired via VFIO_GROUP_GET_DEVICE_FD will fail.
+
+Since the kernel holds an extra reference to files preserved in sessions, there
+is no way for the underlying PCI device to be unbound from vfio-pci while it
+is being preserved.
+
+When a VFIO device file is preserved in a session, interrupts must be disabled
+on the device prior to reboot(LINUX_REBOOT_CMD_KEXEC), or the kexec will fail.
+
+Preserved VFIO device files can be retrieved after a Live Update just like any
+other preserved file::
+
+  ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg);
+  device_fd = arg.fd;
+
+  ...
+
+  ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, ...);
+
+Prior to LIVEUPDATE_SESSION_FINISH, preserved devices must be retrieved from
+the session and bound to an iommufd. Attempting to open the device through
+its character device (/dev/vfio/devices/X) or VFIO_GROUP_GET_DEVICE_FD will
+fail with -EBUSY.
+
+The eventual goal of these support is to preserve devices running uninterrupted
+across a Live Update. However there are many steps still needed to achieve this
+(see Future Work below). So for now, VFIO will reset and restore the device
+back into an idle state during reboot(LINUX_REBOOT_CMD_KEXEC).
+
+Future work:
+
+ - Preservation of iommufd files
+ - Preservation of IOMMU driver state
+ - Preservation of PCI state (BAR resources, device state, bridge state, ...)
+ - Preservation of vfio-pci driver state
+
 See Also
 ========
 
-- 
2.53.0.rc1.225.gd81095ad13-goog


