Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B628C001DD
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 08:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FsHrSVvDi75hnlyR+/5kekVUrHT5hXaxNf/hfnJi4aU=; b=ZzhiZpM2T/49Dh
	u1XgQ7hnYv+/cRVh6AR/Bb7jj2dLRN0RXxCyF1caaqy4cXznBsQzlH5n0YdT+FlGhn/2G7dwHtroz
	x+ozOuzCAOBGO/t/ODs6bwXvHmZnQqdV6aZpaEf1KdrW+sgwUZoc6oP06o491x4fEM1LMTh0oMBbl
	9QsRWeuJPQtVytQXwn5nz4d8KyNmsCVuJezOnNxTC6zFDYRbJ+804QzbnTG+JGHNjn6uP+amJQwU4
	W8nJXQG1F0jZ7S6aSDNDrZF/41CuD9vS1H+QvtlgHNVy8LuIL6eqWs0Qe6mlcjVY8YUNkgDogjYUD
	jcNVI5XZ+6Eb9o1jLH6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHgk6-003z5O-2C;
	Fri, 07 Jul 2023 08:23:06 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHgk4-003z1p-13
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 08:23:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4702227B0;
	Fri,  7 Jul 2023 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688718178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTaTx/R0QAu6GJW6rE7C/1qQWY5Fc41FkF1jDqmTGVY=;
	b=aKFSdPYVU/8rW9N80UySni4O07Kx0AnMzhdVdu6NZat0CXnyicNGBh0pQ35tkiT+R3C/Gb
	GbKfjoEWjEfJAkHI/g1B/gl9Sz7Q2fbWtc2MK5JoHa4mBGzbIEw9cOtBUxmHDC3O+bFB50
	/SfLFPdBwGH/E4cuoBk9/yAih7SGX/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688718178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTaTx/R0QAu6GJW6rE7C/1qQWY5Fc41FkF1jDqmTGVY=;
	b=W3ApvboxU9JouxaEEKxMBuOkgOmRPL0CSDAdvIGYPnLG/UJpYFfjtQKjX2tQUrHrD9D4Ke
	d8zwq+IS+W5MfMDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FA23139E0;
	Fri,  7 Jul 2023 08:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id s/dbEmLLp2SiOgAAMHmgww
	(envelope-from <jroedel@suse.de>); Fri, 07 Jul 2023 08:22:58 +0000
Date: Fri, 7 Jul 2023 10:22:56 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Baoquan He <bhe@redhat.com>
Cc: Tao Liu <ltao@redhat.com>, thomas.lendacky@amd.com,
	Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, michael.roth@amd.com
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <ZKfLYG_4DANc_i5r@suse.de>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_012304_516702_F621C406 
X-CRM114-Status: UNSURE (   9.93  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Jul 07, 2023 at 12:23:59PM +0800, Baoquan He wrote:
> I am wondering why we don't detect the cpu type and return early inside
> sev_enable() if it's Intel cpu.
> =

> We can't rely on CONFIG_AMD_MEM_ENCRYPT to decide if the code need be
> executed or not because we usually enable them all in distros.

Looking at the code in head_64.S, by the time sev_enable() runs the SEV
bit should already be set in sev_status. Maybe use that to detect
whether SEV is enabled and bail out early?

Regards,

-- =

J=F6rg R=F6del
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstra=DFe 146
90461 N=FCrnberg
Germany

(HRB 36809, AG N=FCrnberg)
Gesch=E4ftsf=FChrer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moer=
man


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
