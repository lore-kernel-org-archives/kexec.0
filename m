Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7b45-0001Wt-Rl
 for kexec@lists.infradead.org; Thu, 04 Feb 2021 09:36:42 +0000
Received: by mail-ed1-x52d.google.com with SMTP id c6so3351267ede.0
 for <kexec@lists.infradead.org>; Thu, 04 Feb 2021 01:36:39 -0800 (PST)
MIME-Version: 1.0
References: <1611888025-29321-1-git-send-email-kazuhito.hagio@gmail.com>
 <1611888025-29321-4-git-send-email-kazuhito.hagio@gmail.com>
 <c8d8d23b-0686-d5e6-f789-aa01ffdfd833@redhat.com>
 <OSBPR01MB1991ECD05F627F153E8651CCDDB39@OSBPR01MB1991.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB1991ECD05F627F153E8651CCDDB39@OSBPR01MB1991.jpnprd01.prod.outlook.com>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Thu, 4 Feb 2021 15:06:27 +0530
Message-ID: <CAFTCetRsa6QjjxOdD+LQRr8oWzTXHbU8RcfmgL5QVeYAprVbvg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: support flipped VA and 52-bit kernel VA
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: "kazuhito.hagio@gmail.com" <kazuhito.hagio@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, piliu <piliu@redhat.com>

SGkgS2F6dSwKCk9uIFRodSwgRmViIDQsIDIwMjEgYXQgMTE6MjYgQU0gSEFHSU8gS0FaVUhJVE8o
6JCp5bC+44CA5LiA5LuBKQo8ay1oYWdpby1hYkBuZWMuY29tPiB3cm90ZToKPgo+IEhpIFBpbmdm
YW4sIEJodXBlc2gsCj4KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+ID4gRXhjZXB0IGFu
IGNvcnJlY3Rpb24gaW4gbm90ZXMsIHRoZSByZXN0IGxvb2tzIGdvb2QgdG8gbWUuCj4gPgo+ID4g
UmV2aWV3ZWQtYnk6IFBpbmdmYW4gTGl1IDxwaWxpdUByZWRoYXQuY29tPgo+Cj4gVGhhbmsgeW91
IGZvciByZXZpZXdpbmcgYW5kIHRlc3RpbmcgdGhpcywgYXBwbGllZCB0aGUgcGF0Y2ggc2V0Lgo+
IGh0dHBzOi8vZ2l0aHViLmNvbS9tYWtlZHVtcGZpbGUvbWFrZWR1bXBmaWxlL2NvbXBhcmUvN2Yx
ODVkMi4uLmEwMjE2YjYKPgo+IEJodXBlc2gsIHRoYW5rIHlvdSBmb3IgeW91ciBsb25nIHRlcm0g
ZWZmb3J0cy4gIEkgaGFkIHRvIGRyb3AgYSBmZXcgb2YKPiB5b3VyIGlkZWFzIG1haW5seSB0byBt
YWludGFpbiBpdHMgZnVuY3Rpb25hbGl0eSBhbmQgY29tcGF0aWJpbGl0eSwgYnV0Cj4gdGhlIGJh
c2lzIG9mIHlvdXIgcGF0Y2ggd2FzIHZlcnkgaGVscGZ1bC4KClN1cmUsIG5vIHByb2JsZW0uIEkg
aGFkIHNvbWUgaXNzdWVzIHdpdGggZ21haWwgYW5kIHRoZSBhY2NvdW50IGdvdApsb2NrZWQgZm9y
IGEgY291cGxlIG9mIGRheXMuCgpUaGFua3MgZm9yIGFsbCB5b3VyIGhlbHAuCgpUaGFua3MgdG8g
UGluZ2ZhbiBhcyB3ZWxsIGZvciB0aGUgcXVpY2sgcmV2aWV3cy4KClJlZ2FyZHMsCkJodXBlc2gK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
