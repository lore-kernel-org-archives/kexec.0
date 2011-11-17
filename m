Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQvmD-0001FF-NF
 for kexec@lists.infradead.org; Thu, 17 Nov 2011 06:48:50 +0000
Received: by iapp10 with SMTP id p10so2000521iap.36
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 22:48:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1321462343.4198.29.camel@boudreau>
References: <1318376345.2050.20.camel@boudreau> <j9r5m5$b18$1@dough.gmane.org>
 <1321296650.2066.17.camel@boudreau>
 <CAM_iQpVJnGK6UkqS3R7xJiuHfVaeYF=j9wTBh7xOvFF3R0RYXA@mail.gmail.com>
 <1321397853.4198.21.camel@boudreau>
 <CAM_iQpUQ_3B1x+1DTuZ47DBcPbQ89cVWAqjPcR13zaNnimfQ8g@mail.gmail.com>
 <CAMMEr5m9yn7s-DoCvuRtHeJL9JEuhWWjpUS-r=cuyV4pYyOZAg@mail.gmail.com>
 <CAM_iQpX+8xwDYjz=fySg9d-DF-9ezgpcvqUeQsSieVVzTG-16w@mail.gmail.com>
 <1321462343.4198.29.camel@boudreau>
Date: Thu, 17 Nov 2011 14:48:47 +0800
Message-ID: <CAM_iQpUEc_1032u2sETTES-1oFk-EqYV+J2=yxt+NUrmUMsWwA@mail.gmail.com>
Subject: Re: Crash during vmcore_init
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: tim@edgecast.com
Cc: kexec@lists.infradead.org

T24gVGh1LCBOb3YgMTcsIDIwMTEgYXQgMTI6NTIgQU0sIFRpbSBIYXJ0cmljayA8dGltQGVkZ2Vj
YXN0LmNvbT4gd3JvdGU6Cj4KPiBBbWVyaWNvLAo+Cj4gQXR0YWNoZWQgYXJlIGRtZXNnIGFuZCBp
b21lbSBmb3IgMi42LjMyLTIxLXNlcnZlciBhbmQgMi42LjM4LTgtc2VydmVyIG9uCj4gdGhlIHNh
bWUgRGVsbCBSNzEwLiDCoEZvciAyLjYuMzItMjEtc2VydmVyIHRoZSBhbGxvY2F0aW9uIG9mIGEg
NTEyTQo+IGNyYXNoa2VybmVsIGFyZWEgc3VjY2VlZGVkLiDCoEZvciAyLjYuMzgtOC1zZXJ2ZXIg
dGhlIGFsbG9jYXRpb24gb2YgYQo+IDUxMk0gY3Jhc2hrZXJuZWwgYXJlYSBmYWlsZWQuCj4KClRo
YW5rcyBmb3IgZGlnZ2luZyB0aGlzLgoKLjMyLAoKMDAwMDAwMDAtMDAwMDBmZmYgOiBTeXN0ZW0g
UkFNCjAwMDAxMDAwLTAwMDA1ZmZmIDogcmVzZXJ2ZWQKMDAwMDYwMDAtMDAwOWZmZmYgOiBTeXN0
ZW0gUkFNCjAwMTAwMDAwLTdmNjc4ZmZmIDogU3lzdGVtIFJBTQogIDAxMDAwMDAwLTAxNTVlYzBm
IDogS2VybmVsIGNvZGUKICAwMTU1ZWMxMC0wMTg2MTE4ZiA6IEtlcm5lbCBkYXRhCiAgMDE5MzYw
MDAtMDFhNDZlYTMgOiBLZXJuZWwgYnNzCiAgMDIwMDAwMDAtMjFmZmZmZmYgOiBDcmFzaCBrZXJu
ZWwKN2Y2NzkwMDAtN2Y2OGVmZmYgOiByZXNlcnZlZAoKLjM4LAoKMDAwMDAwMDAtMDAwMGZmZmYg
OiByZXNlcnZlZAowMDAxMDAwMC0wMDA5ZmZmZiA6IFN5c3RlbSBSQU0KMDAwYTAwMDAtMDAwYmZm
ZmYgOiBQQ0kgQnVzIDAwMDA6MDAKMDAxMDAwMDAtN2Y2NzhmZmYgOiBTeXN0ZW0gUkFNCiAgMDEw
MDAwMDAtMDE1ZTFkNmMgOiBLZXJuZWwgY29kZQogIDAxNWUxZDZkLTAxYWNhMTdmIDogS2VybmVs
IGRhdGEKICAwMWJhZTAwMC0wMWQwM2ZmZiA6IEtlcm5lbCBic3MKN2Y2NzkwMDAtN2Y2OGVmZmYg
OiByZXNlcnZlZAoKYWx0aG91Z2ggdGhlIGVuZCBvZiBrZXJuZWwgYnNzIGdyb3dzLCBidXQgdGhl
cmUgc2hvdWxkIGJlIHN0aWxsCmVub3VnaCBtZW1vcnkgZm9yIGNyYXNoIGtlcm5lbCwgYXQgbGVh
c3QgMDIwMDAwMDAtMjFmZmZmZmYgc2hvdWxkCmJlIGF2YWlsYWJsZSwgZG9uJ3Qga25vdyB3aHkg
a2VybmVsIGZhaWxzIHRvIGZpbmQgaXQuLi4gSUlSQywgdGhlIGJvb3RtZW0KYWxsb2NhdG9yIHdh
cyB3cml0dGVuIGJldHdlZW4gLjMyIGFuZCAuMzguCgpBbnl3YXksIGNvdWxkIHlvdSBhZGQgImJv
b3RtZW1fZGVidWciIHRvIHlvdXIgLjM4IGtlcm5lbCB0byBzZWUKd2h5IGtlcm5lbCBmYWlscyB0
byByZXNlcnZlIGl0PwoKVGhhbmtzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
