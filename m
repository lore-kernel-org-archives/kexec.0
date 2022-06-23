Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB486C433EF
	for <kexec@archiver.kernel.org>; Thu, 23 Jun 2022 09:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3WHGgXiwBbZwWi3ifLGKuXws0p3udyFUtZ4leAyrcXU=; b=N3HUZSqwG28md5
	nonnpx3TqT8l0ddXzqhSz5rfaTL670+p0qbMw5wqrft21VAmu8FNFuZ9FBUBnsyfB4Aa3EalAdWg2
	+MN6Kuv2HXEzssvOwnywQhnXhd5/r6QVGM52+F3tec+SAkNgbEWqeORJUSI/Pvk5eE1PUItsvzxlI
	0XQUkRkbiO41FCEs31PPH/Xz0BP3D7vwHQN+fjC5IdEpiYKvO7lbBJisbxVKyT3+5zQM1D2HL1UFt
	K/2/I4gZHMoJfmvLADNiAzAEd8/YUdmh1b8V16hgstBIEAf6Dpg5TS7dAWlAk/jUqTTk419WUT4UF
	Tm/PLav7wcSUMmFsWocg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4JC7-00EKvh-Kc; Thu, 23 Jun 2022 09:32:11 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4JC1-00EKu2-Pq
	for kexec@lists.infradead.org; Thu, 23 Jun 2022 09:32:07 +0000
Date: Thu, 23 Jun 2022 11:31:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1655976713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdy+QUhPkvFcFC80rvjevTMJhfdSl1qbxeO2CTdvv58=;
	b=NEhmq8viQ72FOh+cau9QybpV1lZZv76F0Y0skF4OQ3K33zgzmjPISWBUw8wZ8ejYmmzZtJ
	Za/VxomJ8D0EbRmyHsp9iIgo5KJtEtw8W01lx6LJFRXY7qpRtQEeftXKQrJEcY8hZzGlao
	KFURtbeaNG/jIDaSC6pLEds9Sjs2tQ+rHR0NN2Ab4xtI0Y5BCzxPZgxN0ZT2FcYK9XAvq7
	gSwZLLW3g90EflW0hduk0fFEQjhbAh7nK+ixMY00pRCxuxyhm4XqHCAREYUSI49F4mfXAT
	T+c1qZC3PMNYcahuSC2DpV5oXODqczdVooKzp4pXQI/smcHSisXnnjHwclyScw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1655976713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdy+QUhPkvFcFC80rvjevTMJhfdSl1qbxeO2CTdvv58=;
	b=1tpp+G+oSQjiwNGLj9aUmHGzkXlmunN6sB7hmmrXtf56s+eH5ZchYT6PhUcvWW8snWnOb/
	i9anyEfJ1+O1mHDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-rt-users@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
Message-ID: <YrQzB7sPD8BNxSFq@linutronix.de>
References: <20220620111520.1039685-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220620111520.1039685-1-vschneid@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_023206_016423_97E83A2D 
X-CRM114-Status: GOOD (  10.19  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gMjAyMi0wNi0yMCAxMjoxNToyMCBbKzAxMDBdLCBWYWxlbnRpbiBTY2huZWlkZXIgd3JvdGU6
Cj4gQXR0ZW1wdGluZyB0byBnZXQgYSBjcmFzaCBkdW1wIG91dCBvZiBhIGRlYnVnIFBSRUVNUFRf
UlQga2VybmVsIHZpYSBhbiBOTUkKPiBwYW5pYygpIGRvZXNuJ3Qgd29yay4gVGhlIGNhdXNlIG9m
IHRoYXQgbGllcyBpbiB0aGUgUFJFRU1QVF9SVCBkZWZpbml0aW9uCj4gb2YgbXV0ZXhfdHJ5bG9j
aygpOgo+IArigKYKCj4gRml4ZXM6IDZjZTQ3ZmQ5NjFmYSAoInJ0bXV0ZXg6IFdhcm4gaWYgdHJ5
bG9jayBpcyBjYWxsZWQgZnJvbSBoYXJkL3NvZnRpcnEgY29udGV4dCIpCj4gU2lnbmVkLW9mZi1i
eTogVmFsZW50aW4gU2NobmVpZGVyIDx2c2NobmVpZEByZWRoYXQuY29tPgoKUmV2aWV3ZWQtYnk6
IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25peC5kZT4KCj4gLS0t
Cj4gdjEgLT4gdjIKPiArKysrKysrKwo+IAo+IG8gQ2hhbmdlZCBmcm9tIFBldGVyc29uLWxpa2Ug
c3luY2hyb25pemF0aW9uIHRvIHNpbXBsZXIgYXRvbWljX2NtcHhjaGcKPiAgIChQZXRyKQo+IG8g
U2xpZ2h0bHkgcmV3b3JkZWQgY2hhbmdlbG9nCj4gbyBBZGRlZCBGaXhlczogdGFnLiBUZWNobmlj
YWxseSBzaG91bGQgYmUgdXAgdG8gc2luY2Uga2V4ZWMgY2FuIGhhcHBlbgo+ICAgaW4gYW4gTk1J
LCBidXQgdGhhdCBpc24ndCBzdWNoIGEgY2xlYXIgdGFyZ2V0CgpSVC13aXNlIGl0IHdvdWxkIGJl
IG5lZWRlZCBmb3IgZWFjaCByZWxlYXNlLgpUaGVyZSBpcyBhbHNvIGEgbXV0ZXhfdW5sb2NrKCkg
aW4gY2FzZSBhbiBpbWFnZSBpcyBtaXNzaW5nLiBUaGlzIGNhbiBnbwp2aWEgdGhlIHNjaGVkdWxl
ciBpZiB0aGVyZSBpcyBhIHdhaXRlciB3aGljaCBkb2VzIG5vdCBsb29rIGdvb2Qgd2l0aCB0aGUK
Tk1JIGluIHRoZSBwaWN0dXJlLgoKU2ViYXN0aWFuCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
