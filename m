Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1009CCD1AF
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+dhzEiy+8NWdg0h4CeSLeODHjNB3Z/i+xinCfvk2bH8=; b=Vujm5pjqDHKnHoOL1TlygR+0yB
	UHrpOIJJ8c9nQP/mxZj6AIAjMn/lafUFPlOSCrD14gMdoTpGekHGrncGanVquUzXJxhAzkWOUwtN7
	BURn39gaf0a8vT7cotP+77J/0eEJuihn2gmULlKOxs1SIMz5eRid27+OSXdrjonTsIshTLLF7k33B
	AnCTHwhk8ajnchMmCmyCOok24VqX+Ew7lKSZeNQgFiAsW6wTYaCB7GuH9ql1km6yJIkBlxraISOUk
	1CwnabH1sjT7AtCbU2UU5wcGjYBqV5ICqeF/rC/OKXxkBsSgIOT4ESJKkDnljCCggDrR/48c8d6K8
	fjq5VupA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMjB-0000000AjDN-3Pmu;
	Sun, 19 Oct 2025 06:17:13 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMj9-0000000AjAs-12iT
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:17:12 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-33bafd5d2adso2814644a91.3
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854630; x=1761459430; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dhzEiy+8NWdg0h4CeSLeODHjNB3Z/i+xinCfvk2bH8=;
        b=mXDzOw+BX7kpN+PtOHQ7LV1vOTt4AXGRMoRa5iKYO7Q5wBmDYGkqtQRynJSRIMR0Sd
         l/KypVCYWjs5i8JqX4lUwuN4C8mV3bK1D78OJmnH29x+Ks+I+ctAgHLopkSlRh78oOAB
         m3VKIgRyKm5tqIwVrF9TRzTzfu5bUK8cIwUEm3uWDB5wnQXQUuHLvkDm7mHsQEC4s3cC
         1KApppMXHHt2kyPfjhO/vBuSSKltgbVl64okNVCBhTkTRYa/fFUTZk5w6cfMi69KmWXy
         hFzXaoA6zfFjJIyauWOK/WIlUwSE+sKfeGn0XznNdIFMUR+DKdrPv4BAz4INRQz9XwEb
         LDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854630; x=1761459430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dhzEiy+8NWdg0h4CeSLeODHjNB3Z/i+xinCfvk2bH8=;
        b=u0AKTz51FRZgeub2Eexjd0hQmri9LKQP618ob8djAsqoTcRnL3el+eCVCdXVDVsPC9
         5f0mjcp5IJGCN6J8ef3ry5mc8MO0vNxQDUg3F86t3qPum+AxsxXDexXm1qhyFqeyUd7k
         q3QRDzv5TzUbvkDuInaihn7GZC0D6CpvvvNroKa49Br+5/YoCKF4DakshYdKr96m7WOY
         29JaL1j0wuF71CuKWIcVDmyB3vevIL+I/LxJwwtkvTbAt5EMl2gcnGC3d2A0/u9VtvIS
         LaGFzeAww8CwKevdQcZ7WgLznbNsNDCtwwCUeEXVUbRLgvGIoZrkA4q4MrKS6YzkKfbQ
         Jd3g==
X-Forwarded-Encrypted: i=1; AJvYcCU3Ec63yqdei0cnoAGu98JSoTspO/5zo2DKBGT663Uu8TUa/GCXtTELfZdnxQcFG6wQ9j478g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyzC30iiCfJd16lmhh2WoAuHj8o83TxVNPXZMmyBIQmMOXqgjwP
	QOlOI7xdPpNEphAC9yHLMe4VAHjTtWdNVnEG2rt/E/eW/9b7+a1sT8yu
X-Gm-Gg: ASbGncvZ0ECqVttk9cYzDo8GgDYejWCULHhYU4LnLzp6L5iAKLfqDy+03vLpJc7F6jj
	+mKwa7B6wiCX8dRAev6YxoLAda/7jKAfw1+3FO0raRGXkbAtWz/zhkqYgKgMggP0cMrGKVZMYwh
	Zjo2ltzjNpArF3AKGm030OclQBWZ3EDBK5t1C5yzm0gdC29vGNPIwvJix61NLW1SSvTkKfvkBoK
	i0txymuMub5SUeXgDQzAYCE1/Bm/O70+v/1MouTDpOIDJMb9tZgIonFbcbe40kLFICXdw19NR6E
	74HejfkukHnazOIzJAuVO1qljYadftHrB3n34x0gTQlPaJy1t3Gtf3ffjA+j7cn0Js0pc5sjz+2
	azBxKLq90Dp6gk1JqwGJWg0yuHG2JvcTorDv18K0qzcarXaCSL8Mch48lTvO7s6yo+sA+tL61Jx
	WbomRdls4H9sIpTY0=
X-Google-Smtp-Source: AGHT+IHsfMse1ea3nbYNy4BvjdFagVFMuvl17zEl9LnMyhbIq3nsVQdQyV1KljR01j/1hJqe5RDh3A==
X-Received: by 2002:a17:90b:1e07:b0:32e:7340:a7f7 with SMTP id 98e67ed59e1d1-33bcf85abb4mr10954646a91.2.1760854630353;
        Sat, 18 Oct 2025 23:17:10 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:09 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multiernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 10/16] Documentation: Add multikernel usage
Date: Sat, 18 Oct 2025 23:16:24 -0700
Message-Id: <20251019061631.2235405-11-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231711_312772_4812881E 
X-CRM114-Status: GOOD (  18.70  )
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

From: Cong Wang <cwang@multiernel.io>

Signed-off-by: Cong Wang <cwang@multiernel.io>
---
 Documentation/multikernel/usage.rst | 215 ++++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 Documentation/multikernel/usage.rst

diff --git a/Documentation/multikernel/usage.rst b/Documentation/multikernel/usage.rst
new file mode 100644
index 000000000000..a2ec8d56ca1d
--- /dev/null
+++ b/Documentation/multikernel/usage.rst
@@ -0,0 +1,215 @@
+===================================
+Multikernel Kernfs Interface Usage
+===================================
+
+Overview
+========
+
+The multikernel kernfs interface provides a clean, user-friendly way to manage multikernel instances through the filesystem. The interface is located at ``/sys/fs/multikernel/`` and supports automatic instance creation from multikernel device trees.
+
+Architecture
+============
+
+::
+
+    /sys/fs/multikernel/
+    ├── device_tree         # Root-level DTB upload (write-only)
+    └── instances/          # Instance directory
+        ├── web-server/     # Instance created from DTB
+        │   ├── id          # Instance ID (read-only)
+        │   ├── status      # Instance status (read-only)
+        │   └── device_tree_source  # Instance DTB in DTS format (read-only)
+        ├── database/       # Another instance
+        │   ├── id
+        │   ├── status
+        │   └── device_tree_source
+        └── ...
+
+Workflow
+========
+
+Phase 1: Instance Creation (Automatic from DTB)
+------------------------------------------------
+
+1. **Create Multikernel Device Tree**
+
+   Create a device tree with multiple instances:
+
+   .. code-block:: dts
+
+      /dts-v1/;
+      / {
+          compatible = "multikernel-v1";
+
+          instances {
+              web-server {
+                  id = <1>;
+                  resources {
+                      cpus = <1>;
+                      memory-bytes = <0x20000000>;   // 512MB
+                  };
+              };
+
+              database {
+                  id = <2>;
+                  resources {
+                      cpus = <2 3>;
+                      memory-bytes = <0x40000000>;   // 1GB
+                  };
+              };
+          };
+      };
+
+2. **Upload Multikernel DTB**
+
+   .. code-block:: bash
+
+      # Compile device tree to binary format
+      dtc -O dtb -o multikernel.dtb multikernel.dts
+
+      # Upload DTB to create instances automatically
+      cat multikernel.dtb > /sys/fs/multikernel/device_tree
+
+   This automatically:
+
+   - Validates DTB format and multikernel-v1 compatibility
+   - Parses each instance in the ``/instances`` node
+   - Creates instance directories under ``instances/``
+   - Reserves memory and CPU resources for each instance
+   - Updates each instance status to "ready"
+
+3. **Check Created Instances**
+
+   .. code-block:: bash
+
+      # List created instances
+      ls /sys/fs/multikernel/instances/
+      # Output: database  web-server
+
+      # Check instance details
+      cat /sys/fs/multikernel/instances/web-server/id
+      # Output: 1
+
+      cat /sys/fs/multikernel/instances/web-server/status
+      # Output: ready
+
+      # View instance device tree
+      cat /sys/fs/multikernel/instances/web-server/device_tree_source
+      # Output: DTS format showing the instance configuration
+
+Phase 2: Kernel Loading (Kexec Integration)
+--------------------------------------------
+
+1. **Load Kernel Image**
+
+   .. code-block:: bash
+
+      # Load kernel for instance ID 1 (web-server)
+      kexec_file_load(..., KEXEC_MULTIKERNEL | KEXEC_MK_ID(1))
+
+   This:
+
+   - Finds pre-reserved resources for instance ID 1
+   - Creates kimage using pre-allocated memory and CPU resources
+   - Updates status to "loading" → "active"
+   - Preserves instance DTB for KHO (Kexec HandOver) restoration
+
+2. **Instance DTB Preservation**
+
+   The multikernel system automatically preserves each instance's device tree during kexec for restoration in the spawn kernel. The spawn kernel will:
+
+   - Detect multikernel KHO data during early boot
+   - Restore the instance's DTB and recreate the instance structure
+   - Re-reserve the same memory and CPU resources
+
+Device Tree Format
+==================
+
+Multikernel DTB Structure
+--------------------------
+
+The multikernel device tree uses the ``/instances`` structure with ``multikernel-v1`` compatibility:
+
+.. code-block:: dts
+
+    /dts-v1/;
+    / {
+        compatible = "multikernel-v1";
+
+        instances {
+            web-server {
+                id = <1>;
+                resources {
+                    cpus = <1>;                      // CPU ID 1
+                    memory-bytes = <0x20000000>;     // 512MB
+                };
+            };
+
+            database {
+                id = <2>;
+                resources {
+                    cpus = <2 3>;                    // CPU IDs 2 and 3
+                    memory-bytes = <0x40000000>;     // 1GB
+                };
+            };
+
+            load-balancer {
+                id = <3>;
+                resources {
+                    cpus = <0>;                      // CPU ID 0
+                    memory-bytes = <0x10000000>;     // 256MB
+                };
+            };
+        };
+    };
+
+Per-Instance DTB Format
+-----------------------
+
+When viewing an instance's ``device_tree_source``, it appears in per-instance format:
+
+.. code-block:: dts
+
+    /dts-v1/;
+
+    /web-server {
+        compatible = "multikernel-v1";
+        id = <1>;
+        resources {
+            cpus = <1>;
+            memory-bytes = <0x20000000>; // 512 MB
+        };
+    };
+
+Resource Properties
+-------------------
+
+- **cpus**: Array of CPU IDs to assign to this instance
+- **memory-bytes**: Memory size in bytes (must be page-aligned)
+- **id**: Unique instance identifier used for kexec operations
+
+The system validates that:
+
+- CPU IDs are valid and available
+- Memory requests don't exceed available multikernel pool
+- Instance IDs are unique
+- All values are properly aligned
+
+Instance States
+===============
+
+- **empty**: Instance created but no resources allocated yet
+- **ready**: DTB processed, resources reserved, ready for kexec
+- **loading**: Kernel being loaded via kexec
+- **active**: Kernel running in this instance
+- **failed**: Error occurred during any phase
+
+Interface Restrictions
+======================
+
+The new kernfs interface has the following restrictions:
+
+- **No manual instance creation**: Use ``mkdir`` under ``instances/`` is disabled
+- **No direct DTB upload to instances**: Instances don't have writable ``device_tree`` files
+- **Centralized DTB management**: All instances must be created via the root ``device_tree`` file
+- **Read-only instance files**: All instance attributes are read-only for consistency
-- 
2.34.1


