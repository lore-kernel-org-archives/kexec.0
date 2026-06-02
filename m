Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEF5CD6E61
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 08:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dBkjXMTmjLYTnOUwfnks3EFmZB9pPlPFfyMtmk7cI3U=; b=eVlpO4DnvUhiSlNdU29Kt5ZjrQ
	S1jPYv5Y9BQ+veeowR3K8J0JYFR78tE1aH3bi7vIKBJsrw0eMKC8/DNE1tnlAHpRoRmIYB1BZYgOv
	0EYpOohZKsXqzSaURL8xfb6ifrA7FbVZa6+4VgeX/24BygbSmiwiwPukzTnKBGUHt11ex3HQ6OPQD
	yIRes0rAln/vHV/hnxxB9SmmF9TYTROnprlgqRw6hcPQJjGQnWixD1q6OjepVnh7YVoIM8LtnbEyM
	zn9qLwh7+4djl6IrZk/10rlU9kelOWbwQrJ73/ddAcrvm4VGl7cC67WnX4s1Elk++wWL/OVcJxGBH
	p0hYyppA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKFt-0000000CXrr-2IIU;
	Tue, 02 Jun 2026 08:13:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKFr-0000000CXrl-1kE3
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 08:13:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A21016008A;
	Tue,  2 Jun 2026 08:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3AD1F00893;
	Tue,  2 Jun 2026 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780388022;
	bh=dBkjXMTmjLYTnOUwfnks3EFmZB9pPlPFfyMtmk7cI3U=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Bpa1KuA5WsCD66AasZ0sl3TPcc1/4v3KFLp4MBWQ3V/DKp9IxKexcZETomuPehqTH
	 oW7AjhG5pIG0+1zPLNhQr1BDSRpxy0OXJLhEu054Dk67FXWjHvCzfw+yOu7ZSXp9WJ
	 TTMEJZlPB80bvMNID92SiC2lb+b5+MbERApA9AM+sYZsv/xvWNdPNt0RFDlZv4BH8G
	 0lubNHY31s9XSrUDOq0nXy9XEegapfFje+0pK4oRel7PqRqFxQ640yWxWQRe5qEHCX
	 dElzNPk+Fbugx4/pfXDfPeoWC4gg0nTxxb7+/9VvEPJNz0qQnr4IzF0xJ68T7cSaa0
	 DoWuzoVX7NVSw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 01/13] liveupdate: change file_set->count type to
 u64 for type safety
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 skhawaja@google.com, graf@amazon.com
In-Reply-To: <20260530221938.115978-2-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-2-pasha.tatashin@soleen.com>
Date: Tue, 02 Jun 2026 11:13:34 +0300
Message-Id: <178038801483.119771.5551368813719436713.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Sat, 30 May 2026 22:19:26 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> This improves type safety and aligns the in-memory file_set->count with
> the serialized count type. It avoids potential truncation or sign
> conversion mismatch issues.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


