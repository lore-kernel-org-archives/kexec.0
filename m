Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831E6C28B2F
	for <kexec@archiver.kernel.org>; Tue, 11 Mar 2025 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e17YIKewOJw7kg96MYs2+UoD1X4UIFS2MZO7LIlijb0=; b=am/oT+aZ0eWCKOdsoO/emrb+5y
	rkD2RYXRC4P08MyZ+jaurgpNyaVjuB/SGtNRJd3BzM61iS3SLfwqWLZszXvQHeUPwzYbAGbPXtO5H
	9Wve57pTVBwDf9GBYVSFtv+aT2nx2ZppsAT8Nz0vco2okqPuy4XYlvlfjtAPEpJr7gurX96NOHKHH
	CkAHBCrqXoijnaPdbv64jHfgxeXxgd9SNxp2g1g0YgTxQBZ8+jpsuKM4J+RBLUD5FiLTFOOOf+Nm7
	4OOaEhrsQ3Z0u1iv9HqsCelufDISKbRhnP9loIz0aqKItO3W6cTWOKKsrWXxLzBC9AlPii4JqWnDS
	KLL8PHDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ts0oT-000000061CO-1EjQ;
	Tue, 11 Mar 2025 14:42:33 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ts0nM-000000060uV-3yeL
	for kexec@lists.infradead.org;
	Tue, 11 Mar 2025 14:41:26 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-39143200ddaso1600005f8f.1
        for <kexec@lists.infradead.org>; Tue, 11 Mar 2025 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741704082; x=1742308882; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e17YIKewOJw7kg96MYs2+UoD1X4UIFS2MZO7LIlijb0=;
        b=A7zSE2qSGnRwM2ho4oeIv/bBJ3KyNxUBuBAwaCQY1w5TQWIfxNt9e6oNDjamAoyXGo
         SCTT1AU0+8GgeXn7jm2LHmv0Dgpkkuqmq8ljFb2v1rgsadlZI0DR16SNW3R91w6hFyUD
         mTMEKVRG2iJk3kI5FxAciED3DPcty7PKcxcH2nlV2p0G3sucWQ3Zefwnkfcqpg6k80O1
         DafiSruQsc4H95G2KeJC+WdrMot9emOoeoZwcfsSZMd+6nBcNgkWu0SOSyIcxR3lveIx
         rfsQjFfdFbAna7mzsM4BIqRAIeJYUA2YqUzTVNwWbvxXNQAKRiIZYpX7IxrCus+v18Hv
         qLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704082; x=1742308882;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e17YIKewOJw7kg96MYs2+UoD1X4UIFS2MZO7LIlijb0=;
        b=hAB5t34wVG7/lKTjHthHaI80vdhCweSAT0CO8uWdxhQDmxUted042uaG20xEyzLMB9
         YIGuWR8xR/B2HTWz7B2rFkpMfEBHT/3oKj4h7x7aMsusYhJFVv0YT+QLefU3lTjq5Gm+
         iSqT2AspLTSjYVl9bIoljU6GIyVZ7s+J/1RBBJO7m/uguBXhDlVMN3wOivZl5Zsg9Hu8
         CBbvXDYLClcJuePYgH+p9+bXBe9YRgsCd7n0hZfhJ45J88fhQ9bj4tl7U5N0Dr4RLpqW
         Fds6YuozVRypFtMZ+R1cJaSeMIO7sO77TKhO8MlP/kfajKrvAFCkMmXeLTBrZFh4atmR
         re1w==
X-Forwarded-Encrypted: i=1; AJvYcCWRUNCpjl9fTXs+YZKwWRWLz8iT/S85kDKOvoYCuYuo8sl1Tezek2ZzcpdNhybY4RTXp26r0A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzykZalVrSi+ogwzL5Cm97ks5gPVEA2cKukNr82YJm1CaVRFVWo
	0KmuPFz04o5cbU5/mFrGODB+Dqy8t5yj7/oNnwFvMT7yc+5tatzmj0ae1OzhIYM=
X-Gm-Gg: ASbGnct4p9E3jFu21L5djYPtUkxvTO2LPJD+BymXpMjYlT1fkl3JYGDXr/kIqGsWZez
	u4gGrn5lsmQYkXDe+/Kgr9F7zfEWX7FPZc4ntZ1CrPaTDmfZlebn0JnUVLZTA3H+BGAVn6HqoEn
	qa9iHnMKjtRTF3i9JwUXlhySz1OXj1BKSYQSTdOIyza0gxsKpzwcW6IaONFMulbueHJgmQD5Wf9
	QdnbnfQzo2FuWINvPlPEGzb0S3u7m1CfddSuXZJ3zL8JTWoKFjWlcosCZ3MvfjmP1WU1VXGiW34
	iJFyMd7T29j3Nh8XBbBkIyl7zcN5/F6+awnrZon9+EaGjdGAdog8+m8Fj74e8DCQgjG5G7bQz9s
	=
X-Google-Smtp-Source: AGHT+IHedVj4RUj6sW41ewt21ZWFTQVrQn0/iCeA7D/35qQUSXCzs/EtRBqy+mOCc1u29u+Bx4/luQ==
X-Received: by 2002:a5d:584b:0:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3926c78f6b5mr4736641f8f.54.1741704082203;
        Tue, 11 Mar 2025 07:41:22 -0700 (PDT)
Received: from [192.168.3.33] (110.39.160.45.gramnet.com.br. [45.160.39.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195casm18675615f8f.53.2025.03.11.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:41:21 -0700 (PDT)
Message-ID: <9a8b7634b123e82c3eaf278a5944feafd91279cc.camel@suse.com>
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Biederman	
 <ebiederm@xmission.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	 <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt	
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Todd E Brandt
 <todd.e.brandt@linux.intel.com>, Jiri Slaby	 <jirislaby@kernel.org>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org
Date: Tue, 11 Mar 2025 11:41:14 -0300
In-Reply-To: <Z9AvKmM4Li57-E2E@pathway.suse.cz>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
	 <Z9AShs1dEO0jrgjL@pathway.suse.cz> <Z9AvKmM4Li57-E2E@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (by Flathub.org) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_074124_984986_CA31A277 
X-CRM114-Status: GOOD (  25.47  )
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

On Tue, 2025-03-11 at 13:40 +0100, Petr Mladek wrote:
> On Tue 2025-03-11 11:38:00, Petr Mladek wrote:
> > On Wed 2025-02-26 16:59:00, Marcos Paulo de Souza wrote:
> > > Hello, I've being working on some patches that help to clarify
> > > the suspend/resume
> > > of printk machinery. The last patch on this patchset address one
> > > issue regarding
> > > suspended consoles and blanking.
> > >=20
> > > This is a part one patchset that I would like to see merged
> > > before I send more patches
> > > that will rework the suspend flag (a global suspend flag istead
> > > of per console) and
> > > the removal of CON_ENABLED flag later on (I've created a function
> > > that will forcibly)
> > > register the console instead of using this flag.
> > >=20
> > > Please review!
> > >=20
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> >=20
> > Looks good to me. I could fix the typos when pushing.
> >=20
> > Well, there is one more thing. It seems that the simple graphic
> > logger
> > was merged for 6.14-rc1. And the console_stop()/console_start() API
> > is used also in drivers/gpu/drm/clients/drm_log.c.
> >=20
> > It is actually the code which motivated this rename, as already
> > pointed out by John, see
> > https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/
> >=20
> > Well, I am going to update these two locations when pushing this
> > as well. Let's just get this change done.
>=20
> And I did as mentioned above.
>=20
> JFYI, the patcheset has been committed into printk/linux.git,
> branch for-6.15-console-suspend-api-cleanup.

Thanks to all reviewers and to you Petr for taking the patches and
adjusting the typos!

>=20
> Best Regards,
> Petr


