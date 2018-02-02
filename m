Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
 by merlin.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ehjIA-0008O4-AF
 for kexec@lists.infradead.org; Fri, 02 Feb 2018 21:54:43 +0000
Subject: Re: [PATCH] kexec: Allow to skip digest calculation for speed
References: <20180201231116.28077-1-jschoenh@amazon.de>
 <87h8r0jhf4.fsf@xmission.com>
From: "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Message-ID: <4d45f270-7659-4d64-69a2-a9c448875c02@amazon.de>
Date: Fri, 2 Feb 2018 22:54:22 +0100
MIME-Version: 1.0
In-Reply-To: <87h8r0jhf4.fsf@xmission.com>
Content-Language: en-US
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, kexec@lists.infradead.org

T24gMDIvMDIvMjAxOCAwMjo0MiBBTSwgRXJpYyBXLiBCaWVkZXJtYW4gd3JvdGU6Cj4gSmFuIEgu
IFNjaMO2bmhlcnIgPGpzY2hvZW5oQGFtYXpvbi5kZT4gd3JpdGVzOgo+IAo+PiBHaXZlIHRoZSBh
ZG1pbmlzdHJhdG9yIHRoZSBhYmlsaXR5IHRvIHRyYWRlIGtleGVjIHNhZmV0eSBmb3Iga2V4ZWMg
c3BlZWQKPj4gYnkgZGlzYWJsaW5nIHRoZSBkaWdlc3QgY2FsY3VsYXRpb24vdmVyaWZpY2F0aW9u
IGZvciByZWd1bGFyIGtleGVjcy4KPj4KPj4gVGhlIGJlaGF2aW9yIG9mIGtleGVjLW9uLWNyYXNo
IGlzIG5vdCB0b3VjaGVkLgo+IAo+IFRoZSBwZXJmb3JtYW5jZSBvZiB0aGUgZGlnZXN0IGNhY3Vs
YXRpb24gaXMgYWNjZXB0YWJsZSBvbiAzODZzLiAgT3IgaXQKPiB3YXMgeWVhcnMgYWdvIHdoZW4g
SSB0ZXN0ZWQgaXQgb24gYSAzODYuICBXaGF0IGlzIHRoZSBwcm9ibGVtIHlvdSBhcmUKPiBoYXZp
bmcuCj4gCj4gSXMgdGhlcmUgc29tZXRoaW5nIHNpbGx5IGxpa2UgYSBjYWNoZSBkaXNhYmxlIGlu
IHlvdXIgY29uZmlndXJhdGlvbj8KCkxhc3QgdGltZSBJIG1lYXN1cmVkLCB0aGlzIHBhdGNoIHJl
ZHVjZWQgdGhlIHRpbWUgdW50aWwgdGhlIHN5c3RlbSBpcyByZXNwb25zaXZlCmFnYWluIGFmdGVy
IGEga2V4ZWMgYnkgYWJvdXQgNTAgbXMgdG8gMTAwIG1zIGluIG15IHNldHVwcy4gVGhhdCBzZWVt
cyB0byBiZSBhYm91dAp0aGUgcmlnaHQgdGltZSBmb3IgZW5hYmxlZCBjYWNoZXMsIGp1ZGdpbmcg
ZnJvbSBhIHF1aWNrIHNoYTI1NnN1bSBvbiB0aGUgY29tbWFuZApsaW5lIGFuZCB0aGUga2VybmVs
IHNpemVzIEknbSB3b3JraW5nIHdpdGguCgpUaGVzZSA1MCBtcyB0byAxMDAgbXMgYXJlIGEgbm90
aWNlYWJsZSBmcmFjdGlvbiBvZiB0aGUgdG90YWwga2V4ZWMgdGltZSBhbmQgdGhleQphcmUgZWFz
eSB0byBhdm9pZCAtLSBjb21wYXJlZCB0byBzb21lIG90aGVyIHRpbWUgc2lua3MgaW4gdGhlIExp
bnV4IGJvb3QgcHJvY2Vzcy4KClJlZ2FyZHMKSmFuCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
