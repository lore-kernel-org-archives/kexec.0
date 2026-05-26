Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98956CD5BB4
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7lLqjxWsNK3wG5hsFQx4HuXM9R/Kp26iiy3YmlseoLI=; b=WKHU9+ITYgXPh1a4Si0tRLzJGG
	0tB49fLO93djyxVMsPrHhcl2g8EBfTL2yl4yKmoClCjYmOYgDNhImVljHKkksIfD3vUiLu0NKbdnP
	wn0g2dzWBH2nQy1N4rEShanXCskAfT/mO7AttjEUqhoEP9yuMBraiE420Wc/xk10KEL2RufekJ31G
	bJIG0XKs6lkyRlalxbksoQGksbR+DjelU4yXtWqW6sd5eXMDcceV/M5G5qQbWRVG+idgbWqTeY9Ty
	Jlt2pyxVtBZJeWwpge3NBX89fv6BGdwUUvJAQvOUMAF8SyflC8RN+sMxcuTa2ZPta7tLmLAcuxZGH
	CnAGKuQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRmr4-00000001LP1-2CkI;
	Tue, 26 May 2026 08:09:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRmqz-00000001LOO-1hGn
	for kexec@lists.infradead.org;
	Tue, 26 May 2026 08:09:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B7F240983;
	Tue, 26 May 2026 08:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7BF1F000E9;
	Tue, 26 May 2026 08:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779782971;
	bh=7lLqjxWsNK3wG5hsFQx4HuXM9R/Kp26iiy3YmlseoLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V/6YcQ6XnmblmspJprDGRngxPal5gJoClYl7PDFFq5a2oMRNWKEIOtskete9OwCY5
	 CPLKv5J0hMV5FVxgczIomlhiys609xrC+a5AoXQOsMUv8exdeSoglz3MUrHXHo5dQD
	 cUJUSIGKKlVL2Kl+RAYVm01RYAll2jlK+xZdqNlPXEtGpsUBwmw49gkRPQyG7B9+wk
	 tyo02RQM2N4ZPvl6RKCLCc1dUfne7SJzi3FZMI0eCNYZXu88nGQay4UmvstHipDoXT
	 CePL9iyiIlYRePZz3IVPpZxTXWNClOFQPA7i+QGjB/NVHT4wVZKMorgp6S/ZLdL/CH
	 qlwDrdvlFuNLA==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: validate session type before performing operation
Date: Tue, 26 May 2026 11:09:24 +0300
Message-ID: <177978294141.4088010.16047486364171482805.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519122428.2378446-1-pratyush@kernel.org>
References: <20260519122428.2378446-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_010933_495256_30C28807 
X-CRM114-Status: GOOD (  11.82  )
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

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Tue, 19 May 2026 14:24:26 +0200, Pratyush Yadav wrote:
> The sessions ioctls are not applicable to all session types. PRESERVE_FD
> is only applicable to outgoing sessions. RETRIEVE_FD and FINISH are only
> valid for incoming session. Calling a incoming ioctl on an outgoing
> session is invalid and can cause file handlers to run into unexpected
> errors.
> 
> For example, a user can create a (outgoing) session, preserve a memfd,
> and then immediately do a retrieve without doing a kexec in between.
> This would result in memfd's retrieve handler to run. The handlers
> expects to be called from a post-kexec context, and will try to do a
> kho_restore_vmalloc() or kho_restore_folio() to try and restore memory.
> 
> [...]

Applied to fixes branch of liveupdate/linux.git tree, thanks!

[1/1] liveupdate: validate session type before performing operation
      commit: da7f658ccc8da60d836051a7af1c53e643f4bd11

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: fixes

--
Sincerely yours,
Mike.


