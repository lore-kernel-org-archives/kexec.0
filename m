Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B4CC0032E
	for <kexec@archiver.kernel.org>; Mon, 23 Oct 2023 02:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vd0OcFN9GS5BM6aPZezOLdHULTZKb17cFoy9YWXSIFc=; b=fvO8ClryTROL7D
	ZxPytFAHC0hX3d/NpyC6GoOO3l5UAHZIvhAlmM+3bGmNLhA+r+sFx7kuUaa7v4iA+iwl0fM+vt3B1
	Qf+/yQBNm6Ksx4Bh05WH+UsC3WO/yvStDPzVwUpS1j4Kx7sC7+hh/X1fryrZ02JAuiIH9cqde2Arw
	fIDl+sZX7+Excixx5rkUW9BQCLKVw6t64Z7DDEj1aolLJ+HDeOlUyR9RY85d7iHw06f/VF20VtHAp
	qMz1SUvPi930Fl2fYXdYYWFeGH756F6a38NQxwTWnrIqt75cE9MpY7/07k4rZZhplsx4uCnMRT49F
	LK0flXo/q33aaTPOIRYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1quktv-006GpZ-1F;
	Mon, 23 Oct 2023 02:42:43 +0000
Received: from [2607:7c80:54:3::138] (helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qukts-006Gp9-16
	for kexec@lists.infradead.org;
	Mon, 23 Oct 2023 02:42:41 +0000
Received: from [127.0.0.1] ([98.35.210.218])
	(authenticated bits=0)
	by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 39N2fuu22514359
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 22 Oct 2023 19:41:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 39N2fuu22514359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023101201; t=1698028917;
	bh=/FyxLFJpdyGgPFlWMuscXJXr9IiE9nMwl9kTBhkCwbk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CJWoyCAsAV8zCdBdlvxqgHxpb8s2yvUrvNiDW2/LACkmc2iFhjqIbMHF7fu2sJ1uR
	 6kdrLV5CHAzkkjoHIy00F4Tex/14tAxWyB3/XWsAFldqXZuphkIeFP/OgoJfQS0Y7W
	 wgxh4ORNZ8emuie/W5eC1OSj8QZRdB21I53ziCNe5Dm9/iFGENkLUdBubp9qOVVbux
	 3qzUYt0boIvL/zARtpsLyU8C9dBHiYRF0/Wa4iAGfLm0iDeFVJX5+5hNMJswiNXPBa
	 iS5H/XOod+1ZZq2X5TM5qCnlAzd7U/JXlp9lT4HIY29yQqbxgllqqt9s5KR33LFNUZ
	 6TH8hkSwkk7hw==
Date: Sun, 22 Oct 2023 19:41:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: John Sperbeck <jsperbeck@google.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org
CC: Dave Hansen <dave.hansen@linux.intel.com>, Zac Tang <zactang@google.com>,
        Cloud Hsu <cloudhsu@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kexec: set MIN_KERNEL_LOAD_ADDR to 0x01000000
User-Agent: K-9 Mail for Android
In-Reply-To: <20231023023121.1464544-1-jsperbeck@google.com>
References: <20231023023121.1464544-1-jsperbeck@google.com>
Message-ID: <4FDF6E7A-C6E2-415D-A82B-342DAE6BD561@zytor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231022_194240_384839_C594214C 
X-CRM114-Status: GOOD (  20.27  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On October 22, 2023 7:31:21 PM PDT, John Sperbeck <jsperbeck@google.com> wrote:
>The physical memory range that kexec selects for the compressed
>bzimage target kernel, might not be where it runs from.  The
>startup_64() code in head_64.S copies itself out of the way
>before the decompression so it doesn't clobber itself.
>
>If the start of the memory range selected by kexec is above
>LOAD_PHYSICAL_ADDR (0x01000000 by default), then the copy remains
>within the memory area.  But if the start is below this range,
>then the copy will likely end up outside the range.
>
>Usually, this will be harmless because not much memory is in use
>at the time of the pre-decompression copy, so there is little
>to accidentally clobber.  However, an unlucky choice for the
>adress of the kernel and the initrd could put the initrd in harm's
>way.  For example:
>
>    0x00400000 - physical address for target kernel
>    0x03ff8000 - physical address of seven-page initrd
>    0x0302c000 - size of uncompressed kernel (about 50 Mbytes)
>
>The decompressed kernel will span 0x01000000 through 0x0402c000,
>which will overwrite the initrd.
>
>If the kexec code restricts itself to physical addresses above
>0x01000000, then the pre-decompression copy and the decompression
>itself will stay within the bounds of the memory kexec selected
>(unless a non-default value is used in the target kernel for
>CONFIG_PHYSICAL_START, which will change LOAD_PHYSICAL_ADDR,
>but that's probably unsolvable unless the target kernel were to
>somehow communicate this to kexec).
>
>Signed-off-by: John Sperbeck <jsperbeck@google.com>
>---
> arch/x86/kernel/kexec-bzimage64.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>index a61c12c01270..d6bf6c13dab1 100644
>--- a/arch/x86/kernel/kexec-bzimage64.c
>+++ b/arch/x86/kernel/kexec-bzimage64.c
>@@ -36,7 +36,7 @@
>  */
> #define MIN_PURGATORY_ADDR	0x3000
> #define MIN_BOOTPARAM_ADDR	0x3000
>-#define MIN_KERNEL_LOAD_ADDR	0x100000
>+#define MIN_KERNEL_LOAD_ADDR	0x1000000
> #define MIN_INITRD_LOAD_ADDR	0x1000000
> 
> /*

This doesn't make any sense to me. There is already a high water mark for his much memory the kernel needs until an initrd or setup_data item can appear. This is just a hack, please fix it properly.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
