Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675E4C54E71
	for <kexec@archiver.kernel.org>; Fri, 22 Mar 2024 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gAxCCmNmbRwR/ypQspUmKjtJYnYaXGcCn67P+JoB8/I=; b=TymClSAXb+iaZx
	rh+hWUGP86Sz4mMbMUD5GhZ+2HapQIlUrgkWs0txexD7q97OEylE04wjGe23bjamuuOD4C+6aU1IH
	iuBndfjLWpCXWEuWuzjWWdWV9ofZGHTln7j87pv+a8VCpYtHL8M1gzM/nGJFqOF7MexeWwB/lVAJH
	U0xGxaf3duQNm4kG3BK7umpBevQSDCHqDSu3fnv7sbTNnt+ljwtGX/0eBg/74wK132YdRPKAb5TBR
	eNbRWsKiUnr1YNNyrEHHBEKwdzuZlX4uIc1/Pv+k4O/zcAAsAHDM6ag1IyXJl0gz4i7siRdq882Qf
	6d3q794d6790Nms4ABgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnm9N-00000008gHg-1wDA;
	Fri, 22 Mar 2024 21:10:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnm9K-00000008gGV-3Wpl
	for kexec@lists.infradead.org;
	Fri, 22 Mar 2024 21:10:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7519060ECF;
	Fri, 22 Mar 2024 21:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764BFC433C7;
	Fri, 22 Mar 2024 21:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711141801;
	bh=7yATw20Tyd8/PIFRUwUC5V36lD1BhBjeArxyRcGy3wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCS0R9PGsO6y58EcOjy6xJj3xos7SxAWn0iHi0k0HIGCnr8I82tcOd97aUndF9UTs
	 CYRVqsrDipVPHg2JPnO/X1dy+lPuypbfQiFjtbUh5VdiwY2QykWSv+lyEiXEEWDBh4
	 XYbOT4n0t2A4/1nys7o0cmDsVpM1C6+Nb1LeTNk9Dx7AFm4DoaYEFUUL3Uf46GhPLZ
	 zEvZtuHARGUkzZYLNItnH66cJ904jthYACR4Hm9/Wfl3+KkTpD5cVQle1y30ffbbU6
	 u0BJ1Ex/rMXoSoYe0WGIzipE4LYiBMv1iq8l130CFeJdeydedZfUsojB9zjMjOwmr9
	 JX+0+JbPtw6Sw==
Date: Fri, 22 Mar 2024 21:09:58 +0000
From: Simon Horman <horms@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] util_lib/elf_info.c: fix a warning
Message-ID: <20240322210958.GC387537@kernel.org>
References: <20240321073037.823696-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240321073037.823696-1-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_141002_945167_623E0FD6 
X-CRM114-Status: UNSURE (   9.07  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBNYXIgMjEsIDIwMjQgYXQgMDM6MzA6MzdQTSArMDgwMCwgQmFvcXVhbiBIZSB3cm90
ZToKPiBUaGVyZSdzIGEgaW5jb3JyZWN0IGFycmF5IG9wZXJhdGlvbiBpbiBmdW5jdGlvbiBzY2Fu
X3ZtY29yZWluZm8oKSwgaXQKPiB3aWxsIGNhdXNlIGJlbG93IHdhcm5pbmcgbWVzc2FnZS4KPiAK
PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IHV0aWxfbGliL2VsZl9pbmZvLmM6IEluIGZ1bmN0
aW9uIOKAmHNjYW5fdm1jb3JlaW5mb+KAmToKPiB1dGlsX2xpYi9lbGZfaW5mby5jOjM2MDo0Mzog
d2FybmluZzogd3JpdGluZyAxIGJ5dGUgaW50byBhIHJlZ2lvbiBvZiBzaXplIDAgWy1Xc3RyaW5n
b3Atb3ZlcmZsb3c9XQo+ICAgMzYwIHwgICAgICAgICAgICAgICAgICAgICAgICAgdGVtcF9idWZb
bGVuICsgMV0gPSAnXDAnOwo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+
fn5+fn5+fn5+fn5+Xn5+fn5+Cj4gdXRpbF9saWIvZWxmX2luZm8uYzozMTk6MTQ6IG5vdGU6IGF0
IG9mZnNldCAxMDI0IGludG8gZGVzdGluYXRpb24gb2JqZWN0IOKAmHRlbXBfYnVm4oCZIG9mIHNp
emUgMTAyNAo+ICAgMzE5IHwgICAgICAgICBjaGFyIHRlbXBfYnVmWzEwMjRdOwo+ICAgICAgIHwg
ICAgICAgICAgICAgIF5+fn5+fn5+Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gCj4gRml4IGl0
IHRvIGF2b2lkIG9vYiBhY2Nlc3Mgb2YgYXJyYXkuCj4gCj4gU2lnbmVkLW9mZi1ieTogQmFvcXVh
biBIZSA8YmhlQHJlZGhhdC5jb20+CgpUaGFua3MsIGFwcGxpZWQuCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
