Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE370C4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9aBsMhFc0BZnvKmTFPZ//XletPNZzMj/y0U4wuQ3Kak=; b=mLeIa6mgD/APhl
	LAbhgl0lByUFB8FplHYd8BY5T044JLJwL99lxxCOyaKL9oRDPzfO9wr9GhMGRLWii2POkJg0205ZT
	ucGqCJOp1KUkIYydlfgA75A/q38EGjcGT7pF2dyS9xv2TTDZWS/r2XhCs+k1sG8SGJX5fml6YSR/h
	BYK83kqzVHgmmsJNSrBeHtzeFmSuLug8nE+ZFOH1RkeWV2Xi/2AeSxOxWlhnZoZbD0+e6J7OmqEdl
	tq5kGqcn+rGoRnWcP43vrnSXv3PbhMAArPO5sQObzzYhNn9GFoXJjYFu8gU8k3pdOYh79ck2Gmm5U
	f4bT4srT+X2TVB74gcxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzdyU-00000004ZWK-3TEI;
	Wed, 24 Apr 2024 14:51:54 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzdyS-00000004ZUu-0EE2
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 14:51:53 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1EA2E40E0177;
	Wed, 24 Apr 2024 14:51:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FLV5n242awhg; Wed, 24 Apr 2024 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713970305; bh=hAzgTdW20PH8p2TSvQDh/sf526Oq7pqMUYP84FyR6+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsLWA4oeHhE1aKts/WuRjHM5YGSItzza5+A7EtRPfUalEAza7A4eT/wCqKrkjtVAJ
	 Bu+paApzhfU8mIQx+T15513wLpMsBfcVD+xGPv3HCtrVVEaASwj7ujZtjLKjatglhF
	 TYtEo76RZCbRHZHlpaTacn/gbT/CzLrzimhUpRZ91nYkXIiCdJ1zKvbec3b8cYUVwu
	 uAkXyQO6JI3LpCIn831pSy8UZocD4hLsM9zBASEoh5cHPPzjbHmJcdYFsKo8FYwL+b
	 IpLLslb9O/yhwD+HOPEdOvrzPykVBVbMV3Anb3vKoa8nam13um74MPbOdJgYAmFlbH
	 mgI+MMopUxh1af0NFhU7FkKIeZDHDVCZnDwtq48QwD06iYxVb0Ndfh+PvH4j4D3t06
	 93+vso7mtQ27ZjEO9FZ246qrt/YdLRhkqGz8lrMUT28Sb/TG5WpvCLYJ5LxxgQA45D
	 7o8W1mDGYtfg6pqRaFokPSNMJrkVg6BmbcT78sL0U6O8n04wAuodP8gmaPg0izFtGE
	 mscySG9g3QOxGHk+c+0Kr8QiiHFCk2jiNxuAV0vCtPFNe+JUnLQ/KJ/O87zsxrRfJh
	 TfylnRkDMqu/zghw53T1O3Piq07mo6c3qKwDpidI1yfdyiS7+1nhR5czcTu1mnGwyQ
	 ahGVBjRQJnbFzikoFk0c4eJI=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4031C40E00C7;
	Wed, 24 Apr 2024 14:51:23 +0000 (UTC)
Date: Wed, 24 Apr 2024 16:51:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20240424145122.GEZikcaiqFT_eG1KDo@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-5-kirill.shutemov@linux.intel.com>
 <20240423160258.GBZifbsuoTIbWDapej@fat_crate.local>
 <k4t62qfiyapfh2hjp4bpnaa4bmtlajpm5q4an3qs4jimhldcwv@wtrp63ofrfk6>
 <20240424135052.GDZikOPIOeGxtQRBBc@fat_crate.local>
 <svpuqhoglv7s2wtu754i4oicowueen47vq6eobjbznsromb4m3@4h7vy346n4ak>
 <e1a71955-5228-47fe-9241-dd0197d4a552@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1a71955-5228-47fe-9241-dd0197d4a552@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_075152_256062_1AD4D5B8 
X-CRM114-Status: GOOD (  15.44  )
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

On Wed, Apr 24, 2024 at 07:40:26AM -0700, Dave Hansen wrote:
> On 4/24/24 07:35, Kirill A. Shutemov wrote:
> >> Also, does this need to go to stable although it is kinda big for
> >> stable. If stable, do we need a smaller fix first which is backportable?
> > Correct me, if I am wrong, but I believe TDX guest is the only user of
> > ACPI MADT wake up method. At least it was added into kernel for TDX guest.
> > So it wouldn't fix anything user-visible. It might affect a future
> > platform that uses this wake up method, but it is a guessing game.
> 
> Yeah, the MADT wakeup is pretty funky, highly TDX specific, and not in
> use or planned to be _put_ into use anywhere else.

Then please make sure all that info is in the commit messages in the
next revision. Because as they are now, they're not even beginning to
explain what exactly is this fixing. /me thinking that this is some
generic fix needed in stable is case-in-point.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
