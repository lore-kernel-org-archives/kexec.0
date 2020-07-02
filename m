Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqvkn-0003ik-Mr
 for kexec@lists.infradead.org; Thu, 02 Jul 2020 09:43:38 +0000
Subject: Re: [PATCH v3 3/3] printk: use the lockless ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <ba338fab-9e98-366b-8fd4-05d4daa14f6d@redhat.com>
 <87zh8imgs5.fsf@jogness.linutronix.de>
From: lijiang <lijiang@redhat.com>
Message-ID: <585a6a1b-931c-1034-e2cc-da2c4381751e@redhat.com>
Date: Thu, 2 Jul 2020 17:43:22 +0800
MIME-Version: 1.0
In-Reply-To: <87zh8imgs5.fsf@jogness.linutronix.de>
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

5ZyoIDIwMjDlubQwN+aciDAy5pelIDE3OjAyLCBKb2huIE9nbmVzcyDlhpnpgZM6Cj4gT24gMjAy
MC0wNy0wMiwgbGlqaWFuZyA8bGlqaWFuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4gQWJvdXQgdGhl
IFZNQ09SRUlORk8gcGFydCwgSSBtYWRlIHNvbWUgdGVzdHMgYmFzZWQgb24gdGhlIGtlcm5lbCBw
YXRjaAo+PiB2MywgdGhlIG1ha2VkdW1wZmlsZSBhbmQgY3Jhc2gtdXRpbGl0eSBjYW4gd29yayBh
cyBleHBlY3RlZCB3aXRoIHlvdXIKPj4gcGF0Y2godXNlcnNwYWNlIHBhdGNoKSwgYnV0LCB1bmZv
cnR1bmF0ZWx5LCB0aGUgdm1jb3JlLWRtZXNnKGtleGVjLXRvb2xzKQo+PiBjYW4ndCBjb3JyZWN0
bHkgcmVhZCB0aGUgcHJpbnRrIHJpbmcgYnVmZmVyIGluZm9ybWF0aW9uLCBhbmQgZ2V0IHRoZQo+
PiBmb2xsb3dpbmcgZXJyb3I6Cj4+Cj4+ICJNaXNzaW5nIHRoZSBsb2dfYnVmIHN5bWJvbCIKPj4K
Pj4gVGhlIGtleGVjLXRvb2xzKHZtY29yZS1kbWVzZykgc2hvdWxkIGFsc28gaGF2ZSBhIHNpbWls
YXIgcGF0Y2gsIGp1c3QgbGlrZQo+PiBpbiB0aGUgbWFrZWR1bXBmaWxlIGFuZCBjcmFzaC11dGls
aXR5Lgo+IAo+IFllcywgYSBwYXRjaCBmb3IgdGhpcyBpcyBuZWVkZWQgKGFzIHdlbGwgYXMgZm9y
IGFueSBvdGhlciByZWxhdGVkCj4gc29mdHdhcmUgZmxvYXRpbmcgYXJvdW5kIHRoZSBpbnRlcm5l
dCkuCj4gCj4gSSBoYXZlIG5vIFJGQyBwYXRjaGVzIGZvciB2bWNvcmUtZG1lc2cuIExvb2tpbmcg
YXQgdGhlIGNvZGUsIEkgdGhpbmsgaXQKPiB3b3VsZCBiZSBxdWl0ZSBzdHJhaWdodCBmb3J3YXJk
IHRvIHBvcnQgdGhlIG1ha2VkdW1wZmlsZSBwYXRjaC4gSSB3aWxsCgpZZXMsIGl0IHNob3VsZCBi
ZSBhIHNpbWlsYXIgcGF0Y2guCgo+IHRyeSB0byBtYWtlIHNvbWUgdGltZSBmb3IgdGhpcy4KPiAK
VGhhdCB3b3VsZCBiZSBuaWNlLiBUaGFuayB5b3UsIEpvaG4gT2duZXNzLgoKPiBJIGRvIG5vdCB3
YW50IHRvIHBhdGNoIGFueSBvdGhlciBzb2Z0d2FyZSBmb3IgdGhpcy4gSSB0aGluayB3aXRoIDMK
PiBleGFtcGxlcyAoY3Jhc2gsIG1ha2VkdW1wZmlsZSwgdm1jb3JlLWRtZXNnKSwgb3RoZXJzIHNo
b3VsZCBiZSBhYmxlIHRvCgpJdCdzIGdvb2QgZW5vdWdoIHRvIGhhdmUgdGhlIHBhdGNoIGZvciB0
aGUgbWFrZWR1bXBmaWxlLCBjcmFzaCBhbmQgdm1jb3JlLWRtZXNnLAp3aGljaCBjYW4gZW5zdXJl
IHRoZSBrZHVtcCh1c2Vyc3BhY2UpIHdvcmsgd2VsbC4KClRoYW5rcy4KTGlhbmJvCgo+IGltcGxl
bWVudCB0aGUgY2hhbmdlcyB0byB0aGVpciBzb2Z0d2FyZSB3aXRob3V0IG5lZWRpbmcgbXkgaGVs
cC4KPiAKPiBKb2huIE9nbmVzcwo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
