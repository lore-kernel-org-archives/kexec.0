Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D07C6FD1D
	for <kexec@archiver.kernel.org>; Fri,  7 Apr 2023 12:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WNktIcLR3P7/DQqB+PXMyxglhNQr/JqAFqfB8ODh9ig=; b=wzf32r96/pklvt
	Ph1897Ze9YTu9JGk/JepN1oujyO1iQTa8sIKQujorwCz+Gz0qiy+ibUZ0jix6iyD7rYrzt2L2zLyo
	13zPGoRsuN7B/061x+08n/Zr9halRQ4twJvX2YMeF+zjmmzEq23qVPD1dU7xQtCMbqb9EvwF6wBLa
	lMlxVki+DE1yYXzNyTfeiO/EIPMnU3GoH41jnVfMsAK7MhERqkw5rdK2oA4ZdgySzZPC4en1uuf9l
	5JGPSnZV/R0GobQEX3ls/Msy49A4xB9oaSK97XIaNkv/lGvH7ypRkAlOmlzMUPhKiwh9Yaps5b/UM
	tpIbzqYmU/+7/d9LTslQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkkp2-00A8eu-05;
	Fri, 07 Apr 2023 12:04:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkkox-00A8dy-1Z;
	Fri, 07 Apr 2023 12:04:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B67756100F;
	Fri,  7 Apr 2023 12:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B44C4339B;
	Fri,  7 Apr 2023 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680869038;
	bh=hj8WZn4fsaNVXzouph4VuJoSDtm/pAjQ+hGj5NXmwD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBXLq4fagWKRTewxo4p5y+yltMfue1gHv9h6Rhkf+kT90l5ObTPyf5Q+HxCMGQAsM
	 1WP18Sp/Ya3w+QiZ4Uku4/jcrSyIhhTDl6GoeWbpZfrxfYH144zC7BdFXcOmN3Bs8l
	 ixgsTZd59XKKamoXJiCD5OBzTnOMIL4T96AiI38v7Ttj3fY3eZPYH/jj8zcKKxqUjw
	 yZoR54HGahnG32BUoRdGl3XUEBDexCXzAufgslwOsGCS+z+ydlK/+dWroXXTzS6rYo
	 BzhTRRDstfoWaFx2kUjdCg3egxn1cf8mY8FaYa/WqcsUV2RCUa8bxxeEYIVS0jpejz
	 CO8A+lDkofXZw==
Date: Fri, 7 Apr 2023 14:03:52 +0200
From: Simon Horman <horms@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Chen Jiahao <chenjiahao16@huawei.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, heiko@sntech.de,
	bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
	atishp@rivosinc.com, bhe@redhat.com, thunder.leizhen@huawei.com
Subject: Re: [PATCH -next v3 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Message-ID: <ZDAGqL6CZGrL499u@kernel.org>
References: <20230406220206.3067006-1-chenjiahao16@huawei.com>
 <20230406220206.3067006-2-chenjiahao16@huawei.com>
 <CAJF2gTRtj=-XONv3cMZFd+qCtqUQqYZo5Lv7cgQbkGKTB0j7yg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJF2gTRtj=-XONv3cMZFd+qCtqUQqYZo5Lv7cgQbkGKTB0j7yg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_050359_581758_AFF5ACBD 
X-CRM114-Status: GOOD (  12.56  )
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

T24gRnJpLCBBcHIgMDcsIDIwMjMgYXQgMDU6MDY6MjRQTSArMDgwMCwgR3VvIFJlbiB3cm90ZToK
PiBPbiBUaHUsIEFwciA2LCAyMDIzIGF0IDEwOjA24oCvUE0gQ2hlbiBKaWFoYW8gPGNoZW5qaWFo
YW8xNkBodWF3ZWkuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiByaXNjdiwgdGhlIGN1cnJlbnQgY3Jh
c2gga2VybmVsIGFsbG9jYXRpb24gbG9naWMgaXMgdHJ5aW5nIHRvCj4gPiBhbGxvY2F0ZSB3aXRo
aW4gMzJiaXQgYWRkcmVzc2libGUgbWVtb3J5IHJlZ2lvbiBieSBkZWZhdWx0LCBpZgo+ID4gZmFp
bGVkLCB0cnkgdG8gYWxsb2NhdGUgd2l0aG91dCA0RyByZXN0cmljdGlvbi4KPiA+Cj4gPiBJbiBu
ZWVkIG9mIHNhdmluZyBETUEgem9uZSBtZW1vcnkgd2hpbGUgYWxsb2NhdGluZyBhIHJlbGF0aXZl
bHkgbGFyZ2UKPiA+IGNyYXNoIGtlcm5lbCByZWdpb24sIGFsbG9jYXRpbmcgdGhlIHJlc2VydmVk
IG1lbW9yeSB0b3AgZG93biBpbgo+ID4gaGlnaCBtZW1vcnksIHdpdGhvdXQgb3ZlcmxhcHBpbmcg
dGhlIERNQSB6b25lLCBpcyBhIG1hdHVyZSBzb2x1dGlvbi4KPiA+IEhlcmUgaW50cm9kdWNlIHRo
ZSBwYXJhbWV0ZXIgb3B0aW9uIGNyYXNoa2VybmVsPVgsW2hpZ2gsbG93XS4KPiA+Cj4gPiBPbmUg
Y2FuIHJlc2VydmUgdGhlIGNyYXNoIGtlcm5lbCBmcm9tIGhpZ2ggbWVtb3J5IGFib3ZlIERNQSB6
b25lIHJhbmdlCj4gPiBieSBleHBsaWNpdGx5IHBhc3NpbmcgImNyYXNoa2VybmVsPVgsaGlnaCI7
IG9yIHJlc2VydmUgYSBtZW1vcnkgcmFuZ2UKPiA+IGJlbG93IDRHIHdpdGggImNyYXNoa2VybmVs
PVgsbG93Ii4KPiBBc2tlZC1ieTogR3VvIFJlbiA8Z3VvcmVuQGtlcm5lbC5vcmc+CgpQZXJoYXBz
ICdBY2tlZC1ieScgOikKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
