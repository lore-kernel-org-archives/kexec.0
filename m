Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFB9C32771
	for <kexec@archiver.kernel.org>; Wed, 28 Sep 2022 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K5Dbwey/Br7dKKOGqXGgKUMrIxTdVepScDa02Vtkha4=; b=bP/O/5aNzr6jLO
	n5ZmO8GEHeVsAJG6lGKnlOqaj84uniWA45l/jx5wmQ0DMtnrnmsr7HGlBD2pF1bkm2UgfKOPld4Vn
	RR+rZpCrAxH1nDSzPNGIEXlQOIpieBEAPf6PBStQMcuf1fb+y6hPn+TWjBbM7O4uR1CCh+BepqG7r
	sf/W525NFMGX1q7gnp9PBW6Mu1aiJLL/eipOMpBdsF8p9HdidCMLA5hTJ5rgH3jxTSvX23nqWpWT7
	HlYDf5mAvp6z4ciAdf9uNSLVyqgDTzhLfX0zvnLdNQLNXNoROVEjSiAMkUrIwh21Hb3ENMz1S7d8u
	tgGAqJrMaeZmSA1RJy9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oda5U-00H8sA-El; Wed, 28 Sep 2022 16:39:08 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oda5R-00H8qG-Is
	for kexec@lists.infradead.org; Wed, 28 Sep 2022 16:39:07 +0000
Received: from zn.tnic (p200300ea9733e7ee329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ee:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 766591EC058B;
	Wed, 28 Sep 2022 18:38:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1664383137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=WaGpA9Je9H07sCeEfaw6oqmp71ONkeh2idDIs+QiNXw=;
	b=DZcvbNRXx2Ancght4ZlZ/Tft8TaDUM8B3ldBqhHG86Hy1epnLbUlFhhQ+Ht9AiojDkivYp
	wXGnXOeGZRdXLMUzyXRJMK1gZIdERaWXQWvJykGQum66YWiFkgdPDcrZZJ58ZMQKgOAc1O
	OJfJQTVogRRVqJLW2rlenyDqNyZZmw0=
Date: Wed, 28 Sep 2022 18:38:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <YzR4neYLNB8tByNa@zn.tnic>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YzRxPAoN+XmOfJzV@zn.tnic>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_093905_794392_8A3D421B 
X-CRM114-Status: UNSURE (   8.88  )
X-CRM114-Notice: Please train this message.
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

On Wed, Sep 28, 2022 at 06:07:24PM +0200, Borislav Petkov wrote:
>  #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>  	/* Ensure elfcorehdr segment large enough for hotplug changes */
> @@ -407,9 +408,8 @@ int crash_load_segments(struct kimage *image)
>  	image->elf_headers_sz = kbuf.memsz;
>  	image->elfcorehdr_index = image->nr_segments;
>  	image->elfcorehdr_index_valid = true;

And that ifdeffery above can be made more readable too:

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index a526c893abe8..7aab6e942761 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -399,16 +399,15 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers_sz	= kbuf.bufsz;
 	kbuf.memsz		= kbuf.bufsz;
 
-#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
 	/* Ensure elfcorehdr segment large enough for hotplug changes */
-	kbuf.memsz =
-		(CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
-			sizeof(Elf64_Phdr);
-	/* Mark as usable to crash kernel, else crash kernel fails on boot */
-	image->elf_headers_sz = kbuf.memsz;
-	image->elfcorehdr_index = image->nr_segments;
-	image->elfcorehdr_index_valid = true;
-#endif
+	if (IS_ENABLED(CONFIG_CRASH_MAX_MEMORY_RANGES)) {
+		kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
+
+		/* Mark as usable to crash kernel, else crash kernel fails on boot */
+		image->elf_headers_sz = kbuf.memsz;
+		image->elfcorehdr_index = image->nr_segments;
+		image->elfcorehdr_index_valid = true;
+	}
 
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
