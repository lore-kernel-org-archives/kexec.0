Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D64DC982E6
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8DswF+PpHLQLFXIsTsYB07zyWStQD5M14yzCJNkAmPg=; b=UkPuc/CycUeKnU1JGjfxPc2Pmw
	Xl5xKO1a7EuWRP1WZzoQ3uOx/9xVW4DtlzRrIvNzVdVbB6IIQ/GqK1gZzWre/F4kAznN+fOUiVwd4
	ShDdbF1l9RDwOYlKWuoY05vq2IM+aMVbmWy8XeDOxne8n6diFBdLjKfM7szrlbUL8FJQlOt/7lQSq
	pY7jsTLbZ9zlZ2fYCK7fgrU/jEAlOC7nV3NhV5thntlSHKyCIVt0VYMWd48wzhZhB39AaV/8ZjuPy
	8PUXouHWoEN+ibT7G/rU/HFoFA2XlLbFXeXbaWMuI5XBbx1/iWAU1gtMq4KP41W19BhsMx/KM2NOT
	yeVSe7lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4v-00000000Nhy-2oNW;
	Sun, 20 Sep 2026 20:24:01 +0000
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NNX-00000000J2D-0l1u
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:39:12 +0000
Received: by mail-yx2-x0e.google.com with SMTP id 00721157ae682-8961cca9193so28171107b3.3
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933150; x=1790537950; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8DswF+PpHLQLFXIsTsYB07zyWStQD5M14yzCJNkAmPg=;
        b=KoWRDyjz6XNhbhbDEIFBYukPqZQlsFt3Qz1tDKvwPc723sf6WsHOlwK69dfKEsiW77
         tUWJLYMsDbahUnGc8pXRqhPA6JnuHCqbpmdDWeQ84CeLEgZ0xbTWX6J5NC6IbC6MVkXY
         aPXQnEUGJyxUF42upAstvXa5IFXGZ0MDTiZn82QHkmm1Ys0cKpIR37xs6l6Rf0aWP82c
         ZZinvaJD5KSN0PTF41jN0ApCSfSVc7E29bdPBnpH0ROqaDyYTLf4oZYeDKva18IAgMOF
         ahnHIpj2/la7HeM9Us0nd1leVILazUoy69JC4fFy3Wo4cOpy/gfycF3yYhiSPqSO4Rjv
         s9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933150; x=1790537950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8DswF+PpHLQLFXIsTsYB07zyWStQD5M14yzCJNkAmPg=;
        b=PVtLnQsADcJSpEiiJuXEiQCu0M3cdsPblOnk0vZY/ZVpdKBusl7ZlIuMvjIs7TwLEd
         XfCkeP9zGZ8ZkyzI3LF5ei82AdB7P4vJkBU6E4XrSQifJv50phTcc2rB/6HFHo6B0ZEw
         gpbJX+1g3uPcCn/zjzAHPClJWZHOtZVSe+LNtyw0jJslKCjmFtmFDu5BixwKcbaeq3+D
         iYpq76CAXRfddLaSz6HXi2s8WLwYPz97bBdTWA2UoaGIVP5c0tKaHU/i06jcoPsFBy3q
         CAw9BB1UcQnK0CUv9al8EmVxde2lu0LV03EQm1X1oFKANYwtbjnW10dvk/YqgBWaUMst
         X8sw==
X-Forwarded-Encrypted: i=1; AKwUvBwawidFH5vxaQtBghmQDj2RXCr2tNd1aRJh+8piEwgfPo0qvR9S4EaHbDZijpbuqNLVB4YXFg==@lists.infradead.org
X-Gm-Message-State: AFuF++knVezrRlIpkoZkExwH2acFZp4I+Cf/f60Ho0tB8AzwbaEBflSp
	rc1p45chydDbgnSoUGIB/aVd+ShVSsnQeWzADlVdOskC9NvFuQLxOhTTL56B6iian3g=
X-Gm-Gg: AYBFou3uZNhnO4b1OyGVmJbOanS5QFQyy3xRf0f2GXwrpP1V5gSImzjvQR7aj3uLKol
	LAR1H3FP4VPMYB27Nt3oD7jVB+PulhZjNY1ZwwDDz0GfcYKMhB19kIW/K/XsBTu7oEKsQLuybZ6
	eS/310Mmj+OEatc5eVMDcCrBVj+ppjLCDfGGGHnoXazdGHUvHzKp/GQ4ngvpbROKBRv+M5Be++9
	crbsBLFvmZUG0231QNbEhu8v+z1rHlWlepb+wm+xHcZc0WQND5+C3jfhK3NvRJeJwrCZVNoJzIL
	+mJDII+2caKVeFXWc1h6Q8NwKq3+Upb0ytwtZBuBKe/da43B7U6Ov1/192M/+pukSu1f+feG0yL
	/FiydL66xNcc+BUnsp0r0trNkdFqrpk0WNwkZ9PlLeXWXX5n4PSCAitnP+QYbllvxwM8SRisYld
	y1q4h03EaTgWY4c2Pta49D5D+1roJ9olHvfmh5eVQ8W8RdXAnv+1vBHEt2TyRfVmLtobsoOuRoo
	pCtxS+dduAFjBNo7UOTMEiO+EUz2KSrjqmf2H+q7GeUGUlt5qzKK4/8COxR4kqS2UmdnmNVyHZ3
	bGP7qJ+7kt/L+C4OXCo=
X-Received: by 2002:a05:690c:39d:b0:89b:6b8c:8edf with SMTP id 00721157ae682-89b6b8c9360mr12390877b3.50.1789933150155;
        Sun, 20 Sep 2026 12:39:10 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a41521471sm19169577b3.6.2026.09.20.12.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:39:09 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 23/46] Documentation: liveupdate: Add physical CPU preservation documentation
Date: Sun, 20 Sep 2026 15:36:27 -0400
Message-ID: <20260920193650.3373435-24-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123911_230357_C9F7BB11 
X-CRM114-Status: GOOD (  10.27  )
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:19 -0700
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

Add documentation for physical CPU preservation subsystem, workload
attachment API, architecture backend hooks, and KHO serialization ABI.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/liveupdate/cpu_preservation.rst | 34 +++++++++++++++++++
 Documentation/liveupdate/index.rst            | 11 ++++++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/liveupdate/cpu_preservation.rst
 create mode 100644 Documentation/liveupdate/index.rst

diff --git a/Documentation/liveupdate/cpu_preservation.rst b/Documentation/liveupdate/cpu_preservation.rst
new file mode 100644
index 000000000000..a7a534188685
--- /dev/null
+++ b/Documentation/liveupdate/cpu_preservation.rst
@@ -0,0 +1,34 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=========================
+Physical CPU Preservation
+=========================
+
+.. kernel-doc:: kernel/liveupdate/cpu_preserve.c
+   :doc: Preserved CPU Subsystem
+
+CPU Preservation Workload API
+=============================
+
+.. kernel-doc:: kernel/liveupdate/cpu_preserve.c
+   :export:
+
+Architecture Backend Interface
+==============================
+
+.. kernel-doc:: include/linux/cpu_preserve.h
+
+CPU Preservation ABI
+====================
+
+.. kernel-doc:: include/linux/kho/abi/cpu.h
+   :doc: CPU Preservation Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/cpu.h
+
+See Also
+========
+
+- :doc:`/core-api/liveupdate`
+- :doc:`/liveupdate/vmm`
+- :doc:`/mm/memfd_preservation`
diff --git a/Documentation/liveupdate/index.rst b/Documentation/liveupdate/index.rst
new file mode 100644
index 000000000000..415ac748c9f7
--- /dev/null
+++ b/Documentation/liveupdate/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+Live Update
+===========
+
+.. toctree::
+   :maxdepth: 1
+
+   vmm
+   cpu_preservation
-- 
2.55.0.1082.g2b9226bbc0-goog


