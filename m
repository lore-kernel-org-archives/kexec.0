Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16AACCF9FE
	for <kexec@archiver.kernel.org>; Mon,  3 Nov 2025 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6nWQdDTisj74ae8hwOWGFoeO0H59LpJ+3DqT0uV3z3g=; b=x3GZ2ncmJCwtzZ6MqoXG86oSZI
	WrImW7ZiBLI0ZA8OxXiD667kcaIM4mp7FBj7/GygSEWVKa0H4SCujOuhyo1h6wsyKWccE/dW3tXJm
	F86zls0JSvYmFIjm552S1gvXgGtNejJmC1U34kGiP2oH6I1YmPNH9nJvdrv8u1u4mSt9kQ091qlxJ
	nShOGMlT/mh4jjTPOW7W3AP0BLpWQK0JeIplBYqhn7E+pvQP1dPdCliCco37Xr5xMDsjg4MekRAiU
	g2M6SVGsvbWSKif1LqZxTY1J7WCZUINHK5yT37y4w7dPgsvr47i4b1MPCBEbBIqZbGQCxtRKxOiWA
	HDlo5dzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFoBb-00000009J2M-2dv7;
	Mon, 03 Nov 2025 06:37:03 +0000
Received: from smtpbguseast1.qq.com ([54.204.34.129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFoBW-00000009J0X-2ufj
	for kexec@lists.infradead.org;
	Mon, 03 Nov 2025 06:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762151785;
	bh=6nWQdDTisj74ae8hwOWGFoeO0H59LpJ+3DqT0uV3z3g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=kKN/h2Dd50B/nOU6Y3j611+GscUTbSi+ItN1H9wWm1kjaGn5tMIsmUvpGCfhSzEwp
	 jJk1LkiK7VTGAu+TVKc0/vwSEvalBGGPS10nBa5udlqtrJp8egwTi5DlrR11ctH9sr
	 NijHrLdGO+49aiOCDT9ThZA2vYohwujAzAmF98ZQ=
X-QQ-mid: zesmtpgz4t1762151780t36c286f0
X-QQ-Originating-IP: W5nUt9g3JfSt8+p3u2fUBuGOZvfjeepy8ll3/hWQyAk=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Nov 2025 14:36:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5943944819096324801
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2 0/4] kexec: print out debugging message if required for kexec_load
Date: Mon,  3 Nov 2025 14:34:36 +0800
Message-Id: <20251103063440.1681657-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MLbAtvpy5B1PrJJdvh4Q2hH3mOr9UDWe0wy/0g51W4UQpZrUNMS8ArEd
	kmYlWbCUa6HlKzN6grkR188ZPesFXCt5dHlpQcl+co1EBc4UfCgim8/pi9tmEd19LMy9jkL
	BT0PftrvH/K+U3tJdV2C0gM/3zxetm/BHK3hTSCsrUTNR+qoAVgWHQNEuVDGNl57gh09vn6
	nQbkTnNor4q4HGPel39rWztNdL5RxhGHOSTR+p88vqbAdShBHD9E1TJ4AkxDjxHr2HvJpEW
	kpDvx5/56fdgmnHRL7yQvpuvPumxkZmc6KQrMMPZ43XfbYwtZNAUHU+cTR4wp9QSKB3x92i
	JdCyvmq0PuVKt0y0ohDsAgoLdnWx75XbZjCpUsETuD0waZtFSd3KdkMhol92nidyVFbFqUQ
	XkTwBCTPfRilrfO9QP3qyFlglFwU6MHlHp945UY3iLf3b5aSzuMWGq2qSvGpG/U4wxpTlEU
	0NR6QMR/o+7ndGqAwODDb+o5DvhHiAPND9jL/EC30uNQLmPs8NJibXWi/I1l/lUs5pO6MVa
	t7CDtuukcqXzr8xKnpxzgxe5pkcyr5Jwyj2Er0FujvjK+YRPn96lTwvMoatOq0r/ytRD+0Y
	ZhNMAKjx2daEAZqinWo6O1X6FGjS7F6H7u1Ox7eZsPM8EzXs8M297FxI54jMppxCSnuPp1S
	nNGDXSHVxc6BzXqgcWXKTypIhwvS6t0sj99iG5xAQreCVoPJcqm34+gOUt+l6rAjwZ7YadW
	f8rmOSQYNXr8NWWKBO6AM4HiiFm68C6GpiFqnaqZFJPFX2sfD+PK9EXEeCzzMCOf/XWOmX7
	JpLT1ftEhkPWwhSAEYvyj/h8K76aDm5OarKA/M2zB1ptWCxDzelqlXhHolK5q+7GkwEDv5Q
	esF3tmwyZQLvB7YeENhkK1P8PbcXBzz1VKwIuxL2AfLSZfQjoja8Qlpzw74JjgVB1mtIFoR
	SxNxWZL9uVgZKqts+xYunHKbYAaRUi6pZN4wZHQdLDiG7cdAh9z2q54chKeaP+qqUBer5uD
	P8vFa9lO+JswKdPDQyCiDDqa7SI/Y=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_223659_567888_30C6119B 
X-CRM114-Status: UNSURE (   8.98  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Overview:
=========
The commit a85ee18c7900 ("kexec_file: print out debugging message
if required") has added general code printing in kexec_file_load(),
but not in kexec_load().
    
Since kexec_load and kexec_file_load are not triggered simultaneously,
we can unify the debug flag of kexec and kexec_file as kexec_core_dbg_print.
    
Next, we need to do some things in this patchset:
    
1. rename kexec_file_dbg_print to kexec_core_dbg_print
2. Add KEXEC_DEBUG
3. Initialize kexec_core_dbg_print for kexec
4. Fix uninitialized struct kimage *image pointer 
5. Set the reset of kexec_file_dbg_print to kimage_free

Testing:
=========
I did testing on x86_64, arm64 and loongarch. On x86_64, the printed messages
look like below:

unset CONFIG_KEXEC_FILE:
[   81.476959] kexec: nr_segments = 7
[   81.477565] kexec: segment[0]: buf=0x00000000c22469d2 bufsz=0x70 mem=0x100000 memsz=0x1000
[   81.478797] kexec: segment[1]: buf=0x00000000dedbb3b1 bufsz=0x140 mem=0x101000 memsz=0x1000
[   81.480075] kexec: segment[2]: buf=0x00000000d7657a33 bufsz=0x30 mem=0x102000 memsz=0x1000
[   81.481288] kexec: segment[3]: buf=0x00000000c7eb60a6 bufsz=0x16f40a8 mem=0x23bd0b000 memsz=0x16f5000
[   81.489018] kexec: segment[4]: buf=0x00000000d1ca53c8 bufsz=0xd73400 mem=0x23d400000 memsz=0x2ab7000
[   81.499697] kexec: segment[5]: buf=0x00000000697bac5a bufsz=0x50dc mem=0x23fff1000 memsz=0x6000
[   81.501084] kexec: segment[6]: buf=0x000000001f743a68 bufsz=0x70e0 mem=0x23fff7000 memsz=0x9000
[   81.502374] kexec: kexec_load: type:0, start:0x23fff7700 head:0x10a4b9002 flags:0x3e0010

set CONFIG_KEXEC_FILE
[   36.774228] kexec_file: kernel: 0000000066c386c8 kernel_size: 0xd78400
[   36.821814] kexec-bzImage64: Loaded purgatory at 0x23fffb000
[   36.821826] kexec-bzImage64: Loaded boot_param, command line and misc at 0x23fff9000 bufsz=0x12d0 memsz=0x2000
[   36.821829] kexec-bzImage64: Loaded 64bit kernel at 0x23d400000 bufsz=0xd73400 memsz=0x2ab7000
[   36.821918] kexec-bzImage64: Loaded initrd at 0x23bd0b000 bufsz=0x16f40a8 memsz=0x16f40a8
[   36.821920] kexec-bzImage64: Final command line is: root=/dev/mapper/test-root crashkernel=auto rd.lvm.lv=test/root
[   36.821925] kexec-bzImage64: E820 memmap:
[   36.821926] kexec-bzImage64: 0000000000000000-000000000009ffff (1)
[   36.821928] kexec-bzImage64: 0000000000100000-0000000000811fff (1)
[   36.821930] kexec-bzImage64: 0000000000812000-0000000000812fff (2)
[   36.821931] kexec-bzImage64: 0000000000813000-00000000bee38fff (1)
[   36.821933] kexec-bzImage64: 00000000bee39000-00000000beec2fff (2)
[   36.821934] kexec-bzImage64: 00000000beec3000-00000000bf8ecfff (1)
[   36.821935] kexec-bzImage64: 00000000bf8ed000-00000000bfb6cfff (2)
[   36.821936] kexec-bzImage64: 00000000bfb6d000-00000000bfb7efff (3)
[   36.821937] kexec-bzImage64: 00000000bfb7f000-00000000bfbfefff (4)
[   36.821938] kexec-bzImage64: 00000000bfbff000-00000000bff7bfff (1)
[   36.821939] kexec-bzImage64: 00000000bff7c000-00000000bfffffff (2)
[   36.821940] kexec-bzImage64: 00000000feffc000-00000000feffffff (2)
[   36.821941] kexec-bzImage64: 00000000ffc00000-00000000ffffffff (2)
[   36.821942] kexec-bzImage64: 0000000100000000-000000023fffffff (1)
[   36.872348] kexec_file: nr_segments = 4
[   36.872356] kexec_file: segment[0]: buf=0x000000005314ece7 bufsz=0x4000 mem=0x23fffb000 memsz=0x5000
[   36.872370] kexec_file: segment[1]: buf=0x000000006e59b143 bufsz=0x12d0 mem=0x23fff9000 memsz=0x2000
[   36.872374] kexec_file: segment[2]: buf=0x00000000eb7b1fc3 bufsz=0xd73400 mem=0x23d400000 memsz=0x2ab7000
[   36.882172] kexec_file: segment[3]: buf=0x000000006af76441 bufsz=0x16f40a8 mem=0x23bd0b000 memsz=0x16f5000
[   36.889113] kexec_file: kexec_file_load: type:0, start:0x23fffb150 head:0x101a2e002 flags:0x8

Changes in v2:
==========
- Unify the debug flag of kexec and kexec_file
- Fix uninitialized struct kimage *image pointer
- Fix the issue of mismatch between loop variable types

Qiang Ma (4):
  kexec: Fix uninitialized struct kimage *image pointer
  kexec: add kexec_core flag to control debug printing
  kexec: print out debugging message if required for kexec_load
  kexec_file: Fix the issue of mismatch between loop variable types

 include/linux/kexec.h      |  9 +++++----
 include/uapi/linux/kexec.h |  1 +
 kernel/kexec.c             | 16 +++++++++++++++-
 kernel/kexec_core.c        |  4 +++-
 kernel/kexec_file.c        |  9 ++++-----
 5 files changed, 28 insertions(+), 11 deletions(-)

-- 
2.20.1


