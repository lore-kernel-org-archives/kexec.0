Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ye0-x22f.google.com ([2607:f8b0:4002:c04::22f])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJAXx-0004F9-QG
 for kexec@lists.infradead.org; Mon, 09 Sep 2013 23:07:06 +0000
Received: by mail-ye0-f175.google.com with SMTP id q8so2259001yen.34
 for <kexec@lists.infradead.org>; Mon, 09 Sep 2013 16:06:43 -0700 (PDT)
Message-ID: <522E547F.5030001@codyps.com>
Date: Mon, 09 Sep 2013 16:06:39 -0700
From: Cody P Schafer <devel-lists@codyps.com>
MIME-Version: 1.0
Subject: given a makedumpfile processed coredump, generate a symbolic backtrace
 containing the same info as a standard gdb backtrace
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: crash-utility@redhat.com, kexec@lists.infradead.org


Hi all,

I've got a coredump file processed by makedumpfile (non-elf) and am 
trying to get a backtrace with all the line numbers, argument values, 
and argument types like a normal gdb backtrace with debug info (yes, I 
have a vmlinux built with debuginfo).

gdb refuses to load the core dump (no big supprise there). crash loads 
it but it's builtin backtrace doesn't appear to use debug info, and as a 
result doesn't give me arguments + types. Doing "gdb bt" complains about 
not having a stack.

Any advise? I see a few paths forward:

  - somehow get crash's gdb to understand where the stack is
  - hack gdb to load the non-elf coredump
  - modify makedumpfile to allow it to convert the non-elf coredump back 
to elf.

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
