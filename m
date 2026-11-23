Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD385606A326
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DEAgKL2f;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=Pvn15Xxb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GX5aMCRIgJiZuuGkpcknd4x+6v9xITU+D6Sjcmd128Q=; b=DEAgKL2fjN7vS1
	7d56SpyDahdmj1J+JAr9EyM0oETLd2sbAZGGAnZBpYhSbiM4TW0EtWn84bo2S3soa2EGG4VuPItMi
	HYCCstvNtJBVGKn5HyE7XrlRIm77eD5FUDDIJe7pBClZm9I1uF/kB+LGzDCsWDEia3TP37k+M73Ku
	Gx5FY9R3PnjIsdnHkvipRXyi8Ast+MIcmGn+KgpCStgJzZ34t+DyFqtnzKGsr+AttaIH1gM+qnyKi
	Nv2aayp4Q39UtpeWmJHUXL+Rr+LQpFo6ymuXXCyUPIHFYr6NWPbDUm9ROPV1FzFFBOS4WRUGT4l9P
	ri0iJzM04cR9f22MHS2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVaKv-00000004nHR-20Fo;
	Mon, 23 Nov 2026 20:08:25 +0000
Received: from outgoing2021.csail.mit.edu ([128.30.2.78])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVaKt-00000004nGK-0Igl
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 20:08:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GX5aMCRIgJiZuuGkpcknd4x+6v9xITU+D6Sjcmd128Q=; t=1795464503; x=1796328503; 
	b=Pvn15XxbNXj6Ybe9cFgVXlf8dvBTEZgD5TOgRg+sH0WJ5mqhRG0K28Vqv955G0VRZ/h2jVjdcxW
	nXwT21yYUiFoiM56zYVldDV8GjO0cyoH6h4S/d7pVPtJDAPJ8muXUfgct8+YMlAZ3vpPjAMrMN7Xt
	pykUHiA9jCyD8tRi3o2gHIQq1unwFat/a3KN0TvVuey+Wc/YrB6QiiYv+rV4rxNluNn3Fx55QkAu5
	SPx0kJtUlXTfNnrxq+fOPqaJtOjoEBvejT7YGmni7Oc39rWV8GuOIYaRWUrkocnHbGsQPe9+vI7pN
	rSJmJ7JB0mPpFl5zMEtV/wg3HYD97Q5WclEg==;
Received: from [49.207.211.146] (helo=[127.0.1.1])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1xVaKi-006jgv-4Z;
	Mon, 23 Nov 2026 15:08:12 -0500
From: "Srivatsa S. Bhat (Microsoft)" <srivatsa@csail.mit.edu>
Date: Tue, 24 Nov 2026 01:37:54 +0530
Subject: [PATCH 2/2] MAINTAINERS: Add missing files to KDUMP subsystem
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-fix-kexec-kdump-maintainers-v1-2-79c6a6144de4@csail.mit.edu>
References: <20261124-fix-kexec-kdump-maintainers-v1-0-79c6a6144de4@csail.mit.edu>
In-Reply-To: <20261124-fix-kexec-kdump-maintainers-v1-0-79c6a6144de4@csail.mit.edu>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_120823_113758_52BDA901 
X-CRM114-Status: UNSURE (   9.30  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The KDUMP entry covers crash-reservation code and the vmcore interface,
but omits the crash-reservation header and the vmcoreinfo implementation
and header. It also omits the dedicated kexec/kdump and vmcoreinfo sysfs
ABI documentation.

Add these files to KDUMP so that scripts/get_maintainer.pl can recommend
the subsystem maintainers and kexec mailing list for changes to them.

Signed-off-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb4d9c20db06..bb8e1c414394 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14429,12 +14429,18 @@ M:	Pratyush Yadav <pratyush@kernel.org>
 L:	kexec@lists.infradead.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/ABI/obsolete/sysfs-kernel-kexec-kdump
+F:	Documentation/ABI/testing/sysfs-kernel-kexec-kdump
+F:	Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
 F:	Documentation/admin-guide/kdump/
 F:	fs/proc/vmcore.c
 F:	include/linux/crash_core.h
 F:	include/linux/crash_dump.h
+F:	include/linux/crash_reserve.h
+F:	include/linux/vmcore_info.h
 F:	include/uapi/linux/vmcore.h
 F:	kernel/crash_*.c
+F:	kernel/vmcore_info.c
 
 KEENE FM RADIO TRANSMITTER DRIVER
 M:	Hans Verkuil <hverkuil@kernel.org>

-- 
2.43.0


