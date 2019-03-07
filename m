Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h1pMx-00011R-9x
 for kexec@lists.infradead.org; Thu, 07 Mar 2019 09:31:17 +0000
Received: by mail-pg1-x535.google.com with SMTP id e17so10813972pgd.2
 for <kexec@lists.infradead.org>; Thu, 07 Mar 2019 01:31:13 -0800 (PST)
Received: from [10.142.108.139] ([72.163.220.12])
 by smtp.gmail.com with ESMTPSA id h64sm6920974pfj.40.2019.03.07.01.31.11
 for <kexec@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Mar 2019 01:31:12 -0800 (PST)
From: Subin P T <ptsubin@gmail.com>
Subject: machine_kexec() stuck at load_segments() in
 arch/x86/kernel/machine_kexec_64.c
Message-ID: <5032ee4d-b493-f588-2f50-6c16c7a0699c@gmail.com>
Date: Thu, 7 Mar 2019 15:01:10 +0530
MIME-Version: 1.0
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

SGVsbG8sCgpJIGFtIHRyeWluZyB0byBnZXQga2R1bXAgdG8gd29yayBvbiBteSBwbGF0Zm9ybSB3
aXRoIEludGVsIERlbnZlcnRvbiwgCkludGVsKFIpIEF0b20oVE0pIENQVSBDMzc1OC4gU0luY2Ug
SSBjb3VsZG4ndCBzZWUgdGhlIG5ldyBrZXJuZWwgYmVpbmcgCmxvYWRlZCwgSSBoYXZlIHRyaWVk
IGFkZGluZyBwcmludGsgcyBhbmQgZmlndXJlZCBvdXQgdGhpcyBpcyBiZWluZyBzdHVjayAKaW4g
bG9hZF9zZWdtZW50cygpLiBUaGlzIGlzIHdpbmRyaXZlciBMaW51eCA3IGRpc3RyaWJ1dGlvbiBh
bmQga2VybmVsIAp2ZXJzaW9uIGlzIDMuMTQgd2l0aCBjcml0aWNhbCBmaXhlcyBmcm9tIHVwc3Ry
ZWFtLiBJIGNvdWxkbid0IGZpbmQgYW55IAptYWpvciBjaGFuZ2VzIGluIGtleGVjIHJlbGF0ZWQg
ZmlsZXMgY29tcGFyZWQgdG8gd2hhdCBpcyB0aGVyZSBpbiAKY3VycmVudCBXUkw3LiBPbiBhbm90
aGVyIGRldmljZSB3aXRoIEludGVsKFIpIEF0b20oVE0pIENQVSDCoEMyNzE4LCB0aGlzIAppcyB3
b3JraW5nIGZpbmUgd2l0aG91dCBhbnkgcHJvYmxlbS4gQmVsb3cgaXMgdGhlIG91dHB1dCBvZiBr
ZXhlYyBsb2FkIApjb21tYW5kLiBXaXRoIGtleGVjIC1lLCBhbGwgSSBzZWUgaXMgWyA2MzMyLjUw
Nzk2MF0gU3RhcnRpbmcgbmV3IGtlcm5lbC4KCkNhbiB5b3UgcGxlYXNlIGhlbHAgbWUgaWRlbnRp
ZnkgdGhlIHByb2JsZW0gd2l0aCBzb21lIHBvaW50ZXJzIG9uIGhvdyB0byAKcHJvY2VlZCB3aXRo
IHRoZSBkZWJ1ZyBvciB3aGF0IHBsYWNlcyBkbyBJIG5lZWQgdG8gc3RhcnQgbG9va2luZz8KClRo
ZSBvdXRwdXQgb2Yga2V4ZWMgLWw6IGh0dHBzOi8vcGFzdGViaW4uY29tLzR6Z0FyZkt3CgpJIGhh
dmUgdGhpcyBpbiBkbWVzZwpbIMKgIMKgMC4wMDAwMDBdIFJlc2VydmluZyAyNTZNQiBvZiBtZW1v
cnkgYXQgNjQwTUIgZm9yIGNyYXNoa2VybmVsIAooU3lzdGVtIFJBTTogMTYzNTBNQikKClRoYW5r
cyBhbmQgUmVnYXJkcywKU3ViaW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
