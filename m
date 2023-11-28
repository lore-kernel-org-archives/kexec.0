Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83661C4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 03:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6MbLOGcM9+OEpsvGDlxGn+lDiRW0H0+QIYmpshzOzLE=; b=GI21XX8Ye/AlCJ
	o/fHVTsxbFT9jfixBdVkhUfJHhvGjhQ6i0v8zF0YeUPh73KABeo2VFpQuaann0xGPnu8LEx/k4iWw
	DU5kdhI6wvFC6BOIqRSdnBVSCiGXDuto+cF3DHxUFg/TV3n2kP9WoqSpJXsXu3Zhd59PIIVo5C+v9
	G0uL9nV4KK2jwIaEo0EIRJWzdC/4g5GFxFWqp+rZqvL12MjOddq21ru38tCFnQC3EJEpdSkjWSejf
	E5C+h439zSRDqFWMS0HNB+HmsXBuztM8xrlPPo13QNI5+t3IWJdgvZHk+JnpCHetNtU+pcReCiVrQ
	CByHue8dRwyXeC/tuYMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7ojo-003y89-0b;
	Tue, 28 Nov 2023 03:26:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7oji-003y7D-2O
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 03:26:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701141965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dymokLtc+Ixha61+4f7cZK1W1d0w612OLAA0dg5oPzE=;
	b=Jjse6EVS2OdQDb1IeF5l8VneYo888MVFVr94YjszNY4ZbeDY+fsS+D7itF/aSR2MkKb4Dw
	aTJn7pz2KN9cSWwWsAcApKIWQa4cdiO02GJ4vu+9R5mEbg8teZKR54BTpnc8IvWb3xFR4U
	1MGw+WzECbetZtQKMd6PCy//KzX1pXw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-WLJMPzMwPQKD8zSJIA65RQ-1; Mon, 27 Nov 2023 22:26:00 -0500
X-MC-Unique: WLJMPzMwPQKD8zSJIA65RQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5490485A5BD;
	Tue, 28 Nov 2023 03:26:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 64EDD1121307;
	Tue, 28 Nov 2023 03:25:59 +0000 (UTC)
Date: Tue, 28 Nov 2023 11:25:56 +0800
From: Baoquan He <bhe@redhat.com>
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, k-hagio-ab@nec.com,
	lijiang@redhat.com, akpm@linux-foundation.org, vgoyal@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
Message-ID: <ZWVdxAv/PPHY3Ndl@MiWiFi-R3L-srv>
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
 <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
 <33021b87-4c6a-45fc-a6ae-265765cfcd78@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33021b87-4c6a-45fc-a6ae-265765cfcd78@amperemail.onmicrosoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_192610_852155_57F15178 
X-CRM114-Status: GOOD (  17.10  )
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

T24gMTEvMjcvMjMgYXQgMTE6MThhbSwgU2hpamllIEh1YW5nIHdyb3RlOgo+IAo+IOWcqCAyMDIz
LzExLzI3IDEwOjUxLCBCYW9xdWFuIEhlIOWGmemBkzoKPiA+IEhpLAo+ID4gCj4gPiBPbiAxMS8y
Ny8yMyBhdCAxMDowN2FtLCBIdWFuZyBTaGlqaWUgd3JvdGU6Cj4gPiA+IEluIG1lbW9yeV9tb2Rl
bC5oLCBpZiBDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVAgaXMgY29uZmlnZWQsCj4gPiA+IGtlcm5l
bCB3aWxsIHVzZSB2bWVtbWFwIHRvIGRvIHRoZSBfX3Bmbl90b19wYWdlL3BhZ2VfdG9fcGZuLAo+
ID4gPiBhbmQga2VybmVsIHdpbGwgbm90IHVzZSB0aGUgImNsYXNzaWMgc3BhcnNlIiB0byBkbyB0
aGUKPiA+ID4gX19wZm5fdG9fcGFnZS9wYWdlX3RvX3Bmbi4KPiA+ID4gCj4gPiA+IFNvIGV4cG9y
dCB0aGUgdm1lbW1hcCB3aGVuIENPTkZJR19TUEFSU0VNRU1fVk1FTU1BUCBpcyBjb25maWdlZC4K
PiA+ID4gVGhpcyBtYWtlcyB0aGUgdXNlciBhcHBsaWNhdGlvbnMgKGNyYXNoLCBldGMpIGdldCBm
YXN0ZXIKPiA+ID4gcGZuX3RvX3BhZ2UvcGFnZV90b19wZm4gb3BlcmF0aW9ucyB0b28uCj4gPiBB
cmUgdGhlcmUgQ3Jhc2ggb3IgbWFrZWR1cGZpbGUgcGF0Y2hlcyBwb3N0ZWQgeWV0IHRvIG1ha2Ug
dXNlIG9mIHRoaXM/Cj4gCj4gSSBoYXZlIHBhdGNoZXMgZm9yIENyYXNoIHRvIHVzZSB0aGUgJ3Zt
ZW1tYXAnLCBidXQgYWZ0ZXIgdGhpcyBwYXRjaCBpcwo+IG1lcmdlZCwgSSB3aWxsIHNlbmQgaXQg
b3V0Lgo+IAo+IChJIHRoaW5rIEthenUgd2lsbCBub3QgbWVyZ2UgYSBjcmFzaCBwYXRjaCB3aGlj
aCBkZXBlbmRzIG9uIGEga2VybmVsIHBhdGNoCj4gd2hpY2ggaXMgbm90IG1lcmdlZC4pCgpNYXli
ZSBwb3N0IHRoZXNlIHVzZXJzcGFjZSBwYXRjaGVzIHRvbyBzbyB0aGF0IEthenUgY2FuIGV2YWx1
YXQgaWYgdGhvc2UKaW1wcm92ZW1lbnQgaXMgbmVjZXNzYXJ5PwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
