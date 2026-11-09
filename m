Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF041606A334
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=E2tePbKg;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o07L0xCJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=; b=E2tePbKgUHAeru
	xj7PVG3N7Y1crKvPo/JmeXY+CPimL4rguCBMV61W9BaTDFkPMZBsM4Sw6pIBUWzAhGePHsjduHLCx
	MvowQIip6x0YoGEzwlLhhcGMkV86c+klSYtFxhjWSswRxI0jVZTCrVU44mW3u325f2mICTRVyx8ny
	KasLgd5OOhVGTjmK67zDbug1Cgjmg/kizvpdXwcsA8QeUr1gj2cjnBDXnOdujeV27ac0oImxiGCdE
	otO15jjjp8E+N31Nd54qJPFbR4rr2Zl0eaNZXntxo+kkMq1vShNAflqTYIGgo7zUEE1CvGoBoj3gj
	vo/ff2bv7ZAInPT6bDhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXBr-00000001oAi-3Ojm;
	Mon, 09 Nov 2026 21:46:11 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXBk-00000001o8x-24UL
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 21:46:06 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-492f6b7f70dso881092f8f.0
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794260761; x=1794865561; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=o07L0xCJXTJS6Bd5vOuuGkxzEl0qWE+4Nio/j68J63Gi9fJrnyaEVtr1mcqrAnXslG
         PFjfBaSlKZUyetHJ5AH70UFjlD4445+ZtJnxH8JRfspj0Bi1CGR0AcG1t7ADq5NShvXt
         96GVua+kRzYWkz+duTF53/o1nQKxgO+q10BEXy9f8i7NEclk4cUSW4IDGCndCdQIZAaS
         FlPVbPuGp5AMnCDehFdbRBjR5OJVkM/nBpB5MfYHNcHSp7FdHFYCaVKyX/zDHUJ0jfj+
         JY/WkWLli554o4uODYR3Oxh+fRRJYDOfBJarmoeTg2h2BjQuD49XzzMLmHc4Uac0LHz5
         E5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260761; x=1794865561;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=2B010SIRHSe7BA+XZP+JcFZEeJhCNpCsVEfOWlrnwZkE5/azHTQiRmlKTT33J1Z5bR
         LgopM293hYulAMDxHbT3QputbtmpkFcCmze3CuwYSJobAWrjJuAlA/iaEQZ7zdkOpwlm
         U6lyWoqVE/Wo/qb/uQ86RkDZE9fl17q9fl2jkknirtj84fnm4NsxXXdGBin37FaQNcvi
         PZOQpLgK2XiwgY5+g8WnTXat6DYNkfjMdCQT/xtBs5Nnrp7SQGe1KAnuOW6nYEp5woLW
         7yMR5o+eM1FaryycLRzWWk70JfCxc222STXlXPTQ2TPXF9/3jyKvlRX9bYQSoHK/U5Z7
         8LBw==
X-Forwarded-Encrypted: i=1; AL+hErE6wnCHT489bygVx8nf2pEcJGYH00kAZMop0heHH6phdZteaYwq5iEA4RhRpC0ZtIM2ADvofw==@lists.infradead.org
X-Gm-Message-State: APuU4Z9VHPRNvefUT541eMVVuAvI6jS44boZ7V8NA2ejHhPna1t59JnV
	4GaNLbO0w88CWklcQzR4KzHwFtr0iRMSMdxMBqUGBPMZXA/i4ZZUT49H
X-Gm-Gg: AYBFou20dlOMMjnBhUjpzeR3tjNFchx72C/kLmh2j74kRhArz4Km4YDUR576vIFGvMt
	UKoHs4cL4am8/oaGQ8UebUKUHX7rSYiHv4cjJ8c/W3O0soEjxpwDtcqT/Eo6bh+mK3r4icnS6DE
	1YQOJR7jO6JItD2cTi8/3EwX21iykBhVzebHkbkZj5tGQq1z9i11uulE/3HIG2Qo6UjQ4I8H1wH
	klpL6GXk4qNADwuAR1O+ZCuwXyfSuJLVOeps5/WJcBCp18r55VJC1VRJORboNXv2rh9S2rNy5hS
	T+NDmFach0x+fJBoJ9VOe3ck2wR/p187u2wxiP0WC3OEtwFb/W6oZZyQ5w5HXlK4ACFAoW7zXYa
	6ZAjdvYWyfr571teGRdyYeSc6Mvpp9gMuro0pBhSkisMJDp4Ree+EUB0kc7cboVuOnxtbdNcFmY
	5DmMzxENz/NBpLVKvt6y9JZus+x7UsAhup3LpUCzfhd4Hb35zgnaIqMCplJF6hOcv45YoIO2V25
	/1OegUO2zMjEMPF0d2w0JPSGTEl6IsTwkmnDlyX7SfeS7r0gy1Zk+5MBFVLYRjU67ZTImjRcdhP
	hYNp6MRsMbuZ1jAla8XiLMA6eEhZLCQzedwwKmHp4W7r/rAnFbs6E/qM/AlQRduw4w==
X-Received: by 2002:a05:6000:288d:b0:48e:25e1:5eb8 with SMTP id ffacd0b85a97d-4982b28aa42mr1487213f8f.3.1794260760763;
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm1213644f8f.10.2026.11.09.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Date: Mon, 9 Nov 2026 21:45:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Christian Brauner <brauner@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
	<20261108185953.28054fb3@pumpkin>
	<alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_134604_547055_D0961845 
X-CRM114-Status: GOOD (  18.04  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 05:05:57 +0000 (GMT)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> On Sun, 8 Nov 2026, David Laight wrote:
> 
> > > > While at it, I think it would be good to use this conversion as an
> > > > opportunity to replace "char *" by "void *", which will probably let
> > > > you drop several casts from users.    
> > > 
> > > So I tried that too. The thing is it drops exactly one u8 * cast in
> > > ntfs3's label write.   
> > 
> > Since char is now unsigned that one isn't even needed...  
> 
>  Please excuse me missing the context, but what circumstances does your 
> claim refer to?

Just that the cast would have to be:
	u8 *foo = (u8 *)bar;
where 'bar' is 'char *', and I don't think you need a cast there when
char is unsigned.

David
 
> 
>   Maciej
> 


