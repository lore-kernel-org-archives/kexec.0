Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3680EC38A02
	for <kexec@archiver.kernel.org>; Fri, 28 Oct 2022 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WRWDjSvtSEb64tsBHlj0DnYMwg7Q+tLFJtqLFIiWRqU=; b=hx5aDbdtcXGFiH
	EhuSl4aFVby9nmF/U6NspxJrfQDnynGsgyMyzx5PG95ZD2hMH8Le44Xzjr1a06FmZ4JTxB9QovKpK
	J8az/SjxfvYRskUz718XSh53Snw1M88QcQVKoiAHe6YyofQBzdiPqcQbYKikchNoakqqF5/RWGg5I
	YtCzvk7mfbrR8OHry8lBsvJLDlMvI3ClaeGtoTUhibu4E/gTIHwI678OEvLv+j26ww770Tvse6827
	lhcfjiKkbFJNkN6qtrld437fEIXGRB+X7ohE/cyllPfH1YTUeqz/22KasMbIIXXEEaJDBo1LNMWf6
	/BAcKYF9iHGoQPwMHlhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooTG4-001MIE-2d; Fri, 28 Oct 2022 17:35:04 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooSo6-0018cL-ST
	for kexec@lists.infradead.org; Fri, 28 Oct 2022 17:06:12 +0000
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2027D1EC0676;
	Fri, 28 Oct 2022 19:06:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1666976765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=UpitehZpLYGjIwKABq3amz3Mj5g5BAkI3R/OCX9YIGU=;
	b=sYaqnLEfiGpccG69Zo0DHQ8p82KZKaS9i7HHJxG1ytsE2O6MRw9p46NNgIzbmM8HV7b4Wh
	aDsWDGjCtw54+5Ag2KuMSALI2dA70QKjaOXaHGWQmTKnu2gNxUBncbpmflVX7+4m8keEFE
	Lbb2fSANN7sbNULJMbKglClTrthTZcY=
Date: Fri, 28 Oct 2022 19:06:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: Baoquan He <bhe@redhat.com>, david@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org,
	sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y1wL+ZrvD5gTZaKN@zn.tnic>
References: <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic>
 <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic>
 <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic>
 <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com>
 <Y1uspLb7fLdtnQq+@zn.tnic>
 <d91f8728-6a63-415d-577c-bd76e69ec7f6@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d91f8728-6a63-415d-577c-bd76e69ec7f6@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_100611_123658_4332A153 
X-CRM114-Status: GOOD (  16.65  )
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

On Fri, Oct 28, 2022 at 10:29:45AM -0500, Eric DeVolder wrote:
> So it is with this in mind that I suggest we stay with the statically sized elfcorehdr buffer.
> 
> If that can be agreed upon, then it is "just a matter" of picking a useful
> elfcorehdr size. Currently that size is derived from the NR_DEFAULT_CPUS and
> CRASH_MAX_MEMORY_RANGES. So, there is still the CRASH_MAX_MEMORY_RANGES knob
> to help a dial in size, should there be some issue with the default
> value/size.

Let's see

        kbuf.memsz =
                (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
                        sizeof(Elf64_Phdr);

which, IINM, is

	(8192 + 32768) * 56

which is something like 2M.

(CONFIG_NR_CPUS_DEFAULT = 8192 - this is because of MAXSMP which gets
set on distro kernels)

Now, since userspace kexec tools uses 2048 for max memory ranges, that
size becomes smaller - around half a Mb. And since y'all wanna be on the
safe side, you can quadruple it and have

	(8192 + 8192) * 56

which is still under a megabyte. And that's fine, I guess, on a big
server.

> Or if there is desire to drop computing the size from NR_DEFAULT_CPUs and

I think you should leave the dependency on the Kconfig size so that
smaller machines which are configured this way, don't end up wasting
unnecessary memory.

> It is my intention to correct the CRASH_MAX_MEMORY_RANGES (if we keep it) as such:
> 
> config CRASH_MAX_MEMORY_RANGES
>     depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG

Yes, but don't leave it to the user to decide what number to choose
- choose a high enough number, explain why you've chosen this with a
comment and that's it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
