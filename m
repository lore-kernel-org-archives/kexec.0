Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4BDCA5FA2
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 02:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FJ1G7XRTXKhL/y14SSAQr5z2lhftlnrM/l7NA1vY8wc=; b=DFLfKfcUPL4zyOrWJZW1z6F8bm
	aTwJ6NzDWvnojozPGTgk9syLToBvDqPNMGUali6IwDQdMLucMyVne4Dq7YsKZqoB6KPvYp8iekGwp
	HLzkeayepjIfmNMZhX+NBtGnVQUJ+mHRpqlO0nMIG/nApdC4X7WvHPGMkcCC9qZAGWebNgbeFCM7r
	MB9pH4/xmRIZYGT8Nazif/I8dOgjMw7Kuf/XOhS2fvFdz71fD2LNouN0y+ndaApf5dcEUebTJxanH
	FIgNO0lsbRlx7DKKx3z23xesBQHqWYrrBbM2PTjw3DG7sha7I7rLAse1HlhWJEYopSiqG7OoJhX0t
	uci/fJUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB18m-0000000HBDk-1PzD;
	Mon, 28 Sep 2026 02:30:52 +0000
Received: from out-133.mta0.migadu.com ([2001:41d0:1004:224b::85] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB18i-0000000HB9o-3qmZ
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 02:30:50 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=4+s99KWizSzbFmjJiglWm5XJ4fIhkEZlwghACv5Q8bE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790562642; v=1; x=1791167442;
 b=Rj94uIUP3AEcFLC/QVR69BsOqgxVWbnnMzQ29M4+qXoZy/NgGYgEvTbl1fM4l+RFXjf0v3iR
 8FyluHgllvHCR1TeDiSTHwKsRyZii3ZOK+IwN+r7+1Gn5jjsNhR9zyTDGwsBV/dKk7aKLWRmRw/
 WyBDVoAsu6O+NZiots7qw0WY=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 4c0fd7c181865d0e;
	Mon, 28 Sep 2026 02:30:29 +0000
X-Mizu-Trace-ID: 4c0fd7c181865d0e
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: rppt@kernel.org
Cc: chenhuacai@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ardb@kernel.org,
	shuah@kernel.org,
	ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	liukexin@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v5 0/5] LoongArch: add KHO support and selftests
Date: Mon, 28 Sep 2026 10:30:10 +0800
Message-ID: <20260928023010.3018-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ap3KYSXQJfC0iysw@kernel.org>
References: <ap3KYSXQJfC0iysw@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_193049_430624_64EBA794 
X-CRM114-Status: GOOD (  11.10  )
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

Hi Mike,

On Sun, Sep 06, 2026 at 11:17:37PM +0300, Mike Rapoport wrote:
> > EFI KHO channel:
>
> I can't say I like "transport" and "channel" terminology. We don't send
> anything anywhere.

Agreed. It is just a table that the next kernel reads. v6 calls it the
KHO EFI configuration table everywhere, and "transport" and "channel"
are gone from the code, the commit messages and the cover letter.

[...]

> The text here and in the patches changelog reads reads as LLM-generated
> text. First, it's quite blind and unreadable with wall-to-wall text.
> Second, LLMs tend to describe what they did in the context of a session,
> but since we apply the cover letter to the liveupdate tree, the description
> here should *only* describe why the changes are required and how they are
> implemented. The history belongs to changes since vN-1 section.
>
> And last, but not least, please add LLM attribution as per
>
> https://docs.kernel.org/process/coding-assistants.html#attribution

You are right, and I am sorry. I used an LLM to help write this series.
I meant to check every line word by word myself before sending, but I
made a mistake and sent v5 to the list before doing that check.

For v6:

  - The cover letter only explains why LoongArch needs this and how it
    works. Everything about earlier versions moves to "Changes since v5".
  - I am rewriting the cover letter and commit messages by hand, in
    short paragraphs, and checking every line myself before sending.
  - Every patch carries the Assisted-by tag if we used LLM.

Thanks,
George

