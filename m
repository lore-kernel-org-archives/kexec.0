Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825B4CC6B1A
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bWpNLUzvXXnBTpZNjknwwhw/as8BAKF/fqR9wquhzLQ=; b=rCHAFeubHbykd+8zYibyUOWURG
	P2bL9PYxizwUq2YebSsLPwP6+3x5oTd76V2YPShlp8TAYbqNQ5cDw87148G75GPtLB59xUaHfLHJx
	gYCbbgFnAYcjuM5fDucziDyHbfugrm4I7wB8Ry4Ey6k8kLD0ACmOJmNlWG/VSiP9Q8CpMZrMeXaBv
	MA1S6BV3Ylm9SY/eP3aQd/v1+nYXYIr2Ba+PzJ9R1mHpY98iYqKT5+CkvHLmL27f0A8EWEFws6fDQ
	xZS2bfZLvor1tMGH++BbLA2i/iF6wGtwuo2LKIlejKOP6Oqd45TPHbqR7uoJQcbyTo5aiT+6/tkjn
	Hj0L4LKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfKE-0000000DUtM-3X9v;
	Tue, 13 Oct 2026 16:26:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfK7-0000000DUoj-1wL2
	for kexec@bombadil.infradead.org;
	Tue, 13 Oct 2026 16:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bWpNLUzvXXnBTpZNjknwwhw/as8BAKF/fqR9wquhzLQ=; b=fVqINejbKhpAFzXAKXNuxUa2J2
	NsjMUF2G0ElwrgDESY9d05N/wjo0l/v+FOhehvmJJEEF5qvkwZTOMxx0J240UTkUN6b0Ff+c7lKjm
	m5qQmXfaeAgnHa66p3ZBuAv2Td2tQsCfV5VG5E3jQKvd+NUEZQ3SECZ8Mb1uxjkyB3IM9JJohXdqZ
	2XeGPFUhiW7ns8yugjZ8lsUmvTxpp3ZwCIETJ4xaM8ggpa2A2Wo1BkhordZXa7q9FhjciGdunEHga
	XJyNuj1DLGFrR37q589L0UkHK1DT/2CMG54Jwu64BEiE+G24o9r2W1tJcdISpTHufkQutq6kvh4VM
	I7NzFqXA==;
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGfK4-0000000FmNS-3DxK
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:25:54 +0000
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2e5d759038aso526835ad.3
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908751; x=1792513551; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWpNLUzvXXnBTpZNjknwwhw/as8BAKF/fqR9wquhzLQ=;
        b=B0bZbCWnizV8T5/BYJMIhV4AsEE3eFVaUA9g0SoI2kA1g9qtAAC8qPUP5rzWldJ5BD
         ah2IBR0wF7ICKvzg62mNjerym0GGfIpHcI4PJJIb2oQdVavUZXJ1Vr6SQFFRkbzr3kNr
         z5WaYdLRjnfEXPk/pCwV28GiezQogyIdteBNVH4ho+46FPl+epBZHq5vOpmmRE9J0Upf
         1UT5K1+u6IEKewhqYs3YXfDsEtrGasPWSQ5i/DQ6nrnQvNsI6qsLPRaCl8RNe+ECKNFD
         RC74K8Js0rZtkgB0abT8VhZXMjdIajGu5GjLgSipEyVFq0TQ1q3IestifujH3m6AKra2
         jXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908751; x=1792513551;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bWpNLUzvXXnBTpZNjknwwhw/as8BAKF/fqR9wquhzLQ=;
        b=pVmzw4v7vnVVV+3IB3IsyirLyCLcXMdpFCR1beiCw2T7QD1ndrJT1fjxH0XrdnYyFH
         j5xHfXFCu252r0q3jwV8sAMXGkAngaCOUaeri4pQ8cABhzk62E8sH7cwSSbNUwHoyb9t
         iUjMiy5CVrIJYfr/zSbmp5Q80mr8cZvg423GvXBo+ipFBt2PT1mmR36A5e+JepgYXa2H
         dFeYXo63g7+7/0zM3gcNB0VQsa5sYM4iXRj/9PL/J4l78UGkMnxiDcUX8+29wTXL0Ehb
         vOxyTe+LdmF0vdGNgclmObRKxCArQl34667rQKvHbW01kxF6f/NnEk+T9Jjo/IEoifGH
         L8pQ==
X-Gm-Message-State: AFq9FYJZT537ERdbxyHp0tdPpaD5pzfnOyz5Gi4gRYtyJ8Yae1Gw/bKW
	1Qq0CcTUOAIgQk+qd6pl2ppD/evX9krCKH5f6VT98Pk6bhyNl+p+v1lZLv4XQ0K7VB37vAEw0vi
	UB2YgOBUYBNE0Y1wprczDkVzgScPorw5Qqk2reKqMW2L+K5FCsB2sWfE+/xau2piG60cum/ypRU
	UK/b+0+tW6SOzRQf2ulFchr57HOMSRQSHbN0WT6gZuR4Y3tq43vlY=
X-Received: from plnq15.prod.google.com ([2002:a17:902:f78f:b0:2e2:d223:8126])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2309:b0:2e5:38bf:cb43 with SMTP id d9443c01a7336-2e8427f0c01mr119406635ad.2.1791908750143;
 Tue, 13 Oct 2026 09:25:50 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:29 +0000
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-14-dmatlack@google.com>
Subject: [PATCH v10 13/13] Documentation: PCI: Add documentation for Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_172552_936367_4721D0F7 
X-CRM114-Status: GOOD (  15.63  )
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

Add documentation files for the PCI subsystem's participation in Live
Update.

These documentation files are generated from the kernel-doc comments in
the PCI Live Update source code. They describe the File-Lifecycle-Bound
(FLB) API, the device tracking API, and the specific policies applied to
preserved devices (such as bus number inheritance and bus mastering
preservation).

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/PCI/index.rst           |  1 +
 Documentation/PCI/liveupdate.rst      | 35 +++++++++++++++++++++++++++
 Documentation/core-api/liveupdate.rst |  1 +
 MAINTAINERS                           |  1 +
 4 files changed, 38 insertions(+)
 create mode 100644 Documentation/PCI/liveupdate.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 5d720d2a415e..23fb737ac969 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -20,3 +20,4 @@ PCI Bus Subsystem
    controller/index
    boot-interrupts
    tph
+   liveupdate
diff --git a/Documentation/PCI/liveupdate.rst b/Documentation/PCI/liveupdate.rst
new file mode 100644
index 000000000000..96b1d7f5df3a
--- /dev/null
+++ b/Documentation/PCI/liveupdate.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+===========================
+PCI Support for Live Update
+===========================
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :doc: PCI Live Update
+
+Driver API
+==========
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :export:
+
+Internal API
+============
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :internal:
+
+Live Update ABI
+===============
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :doc: PCI File-Lifecycle Bound (FLB) Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :internal:
+
+See Also
+========
+
+ * :doc:`/core-api/liveupdate`
+ * :doc:`/core-api/kho/index`
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index b3c689e633c1..2bce2644eba2 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -74,3 +74,4 @@ See Also
 
 - :doc:`Live Update uAPI </userspace-api/liveupdate>`
 - :doc:`/core-api/kho/index`
+- :doc:`PCI </PCI/liveupdate>`
diff --git a/MAINTAINERS b/MAINTAINERS
index 3eacaa98775c..5d1b58271989 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21055,6 +21055,7 @@ L:	kexec@lists.infradead.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/PCI/liveupdate.rst
 F:	drivers/pci/liveupdate.c
 F:	drivers/pci/liveupdate.h
 F:	include/linux/kho/abi/pci.h
-- 
2.56.0.385.gd3acb90ef8-goog


