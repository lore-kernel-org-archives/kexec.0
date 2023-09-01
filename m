Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E323CA0FF6
	for <kexec@archiver.kernel.org>; Fri,  1 Sep 2023 21:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v3HRJzm+My2V4fXb3BJTJed6phXz0lTP29ymZ2s19fo=; b=E/LBTaFSC//z5k
	6P+Phns9hsbDfH0zFZyuV52NM+vQ8KIDod55okvomO2ai+Uiu4s7Wu7aD/r9xkbL+CY6DHQxXJtCF
	QQRPuMJRCNFOq3a7Q/R6uYD0maJLPhTqo9yc2L/nuh1w9JcbdxCoyMdVB5Z7nZna1maEgHLYtXLVh
	UUJXO86FZZ0WSFN3vSAjUKtbQimAUFBiPhXkGzwG2JzSkQvDM3E2/NPKFf4biVLBjBdqPd6ykYPMo
	rQZFm8CceOh8LZIUU0kv4yMSpOxJQ2uJHteqDASgf2MJyxPFG3p0elembuqag8pJ4K7wI3LSBWlNP
	iw7yVTeNFGTexfBJV4wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qcBbI-000PTM-1G;
	Fri, 01 Sep 2023 21:22:44 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qcBbG-000PSx-1o
	for kexec@lists.infradead.org;
	Fri, 01 Sep 2023 21:22:43 +0000
Received: from [192.168.86.41] (unknown [50.46.242.41])
	by linux.microsoft.com (Postfix) with ESMTPSA id 372E5212A780;
	Fri,  1 Sep 2023 14:22:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 372E5212A780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1693603360;
	bh=4JQjdrI292EM3uTRhuuRomABTjztaCmafSCbCythPpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j30XoI5vPo8T3nfJL9MN6kNFYCQB+CNeUOW2GiK0ojRnnmunk7GhuBXobWOux+4tY
	 UrKElmoYgxqVEpUtD9BTMfq9Rb2yO4xwZ/yTv3ysw/HPeL/0idV82XqbRGA0b6u9NH
	 E56ByYSPFK3sPcWXTOElRqwQziO0eL/LPhCEhmDQ=
Message-ID: <1d2b1df7-aabd-8a18-a564-24399b53f3d2@linux.microsoft.com>
Date: Fri, 1 Sep 2023 14:22:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - unseal
Content-Language: en-US
To: Ken Goldman <kgold@linux.ibm.com>,
 Sush Shringarputale <sushring@linux.microsoft.com>,
 linux-integrity@vger.kernel.org, zohar@linux.ibm.com, peterhuewe@gmx.de,
 jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
 Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com,
 linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <1ef45099-da24-b73f-b33f-6a299c0b1696@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <1ef45099-da24-b73f-b33f-6a299c0b1696@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_142242_626345_03330F85 
X-CRM114-Status: GOOD (  14.90  )
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

CgpPbiA4LzMwLzIzIDEyOjEyLCBLZW4gR29sZG1hbiB3cm90ZToKPiBPbiA4LzEvMjAyMyAzOjEy
IFBNLCBTdXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+IAo+PiBGb3IgcmVtb3RlIGF0dGVzdGF0
aW9uIHRvIHdvcmssIHRoZSBzZXJ2aWNlIHdpbGwgbmVlZCB0byBrbm93IGhvdyB0bwo+PiDCoHZh
bGlkYXRlIHRoZSBzbmFwc2hvdF9hZ2dyZWdhdGUgZW50cnkgaW4gdGhlIElNQSBsb2cuwqAgSXQg
d2lsbCBoYXZlCj4+IHRvIHJlYWQgdGhlIFBDUiB2YWx1ZXMgcHJlc2VudCBpbiB0aGUgdGVtcGxh
dGUgZGF0YSBvZgo+PiBzbmFwc2hvdF9hZ2dyZWdhdGUgZXZlbnQgaW4gdGhlIGxhdGVzdCBJTUEg
bG9nLCBhbmQgZW5zdXJlIHRoYXQgdGhlCj4+IFBDUiBxdW90ZXMgYWxpZ24gd2l0aCB0aGUgY29u
dGVudHMgb2YgdGhlIHBhc3QgVU1fc25hcHNob3RfZmlsZShzKS4KPj4gVGhpcyB3aWxsIHJlLWVz
dGFibGlzaCB0aGUgY2hhaW4gb2YgdHJ1c3QgbmVlZGVkIGZvciB0aGUgZGV2aWNlIHRvCj4+IHBh
c3MgcmVtb3RlIGF0dGVzdGF0aW9uLsKgIFRoaXMgd2lsbCBhbHNvIG1haW50YWluIHRoZSBhYmls
aXR5IG9mIHRoZQo+PiByZW1vdGUtYXR0ZXN0YXRpb24tc2VydmljZSB0byBzZWFsIHRoZSBzZWNy
ZXRzLCBpZiB0aGUgY2xpZW50LXNlcnZlcgo+PiDCoHVzZSBUUE0gdW5zZWFsIG1lY2hhbmlzbSB0
byBhdHRlc3QgdGhlIHN0YXRlIG9mIHRoZSBkZXZpY2UuCj4gCj4gSSB0aGluayB0aGF0IHNlYWwv
dW5zZWFsIHRvIElNQSBQQ1JzIGlzIGZ1dGlsZS7CoCBTaW5jZSBib290IGlzCj4gbXVsdGktdGhy
ZWFkZWQsIHRoZSBJTUEgUENSIGlzIHVucHJlZGljdGFibGUgZXZlbiB3aGVuIHZhbGlkLgoKVHJ1
ZS4gQnV0IGhlcmUgd2UgYXJlIHRhbGtpbmcgYWJvdXQgc2VhbC91bnNlYWwgcG9zdCBib290IHdo
ZW4gdGhlCmRldmljZSBpcyBpbiBhIHN0YWJsZSBzdGF0ZSwgYW5kIHRoZXJlIGFyZSByZWxhdGl2
ZWx5IGxlc3MgbnVtYmVyIG9mCmV2ZW50cyBleHRlbmRpbmcgSU1BIFBDUi4gVGhlIHZhbHVlIG9m
IHRoZSBhY3R1YWwgSU1BIFBDUiBkb2Vzbid0IG1hdHRlcgppbiB0aGlzIGNvbnRleHQgYXMgbG9u
ZyBhcyBpdCBzdGF5cyB0aGUgc2FtZSBiZXR3ZWVuIHNlYWwtdW5zZWFsIHdpbmRvdy4KCklmIGl0
IGNoYW5nZXMgYmV0d2VlbiB0aGF0IHdpbmRvdywgdGhlIGNsaWVudHMgdHlwaWNhbGx5IHJldHJ5
IGJ5CnNlbmRpbmcgdGhlIHJlcXVlc3QgdG8gdGhlIHNlcnZpY2Ugd2l0aCBhIG5ldyBzdGFibGUg
UENSLgoKU2VhbC11bnNlYWwgaXMgc3VwcG9ydGVkIGJ5IFRQTSBzcGVjLCBhbmQgaXMgdXNlZCB3
aWRlbHkuIFNvIHdlIGhhZCB0bwplbnN1cmUgdGhhdCBvdXIgcHJvcG9zZWQgZGVzaWduIHdvdWxk
bid0IHJlZ3Jlc3MgdGhpcyBleGlzdGluZwpmdW5jdGlvbmFsaXR5LgoKflR1c2hhcgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
