Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2903BC2BB3F
	for <kexec@archiver.kernel.org>; Wed, 15 Nov 2023 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xnvWnw9oXDQ5itxRkOljgnMGQIWehOjeXC/ZxnL5l28=; b=XzZhpl/bWcR6Wq
	JqKMoVuuv48t49HhEGUw/i4wWUuSHvnGRQ2PhfyMAxnkKbmkZROJh9mmzconMedXd6IdDOImeOVS8
	8HEjtdLAu8OP72wey5Bg0Yss4lHVe2MjfFck+nchcq+sMAMSxXLgEJdbULV1BhqJnSvaHUisJ6poi
	mTDq1X6l5YWjuaoKO/9L9i1fYdSGzRp4GVOc9iNvPslongp7yRh/phIBnugGsnyM0odkMJKm1GV3g
	kmqm7k5GsCTWUr2Mk1RaMaeHGmoBlvreHrsq4xfnQ3fbKtSdEK59aTfrpYLIC+NnaebZrqUgad9Ar
	Jm75+vNFY+qcRq78oo4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3OOv-001sA1-10;
	Wed, 15 Nov 2023 22:30:25 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3OOq-001s8Z-2C
	for kexec@lists.infradead.org;
	Wed, 15 Nov 2023 22:30:23 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6E7E120B74C1;
	Wed, 15 Nov 2023 14:30:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E7E120B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700087410;
	bh=9kuRbTwEDCnlaY4fWGmVEgvxMIwpPB2ZxeKvyy6LxSA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=lPS9XATtwFy0vuS7v7XHb+DOXMixr5FEczdQU1OQLUAMqYgpPHRrRjje/JbRDEXLT
	 JFTR4hPhjP9E/G/aEgkr01lKGxFE6qNQUPF8uc4VJxFEhn/RZPI+tIr4BszXfb2C8v
	 kh7tWmo0foWemsuxmUDPp8vHbmaAFubHZgD6BYZw=
Message-ID: <0263e2b0-6d61-4778-ad89-8fa01fd8034d@linux.microsoft.com>
Date: Wed, 15 Nov 2023 14:30:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] ima: move ima_dump_measurement_list call from
 kexec load to execute
Content-Language: en-US
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-3-tusharsu@linux.microsoft.com>
 <989af3e9a8621f57643b67b717d9a39fdb2ffe24.camel@linux.ibm.com>
 <57c97b4f-8489-4cac-8014-c16e4af8fcfc@linux.microsoft.com>
In-Reply-To: <57c97b4f-8489-4cac-8014-c16e4af8fcfc@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_143020_803421_952A14E7 
X-CRM114-Status: UNSURE (   9.68  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CgpPbiAxMS8xNC8yMyAxNDo0MywgVHVzaGFyIFN1Z2FuZGhpIHdyb3RlOgo+IAo+IEluIGFkZGl0
aW9uLCB0aGlzIHBhdGNoIG1vdmVzIHRoZSBmdW5jdGlvbiBpbWFfZHVtcF9tZWFzdXJlbWVudF9s
aXN0KCkKPiB0byBhIG5ldyBmdW5jdGlvbiBuYW1lZCBpbWFfdXBkYXRlX2tleGVjX2J1ZmZlcigp
LCB3aGljaCBpcyBuZXZlcgo+IGNhbGxlZC7CoMKgIFRoZSBwYXRjaCBzZXQgaXMgdGh1cyBub3Qg
YmlzZWN0IHNhZmUuCgpCVFcsIGltYV91cGRhdGVfa2V4ZWNfYnVmZmVyKCkgaXMgcGFydCBvZiB0
aGUgbm90aWZpZXJfYmxvY2suCndoaWNoIGlzIHBhcnQgb2YgdGhlIHNhbWUgcGF0Y2ggMi83LgoK
K3N0cnVjdCBub3RpZmllcl9ibG9jayB1cGRhdGVfYnVmZmVyX25iID0geworCS5ub3RpZmllcl9j
YWxsID0gaW1hX3VwZGF0ZV9rZXhlY19idWZmZXIsCit9OworCgp1cGRhdGVfYnVmZmVyX25iIGlz
IGJlaW5nIHJlZ2lzdGVyZWQgdG8gdGhlIHJlYm9vdCBub3RpZmllcnMgaW4gcGF0Y2gKMy83IG9m
IHRoaXMgc2VyaWVzLgoKU28gaW1hX3VwZGF0ZV9rZXhlY19idWZmZXIoKSBpcyBiZWluZyBjYWxs
ZWQuCgordm9pZCBpbWFfa2V4ZWNfcG9zdF9sb2FkKHN0cnVjdCBraW1hZ2UgKmltYWdlKQorewou
Li4KLi4uCisKKwlpZiAoIWltYV9rZXhlY191cGRhdGVfcmVnaXN0ZXJlZCkgeworCQlyZWdpc3Rl
cl9yZWJvb3Rfbm90aWZpZXIoJnVwZGF0ZV9idWZmZXJfbmIpOworCQlpbWFfa2V4ZWNfdXBkYXRl
X3JlZ2lzdGVyZWQgPSB0cnVlOworCX0KK30KCk1heWJlIHlvdSBtZWFudCAndXBkYXRlX2J1ZmZl
cl9uYicgdmFyaWFibGUgbmVlZHMgdG8gYmUgZGVmaW5lZCBhbmQgdXNlZAppbiB0aGUgc2FtZSBw
YXRjaCBhbmQgbm90IGRlZmluZWQgaW4gMi83IGFuZCB1c2VkIGluIDMvNy4KCkFueXdheXMsIEkg
dGhpbmsgSSB0b29rIGNhcmUgb2YgdGhlIG1ham9yaXR5IG9mIHRoZSBiaXNlY3Qtc2FmZSBpc3N1
ZXMgCmZyb20gVjEtPlYyIG9mIHRoaXMgc2VyaWVzLiAgQnV0IG1heWJlIEkgbWlzc2VkIGEgZmV3
LiBJIHdpbGwgbG9vayBhdAp0aGlzIHdpdGggZnJlc2ggcGVyc3BlY3RpdmUsIHRvIHNlZSBpZiBJ
IG1pc3NlZCBhbnl0aGluZywgd2hlbiBJIHB1Ymxpc2gKVjMgb2YgdGhlIHNlcmllcy4KClRoYW5r
cywKVHVzaGFyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
