Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcWGR-0003wc-0o
 for kexec@lists.infradead.org; Thu, 17 Sep 2015 10:18:04 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1442271047-4908-6-git-send-email-palmer@dabbelt.com>
References: <1442271047-4908-6-git-send-email-palmer@dabbelt.com>
 <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
Subject: Re: [PATCH 05/13] Split FDPIC "struct elf_prstatus" to "struct
 elf_fdpic_prstatus"
MIME-Version: 1.0
Content-ID: <16417.1442485047.1@warthog.procyon.org.uk>
Date: Thu, 17 Sep 2015 11:17:27 +0100
Message-ID: <16418.1442485047@warthog.procyon.org.uk>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, dhowells@redhat.com, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, dyoung@redhat.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, jikos@kernel.org, a.p.zijlstra@chello.nl, arnd@arndb.de, plagnioj@jcrosoft.com, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

Palmer Dabbelt <palmer@dabbelt.com> wrote:

> I tried to fix all the users of "struct elf_prstatus" that should now
> be using "struct elf_fdpic_prstatus".  The only testing I did here was
> to build a Blackfin defconfig with "struct elf_prstatus" not defined,
> and to build an x86 defconfig with "struct elf_fdpic_prstatus" not
> defined.

You probably also need to try loading a core into a debugger.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
