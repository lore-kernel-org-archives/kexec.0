Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from m-relay2.rz.uni-saarland.de ([134.96.7.8]
	helo=eris.rz.uni-saarland.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KsbEF-0000EH-54
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 10:46:15 +0000
From: Alexander van Heukelum <heukelum@fastmail.fm>
Subject: [PATCH 0/7] x86, dumpstack: unify oops_begin, oops_end,
	die_nmi and die
Date: Wed, 22 Oct 2008 12:00:07 +0200
Message-Id: <1224669614-25863-1-git-send-email-heukelum@fastmail.fm>
In-Reply-To: <20081021145954.GB25750@hmsreliant.think-freely.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@tuxdriver.com>, Ingo Molnar <mingo@elte.hu>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, hbabu@us.ibm.com, hpa@zytor.com, akpm@linux-foundation.org, Alexander van Heukelum <heukelum@fastmail.fm>, ebiederm@xmission.com, tglx@linutronix.de
Cc: Alexander van Heukelum <heukelum@fastmail.fm>

Hello Neil, Ingo, everyone,

This patch series unifies oops_begin, oops_end, die_nmi
and die in dumpstack_xx.c. The first patch might be
considered a bug-fix, because otherwise, as Neil Horman
points out, it might be possible to call crash_kexec with
the console_sem held; if that happens, we deadlock.

Greetings,
	Alexander

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
