Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F05606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mn/il6DI;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WB2nCTXX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4vrUGvYBYjikigCpSRsWM3IL2SKRFIwk8YXcudEu+Vw=; b=mn/il6DI+mQYzvYfY1tfR1ovup
	mNbP+SYIUGcExZewmVdkJxv9cZT+r6d3y9qh7zSlTdwK/Pcr4qZfh+7xSbfKCCScE2WmM9nOQ+ZQO
	xhqPwJy3I1Yc8il1IJTWx1UPlUCRXmzdm+43Ca33vSb//H2ZhKKgWV5KXI9AjyyvVUNYUKP1FG0Uj
	p8a+JNsNM2SgE9rzSbtHEYHpuH4NNtF4AEybgISP49YKpvwm5g3Avq1bD5PnEkN1mR83xF/2FNmjL
	iTgVZqjlbB+DzpD0gF4r/Vzlh5fTNNDbuNvHbN5VSgYC4cI1mx/1OJYWhhCNVaDv8QXHFbkXh3vGA
	QI3Ip4Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTZN1-00000007vOg-0Apy;
	Wed, 18 Nov 2026 06:42:15 +0000
Received: from out-240.mta0.migadu.com ([2001:41d0:1004:224b::f0] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTZMx-00000007vOA-1RVh
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 06:42:13 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=FYJgjS5+nVGzEAb8n72wxlzwghj2XRvZF7p3yXiyO2M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794984127; v=1; x=1795588927;
 b=WB2nCTXXbH7W/R1/6oAKysqyeEqZ+HxxGD40vtPxuZKj2uBIwcqZDeCqS+frOAxEeKEyojEL
 LUSHj1VxElrt1ZXqU4po1aayB/2kYcbweRPa13m2WuzBM0eoPZLqtuQynAvr/Wc24ZJ+pb1vScG
 GHnQu9XU6Y4I49YuXLVbJ2zU=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id fc53258ff22c9965;
	Wed, 18 Nov 2026 06:42:07 +0000
X-Mizu-Trace-ID: fc53258ff22c9965
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 14:42:00 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Message-ID: <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
 <sashiko-outbox-220212@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-220212@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_224211_734397_91A6D7C1 
X-CRM114-Status: GOOD (  12.47  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Zack Rusin <zack.rusin@broadcom.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Eugenio Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, Bradley Morgan <brads@mainlining.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 at 06:14am, sashiko-bot@kernel.org wrote:
> > Allow administrators to disable host log transfer on ordinary guests or
> > opt in on encrypted guests. Expose the boolean recording policy through
> > kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
> > Zero disables recording, nonzero integers enable it, and reads return
> > 0 or 1.
> > 
> > Register the sysctl only after the logger is ready. A registration failure
> > leaves the internal default in force. Document that the log is sent
> > before kdump, and that disable_panic_notifiers_platform_list also skips
> > it.
> > 
> > Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
> > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> 
> Sashiko has reviewed this patch and found no issues.

It might be better to turn off this message if not issues found, just
like what LKP bot has been doing.


