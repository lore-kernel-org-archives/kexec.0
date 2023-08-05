Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5749CEB64DD
	for <kexec@archiver.kernel.org>; Sat,  5 Aug 2023 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9F33MaxRRP/B//EI5ze5hBr87MR0KPCObxlOWff45cY=; b=uWPgs58VOkAdhI
	SQUnDOeeKibA1Kqa1wnoprR+KHKQtPUoQKlcmS01BAAioIaHRKQxZ0YirpRh1QIJBY/p3yVjA8QfG
	enGs98ZtmCbbEnJjTKJ+Hq77ttf7sWrEVgCCvnR0DgoFo4LN8q7Q1Oq6tU/C7RJ56oNl0dEeFsObb
	wJP9lSvY+O4wKcidZHN5uq6GfqFFJxF7bRJR0zncne2f56WQwK3JGLrO0HrXxY7ublmu4vg6WAR92
	NKbOvOvxYsaO0FRWJfnKTrmSvb9Eh+WnDDpabKNcs2usVUzcJzMFeehKDoZhWTwjEmdXocl9k8HMn
	T0RLkrPZ+xN3vhzuENvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSDRz-00Dsop-1G;
	Sat, 05 Aug 2023 09:19:55 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSDRx-00DsoV-08
	for kexec@lists.infradead.org;
	Sat, 05 Aug 2023 09:19:54 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7F3DC40E01E4;
	Sat,  5 Aug 2023 09:19:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FxuIhAfWEWJ5; Sat,  5 Aug 2023 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1691227188; bh=0KFUQzNILwHYJVuVO2OkbW+CwKxvhp7nvWv004pXK4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JkjdPqV8GhK/nNO5lGRvdoFb9dHjqLw7unrUCOtvRSsX/1XfZs/K1iEpVk94RKMbI
	 a21RQA0i/gKZpQH19Dpu/8GYKZ/uYh1tvTobYW4jdKMgDb6rNOKUP+fOnN313nx/g4
	 dsY8YKxheQzD6sfE0O3FVD98Y6ctikUywx2VmYcK/InStVUod5THtMbgdO20Re8B7W
	 eJjldXPCg0bWfNqY85galDd9ZhVJzGf5wPwmWM4NsWROagIjqeGwCpLjfqPnvbQXNb
	 z2cyZB3Sg6VmN5Fm4SHWih7+lhmtexJg1/r/rvEse9gUDqTkjP5mY76Os1bAPkP3GX
	 v2nXmpr4UGkYYlVFLyqdEIY1X3eHKGwL4jwlwyO7VYaLKXPaSDOEm1P6xwA5wexITl
	 jy/TscbELmGbX4/31fGYCKujKzqmnNheK3eR/y7H82gbvKUAc9u8Eu3E4HDo24m0Ho
	 qWSt0ctXqwXo6+Z+iaQ0bAMEubBkeoSM7qlfZG4z/pE3CVVH3Sdew5l2lEMIQIO7o0
	 b2gHvqCUyBOIH4yXq9EoymfgyQa7GYR1VEcdVjBuqX8tYfk4QfANTYVv6C2hk6GSMf
	 F/Q4R8pwbI9f5BQNgUdVDGO0BK8elxbTdMkGCD4DkqMRR33bj6+oSw/Y9eIurOQ38X
	 yVdTEzfXpoFRZOhqRsfXT284=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5048940E019D;
	Sat,  5 Aug 2023 09:19:33 +0000 (UTC)
Date: Sat, 5 Aug 2023 11:19:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, Tao Liu <ltao@redhat.com>,
	Michael Roth <michael.roth@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-kernel@vger.kernel.org, bhe@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230805091932.GBZM4UJC2wL4S2y2Jc@fat_crate.local>
References: <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
 <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local>
 <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
 <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local>
 <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
 <20230802155146.GCZMp7ksDdN2ETVzKV@fat_crate.local>
 <CAMj1kXHnSzdQw5CMAVXU7EzpnrdRvAqKZVgA+EV35kHmwVULgQ@mail.gmail.com>
 <CAMj1kXESuCScMLLAS4tSDcYxA3JTb24RuF7ipcKGd65tBvOBWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXESuCScMLLAS4tSDcYxA3JTb24RuF7ipcKGd65tBvOBWQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230805_021953_234721_8C0E1E6A 
X-CRM114-Status: UNSURE (   4.95  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Aug 03, 2023 at 04:27:41PM +0200, Ard Biesheuvel wrote:
> https://lists.gnu.org/archive/html/grub-devel/2023-08/msg00005.html
> 
> Coming to your distro any decade now!

Cool. The less 32-bit crap we have to deal with, the better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
