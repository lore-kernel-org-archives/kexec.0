Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DBBC4167B
	for <kexec@archiver.kernel.org>; Thu, 30 Nov 2023 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6pa8rCgSQnyrLjBuueQtXxA+Zdhnv4mLUm7o1Br64Sg=; b=hyKFrmQWUmyTa2
	bCTKPgDlTNQE7E7O4uW45mYamOFG8ezBM2v4+nKRQhRkd9vzkmbFjHH9HYJET9dagHsIHWxOVBZby
	inofKLbzAYHxx/cHSPkxaiICvPa96MPwDmB1MR0BsymltxaqBmQ0pGTAuqmL1b/7rFuZheFOBm95l
	TgXp6/mSlungNzXOB2zeXotBxOyijLEtCipcRzIoWZw8zIAwEV5En89S7UMs1Y26RJzWeuna9Bj0z
	OtCP7pZBUXa9cuN1i+yh5MCG7z5pFWaj1dGKl5dJcif2NdYYqw2qZb0h1I+e5Z6eNbN6JYzbgWiAK
	Z+pqQi/HNZNmxFboQYPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8hK1-00Azdv-1W;
	Thu, 30 Nov 2023 13:43:17 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8hJw-00AzYF-0e
	for kexec@lists.infradead.org;
	Thu, 30 Nov 2023 13:43:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF6D021A3C;
	Thu, 30 Nov 2023 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701351789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0xXRK+aUL8cLCXEAdHHc8BYb0q+10UFV8/xhlNkfxo=;
	b=UqaGXeICW1+gaCJDa6EZhJWtlB4LY7R/CiHmE7gP5NDtbyhtrd5Q+id0DpmQy3PSdQXx3F
	YmKFs6lmIf1ejZKglsIKpWaF9FPWZ+VoI60WHgMFsIUDiTkTgPCdVjHECXhi50gel2Va4A
	8dRFvP2nKJJRJQPukyjxCPgNnS7KyJY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB59113AB1;
	Thu, 30 Nov 2023 13:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q5nTJm2RaGUKRAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 30 Nov 2023 13:43:09 +0000
Date: Thu, 30 Nov 2023 14:43:08 +0100
From: Michal Hocko <mhocko@suse.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Tao Liu <ltao@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWiRbLGdBMO2jFGs@tiehlicka>
References: <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiOO-KNJ82f6Gxu@tiehlicka>
 <CAF+s44QSJL5e6BVTAyyHR9Kzx7RJqZSkR=uXEypaouK_XuBbEw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF+s44QSJL5e6BVTAyyHR9Kzx7RJqZSkR=uXEypaouK_XuBbEw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_054312_407225_5C04B5D1 
X-CRM114-Status: GOOD (  40.42  )
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

T24gVGh1IDMwLTExLTIzIDIxOjMzOjA0LCBQaW5nZmFuIExpdSB3cm90ZToKPiBPbiBUaHUsIE5v
diAzMCwgMjAyMyBhdCA5OjI54oCvUE0gTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+IHdy
b3RlOgo+ID4KPiA+IE9uIFRodSAzMC0xMS0yMyAyMDowNDo1OSwgQmFvcXVhbiBIZSB3cm90ZToK
PiA+ID4gT24gMTEvMzAvMjMgYXQgMTE6MTZhbSwgTWljaGFsIEhvY2tvIHdyb3RlOgo+ID4gPiA+
IE9uIFRodSAzMC0xMS0yMyAxMTowMDo0OCwgQmFvcXVhbiBIZSB3cm90ZToKPiA+ID4gPiBbLi4u
XQo+ID4gPiA+ID4gTm93LCB3ZSBhcmUgd29ycmllZCBpZiB0aGVyZSdzIHJpc2sgaWYgdGhlIENN
QSBhcmVhIGlzIHJldGFrZW4gaW50byBrZHVtcAo+ID4gPiA+ID4ga2VybmVsIGFzIHN5c3RlbSBS
QU0uIEUuZyBpcyBpdCBwb3NzaWJsZSB0aGF0IDFzdCBrZXJuZWwncyBvbmdvaW5nIFJETUEKPiA+
ID4gPiA+IG9yIERNQSB3aWxsIGludGVyZmVyZSB3aXRoIGtkdW1wIGtlcm5lbCdzIG5vcm1hbCBt
ZW1vcnkgYWNjZXNzaW5nPwo+ID4gPiA+ID4gQmVjYXVzZSBrZHVtcCBrZXJuZWwgdXN1YWxseSBv
bmx5IHJlc2V0IGFuZCBpbml0aWFsaXplIHRoZSBuZWVkZWQKPiA+ID4gPiA+IGRldmljZSwgZS5n
IGR1bXAgdGFyZ2V0LiBUaG9zZSB1bm5lZWRlZCBkZXZpY2VzIHdpbGwgYmUgdW5zaHV0ZG93biBh
bmQKPiA+ID4gPiA+IGxldCBnby4KPiA+ID4gPgo+ID4gPiA+IEkgZG8gbm90IHJlYWxseSB3YW50
IHRvIGRpc2NvdW50IHlvdXIgY29uY2VybnMgYnV0IEkgYW0gYml0IGNvbmZ1c2VkIHdoeQo+ID4g
PiA+IHRoaXMgbWF0dGVycyBzbyBtdWNoLiBGaXJzdCBvZiBhbGwsIGlmIHRoZXJlIGlzIGEgYnVn
Z3kgUkRNQSBkcml2ZXIKPiA+ID4gPiB3aGljaCBkb2Vzbid0IHVzZSB0aGUgcHJvcGVyIHBpbm5p
bmcgQVBJICh3aGljaCB3b3VsZCBtaWdyYXRlIGF3YXkgZnJvbQo+ID4gPiA+IHRoZSBDTUEpIHRo
ZW4gd2hhdCBpcyB0aGUgd29yc3QgY2FzZT8gV2Ugd2lsbCBnZXQgY3Jhc2gga2VybmVsIGNvcnJ1
cHRlZAo+ID4gPiA+IHBvdGVudGlhbGx5IGFuZCBmYWlsIHRvIHRha2UgYSBwcm9wZXIga2VybmVs
IGNyYXNoLCByaWdodD8gSXMgdGhpcwo+ID4gPiA+IHdvcnJpc29tZT8gWWVzLiBJcyBpdCBhIHJl
YWwgcm9hZGJsb2NrPyBJIGRvIG5vdCB0aGluayBzby4gVGhlIHByb2JsZW0KPiA+ID4gPiBzZWVt
cyB0aGVvcmV0aWNhbCB0byBtZSBhbmQgaXQgaXMgbm90IENNQSB1c2FnZSBhdCBmYXVsdCBoZXJl
IElNSE8uIEl0Cj4gPiA+ID4gaXMgdGhlIHNhaWQgdGhlb3JldGljYWwgZHJpdmVyIHRoYXQgbmVl
ZHMgZml4aW5nIGFueXdheS4KPiA+ID4gPgo+ID4gPiA+IE5vdywgaXQgaXMgcmVhbGx5IGZhaXIg
dG8gbWVudGlvbiB0aGF0IENNQSBiYWNrZWQgY3Jhc2gga2VybmVsIG1lbW9yeQo+ID4gPiA+IGhh
cyBzb21lIGxpbWl0YXRpb25zCj4gPiA+ID4gICAgIC0gQ01BIHJlc2VydmF0aW9uIGNhbiBvbmx5
IGJlIHVzZWQgYnkgdGhlIHVzZXJzcGFjZSBpbiB0aGUKPiA+ID4gPiAgICAgICBwcmltYXJ5IGtl
cm5lbC4gSWYgdGhlIHNpemUgaXMgb3ZlcnNob3QgdGhpcyBtaWdodCBoYXZlCj4gPiA+ID4gICAg
ICAgbmVnYXRpdmUgaW1wYWN0IG9uIGtlcm5lbCBhbGxvY2F0aW9ucwo+ID4gPiA+ICAgICAtIHVz
ZXJzcGFjZSBtZW1vcnkgZHVtcGluZyBpbiB0aGUgY3Jhc2gga2VybmVsIGlzIGZ1bmRhbWVudGFs
bHkKPiA+ID4gPiAgICAgICBpbmNvbXBsZXRlLgo+ID4gPgo+ID4gPiBJIGFtIG5vdCBzdXJlIGlm
IHdlIGFyZSB0YWxraW5nIGFib3V0IHRoZSBzYW1lIHRoaW5nLiBNeSBjb25jZXJuIGlzOgo+ID4g
PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQo+ID4gPiAxKSBzeXN0ZW0gY29ycnV0cHRpb24gaGFwcGVuZWQsIGNyYXNo
IGR1bXBpbmcgaXMgcHJlcGFyZWQsIGNwdSBhbmQKPiA+ID4gaW50ZXJydXB0IGNvbnRyb2xsZXJz
IGFyZSBzaHV0ZG93bjsKPiA+ID4gMikgYWxsIHBjaSBkZXZpY2VzIGFyZSBrZXB0IGFsaXZlOwo+
ID4gPiAzKSBrZHVtcCBrZXJuZWwgYm9vdCB1cCwgaW5pdGlhbGl6YXRpb24gaXMgb25seSBkb25l
IG9uIHRob3NlIGRldmljZXMKPiA+ID4gd2hpY2ggZHJpdmVycyBhcmUgYWRkZWQgaW50byBrZHVt
cCBrZXJuZWwncyBpbml0cmQ7Cj4gPiA+IDQpIHRob3NlIG9uLWZsaWdodCBETUEgZW5naW5lIGNv
dWxkIGJlIHN0aWxsIHdvcmtpbmcgaWYgdGhlaXIga2VybmVsCj4gPiA+IG1vZHVsZSBpcyBub3Qg
bG9hZGVkOwo+ID4gPgo+ID4gPiBJbiB0aGlzIGNhc2UsIGlmIHRoZSBETUEncyBkZXN0aW5hdGlv
biBpcyBsb2NhdGVkIGluIGNyYXNoa2VybmVsPSxjbWEKPiA+ID4gcmVnaW9uLCB0aGUgRE1BIHdy
aXR0aW5nIGNvdWxkIGNvbnRpbnVlIGV2ZW4gd2hlbiBrZHVtcCBrZXJuZWwgaGFzIHB1dAo+ID4g
PiBpbXBvcnRhbnQga2VybmVsIGRhdGEgaW50byB0aGUgYXJlYS4gSXMgdGhpcyBwb3NzaWJsZSBv
ciBhYnNvbHV0ZWx5IG5vdAo+ID4gPiBwb3NzaWJsZSB3aXRoIERNQSwgUkRNQSwgb3IgYW55IG90
aGVyIHN0dWZmIHdoaWNoIGNvdWxkIGtlZXAgYWNjZXNzaW5nCj4gPiA+IHRoYXQgYXJlYT8KPiA+
Cj4gPiBJIGRvIG51ZGVyc3RhbmQgeW91ciBjb25jZXJuLiBCdXQgYXMgYWxyZWFkeSBzdGF0ZWQg
aWYgYW55Ym9keSB1c2VzCj4gPiBtb3ZhYmxlIG1lbW9yeSAoQ01BIGluY2x1ZGluZykgYXMgYSB0
YXJnZXQgb2Yge1J9RE1BIHRoZW4gdGhhdCBtZW1vcnkKPiA+IHNob3VsZCBiZSBwcm9wZXJseSBw
aW5uZWQuIFRoYXQgd291bGQgbWVhbiB0aGF0IHRoZSBtZW1vcnkgd2lsbCBiZQo+ID4gbWlncmF0
ZWQgdG8gc29tZXdoZXJlIG91dHNpZGUgb2YgbW92YWJsZSAoQ01BKSBtZW1vcnkgYmVmb3JlIHRo
ZQo+ID4gdHJhbnNmZXIgaXMgY29uZmlndXJlZC4gU28gbW9kdWxvIGJ1Z3MgdGhpcyBzaG91bGRu
J3QgcmVhbGx5IGhhcHBlbi4KPiA+IEFyZSB0aGVyZSB7Un1ETUEgZHJpdmVycyB0aGF0IGRvIG5v
dCBwaW4gbWVtb3J5IGNvcnJlY3RseT8gUG9zc2libHkuIElzCj4gPiB0aGF0IGEgcm9hZCBibG9h
Y2sgdG8gbm90IHVzaW5nIENNQSB0byBiYWNrIGNyYXNoIGtlcm5lbCBtZW1vcnksIEkgZG8KPiA+
IG5vdCB0aGluayBzby4gVGhvc2UgZHJpdmVycyBzaG91bGQgYmUgZml4ZWQgaW5zdGVhZC4KPiA+
Cj4gSSB0aGluayB0aGF0IGlzIG91ciBjb25jZXJuLiBJcyB0aGVyZSBhbnkgbWV0aG9kIHRvIGd1
YXJhbnRlZSB0aGF0Cj4gd2lsbCBub3QgaGFwcGVuIGluc3RlYWQgb2YgJ3Nob3VsZCBiZScgPwo+
IEFueSBzdGF0aWMgYW5hbHlzaXMgZHVyaW5nIGNvbXBpbGluZyB0aW1lIG9yIGR5bmFtaWMgY2hl
Y2tpbmcgbWV0aG9kPwoKSSBhbSBub3QgYXdhcmUgb2YgYW55IG1ldGhvZCB0byBkZXRlY3QgYSBk
cml2ZXIgaXMgZ29pbmcgdG8gY29uZmlndXJlIGEKUkRNQS4KIAo+IElmIHRoaXMgY2FuIGJlIHJl
c29sdmVkLCBJIHRoaW5rIHRoaXMgbWV0aG9kIGlzIHByb21pc2luZy4KCkFyZSB5b3UgaW5kaWNh
dGluZyB0aGlzIGlzIGEgbWFuZGF0b3J5IHByZXJlcXVpc2l0ZT8KLS0gCk1pY2hhbCBIb2NrbwpT
VVNFIExhYnMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
