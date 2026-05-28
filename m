Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2D3CD4F54
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UGM5KvKWLvExd3E+G1wrD71i5d76a1GTqdZ3/HSVK7M=; b=CptqECLJajwoDGm7NgrH+36EI1
	I3v7c/mHr1A/OgOxOrIlpEY1ZxOyZkWk6Y6reN8fahlMWylaDHOhhwveY+xFsOO7Sy1LQUGiorpfn
	u6TIZFcgAUhj/9Dkz90LYh+t5+VuPQEPbXblE290kv/JElN0oKUXdAWijp51QLqyRdO9OOxJLdK4q
	dsP6gz0oCz8fDDDWbboKsGCzZTCkpF1NUy0AKlo7XrpMEk2eypKEDchw5oU/q42WshzJrnA8gbDCg
	r/uoKB+xI+O40tDuKzn6hxYhnqjhSebeGRUpCsbKxR1ktP/ifKFNYryQ+FXlYuVgu0VPhU4/Wiedo
	bmAV+/8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wScLH-00000005txL-3WVG;
	Thu, 28 May 2026 15:08:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wScLG-00000005tx1-3O9h
	for kexec@lists.infradead.org;
	Thu, 28 May 2026 15:08:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4651D6020A;
	Thu, 28 May 2026 15:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770651F00A3A;
	Thu, 28 May 2026 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779980894;
	bh=UGM5KvKWLvExd3E+G1wrD71i5d76a1GTqdZ3/HSVK7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nHZkqjwfdaygQVKG7bpOtkEdHsBJ2MKkZH3mUIhVAZUjNPmg02/IZvIXbwqY3lJ1q
	 rhgtoha2IfP59eZoEp2TkwRYYcLHPvXkyj0Q14O7P+oFh5+XVmzK6R5JwQiXJFk0Mz
	 kmjGLdLpGFwUHCfuVN8FoVAg46/VYZR5uNzXEUiIjPliQbH2eRZsDAMm7siaQAqjzK
	 uJbqzUGBVAoac18pjOXIuj0MyFy56ykcT3N4cqhB/Osc5Vjxbn4tL5sCXZW+EKxqzN
	 oYnlbA6cFPKzXSEVAw2KYrbEPE9fL/3HOJ8pO7VvSgsUESpETDWH9hdO3VET2g4fXe
	 NDVhH/KuO72zQ==
From: Mike Rapoport <rppt@kernel.org>
To: sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	error27@gmail.com,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 0/5] liveupdate: serialization safety and race fixes
Date: Thu, 28 May 2026 18:08:03 +0300
Message-ID: <177998087859.707577.17373849853815129202.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
References: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Wed, 27 May 2026 20:27:32 +0000, Pasha Tatashin wrote:
> This series addresses several issues related to the synchronization
> between the reboot process and LUO session management.
> 
> 1. Skip LUO serialization for context-preserving kexec: A
> preserve_context kexec returns to the current kernel, which is unrelated
> to live update where state is passed to the next kernel. Skipping
> serialization avoids unnecessary work and prevents sessions from being
> left in a frozen state upon return.
> 
> [...]

Applied to next branch of liveupdate/linux.git tree, thanks!

[1/5] liveupdate: skip serialization for context-preserving kexec
      commit: ef4448795cf193b2828019978d872bc0d301abe4
[2/5] liveupdate: fix TOCTOU race in luo_session_retrieve()
      commit: aedeca39112a2bee13e54097fbb98896010f375f
[3/5] liveupdate: block session mutations during reboot
      commit: 6f070471ce4fc9084165b77bfd7457ef85dc8c8c
[4/5] liveupdate: fix u-a-f in luo_file_unpreserve_files() and luo_file_finish()
      commit: 051c2ed7b42077c511654261f5efb52ab368817f
[5/5] liveupdate: Remove unused ser field from struct luo_session
      commit: 5428435567cbe06c19914592fc22ca23c9ca1de5

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: next

--
Sincerely yours,
Mike.


