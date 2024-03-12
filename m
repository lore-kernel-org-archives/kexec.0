Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B38C54E5D
	for <kexec@archiver.kernel.org>; Tue, 12 Mar 2024 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8YSvpvuGS6crmLoPHUx34XAgbBor7qszUgDuaoza+lc=; b=wmma2hg9GvVV5G
	iNlmIpoZAlkxRtkgSqestb/LYbYGcIsBmTtBHrdoEzkaIX8c+Ey8oY9Hn+3zw2GxGcK8iyciwr9RK
	aA79L8tOHJIijA1nFTfSn8/2LAOrhI6jtE18AJE1Zj3QNk/0FEx6qTRFP3KIKKxCkURryz84nGq0r
	pjjabnFQ6A+J687U41fbyugMPa/45GcjgAgj4ig7GQKg/tG/ikiwFqjUDfAAf/W6cgKYGRRUM8ec2
	KEk44Z24Y/aC7TuOIu3va3UZhMAP5546NkcDc0Zh20NwyLZR/EPvqRWHn+p5PCxlu7vvJ/LYKJ9CC
	P5n10Rlo4oNxry8XLWcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3s7-00000006K7c-1aaH;
	Tue, 12 Mar 2024 15:16:55 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3s1-00000006K4N-3g2V
	for kexec@lists.infradead.org;
	Tue, 12 Mar 2024 15:16:53 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89A125D666;
	Tue, 12 Mar 2024 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710256602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQk1AYXpxqnAnevl0wbO8bx38n5uosNZevuvD043lpQ=;
	b=EcXKC1CL/YQKQnY0zdB6+U5X5kNJ5+cG0o+ZSEHD0RfKNPh9fP04c7xuDqn7uM7+ZfC7yZ
	+fCo9LP6p09xNxmys/iB1qOyAl/dc1xYCchvmTxV7p74UeLv6IKjxDgDaBzdy2g/q8RU4/
	HKUdNBtgUbM/U0x8wUwXKCFu5sCtSLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710256602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQk1AYXpxqnAnevl0wbO8bx38n5uosNZevuvD043lpQ=;
	b=JAe0qVzbWGU8kGVz+EtiebkYSvj4bn/eyZ692mQS7kkV5pbUpoz5ueDNmadp6tm6GM+d9B
	4r2UvKHFLMIpXAAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710256602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQk1AYXpxqnAnevl0wbO8bx38n5uosNZevuvD043lpQ=;
	b=EcXKC1CL/YQKQnY0zdB6+U5X5kNJ5+cG0o+ZSEHD0RfKNPh9fP04c7xuDqn7uM7+ZfC7yZ
	+fCo9LP6p09xNxmys/iB1qOyAl/dc1xYCchvmTxV7p74UeLv6IKjxDgDaBzdy2g/q8RU4/
	HKUdNBtgUbM/U0x8wUwXKCFu5sCtSLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710256602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQk1AYXpxqnAnevl0wbO8bx38n5uosNZevuvD043lpQ=;
	b=JAe0qVzbWGU8kGVz+EtiebkYSvj4bn/eyZ692mQS7kkV5pbUpoz5ueDNmadp6tm6GM+d9B
	4r2UvKHFLMIpXAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 393A91364F;
	Tue, 12 Mar 2024 15:16:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mbBuDdpx8GX6MwAAD6G6ig
	(envelope-from <vkarasulli@suse.de>); Tue, 12 Mar 2024 15:16:42 +0000
Date: Tue, 12 Mar 2024 16:16:41 +0100
From: Vasant Karasulli <vkarasulli@suse.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Vasant k <vsntk18@gmail.com>, x86@kernel.org, joro@8bytes.org,
	cfir@google.com, dan.j.williams@intel.com,
	dave.hansen@linux.intel.com, ebiederm@xmission.com,
	erdemaktas@google.com, hpa@zytor.com, jgross@suse.com,
	jslaby@suse.cz, keescook@chromium.org, kexec@lists.infradead.org,
	kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, luto@kernel.org,
	martin.b.radev@gmail.com, mhiramat@kernel.org, mstunes@vmware.com,
	nivedita@alum.mit.edu, peterz@infradead.org, rientjes@google.com,
	seanjc@google.com, stable@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 0/9] x86/sev: KEXEC/KDUMP support for SEV-ES guests
Message-ID: <ZfBx2ewmB06qQajs@vasant-suse>
References: <20240311161727.14916-1-vsntk18@gmail.com>
 <f1ff678d-88fd-4893-b01a-04e1a60670ce@amd.com>
 <CAF2zH5qZKEmECy=9vG4sLmdDt5k7nC=MwjKvJLyVfPyFzt+0hA@mail.gmail.com>
 <c8c88a28-30be-4034-9fe7-9c9de5247c53@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c8c88a28-30be-4034-9fe7-9c9de5247c53@amd.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[22.84%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLdz9bntmsbxsz5ozaiow1ygjn)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[27];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[gmail.com,kernel.org,8bytes.org,google.com,intel.com,linux.intel.com,xmission.com,zytor.com,suse.com,suse.cz,chromium.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,vmware.com,alum.mit.edu,infradead.org,lists.linux-foundation.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_081650_111048_9AC356C3 
X-CRM114-Status: GOOD (  11.18  )
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

On Di 12-03-24 09:04:13, Tom Lendacky wrote:
> On 3/11/24 15:32, Vasant k wrote:
> > Hi Tom,
> >
> >         Right,  it just escaped my mind that the SNP uses the secrets page
> > to hand over APs to the next stage.  I will correct that in the next
>
> Not quite... The MADT table lists the APs and the GHCB AP Create NAE event
> is used to start the APs.

Alright. So AP Jump Table is not used like in the case of SEV-ES. Thanks,
I will keep the changes in the patch set exclusively for SEV-ES then.

- Vasant

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
