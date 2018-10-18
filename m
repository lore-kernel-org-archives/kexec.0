Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gD50o-0003TB-No
 for kexec@lists.infradead.org; Thu, 18 Oct 2018 09:54:40 +0000
Subject: Patch "x86/boot: Fix kexec booting failure in the SEV bit detection
 code" has been added to the 4.18-stable tree
From: <gregkh@linuxfoundation.org>
Date: Thu, 18 Oct 2018 11:50:52 +0200
Message-ID: <153985625228102@kroah.com>
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
To: 20180927123845.32052-1-kasong@redhat.com, alexander.levin@microsoft.com, bhe@redhat.com, bp@suse.de, brijesh.singh@amd.com, dyoung@redhat.com, ghook@redhat.com, gregkh@linuxfoundation.org, hpa@zytor.com, kasong@redhat.com, kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de, thomas.lendacky@amd.com
Cc: stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    x86/boot: Fix kexec booting failure in the SEV bit detection code

to the 4.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     x86-boot-fix-kexec-booting-failure-in-the-sev-bit-detection-code.patch
and it can be found in the queue-4.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Thu Oct 18 11:08:35 CEST 2018
From: Kairui Song <kasong@redhat.com>
Date: Thu, 27 Sep 2018 20:38:45 +0800
Subject: x86/boot: Fix kexec booting failure in the SEV bit detection code

From: Kairui Song <kasong@redhat.com>

[ Upstream commit bdec8d7fa55e6f5314ed72e5a0b435d90ff90548 ]

Commit

  1958b5fc4010 ("x86/boot: Add early boot support when running with SEV active")

can occasionally cause system resets when kexec-ing a second kernel even
if SEV is not active.

That's because get_sev_encryption_bit() uses 32-bit rIP-relative
addressing to read the value of enc_bit - a variable which caches a
previously detected encryption bit position - but kexec may allocate
the early boot code to a higher location, beyond the 32-bit addressing
limit.

In this case, garbage will be read and get_sev_encryption_bit() will
return the wrong value, leading to accessing memory with the wrong
encryption setting.

Therefore, remove enc_bit, and thus get rid of the need to do 32-bit
rIP-relative addressing in the first place.

 [ bp: massage commit message heavily. ]

Fixes: 1958b5fc4010 ("x86/boot: Add early boot support when running with SEV active")
Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: brijesh.singh@amd.com
Cc: kexec@lists.infradead.org
Cc: dyoung@redhat.com
Cc: bhe@redhat.com
Cc: ghook@redhat.com
Link: https://lkml.kernel.org/r/20180927123845.32052-1-kasong@redhat.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/mem_encrypt.S |   19 -------------------
 1 file changed, 19 deletions(-)

--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -25,20 +25,6 @@ ENTRY(get_sev_encryption_bit)
 	push	%ebx
 	push	%ecx
 	push	%edx
-	push	%edi
-
-	/*
-	 * RIP-relative addressing is needed to access the encryption bit
-	 * variable. Since we are running in 32-bit mode we need this call/pop
-	 * sequence to get the proper relative addressing.
-	 */
-	call	1f
-1:	popl	%edi
-	subl	$1b, %edi
-
-	movl	enc_bit(%edi), %eax
-	cmpl	$0, %eax
-	jge	.Lsev_exit
 
 	/* Check if running under a hypervisor */
 	movl	$1, %eax
@@ -69,15 +55,12 @@ ENTRY(get_sev_encryption_bit)
 
 	movl	%ebx, %eax
 	andl	$0x3f, %eax		/* Return the encryption bit location */
-	movl	%eax, enc_bit(%edi)
 	jmp	.Lsev_exit
 
 .Lno_sev:
 	xor	%eax, %eax
-	movl	%eax, enc_bit(%edi)
 
 .Lsev_exit:
-	pop	%edi
 	pop	%edx
 	pop	%ecx
 	pop	%ebx
@@ -113,8 +96,6 @@ ENTRY(set_sev_encryption_mask)
 ENDPROC(set_sev_encryption_mask)
 
 	.data
-enc_bit:
-	.int	0xffffffff
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	.balign	8


Patches currently in stable-queue which might be from kasong@redhat.com are

queue-4.18/x86-boot-fix-kexec-booting-failure-in-the-sev-bit-detection-code.patch

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
