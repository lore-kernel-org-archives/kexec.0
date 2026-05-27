Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C614DCD5BD0
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 20:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZBWzBJ7tcP2BdZJjyaMfbgUmI299X9kvwn5AEgOwKY=; b=16LLdT/Qf7T/Kl08dSkdGOPR0D
	u3jLClR6PgUBjPk5TxMn0oNc3wCvRSwFtQNFtvKbQXMOdrDfp4cpRsPJ5t7S74hDAqcH5YDNx/KCH
	DIU7ITS5LSzO6COQ4GtYFjXAP94O7CxI3KZXYe0wRmcQrX2ozOSFJ6wYJ+ttmX7ge1c2tIK4C+Rg5
	in1SSl+j5UV9ksiwRcqEN/OB5+PJe4NNZow5x++lEdHOsvQ3ohUB4cefm9ObVlwocBKVkUxhE9QvJ
	0DH+bDaYIRxiDroTqkwRXa8r5WaP9MvbOhnY5yEbVa2OLNuStHBRuMQUv+7Q8nXv/nSQhPLJxzi8H
	VnaN3aXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKqv-00000004iZp-0DUP;
	Wed, 27 May 2026 20:27:45 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKqt-00000004iYs-1ZRf
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 20:27:44 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-516da301e64so85561281cf.1
        for <kexec@lists.infradead.org>; Wed, 27 May 2026 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779913662; x=1780518462; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZBWzBJ7tcP2BdZJjyaMfbgUmI299X9kvwn5AEgOwKY=;
        b=TF3bSgHNWB8GZXadKRSTWWI7cT1X6TKle5nbcDlVN3nE7cAw0AUT+dRJ1rMIcuDU13
         PsE2kmflGwFWR8HFmfIrY0WXQZY389hIJZqv4ylXi8PgAahDZissiIM3RlzTTQZT/Fa6
         HR04WM0YbzbrkQyRCBrv7X4+VZmozTKc0wqGnXe2HC/PyQEoRKA5P6YGexsQvnqrZw5i
         pN7Q2fXbRFuRKt5zGczh6bcdunfgn+X1XH+v3X6Q5xKOplkjdazy/790SW5d8AXl6eKX
         9uCuwD8PcjSYcTBZJqjRiUvknNvHbjd0Oen0WhfHaedfSCdx1NEswK9Cmu1YR39bkL3V
         hxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779913662; x=1780518462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HZBWzBJ7tcP2BdZJjyaMfbgUmI299X9kvwn5AEgOwKY=;
        b=GWR9PlABasXu3m8HSr2dxD90w/l3kVhRrjm68LbHYfKORczaBKi0x9ZKhHlW9wSpKQ
         tyzqWt9QSL08HOlOEhQiPQNFsoO+1lQBXGJTJVZlQyqNx0BAT2iPvmIwYRYqX37dEctW
         muuj3MHf9bK//eozkhxPyrZCK1LdGabwyPtkKi3Xhu1wJkZ4Xz/C8xSfDun1lnTLYMjL
         C+2ixsmixtFIa1mW/IrWvhenRx8uQ0OEuUR9ohA9iscGJdtCgttMUe+1XcN/fkiXoACk
         uejW9S8qxvi/ZKILLD/vwG3qldk8QPD3ZPKynWWxW3LZhDjTjxFyLu7utNN1g1FLGmJ9
         6XHw==
X-Forwarded-Encrypted: i=1; AFNElJ9KnxghDtc56C7TkAmt/csUvMy32UOLJA4R4bhYklPkLK9TSE1DFC5TElpVNF3ZCSrReI6MsQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxjmEIndhid/wdb3UTwPK+T7kGRNNVDz9k6fJ6MTq7p02JMA97o
	n9HfM7Aow66R5uYjF+jpsJa1shl9Dz+mFfcHDtNhK1OJVxaVUXyzRId+Jymv/ppZE8B/e2R4FWC
	QX7Yt
X-Gm-Gg: Acq92OFv98xFThRWCmO8y2Bg1bDFbfVzoiFdIQmK9QB04JWO5guk53w1LXEDI1mNvU9
	EF3HX1c7TlPXb+MG/JSAomchDXqs+QWJbxATLKfc/8Fy2GeiIDsZWwoaOgjzX8X69x4znIwCQK9
	k4suxE8SkSRRMMLEi3/eVj+22SodJnQo171rawRQbTFTEb8+x3gyi9OYvV4kLQdvYjNPkddDeOZ
	wI+5K0zmaWg3xeMBweLPwNStTiL4PQLZ4wzZ1E50MopKDeF0Ya+xkJrD9Wb4CWr+MWP+9a6yxKD
	fwH63pdISXa25kTqA+9d/BFuwq+C0I8lJlYS7xza33pHmrAVOrTdY/baYzXUjVz+bI+MX0Fldzs
	8M5LSevDqeVXF4ovIKYdM28iIfwAJmPF7/6JskDXNDRWgFdVN9mhf/VVRrXAFe3b7CnQPEnTdpX
	BCxRes2Gd7N1xPsVkSqdjRqkuGr81w/eiLGLz7PrEX1ifvIHB9rAgLdBXnOnmB8Q==
X-Received: by 2002:ac8:5ccc:0:b0:50e:a1ab:67ea with SMTP id d75a77b69052e-516d4603cb6mr334534721cf.40.1779913661780;
        Wed, 27 May 2026 13:27:41 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069ecb93sm58632971cf.4.2026.05.27.13.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:27:41 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	error27@gmail.com,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v6 1/5] liveupdate: skip serialization for context-preserving kexec
Date: Wed, 27 May 2026 20:27:33 +0000
Message-ID: <20260527202737.1345192-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
References: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_132743_414809_3F5D9C3E 
X-CRM114-Status: GOOD (  10.11  )
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

A preserve_context kexec returns to the current kernel, which is
unrelated to live update where the state is passed to the next kernel.
Skip liveupdate_reboot() in this case to avoid serialization and prevent
sessions from being left in a frozen state upon return.

Fixes: db8bed8082dc ("kexec: call liveupdate_reboot() before kexec")
Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a43d2da0fe3e..dc770b9a6d05 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1146,9 +1146,11 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
-	error = liveupdate_reboot();
-	if (error)
-		goto Unlock;
+	if (!kexec_image->preserve_context) {
+		error = liveupdate_reboot();
+		if (error)
+			goto Unlock;
+	}
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
-- 
2.53.0


