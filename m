Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A19C5CFC1
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 07:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EH4tDs/d5HwbhZaxavUhyBAHCbild7wYmuQeNMNmXvE=; b=qLz1ZsNf1FF8cqXZrkcopwSqwX
	gPEx6tlppxW2KETvYA+75BnG0YGInELmtYvFRRdVvtj0g7nrCwCp+xYTkwMfKf94WefmasAXbtS/J
	4Td1aNb2u8Ltpby8FbBprkG1oozvYosMX9wTWgQJ8zL9YLwZdXvRjeDAJiQ2ITDDlXDEs5F2R00tj
	22zLxja4Cw4VAe2TPwo32ES1CpWNDD0DWlI5X7Gm7r8lTmxvqBy+h+jQp3RE4bxMUVad/huvv23WA
	GNAAjEFBjUu8Q9sIsJR8f6+urtEhRTq/CfPVZtgvtwHBcasv1aJmOgVLLKA/SdANLSylUf5l5PVKJ
	Brj8V1LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvrw2-00000005Zng-1Az7;
	Mon, 17 Aug 2026 07:39:06 +0000
Received: from out-117.mta0.migadu.com ([2001:41d0:1004:224b::75] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvrvy-00000005Zl0-2kmV
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 07:39:04 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=4YGgPm1wRAd8vr5pINF7lmz4ylld4f9QdvgoaXgstqU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786952337; v=1; x=1787557137;
 b=fAvcBpgWs9Qhdx7zHtKnZUXvfc/e05DuB4q15Xv1X+jwe+C46Lm3EPm4tKh4HbiLhY0WPHZz
 fCRoZh0TZ8AIvHNOq9yFFoW01YnLM0RpKwrFqMBgf9Q4bAB8p76tY9E9jjwbc/H6patvuooZwSY
 X96L28T3cpxqUz2paePTR0c0=
X-Envelope-To: kexec@lists.infradead.org
Received: from localhost (3.112.29.171)
	by mta12.migadu.com with ESMTPS id 17e9312474d067d5;
	Mon, 17 Aug 2026 07:38:57 +0000
X-Migadu-Flow: FLOW_OUT
Date: Mon, 17 Aug 2026 15:38:53 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Lukas Wunner <lukas@wunner.de>,
	Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <contact@jaseg.de>
Cc: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, keyrings@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: Re: [PATCH v2 01/13] kexec: add CRASH_WIPE_SECRETS to wipe secrets
 before kdump
Message-ID: <aoK6jXA-tF9qfKOZ@MiWiFi-R3L-srv>
References: <20260811-crash-zeroize-rework-v2-0-9561d13c2340@jaseg.de>
 <20260811-crash-zeroize-rework-v2-1-9561d13c2340@jaseg.de>
 <anw9ILJiO5xIjP4f@MiWiFi-R3L-srv>
 <9765f7ea-36bb-4c7b-a19b-7facec97b762@jaseg.de>
 <aoGpcczo5GkBsPwt@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aoGpcczo5GkBsPwt@wunner.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_003902_833708_8F899D0F 
X-CRM114-Status: GOOD (  17.17  )
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

On 08/16/26 at 02:13pm, Lukas Wunner wrote:
> On Wed, Aug 12, 2026 at 12:08:39PM +0200, Jan Sebastian Götte wrote:
> > I can imagine one alternative way to approach this, tell me what you think:
> > Instead of registering wipe handlers that memzero places on panic, I could
> > put an optional registry of (addr, len) descriptors into crashkernel memory
> > that the original kernel populates with the PAs of buffers to clear ahead of
> > time. Then the kdump kernel could do the actual memzero. This would remove
> > all code from the actual kdump path here. The registry could be made
> > per-core to avoid locks.

Since there are a lot of security expert in CC, I am wondering what's
the risk if we wipe secrets during dumping. System is located in
user's place, and vmcore is dumped and collected in user's place. If we
filter out secrets memory when we dumping, what could be leaked out?

> 
> Or create a dedicated mempool from which all sensitive data is allocated,
> then call mempool_free_bulk() on kexec to poison everything in that pool?
> 
> Thanks,
> 
> Lukas

