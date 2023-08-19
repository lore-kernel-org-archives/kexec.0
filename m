Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045BCEE49A6
	for <kexec@archiver.kernel.org>; Sat, 19 Aug 2023 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=718B5YKVPcTQkwA84bzqA/Adbqam5q8Flqso4S9Amqk=; b=jYIvR7xQbiJ5LI
	fp07qd2avSn0fs7gEbZ0rMRQIl2BPdg+jVi+fD3md2+eHdEWbfNAbvRgXKmbC3CAPNVz709wikLmg
	Rbo8eBCIUQ5ahQ/HoJpFjdMe4gb2fQvdiUyDwxJdCNqU1RHAqCHqeFygTjQRe0zgDq/znpVUo+97j
	vmBx+rw8YHP2OtmDbGdNf7Lw60FVDbRa5zomR9TY6+buSE1ghwrIW86GM1RyJ4+dUl2UA6f3vy1bt
	BGyI9hQreWooHvJjPZeLbXdO/qNDfbedngviOsZEcDHA8/DZ1Ma7yS+HPBnyD/Mg6ZddNTgXEzO6p
	MfXA1H8TXGu5DddoCJhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXRMI-00B82F-2q;
	Sat, 19 Aug 2023 19:11:38 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXRME-00B81t-37
	for kexec@lists.infradead.org;
	Sat, 19 Aug 2023 19:11:36 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a3082c771so228421b3a.0
        for <kexec@lists.infradead.org>; Sat, 19 Aug 2023 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692472293; x=1693077093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yBVZElvXIUVjwYogLTFeU9J93uxeoCCt3ueyuM82Ze8=;
        b=EmFdo3vDRn+8xxpWfKbDegJ7Dg0MWu66/vy3c/ePaXqbdjKTqQSIklg6ZruXZRhSXE
         IlFV6z6qK5o7bLDHmYwclDtBPyGktjAQ1ALHvWGF1QAEn9I5rjjwhlsCNPC3hy6e4oVl
         2VqURVft6laNslgE/iujIBkLdGpLRjW8qNTvatoNQbz08+VT/vWyb0FIAFb6WMEcrd8s
         skyeVt6zF3B3wPkeUSXpbXb/uvj4lamRlsW6f46huxb5u4MnMIZmXqrAjd3ZJ3e+KB4f
         4ukOwbonWY5wG9PvQWxYuOcJHcFLP8JyxY1gt/bN1JPfhtFU70pnzzcoMbyfHdbk+q9q
         w4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692472293; x=1693077093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBVZElvXIUVjwYogLTFeU9J93uxeoCCt3ueyuM82Ze8=;
        b=JqPz+HjCzRHm7vReGD+jjUU4c85LAcE3a3f+dAnfToLtWbtGQdc+EGOlv+jUV7BiLA
         W4VwCt6mYoYWt8rVopYXkSHfZ4bJNxlipThD/sQjWxXGdmmf2GMcqJILwCKlq5a99efO
         vgSWjDrODbHaJW1Ayvq2np0uQauwQDivNxEYIYy6badXmcCmYOcVThDr8dgvLQjOerK3
         udxZXtMusKDZvDNtDX463/Zls3v3ptRSwfl3/mZUymwaYGQheFcJig8H+QLqmg1J4Evr
         myRjZA9lcK/t/M0xjucmqtPDqCXBAi9BP1t/uZWF7USzbJh1mXRStiqTApfTr0NhofLH
         s1Lg==
X-Gm-Message-State: AOJu0YwyVQPaPuibzu8sF8XMy/IScqEZvQIpwMpTOObtOn+U9m008sN7
	dDgfj/0qqKebZXrOULoK1q5dK8dnDC06RA==
X-Google-Smtp-Source: AGHT+IFB02lmLPVN51mneeejB+JQ6n3JhPnaOTCWrvXgYha1s/AgjWjpGO/ViIhh9nb45dz7vEvhGQ==
X-Received: by 2002:a05:6a21:6da5:b0:123:152d:d46b with SMTP id wl37-20020a056a216da500b00123152dd46bmr3625222pzb.26.1692472293122;
        Sat, 19 Aug 2023 12:11:33 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:641:8080:1a70::ac6b])
        by smtp.gmail.com with ESMTPSA id q15-20020a63ae0f000000b00563ff7d9c4bsm3705643pgf.73.2023.08.19.12.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 12:11:32 -0700 (PDT)
From: Alexander Kamensky <alexander.kamensky42@gmail.com>
To: kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>
Cc: Alexander Kamensky <alexander.kamensky42@gmail.com>
Subject: [PATCH] aarch64: kern_paddr_start calculation makes more accurate legacy check
Date: Sat, 19 Aug 2023 12:11:19 -0700
Message-ID: <20230819191119.975299-1-alexander.kamensky42@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230819_121135_030360_B4D2685B 
X-CRM114-Status: GOOD (  20.43  )
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

In the latest openembedded with aarch64 image that uses 6.4.3 kernel on qemu I
tried to run makedumpfile in secondary kernel with /proc/vmcore. It failed as
follows:

> root@qemuarm64:~# makedumpfile -c -F /proc/vmcore > /dev/null
> read_from_vmcore: Can't seek the dump memory(/proc/vmcore). (offset: ffffffc0123fa000) Invalid argument
> readpage_elf: Can't read the dump memory(/proc/vmcore).
> <snip>

It turns out that not all parts for /proc/vmcore are readable:

> root@qemuarm64:~# cat /proc/vmcore > /dev/null
> [  136.394931] Internal error: synchronous external abort: 0000000096000010 [#1] PREEMPT SMP
> [  136.422434] Modules linked in:
> <snip>

Binary search of different kernel versions I found that the issue goes back to
5.11. It works fine with 5.10 version of the kernel.

After running secondary kernel under qemu gdb, I've found that the primary kernel
main memory segment in elfcorehdr has wrong address and size.

Looking at kexec output with debug enabled at the time when it loads secondary
crash kernel I saw the following:

> Kernel text Elf header: p_type = 1, p_offset = 0x4030200000 p_paddr = 0x4030200000 p_vaddr = 0xffffffffffffffff p_filesz = 0xffffffc011410000 p_memsz = 0xffffffc011410000

These values come from elf_info variable and are set in iomem_range_callback
function. The function gets the following input on my system:

root@qemuarm64:~# cat /proc/iomem | grep "Kernel code"
  40210000-40feffff : Kernel code
root@qemuarm64:~# cat /proc/kallsyms | grep -e ' _text$'
root@qemuarm64:~# cat /proc/kallsyms | grep -e ' _stext$'
ffffffc010010000 T _stext
root@qemuarm64:~# cat /proc/kallsyms | grep -e ' __init_begin$'
ffffffc010df0000 T __init_begin

the function calculates elf_info.kern_paddr_start address similar to
these manual steps:

base = 0x40210000
length = 0x40feffff - 0x40210000 + 0x1 = 0xde0000
kva_text_end - kva_stext = 0xffffffc010df0000 - 0xffffffc010010000 = 0xde0000

elf_info.kern_paddr_start = base - (kva_stext - kva_text) =
                      0x40210000 - 0xffffffc010010000 = 0x4030200000

since 'length' and 'kva_text_end - kva_stext' are equal the function calculate
elf_info.kern_paddr_start as in legacy case:

  if (kva_text_end - kva_stext == length)
     elf_info.kern_paddr_start = base - (kva_stext - kva_text); // <---------
  else
     elf_info.kern_paddr_start = base;

but my kernel is not legacy and kva_text is zero.

The fix is just to add a check for kva_text not being zero before following the
legacy case.

Signed-off-by: Alexander Kamensky <alexander.kamensky42@gmail.com>
---
 kexec/arch/arm64/crashdump-arm64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 3098315..639c82a 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -82,7 +82,7 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 		 * For compatibility, deduce by comparing the gap "__init_begin - _stext"
 		 * and the res size of "Kernel code" in /proc/iomem
 		 */
-		if (kva_text_end - kva_stext == length)
+		if ((kva_text_end - kva_stext == length) && (kva_text != 0))
 			elf_info.kern_paddr_start = base - (kva_stext - kva_text);
 		else
 			elf_info.kern_paddr_start = base;
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
