Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCFBD74970
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 09:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xThT3ZAnzHU5Zu6pI/yzmNv7BBJH0PKrMFuW9mjkr08=; b=qVOtMMuyyecCgvBXlFYKE5Wi39
	yswVpdUnV1n3vU9C9MrlRrGNRoy6M1PL2Pe7BIXP1VlpDtWCXS8dEtek0y8c/InYF+Rat3uIz+oyv
	EL99qLREJ1XZ9MSOK7gz4lIR8IjPzh1ia/YLszdWvpCf9+m1rf9KdE6GlisH7jpcVQSG4wN+TzvwR
	pVkYC0nwPeyVcjtoyt6bw4BFcpDnKv3L78DUlvYZ2TSQmetVEvcf0XY/wpKb4p0kTLDaI2Q9ITCun
	VZT7H4g5msvFtl8Ud0Apxn2XG5cmUX2w4MPSoBgWtu1hT97jraATacSVHdCnmbH5Qjx2ZxWrJV7cH
	9N+6EQ2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWWs4-00000009xZm-0mBY;
	Fri, 19 Dec 2025 09:34:00 +0000
Received: from smtpbgjp3.qq.com ([54.92.39.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWWs0-00000009xXc-3UGx;
	Fri, 19 Dec 2025 09:33:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1766136786;
	bh=xThT3ZAnzHU5Zu6pI/yzmNv7BBJH0PKrMFuW9mjkr08=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=btztKtTYKP3rhnhuHs8jDT5YJZPRJ1HGD+qR0+u2G4awnOVGHo2R/FyV20TkemvZL
	 xxm4DFpeR/hSwskJ3OsI0Xx4SO9GhznB7dj+mtEpvGHIzQbgRrRPfCOQbPMSj/Ue+P
	 nrKNMiMVzJb/J1o4SsLZboC6xH9X49ibfsA7dSbg=
X-QQ-mid: zesmtpsz5t1766136768t2a5a7b80
X-QQ-Originating-IP: BofTwxD2mGpxJbUqngowvcbVd665A4aUXpCTG2nV5AI=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Dec 2025 17:32:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1616808465904202712
EX-QQ-RecipientCnt: 8
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2 0/4] kexec: add kexec flag to control debug printing
Date: Fri, 19 Dec 2025 17:31:30 +0800
Message-Id: <20251219093134.2268620-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MIEPJtBPGxyLy6vdcbEheffAgHGaqcMgngR306b8hwY1SHErHjMRJrV9
	5YcC1dShIcoA1q2twsjeZMty0oXAko6Xp2ihf5bglrpBv0/LXK5hhFZBh/H33vAaqvhFA/d
	/2I2koLsBL5PXdNrSeCaVGIryAUfzVKHtZAYJcgjEAMVdgAuTLTkbbZtIq+9ASNVOVCb/WQ
	c/HlA5o0dq4bg6Pkwv0iJ7k8Ry3ZAJuVJUS+c5KT3LKRnUyfzYe/SijUjb8NA8my1/1wpw0
	ZLu3u6p/yKappDv3kpY/AboOBMYS6cxfSOQ7YZuf6IhskBDsPyskwMRPnBuqVPznjOmn4s0
	rWVtGZ9FqSmAxngdqxG0tzz1MhHD5yI+KuPEZpec8qe0BIk/s9tzf6BaulFE32lypn9aPyp
	GAo63eV2kAi4UR/41isGmUny7gIiprvnUZcvEciMCtqr/ITrOsF+DxiSQwBSm8Wl/Urz8GZ
	moG02ytGYb92XKzkx3ChOWKnwZzitzjg+rRtrrhbEFCwDp2v/1zWwV3aLf+ulYtPwrDIshY
	uglDLKMIU+T1+SqIP7v+FL7ct1uaxLQNzL0ID8VJjVB9q57qePihANVK73gwWzZ0yvucKOq
	RafLNZEkvR2NsRWPra3kiZOI5neVaO3+7FfFzr5fef7gZlQK/7FCpa4S+DkXFkcsJTGxVKc
	ENTcH5C/bVqXxUpY6clIX35rMQgV/B2wbzc1msm9aOXJRuMqSC4qwAumapSYl3doQlvR33S
	CRHc7Q/In0/cNesmid0AW0OFSz+kgV2Cv+oZ6u+EX0bgmgN0Eny8dehekT7rs6JKRi2I3JS
	JAfNTThsgX39e87u5xKAcxhdo+2aoDXWfHRr2yFlsQli0D+ftBG+BagZ9AR5ZGwx5qglPsG
	5qL7d33etF24ZiS6CE9FahLo2NJ5xd1+gqxG/fQulzZpNLylI+l02W6WSF6f13AEZs40stp
	w4RwPHnNE/6vBaZt/USRb/6/Pe+ySfwnIV8zZQw4x4EqiL+Ea//IG96h7dNc9DC0yVNvawJ
	IbwY7FesqmWXHBmdLGbc+mWm2uSAMrdADABy1MTmRZBdR+5adTs5PaIb+K6CWJnMjIhUUFU
	g==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_013357_558865_F66FA779 
X-CRM114-Status: GOOD (  13.38  )
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
The commit cbc2fe9d9cb2 ("kexec_file: add kexec_file flag to control
debug printing") added the kexec_file flag to control debug printing.
However, for arm64, after commit 6f8c1da071a4 ("kexec_file, arm64: print
out debugging message if required"), when using the kexec_load interface,
the kexec_image_info function is called to print debug message, but
it uses kexec_dprintk, which is only available under kexec_file,
then when specifying 'kexec -d', kexec_load interface will print nothing.

For riscv, commit eb7622d908a09 ("kexec_file, riscv: print out debugging
message if required") remove kexec_image_info(), because the content has
been printed out in generic code in kexec_file_load, but not in kexec_load.

Therefore, in order to solve the two problems mentioned above, for this
patchset, several things need to be done:

1. Enabling kexec_dprintk is available for kexec_load.
2. Add some debugging message of the deleted kexec_image_info
   to generic code.
3. Remove duplicate debugging prints for arm64.

Since kexec_load and kexec_file_load are not triggered simultaneously,
we can unify the debug flag of kexec and kexec_file as kexec_dbg_print.

In this way, kexec_dprintk is available for kexec_load and kexec_file_load.

Then when specifying 'kexec -d', the debugging message using kexec_dprintk
in kexec_image_info can be printed normally.

The following are the key points of the specific changes:

1. rename kexec_file_dbg_print to kexec_dbg_print
2. Add KEXEC_DEBUG
3. Initialize kexec_dbg_print for kexec
4. Set the reset of kexec_dbg_print to kimage_free

Testing:
=========
I did testing on x86_64, arm64 and loongarch. On x86_64, the printed
messages look like below:

Unset CONFIG_KEXEC_FILE:
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

On aarch64, the printed messages look like below:

Set CONFIG_KEXEC_FILE
[   39.033203] kexec_file: kernel: 0000000073414684 kernel_size: 0x3123a00
[   39.047010] kexec_file: Loaded initrd at 0x43cf0000 bufsz=0x17e0e19 memsz=0x17e1000
[   39.047054] kexec_file: Loaded dtb at 0x23ec00000 bufsz=0x386 memsz=0x1000
[   39.047056] kexec_file(Image): Loaded kernel at 0x40000000 bufsz=0x3123a00 memsz=0x3cf0000
[   39.047063] kexec_file: nr_segments = 3
[   39.047064] kexec_file: segment[0]: buf=0x0000000073414684 bufsz=0x3123a00 mem=0x40000000 memsz=0x3cf0000
[   39.073612] kexec_file: segment[1]: buf=0x000000005cd5746b bufsz=0x17e0e19 mem=0x43cf0000 memsz=0x17e1000
[   39.085309] kexec_file: segment[2]: buf=0x0000000084c4a0f1 bufsz=0x386 mem=0x23ec00000 memsz=0x1000
[   39.085459] machine_kexec_post_load:155:
[   39.085463]   kexec kimage info:
[   39.085467]     kern_reloc: 0x00000001620e2000
[   39.085468]     el2_vectors: 0x0000000000000000
[   39.085470] kexec_file: kexec_file_load: type:0, start:0x40000000 head:0x1620e4002 flags:0x8

Unset CONFIG_KEXEC_FILE:

With this patch:
[   35.156088] machine_kexec_post_load:155:
[   35.156097]   kexec kimage info:
[   35.156101]     kern_reloc: 0x000000011c134000
[   35.156102]     el2_vectors: 0x0000000000000000
[   35.156104] kexec: kexec_load: type:0, start:0x454d26b0 head:0x105c14002 flags:0xb70010

Without this patch:
There is no kexec print in dmesg.

Previous posts:
Link: https://lore.kernel.org/all/aTdxEvqY6Bcy7Wa1@MiWiFi-R3L-srv/

Changes in v2:
==========
- Remove the Reported-by record of patch "kexec: print out debugging
  message if required for kexec_load"
- Move patch "kexec: Replace the goto out_unlock with out" to this patchset

Qiang Ma (4):
  kexec: Replace the goto out_unlock with out
  kexec: add kexec flag to control debug printing
  kexec: print out debugging message if required for kexec_load
  arm64: kexec: Adjust the debug print of kexec_image_info

 arch/arm64/kernel/machine_kexec.c | 2 --
 include/linux/kexec.h             | 9 +++++----
 include/uapi/linux/kexec.h        | 1 +
 kernel/kexec.c                    | 8 +++++++-
 kernel/kexec_core.c               | 4 +++-
 kernel/kexec_file.c               | 4 +---
 6 files changed, 17 insertions(+), 11 deletions(-)

-- 
2.20.1


