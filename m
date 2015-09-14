Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zbcar-0002Tm-Ty
 for kexec@lists.infradead.org; Mon, 14 Sep 2015 22:51:26 +0000
Received: by padew5 with SMTP id ew5so4711285pad.0
 for <kexec@lists.infradead.org>; Mon, 14 Sep 2015 15:51:04 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3] Remove #ifdef CONFIG_* from	all userspace headers
Date: Mon, 14 Sep 2015 15:50:34 -0700
Message-Id: <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
In-Reply-To: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
References: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
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

This patch set used to be called "[PATCH] Remove #ifdef CONFIG_64BIT
from all asm-generic/fcntl.h".

This is version 3 of the patch set.  I think things are kind of
cleaning up, but there's still some questions I have:

 * #4 might be dangerous, but I think this is the best way to do it
   because otherwise arch maintainers will have to #define this to
   something.  Since Xtensa already had exactly the same bug as the
   asm-generic header did, I think it'd be best to avoid those if
   possible.

   I'm OK changing this to define the value to 0 by default (though
   thinking now, I think it'd be better to not define it by default),
   since most kernels aren't going to have MAP_UNINITIALIZED do
   anything anyway.

 * #5 is big and I don't really understand what's going on, so it's
   probably broken somewhere.

Also, there's some checkpatch warnings that I purposely haven't fixed:

 * In #5, there's a checkpatch.pl complaint about same-line struct
   braces.  I've left that in to match the rest of the file, but I can
   also fix all of them if that would be better.

 * In #10, there's a checkpatch.pl complaint about a split printk
   format string, but that was there before and I don't see a way to
   make it a lot cleaner, so I'm leaving it alone.

 * In #13, there's two checkpatch.pl complains.  One is about block
   comments that is bogus, and one is about long lines but there's
   more of those so I think it's OK.

Thanks to everyone who looked at v2!




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
