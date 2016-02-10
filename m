Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTPY9-0000XX-O0
 for kexec@lists.infradead.org; Wed, 10 Feb 2016 07:50:58 +0000
Date: Wed, 10 Feb 2016 08:47:37 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH 0/3] makedumpfile: Fix handling of ELF segments with p_memsz
 > p_filesz
Message-ID: <20160210084737.3060fb5a@hananiah.suse.cz>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Ivan Delalande <colona@arista.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

Hello Ivan & Atsushi,

after spending some time on this, I think I have a complete working
solution. I chose to rewrite readpage_elf from scratch. Unfortunately,
I'm unable to verify that it still works the same (sans bugs) because
of a regression in commit d18796d090623d18f46c8dc608dcad9960fbbe9b
(reported on the mailing list).

I was able to verify that --dump-dmesg works on a variety of weird ELF
files that I created manually (and the output hasn't changed). In my
opinion, this is enough to verify that the read routine works, but the
final decision is up to you.

Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
