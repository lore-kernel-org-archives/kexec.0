Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from imap.thunk.org ([2600:3c02::f03c:91ff:fe96:be03])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z4LQb-0008Bg-I0
 for kexec@lists.infradead.org; Mon, 15 Jun 2015 03:51:19 +0000
Date: Sun, 14 Jun 2015 23:50:51 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: kexec_load(2) bypasses signature verification
Message-ID: <20150615035051.GA2634@thunk.org>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Eric Biederman <ebiederm@xmission.com>, dhowells@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

From experimentation and from looking at the sources, it appears that
the signature checking is only done in the kexec_file_load(2) system
all, and not in the kexec_load(2) system call.  And I understand why
-- the signature is not sent from userspace to the kernel in the older
kexec_load(2) system call.

The problem is that if you use an old version of kexec, it will use
the old kexec_load(2) system call, and even though
CONFIG_KEXEC_VERIFY_SIG is enabled, kexec_load(2) will happily load an
unsigned kernel, and then "kexec -e" will happily boot into it.

Correct me if I am wrong, but this appears to be a hole in Secure Boot
you could drive a Mack Truck through.

(I noticed this because Debian is still using a kexec-tools from the
stone ages, version 2.0.7, and I was wondering **why** I was able to
kexec boot completely unsigned kernels.)

It would appear to me that if CONFIG_KEXEC_VERIFY_SIG is enabled, the
old kexec_load(2) system call should be disabled (and a warning be
placed in the Kconfig help that the user should have at least verision
2.X of kexec-tools if they enable this kernel option).

Am I missing something?

						- Ted

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
