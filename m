Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED935C4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c/TzpN74b4dlMTcxz4MKwRClOvmqnqRn3Omwfb7NLpg=; b=hSudKjuvuR+V8P
	/IMQ4u0yHfqslc0MCRmBfeYusrNji+XVglvORb8KFXLcyocjEeV3y/iLlpu5xZWsA1HcYJUPG+w1l
	CU0Y46GsV11Xpe5HHXegOwMmLZNaxU6fa6vLppund5fWjRWiTsFUOhHAvAB9S2qQnPk4TvUkS/FHd
	ZqFzp8+tdaIT/LQLCnqTBmOM8uSEp2xbJXp3fdiW8DJQ6NQ+4LVu+Xm/+VkWWxgmyU221XtBLZeMV
	tcm5PrUv88X5QSXFISnmyxHXiKdWOPAU2ns3qKk9+6nkboTJeAJ/Fx1qCH0HrUgtU5Mbt484Jmrt6
	YeiqubIzGWB4cuB/W2Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzd1w-00000004LgC-0cK6;
	Wed, 24 Apr 2024 13:51:24 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzd1s-00000004Lf9-2m84
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 13:51:22 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9EE2240E01C5;
	Wed, 24 Apr 2024 13:51:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JVrBxhuy33_y; Wed, 24 Apr 2024 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713966674; bh=EBY9JeX28ZOF1EBVDHZpilQ+UJ4BEt8eGoNz2J+9fsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFuMhfONd+yCpmn5H3a445TD59aoAoX05f1TAeGQIrB4wGQTfECpx/JK1k7YIkbRK
	 qy63iG7uHaFJumJCDLSbblC9RDeQBYmjg/uLL4CDGieFTYubdn1WmCtx0sZ0Gy0juZ
	 i31C/8Bt7oxGVPOf7uUng1GtjGbVJQTjrapfNosI8FsSwpdlRz73R3d/f5rjkffx9z
	 o5atlg87BSuqS4mvHRS21tEx8RRLFvk8COOVs5dhmmFa+4QGJtT2AerlH9G80DypJE
	 vFOZMJsijUu9ck0Rb5ZipCLmh8jxVDOZwoihsDoenjqmgYViideoERJh/Zq/nyHO1b
	 QPiarPweMFwrKIbo4qH+LXVodOS05jLZDYk0ZeKmONTze40fV3qo9U/KXBfY3tfc+z
	 4K0wc2hDSL2aTa7SvA3VjOQ0FEK70wgcsJB/S/g8Agt5l99B6SNUW3flSKIpEIGIPl
	 F3OfGv8pjypcu2gtuQJPJvTJtbkxneTGdqHFUKYvICFmegFcLdzbMn3jaANyKkTJEj
	 fKGiRW1yd8NM1I2rlaZUy7fSFZtwqffI5aiIguzJCdT/vmV7MA5aK/IL1maDGeq4cO
	 uCD2ncaKutVGK87r8E3J9d0fnfm9DrqqZJ7mlKr0MhRaA+h9Zd5L7ilqhrIraeqWMW
	 8J1zOivBIOjWzmyABaT+4+rM=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 841CE40E0177;
	Wed, 24 Apr 2024 13:50:53 +0000 (UTC)
Date: Wed, 24 Apr 2024 15:50:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 04/18] cpu/hotplug, x86/acpi: Disable CPU offlining
 for ACPI MADT wakeup
Message-ID: <20240424135052.GDZikOPIOeGxtQRBBc@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-5-kirill.shutemov@linux.intel.com>
 <20240423160258.GBZifbsuoTIbWDapej@fat_crate.local>
 <k4t62qfiyapfh2hjp4bpnaa4bmtlajpm5q4an3qs4jimhldcwv@wtrp63ofrfk6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <k4t62qfiyapfh2hjp4bpnaa4bmtlajpm5q4an3qs4jimhldcwv@wtrp63ofrfk6>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_065120_881408_D29829F8 
X-CRM114-Status: UNSURE (   9.81  )
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

On Wed, Apr 24, 2024 at 11:38:42AM +0300, Kirill A. Shutemov wrote:
> It was wrong from beginning. If ACPI MADT wake up method is used on the
> platform, we cannot handle offline, regardless if it is TDX or not.

Sounds to me like this fact should be a prominent part of the commit
message and these 1-4 patches should be carved out as a separate set
fixing that ACPI MADT thing and I should take them separately now...?

Also, does this need to go to stable although it is kinda big for
stable. If stable, do we need a smaller fix first which is backportable?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
