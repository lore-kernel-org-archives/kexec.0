Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fiFRG-0006yj-LU
 for kexec@lists.infradead.org; Wed, 25 Jul 2018 08:46:32 +0000
Received: by mail-wm0-x242.google.com with SMTP id f21-v6so5170313wmc.5
 for <kexec@lists.infradead.org>; Wed, 25 Jul 2018 01:46:19 -0700 (PDT)
Received: from [192.168.0.20] ([94.10.28.213])
 by smtp.googlemail.com with ESMTPSA id
 i125-v6sm7899872wmd.23.2018.07.25.01.46.17
 for <kexec@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Jul 2018 01:46:17 -0700 (PDT)
From: Chris Clayton <chris2553@googlemail.com>
Subject: (Possible) fix for "Unhandled rela relocation: R_X86_64_PLT32" error
Message-ID: <e590dc81-7df7-746d-98f2-710f85e03467@googlemail.com>
Date: Wed, 25 Jul 2018 09:46:10 +0100
MIME-Version: 1.0
Content-Language: en-GB
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
To: kexec@lists.infradead.org

Hi.

I haven't rebooted my laptop with kexec for quite some time, but when I tried to this morning I got the error you will
see in $SUBJECT.  The error occurs with both kexec-tools-2.0.17 or -2.0.16 run on either 4.18.0-rc6+ (built from a git
pull this morning) or 4.14.57 kernels.

I searched for "R_X86_64_PLT32" and found that there was a change to the kernel that may be related -
b21ebf2fb4cde1618915a97cc773e287ff49173e x86: Treat R_X86_64_PLT32 as R_X86_64_PC32. So I replicated the change that
patch made to arch/x86/kernel/machine_kexec_64.c in kexec/arch/x86_64/kexec-elf-rel-x86_64.c and kexec now reboots into
the new kernel.

I don't know enough about relocations and the like to know whether my 'fix' is correct and the best way to go about it,
but I've included it below for your consideration.

Signed-off-by: Chris Clayton <chris2553@googlemail.com>

--- kexec-tools-2.0.17/kexec/arch/x86_64/kexec-elf-rel-x86_64.c.orig	2018-07-25 08:48:24.152054030 +0100
+++ kexec-tools-2.0.17/kexec/arch/x86_64/kexec-elf-rel-x86_64.c	2018-07-25 08:49:16.860055330 +0100
@@ -79,6 +79,7 @@ void machine_apply_elf_rel(struct mem_eh
 			goto overflow;
 		break;
 	case R_X86_64_PC32:
+	case R_X86_64_PLT32:
 		*(uint32_t *)location = value - address;
 		break;
 	default:

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
