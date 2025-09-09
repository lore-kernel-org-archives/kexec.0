Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A650CAC583
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 20:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XK7bLUEvESp+m8RqUZl4D2oF/6AN2tNxcr+b8tCSt7Y=; b=nybDe0z82iQuXL/qK64cIjSOoP
	KwzzybialmU9NEJzrjvnt4l6s1AGMuydWzFLOEeYywtUrBZXANQEkYZcHEoVBWoh7pzi7kSTCMFit
	772C/4B8BezL8+Gv6VYQ5p7nK++xddpo1J3AmcU+WCn+uQBxV/bYkc0HOYiFdEpIVSkLIAv+o4oI8
	xVbpaoxYc+JRxmr568bCUzak8R1vX4v1+WOxK8GukgEL6p4kW8hW9qwlD/p5gCOWYO8T35ik3jV2v
	OjFteOXv9+iAXlaBm4wd5ALckM1t8N+8hQCowGa7KjR1RcB9S4iCfRH8tBUGwTDpoFqFyridFd/62
	nqqGohlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw4kv-00000009wJF-0z2a;
	Tue, 09 Sep 2025 20:15:57 +0000
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw4ks-00000009wF6-1qDa
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 20:15:56 +0000
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B39CEC01AD;
	Tue, 09 Sep 2025 23:15:52 +0300 (MSK)
Received: from localhost.localdomain (172.31.115.73-vpn.dhcp.yndx.net [172.31.115.73])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id IFQqlX5GteA0-oPNV4RHQ;
	Tue, 09 Sep 2025 23:15:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1757448952;
	bh=XK7bLUEvESp+m8RqUZl4D2oF/6AN2tNxcr+b8tCSt7Y=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=l4FamUPeJH/2K/fFm2QGMJdf/TMdhmYBjUawutzSIHby3gBQ+B3lL6Wpkipkd3fLk
	 sO7XVN91XoNbPqj1vqL3ON/aoQC2y44btVzcMZvR9PS7PeLW6Skpxltn0hYiO0//xU
	 NrpO3fwIt5K0uRDNB2l2en+/J4pNiYdBXZUszQRk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v3 7/7] Documentation, kstate: Add KSTATE documentation
Date: Tue,  9 Sep 2025 22:14:42 +0200
Message-ID: <20250909201446.13138-8-arbn@yandex-team.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250909201446.13138-1-arbn@yandex-team.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_131554_663054_4EB701E5 
X-CRM114-Status: GOOD (  25.24  )
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

Add KSTATE doc. Describe 'struct kstate_description' and information
about versioning fields.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 Documentation/core-api/index.rst  |   1 +
 Documentation/core-api/kstate.rst | 117 ++++++++++++++++++++++++++++++
 MAINTAINERS                       |   1 +
 3 files changed, 119 insertions(+)
 create mode 100644 Documentation/core-api/kstate.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index a8b7d1417f0a..6c0466e0bb35 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -136,6 +136,7 @@ Documents that don't fit elsewhere or which have yet to be categorized.
 .. toctree::
    :maxdepth: 1
 
+   kstate
    librs
    liveupdate
    netlink
diff --git a/Documentation/core-api/kstate.rst b/Documentation/core-api/kstate.rst
new file mode 100644
index 000000000000..981ba162109c
--- /dev/null
+++ b/Documentation/core-api/kstate.rst
@@ -0,0 +1,117 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+KSTATE: Kernel state preservation framework
+===========================================
+
+KSTATE (kernel state) is framework to migrate some part of the internal
+kernel state (device driver, memory, etc) from one kernel to another across
+kexec reboot.
+
+kstate_description
+------------------
+
+Most kernel's state is in structs and structs could be described by
+kstate_description. E.g.
+
+struct kstate_test_data {
+	int i;
+	unsigned long *p_ulong;
+	char s[10];
+	struct folio *folio;
+};
+
+struct kstate_description test_state = {
+	.name = "test",
+	.version_id = 1,
+	.id = KSTATE_TEST_ID,
+	.fields = (const struct kstate_field[]) {
+		KSTATE_BASE_TYPE(s, struct kstate_test_data, char [10]),
+		KSTATE_POINTER(p_ulong, struct kstate_test_data),
+		KSTATE_FOLIO(folio, struct kstate_test_data),
+		KSTATE_END_OF_LIST()
+	},
+};
+
+Changing data structures
+------------------------
+
+KSTATE saves/restores structs as a series of fields. When the kernel structs
+are changed we may need to change the state to store more/different information.
+
+Versions
+--------
+
+Version numbers are intended for major incompatible changes, that are not
+backward compatible.
+
+Each version is associated with a series of fields saved. The state is always
+saved as the newest version specified by ->version_id.
+But loading state sometimes is able to load state from an older version.
+
+There are two version fields:
+
+    - version_id: the maximum version_id supported by kstate_description.
+    - min_version_id: the minimum version_id that given kstate_description is able to understand.
+
+KSTATE is able to read versions from minimum_version_id to version_id.
+
+There are _V forms of many KSTATE_ macros to load fields for version dependent fields, e.g.
+
+	KSTATE_BASE_TYPE_V(i, struct kstate_test_data, int, 2),
+
+only loads that field for versions 2 and newer.
+
+Saving state will always create a section with the ‘version_id’ value and thus can’t
+be loaded by any older kernel.
+
+Removing field
+--------------
+If field is no longer needed it could be marked deprecated using
+KSTATE_*_DEPRECATED macro and bumping ->version_id of kstate_description:
+
+	KSTATE_BASE_TYPE_DEPRECATED(k, u16, 1),
+
+The last parameter of the macro is the last version number that have this field.
+Old kernel will save such field, but new kernel will skip it on load. Also
+the new kernel will not save such field (as there is nothing to save).
+Such change is not backward compatible.
+
+Adding new field
+----------------
+
+Addition of new field can be done as version dependent field by using _V form of
+KSTATE_ macro:
+	KSTATE_BASE_TYPE_V(i, struct kstate_test_data, int, 2),
+
+This indicates that 'test_state' only from version 2 and above have field '->i'.
+If new kernel sees incoming 'test_state' of version 1 it will skip restoring '->i'
+as nothing was saved. This is not backward compatible, as old kernel doesn't
+understand the new V2 'test_state'.
+
+Subsections
+-----------
+Another option is adding subsection to kstate_description. A subsection is
+additional kstate_description which linked to the main one:
+
+struct kstate_description test_state_v2 = {
+	.name = "test_v2",
+	.id = KSTATE_TEST_ID_V2,
+	.fields = (const struct kstate_field[]) {
+		KSTATE_BASE_TYPE(i, struct kstate_test_data, int),
+		KSTATE_END_OF_LIST()
+	},
+};
+
+struct kstate_description test_state = {
+	......
+	.subsections = (const struct kstate_description *[]){
+		&test_state_v2,
+		NULL
+	},
+};
+
+
+Subsection must have a unique ->id. If the receiving side finds a subsection
+with unknown id it will be ignored. This make subsections suitable for backward
+compatible changes (migrate from N+1 to N kernel) assuming old kernel is ok without
+information in subsection.
diff --git a/MAINTAINERS b/MAINTAINERS
index e96da6d97e75..a9baf49cdbeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13721,6 +13721,7 @@ F:	include/linux/ks0108.h
 KSTATE
 M:	Andrey Ryabinin <ryabinin.a.a@gmail.com>
 S:	Maintained
+F:	Documentation/core-api/kstate.rst
 F:	include/linux/kstate.h
 F:	kernel/livupdate/kstate.c
 F:	lib/test_kstate.c
-- 
2.49.1


