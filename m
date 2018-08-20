Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1frhva-0001NB-BJ
 for kexec@lists.infradead.org; Mon, 20 Aug 2018 11:00:55 +0000
Received: by mail-wr1-x42c.google.com with SMTP id a108-v6so9956923wrc.13
 for <kexec@lists.infradead.org>; Mon, 20 Aug 2018 04:00:42 -0700 (PDT)
Subject: kexec: fix for "Unhandled rela relocation: R_X86_64_PLT32" error
References: <e590dc81-7df7-746d-98f2-710f85e03467@googlemail.com>
 <20180820083718.GZ4113@MiWiFi-R3L-srv>
From: Chris Clayton <chris2553@googlemail.com>
Message-ID: <cbf043a7-8e95-9486-3441-07ef8f2f86f5@googlemail.com>
Date: Mon, 20 Aug 2018 12:00:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180820083718.GZ4113@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org

In response to a change in binutils, change b21ebf2fb4cde1618915a97cc773e287ff49173e (x86: Treat R_X86_64_PLT32 as
R_X86_64_PC32) was applied to the linux kernel during the 4.16 development cycle and has since been backported to
earlier stable kernel series. The change results in the failure message in $SUBJECT when rebooting via kexec.

Fix this by replicating the change in kexec.

Signed-off-by: Chris Clayton <chris2553@googlemail.com>
---

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
