Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C77DD1039A
	for <kexec@archiver.kernel.org>; Fri, 25 Oct 2024 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Z6At/uishSMjnIXIWeEVH3NU7mXrbKsW5nh8TgbhjRY=; b=X2F9N7e4MKr4yR
	OseD04W5h4bep539RgvSIaZ44sy3I6BHyBqRxlI7H0ZJxLWgy60drdgJi9xM42ulkaHxvcG3UOCS+
	UHhVePnhOuXqmnp1zo6Pmdw1vec/gQBhuZu6Ks/cDXJM1zv7Qzi0y1BUsTeQMHIuSdvmTnGWTag0G
	ml8tAFZNEOafbG7TlmlI4egpjFJ17UZPLhz24Pz2yOHztC7Q0id37mot1zmW8ClcsdvJMIQqXhUfL
	7kmvHgwUFC9SOD3/6YcYp7n5rWhbB2QeNrInzS89n49QOLrBobrOn1wnC+j2Vd8UaRyL3CYjKpIDV
	qXUmMNNINk4C8Lbvmquw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MLQ-00000004GPy-19VJ;
	Fri, 25 Oct 2024 15:35:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Lyi-00000004AYK-2QvD
	for kexec@lists.infradead.org;
	Fri, 25 Oct 2024 15:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729869110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QjXxCmbGyjt3cTdnXge0Xs0ObzNL+3C4WmSnlfC/eHc=;
	b=dewpe2RAQYnz0Mr+DRx61PXHf+8uJAnef7yw5VteXzzMT84JiQf6i5j4xkbuVhSqPfwVjk
	CSGRcnqKgBV7dO+3CNn+c5ZMePMnKN3kQhGjGgFCTg+XzYRm6blCgZOA2/6flCb6LMvvbW
	uvk89y0Hxk+B/J1ViCm2yB9p9VVgVu0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-ADxDlDjTM6qViV2-qHlzTA-1; Fri,
 25 Oct 2024 11:11:47 -0400
X-MC-Unique: ADxDlDjTM6qViV2-qHlzTA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF56C1955E85;
	Fri, 25 Oct 2024 15:11:44 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45618300018D;
	Fri, 25 Oct 2024 15:11:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 00/11] fs/proc/vmcore: kdump support for virtio-mem on s390
Date: Fri, 25 Oct 2024 17:11:22 +0200
Message-ID: <20241025151134.1275575-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_081152_797704_5A6AF0C4 
X-CRM114-Status: GOOD (  20.62  )
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

VGhpcyBpcyBiYXNlZCBvbiAiW1BBVENIIHYzIDAvN10gdmlydGlvLW1lbTogczM5MCBzdXBwb3J0
IiBbMV0sIHdoaWNoIGFkZHMKdmlydGlvLW1lbSBzdXBwb3J0IG9uIHMzOTAuCgpUaGUgb25seSAi
ZGlmZmVyZW50IHRoYW4gZXZlcnl0aGluZyBlbHNlIiB0aGluZyBhYm91dCB2aXJ0aW8tbWVtIG9u
IHMzOTAKaXMga2R1bXA6IFRoZSBjcmFzaCAoMm5kKSBrZXJuZWwgYWxsb2NhdGVzK3ByZXBhcmVz
IHRoZSBlbGZjb3JlIGhkcgpkdXJpbmcgZnNfaW5pdCgpLT52bWNvcmVfaW5pdCgpLT5lbGZjb3Jl
aGRyX2FsbG9jKCkuIENvbnNlcXVlbnRseSwgdGhlCmNyYXNoIGtlcm5lbCBtdXN0IGRldGVjdCBt
ZW1vcnkgcmFuZ2VzIG9mIHRoZSBjcmFzaGVkL3Bhbmlja2VkIGtlcm5lbCB0bwppbmNsdWRlIHZp
YSBQVF9MT0FEIGluIHRoZSB2bWNvcmUuCgpPbiBvdGhlciBhcmNoaXRlY3R1cmVzLCBhbGwgUkFN
IHJlZ2lvbnMgKGJvb3QgKyBob3RwbHVnZ2VkKSBjYW4gZWFzaWx5IGJlCm9ic2VydmVkIG9uIHRo
ZSBvbGQgKHRvIGNyYXNoKSBrZXJuZWwgKGUuZy4sIHVzaW5nIC9wcm9jL2lvbWVtKSB0byBjcmVh
dGUKdGhlIGVsZmNvcmUgaGRyLgoKT24gczM5MCwgaW5mb3JtYXRpb24gYWJvdXQgIm9yZGluYXJ5
IiBtZW1vcnkgKGhlaCwgInN0b3JhZ2UiKSBjYW4gYmUKb2J0YWluZWQgYnkgcXVlcnlpbmcgdGhl
IGh5cGVydmlzb3IvdWx0cmF2aXNvciB2aWEgU0NMUC9kaWFnMjYwLCBhbmQKdGhhdCBpbmZvcm1h
dGlvbiBpcyBzdG9yZWQgZWFybHkgZHVyaW5nIGJvb3QgaW4gdGhlICJwaHlzbWVtIiBtZW1ibG9j
awpkYXRhIHN0cnVjdHVyZS4KCkJ1dCB2aXJ0aW8tbWVtIG1lbW9yeSBpcyBhbHdheXMgZGV0ZWN0
ZWQgYnkgYXMgZGV2aWNlIGRyaXZlciwgd2hpY2ggaXMKdXN1YWxseSBidWlsZCBhcyBhIG1vZHVs
ZS4gU28gaW4gdGhlIGNyYXNoIGtlcm5lbCwgdGhpcyBtZW1vcnkgY2FuIG9ubHkgYmUKcHJvcGVy
bHkgZGV0ZWN0ZWQgb25jZSB0aGUgdmlydGlvLW1lbSBkcml2ZXIgc3RhcnRlZCB1cC4KClRoZSB2
aXJ0aW8tbWVtIGRyaXZlciBhbHJlYWR5IHN1cHBvcnRzIHRoZSAia2R1bXAgbW9kZSIsIHdoZXJl
IGl0IHdvbid0CmhvdHBsdWcgYW55IG1lbW9yeSBidXQgaW5zdGVhZCBxdWVyaWVzIHRoZSBkZXZp
Y2UgdG8gaW1wbGVtZW50IHRoZQpwZm5faXNfcmFtKCkgY2FsbGJhY2ssIHRvIGF2b2lkIHJlYWRp
bmcgdW5wbHVnZ2VkIG1lbW9yeSBob2xlcyB3aGVuIHJlYWRpbmcKdGhlIHZtY29yZS4KCldpdGgg
dGhpcyBzZXJpZXMsIGlmIHRoZSB2aXJ0aW8tbWVtIGRyaXZlciBpcyBpbmNsdWRlZCBpbiB0aGUg
a2R1bXAKaW5pdHJkIC0tIHdoaWNoIGRyYWN1dCBhbHJlYWR5IHRha2VzIGNhcmUgb2YgdW5kZXIg
RmVkb3JhL1JIRUwgLS0gaXQgd2lsbApub3cgZGV0ZWN0IHRoZSBkZXZpY2UgUkFNIHJhbmdlcyBv
biBzMzkwIG9uY2UgaXQgcHJvYmVzIHRoZSBkZXZpY2VzLCB0byBhZGQKdGhlbSB0byB0aGUgdm1j
b3JlIHVzaW5nIHRoZSBzYW1lIGNhbGxiYWNrIG1lY2hhbmlzbSB3ZSBhbHJlYWR5IGhhdmUgZm9y
CnBmbl9pc19yYW0oKS4KClRvIGFkZCB0aGVzZSBkZXZpY2UgUkFNIHJhbmdlcyB0byB0aGUgdm1j
b3JlICgicGF0Y2ggdGhlIHZtY29yZSIpLCB3ZSB3aWxsCmFkZCBuZXcgUFRfTE9BRCBlbnRyaWVz
IHRoYXQgZGVzY3JpYmUgdGhlc2UgbWVtb3J5IHJhbmdlcywgYW5kIHVwZGF0ZQphbGwgb2Zmc2V0
cyB2bWNvcmUgc2l6ZSBzbyBpdCBpcyBhbGwgY29uc2lzdGVudC4KCk5vdGUgdGhhdCBtYWtlZHVt
ZmlsZSBpcyBzaGFreSB3aXRoIHY2LjEyLXJjWCwgSSBtYWRlIHRoZSAib2J2aW91cyIgdGhpbmdz
CihlLmcuLCBmcmVlIHBhZ2UgZGV0ZWN0aW9uKSB3b3JrIGFnYWluIHdoaWxlIHRlc3RpbmcgYXMg
ZG9jdW1lbnRlZCBpbiBbMl0uCgpDcmVhdGluZyB0aGUgZHVtcHMgdXNpbmcgbWFrZWR1bXBmaWxl
IHNlZW1zIHRvIHdvcmsgZmluZSwgYW5kIHRoZQpkdW1wIHJlZ2lvbnMgKFBUX0xPQUQpIGFyZSBh
cyBleHBlY3RlZC4gSSB5ZXQgaGF2ZSB0byBjaGVjayBpbiBtb3JlIGRldGFpbAppZiB0aGUgY3Jl
YXRlZCBkdW1wcyBhcmUgZ29vZCAoSU9XLCB0aGUgcmlnaHQgbWVtb3J5IHdhcyBkdW1wZWQsIGJ1
dCBpdApsb29rcyBsaWtlIG1ha2VkdW1wZmlsZSByZWFkcyB0aGUgcmlnaHQgbWVtb3J5IHdoZW4g
aW50ZXJwcmV0aW5nIHRoZQprZXJuZWwgZGF0YSBzdHJ1Y3R1cmVzLCB3aGljaCBpcyBwcm9taXNp
bmcpLgoKUGF0Y2ggIzEgLS0gIzYgYXJlIHZtY29yZSBwcmVwYXJhdGlvbnMgYW5kIGNsZWFudXBz
ClBhdGNoICM3IGFkZHMgdGhlIGluZnJhc3RydWN0dXJlIGZvciBkcml2ZXJzIHRvIHJlcG9ydCBk
ZXZpY2UgUkFNClBhdGNoICM4ICsgIzkgYXJlIHZpcnRpby1tZW0gcHJlcGFyYXRpb25zClBhdGNo
ICMxMCBpbXBsZW1lbnRzIHZpcnRpby1tZW0gc3VwcG9ydCB0byByZXBvcnQgZGV2aWNlIFJBTQpQ
YXRjaCAjMTEgYWN0aXZhdGVzIGl0IGZvciBzMzkwLCBpbXBsZW1lbnRpbmcgYSBuZXcgZnVuY3Rp
b24gdG8gZmlsbAogICAgICAgICAgUFRfTE9BRCBlbnRyeSBmb3IgZGV2aWNlIFJBTQoKWzFdIGh0
dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAyNDEwMjUxNDE0NTMuMTIxMDYwMC0xLWRhdmlkQHJl
ZGhhdC5jb20KWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9tYWtlZHVtcGZpbGUvbWFrZWR1bXBmaWxl
L2lzc3Vlcy8xNgoKQ2M6IEhlaWtvIENhcnN0ZW5zIDxoY2FAbGludXguaWJtLmNvbT4KQ2M6IFZh
c2lseSBHb3JiaWsgPGdvckBsaW51eC5pYm0uY29tPgpDYzogQWxleGFuZGVyIEdvcmRlZXYgPGFn
b3JkZWV2QGxpbnV4LmlibS5jb20+CkNjOiBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgPGJvcm50cmFl
Z2VyQGxpbnV4LmlibS5jb20+CkNjOiBTdmVuIFNjaG5lbGxlIDxzdmVuc0BsaW51eC5pYm0uY29t
PgpDYzogIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPgpDYzogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KQ2M6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+CkNjOiAiRXVnZW5pbyBQw6lyZXoiIDxlcGVyZXptYUByZWRoYXQuY29tPgpDYzog
QmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+CkNjOiBWaXZlayBHb3lhbCA8dmdveWFsQHJlZGhh
dC5jb20+CkNjOiBEYXZlIFlvdW5nIDxkeW91bmdAcmVkaGF0LmNvbT4KQ2M6IFRob21hcyBIdXRo
IDx0aHV0aEByZWRoYXQuY29tPgpDYzogQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+
CkNjOiBKYW5vc2NoIEZyYW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+CkNjOiBDbGF1ZGlvIElt
YnJlbmRhIDxpbWJyZW5kYUBsaW51eC5pYm0uY29tPgpDYzogRXJpYyBGYXJtYW4gPGZhcm1hbkBs
aW51eC5pYm0uY29tPgpDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9y
Zz4KCkRhdmlkIEhpbGRlbmJyYW5kICgxMSk6CiAgZnMvcHJvYy92bWNvcmU6IGNvbnZlcnQgdm1j
b3JlX2NiX2xvY2sgaW50byB2bWNvcmVfbXV0ZXgKICBmcy9wcm9jL3ZtY29yZTogcmVwbGFjZSB2
bWNvcmVkZF9tdXRleCBieSB2bWNvcmVfbXV0ZXgKICBmcy9wcm9jL3ZtY29yZTogZGlzYWxsb3cg
dm1jb3JlIG1vZGlmaWNhdGlvbnMgYWZ0ZXIgdGhlIHZtY29yZSB3YXMKICAgIG9wZW5lZAogIGZz
L3Byb2Mvdm1jb3JlOiBtb3ZlIHZtY29yZSBkZWZpbml0aW9ucyBmcm9tIGtjb3JlLmggdG8gY3Jh
c2hfZHVtcC5oCiAgZnMvcHJvYy92bWNvcmU6IGZhY3RvciBvdXQgYWxsb2NhdGluZyBhIHZtY29y
ZSBtZW1vcnkgbm9kZQogIGZzL3Byb2Mvdm1jb3JlOiBmYWN0b3Igb3V0IGZyZWVpbmcgYSBsaXN0
IG9mIHZtY29yZSByYW5nZXMKICBmcy9wcm9jL3ZtY29yZTogaW50cm9kdWNlIFBST0NfVk1DT1JF
X0RFVklDRV9SQU0gdG8gZGV0ZWN0IGRldmljZSBSQU0KICAgIHJhbmdlcyBpbiAybmQga2VybmVs
CiAgdmlydGlvLW1lbTogbWFyayBkZXZpY2UgcmVhZHkgYmVmb3JlIHJlZ2lzdGVyaW5nIGNhbGxi
YWNrcyBpbiBrZHVtcAogICAgbW9kZQogIHZpcnRpby1tZW06IHJlbWVtYmVyIHVzYWJsZSByZWdp
b24gc2l6ZQogIHZpcnRpby1tZW06IHN1cHBvcnQgQ09ORklHX1BST0NfVk1DT1JFX0RFVklDRV9S
QU0KICBzMzkwL2tkdW1wOiB2aXJ0aW8tbWVtIGtkdW1wIHN1cHBvcnQgKENPTkZJR19QUk9DX1ZN
Q09SRV9ERVZJQ0VfUkFNKQoKIGFyY2gvczM5MC9LY29uZmlnICAgICAgICAgICAgIHwgICAxICsK
IGFyY2gvczM5MC9rZXJuZWwvY3Jhc2hfZHVtcC5jIHwgIDM5ICsrKy0tCiBkcml2ZXJzL3ZpcnRp
by9LY29uZmlnICAgICAgICB8ICAgMSArCiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fbWVtLmMgICB8
IDEwMyArKysrKysrKysrKysrLQogZnMvcHJvYy9LY29uZmlnICAgICAgICAgICAgICAgfCAgMjUg
KysrKwogZnMvcHJvYy92bWNvcmUuYyAgICAgICAgICAgICAgfCAyNTggKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLQogaW5jbHVkZS9saW51eC9jcmFzaF9kdW1wLmggICAgfCAgNDcg
KysrKysrKwogaW5jbHVkZS9saW51eC9rY29yZS5oICAgICAgICAgfCAgMTMgLS0KIDggZmlsZXMg
Y2hhbmdlZCwgMzk2IGluc2VydGlvbnMoKyksIDkxIGRlbGV0aW9ucygtKQoKLS0gCjIuNDYuMQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
