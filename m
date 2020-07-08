Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jt2z7-0008QQ-Qj
 for kexec@lists.infradead.org; Wed, 08 Jul 2020 05:51:10 +0000
Subject: Re: [PATCH v3 3/3] printk: use the lockless ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <ba338fab-9e98-366b-8fd4-05d4daa14f6d@redhat.com>
 <87zh8imgs5.fsf@jogness.linutronix.de>
 <585a6a1b-931c-1034-e2cc-da2c4381751e@redhat.com>
 <87lfk0stiw.fsf@jogness.linutronix.de>
From: lijiang <lijiang@redhat.com>
Message-ID: <0733578f-1f9d-bbd4-0c30-a8a124f5ffa8@redhat.com>
Date: Wed, 8 Jul 2020 13:50:51 +0800
MIME-Version: 1.0
In-Reply-To: <87lfk0stiw.fsf@jogness.linutronix.de>
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
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

5ZyoIDIwMjDlubQwN+aciDAz5pelIDE5OjU0LCBKb2huIE9nbmVzcyDlhpnpgZM6Cj4gT24gMjAy
MC0wNy0wMiwgbGlqaWFuZyA8bGlqaWFuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4gQWJvdXQgdGhl
IFZNQ09SRUlORk8gcGFydCwgSSBtYWRlIHNvbWUgdGVzdHMgYmFzZWQgb24gdGhlIGtlcm5lbCBw
YXRjaAo+PiB2MywgdGhlIG1ha2VkdW1wZmlsZSBhbmQgY3Jhc2gtdXRpbGl0eSBjYW4gd29yayBh
cyBleHBlY3RlZCB3aXRoIHlvdXIKPj4gcGF0Y2godXNlcnNwYWNlIHBhdGNoKSwgYnV0LCB1bmZv
cnR1bmF0ZWx5LCB0aGUKPj4gdm1jb3JlLWRtZXNnKGtleGVjLXRvb2xzKSBjYW4ndCBjb3JyZWN0
bHkgcmVhZCB0aGUgcHJpbnRrIHJpbmcgYnVmZmVyCj4+IGluZm9ybWF0aW9uLCBhbmQgZ2V0IHRo
ZSBmb2xsb3dpbmcgZXJyb3I6Cj4+Cj4+ICJNaXNzaW5nIHRoZSBsb2dfYnVmIHN5bWJvbCIKPj4K
Pj4gVGhlIGtleGVjLXRvb2xzKHZtY29yZS1kbWVzZykgc2hvdWxkIGFsc28gaGF2ZSBhIHNpbWls
YXIgcGF0Y2gsIGp1c3QgbGlrZQo+PiBpbiB0aGUgbWFrZWR1bXBmaWxlIGFuZCBjcmFzaC11dGls
aXR5Lgo+IAo+IEEgcGF0Y2hlZCBrZXhlYy10b29scyBpcyBhdmFpbGFibGUgaGVyZSBbMF0uCj4g
Cj4gSSBkaWQgbm90IHRlc3QgdXNpbmcgMzItYml0IGR1bXBzIG9uIDY0LWJpdCBtYWNoaW5lcyBh
bmQgdmljZSB2ZXJzYS4gQnV0Cj4gaXQgc2hvdWxkIHdvcmsuCj4gCj4gSm9obiBPZ25lc3MKPiAK
PiBbMF0gaHR0cHM6Ly9naXRodWIuY29tL0xpbnV0cm9uaXgva2V4ZWMtdG9vbHMuZ2l0IChwcmlu
dGsgYnJhbmNoKQo+IAoKQWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaCwgdGhlIHZtY29yZS1kbWVz
ZyBjYW4gd29yay4KClRoYW5rIHlvdSwgSm9obiBPZ25lc3MuCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
