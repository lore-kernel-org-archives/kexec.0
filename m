Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x235.google.com ([2607:f8b0:400e:c03::235])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZthXu-0001jE-R2
 for kexec@lists.infradead.org; Tue, 03 Nov 2015 19:47:07 +0000
Received: by pabfh17 with SMTP id fh17so27161882pab.0
 for <kexec@lists.infradead.org>; Tue, 03 Nov 2015 11:46:45 -0800 (PST)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4] Remove #ifdef CONFIG_* from all userspace headers
Date: Tue,  3 Nov 2015 11:46:21 -0800
Message-Id: <1446579994-9937-1-git-send-email-palmer@dabbelt.com>
In-Reply-To: <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
References: <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: arnd@arndb.de, dhowells@redhat.com
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, plagnioj@jcrosoft.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, a.p.zijlstra@chello.nl, jikos@kernel.org, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

I think this is good to go.  There are two acks, but I wasn't sure if I was
supposed to collect them in the patches or not.  Arnd Bergman acked #1 and #7.

Changes since v3 (<1442271047-4908-1-git-send-email-palmer@dabbelt.com>)

 * #4 is very different: rather than defining a canonical value for
   MAP_UNINITIALIZED, it just punts on the problem and lets arch maintainers
   deal with it.  There's still an #ifndef MAP_UNINITIALIZED in there, but that
   shouldn't get triggered by anything because the arch headers should set it
   to whatever they actually want.

 * #11 defines MAX_RAW_MINORS to 2^20 instead of 2^16.

 * #13 moves the variable around a bit so it gets initialized.  I forgot I was
   in perl and not C :).

Changes since v2 (<1441832902-28993-1-git-send-email-palmer@dabbelt.com>)

 * Patch set renamed.

 * #2 is rewritten to use sys_ni.c instead of an #ifdef

 * #3, #6, #8, #9, #10, and #11 no longer use "#ifdef __KERNEL__" but
   have instead moved the offending lines to the correct, kernel-only
   files.

 * #4 has been rewritten to always define MAP_UNINITIALIZED to
   non-zero, rather than defining it to zero when in userspace.

 * #5 got a whole lot longer -- rather than just always hiding these
   fields from userspace, there is now a second "struct
   elf_fdpic_prstatus" structure.  This should allow userspace to
   parse core dumps correctly.

 * Rebased onto 9c488de24f7264f08d341024bffdd637b4d04c96.

Changes since v1 (<1441152610-22566-1-git-send-email-palmer@dabbelt.com>)

 * All patches but #1 were added.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
