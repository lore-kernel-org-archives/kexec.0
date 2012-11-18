Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZy6S-0000xw-3p
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 06:11:37 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <CAE9FiQXNDEPw6WhfgYspqZsy+VVrPoA7M4kKo+5N95=22WBpkQ@mail.gmail.com>
 <50A86563.30303@zytor.com> <876253sej9.fsf@xmission.com>
 <CAE9FiQVfRHpoBoUyZssfE32wv7j3fD2skRL4UFXP=FBq7rrE1w@mail.gmail.com>
 <878v9zqyfh.fsf@xmission.com>
 <CAE9FiQV=6qeBgzd3ekBRXh1jfv+_-s_UuQqRyMAYwK5E=S55fA@mail.gmail.com>
 <CAE9FiQX7MsAaD4TaDv5gisuA5PNa9AmhDk54AjpzEzp4D_+aDg@mail.gmail.com>
 <CAE9FiQWm=6yas4dRfbc+qLC7yEhbdt+pnRMwAYSQ1jjk5qOvBw@mail.gmail.com>
Date: Sat, 17 Nov 2012 22:11:18 -0800
In-Reply-To: <CAE9FiQWm=6yas4dRfbc+qLC7yEhbdt+pnRMwAYSQ1jjk5qOvBw@mail.gmail.com>
 (Yinghai Lu's message of "Sat, 17 Nov 2012 21:58:48 -0800")
Message-ID: <871ufrqw3d.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] add mem64_min/max control
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

Yinghai Lu <yinghai@kernel.org> writes:

> On Sat, Nov 17, 2012 at 9:39 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Sat, Nov 17, 2012 at 9:35 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Sat, Nov 17, 2012 at 9:20 PM, Eric W. Biederman
>>> <ebiederm@xmission.com> wrote:
>>>> Yinghai Lu <yinghai@kernel.org> writes:
>>>>>
>>>>> there is lots of R_X86_64_32 and R_X86_64_32S for 64bit purgatory.
>>>>>
>>>>> those come from global variables...could kill some by converting them static...
>>>>>
>>>>> but still have some global string or ro data....
>>>>>
>>>>> build one big file include all .S ?
>>>>
>>>> For R_x86_64_32 and R_x86_64_32S the problem is that the instructions
>>>> are using absolute 32bit addresses.
>>>>
>>>> It is probably overkill but we should be able to solve this with
>>>> by adding "-mcmodel=large" to the build of purgatory.
>>>
>>> it kill some...
>>>
>>> still have left.... looks they from .S
>>>
>>> yhlu@linux-siqj:~/xx/xx/utils/kexec-tools> readelf --relocs
>>> purgatory/purgatory.ro | grep R_X86_64_32
>>> 0000000005e9  00020000000b R_X86_64_32S      0000000000000000 .rodata + c0
>>
>> looks like .S did not get that -mcmodel=large applied..
>
> so -mcmodel=large only work with .c, but does not have effects on .S ?

Yes it -mcmodel=large is about which instructions you generate.  The
instructions used determine the relocates.

Just for playing with it the following patch modifies things so
purgatory is 64bit clean.

I don't know yet what to do with the 32bit and 16bit assembly.

Eric


diff --git a/purgatory/Makefile b/purgatory/Makefile
index ee1679c..e39adec 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -64,6 +64,7 @@ $(PURGATORY): $(PURGATORY_OBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
 
 #	$(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) --no-undefined -e purgatory_start -r -o $@ $(PURGATORY_OBJS) $(UTIL_LIB)
+	$(STRIP) --strip-debug $@
 
 echo::
 	@echo "PURGATORY_SRCS $(PURGATORY_SRCS)"
diff --git a/purgatory/arch/x86_64/Makefile b/purgatory/arch/x86_64/Makefile
index 22b4228..2a768c6 100644
--- a/purgatory/arch/x86_64/Makefile
+++ b/purgatory/arch/x86_64/Makefile
@@ -2,7 +2,7 @@
 # Purgatory x86_64
 #
 
-x86_64_PURGATORY_SRCS_native = purgatory/arch/x86_64/entry64-32.S
+#x86_64_PURGATORY_SRCS_native = purgatory/arch/x86_64/entry64-32.S
 x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/entry64.S
 x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/setup-x86_64.S
 x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/stack.S
@@ -16,9 +16,11 @@ dist += purgatory/arch/x86_64/Makefile $(x86_64_PURGATORY_SRCS_native) 	\
 	purgatory/arch/x86_64/purgatory-x86_64.h
 
 # Don't add sources in i386/ to dist, as i386/Makefile adds them
-x86_64_PURGATORY_SRCS +=  purgatory/arch/i386/entry32-16.S
-x86_64_PURGATORY_SRCS += purgatory/arch/i386/entry32-16-debug.S
+#x86_64_PURGATORY_SRCS +=  purgatory/arch/i386/entry32-16.S
+#x86_64_PURGATORY_SRCS += purgatory/arch/i386/entry32-16-debug.S
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/crashdump_backup.c
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/console-x86.c
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/vga.c
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/pic.c
+
+x86_64_PURGATORY_EXTRA_CFLAGS = -mcmodel=large
diff --git a/purgatory/arch/x86_64/entry64.S b/purgatory/arch/x86_64/entry64.S
index 666023c..e3223b7 100644
--- a/purgatory/arch/x86_64/entry64.S
+++ b/purgatory/arch/x86_64/entry64.S
@@ -37,9 +37,10 @@ entry64:
 	movl	%eax, %fs
 	movl	%eax, %gs
 
-	movq	$stack_init, %rsp
+	leaq	stack_init(%rip), %rsp
 	pushq	$0x10 /* CS */
-	pushq	$new_cs_exit
+	leaq	new_cs_exit(%rip), %rax
+	pushq	%rax
 	lretq
 new_cs_exit:
 
diff --git a/purgatory/arch/x86_64/setup-x86_64.S b/purgatory/arch/x86_64/setup-x86_64.S
index 74997fa..95572d8 100644
--- a/purgatory/arch/x86_64/setup-x86_64.S
+++ b/purgatory/arch/x86_64/setup-x86_64.S
@@ -42,10 +42,10 @@ purgatory_start:
 	/* In 64bit mode the code segment is meaningless */
 
 	movq	0(%rsp), %rax
-	movq	%rax, jump_back_entry
+	movq	%rax, jump_back_entry(%rip)
 
 	/* Setup a stack */
-	movq	$lstack_end, %rsp
+	leaq	lstack_end(%rip), %rsp
 
 	/* Call the C code */
 	call purgatory


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
