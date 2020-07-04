Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrWjB-0001j0-ER
 for kexec@lists.infradead.org; Sat, 04 Jul 2020 01:12:27 +0000
Subject: Re: [PATCH v3 3/3] printk: use the lockless ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <ba338fab-9e98-366b-8fd4-05d4daa14f6d@redhat.com>
 <87zh8imgs5.fsf@jogness.linutronix.de>
 <585a6a1b-931c-1034-e2cc-da2c4381751e@redhat.com>
 <20200702133110.GE14288@alley>
From: lijiang <lijiang@redhat.com>
Message-ID: <56266e04-56b2-41fa-fff1-c3437ddec929@redhat.com>
Date: Sat, 4 Jul 2020 09:12:06 +0800
MIME-Version: 1.0
In-Reply-To: <20200702133110.GE14288@alley>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Paul McKenney <paulmck@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

5ZyoIDIwMjDlubQwN+aciDAy5pelIDIxOjMxLCBQZXRyIE1sYWRlayDlhpnpgZM6Cj4gT24gVGh1
IDIwMjAtMDctMDIgMTc6NDM6MjIsIGxpamlhbmcgd3JvdGU6Cj4+IOWcqCAyMDIw5bm0MDfmnIgw
MuaXpSAxNzowMiwgSm9obiBPZ25lc3Mg5YaZ6YGTOgo+Pj4gT24gMjAyMC0wNy0wMiwgbGlqaWFu
ZyA8bGlqaWFuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+PiBBYm91dCB0aGUgVk1DT1JFSU5GTyBw
YXJ0LCBJIG1hZGUgc29tZSB0ZXN0cyBiYXNlZCBvbiB0aGUga2VybmVsIHBhdGNoCj4+Pj4gdjMs
IHRoZSBtYWtlZHVtcGZpbGUgYW5kIGNyYXNoLXV0aWxpdHkgY2FuIHdvcmsgYXMgZXhwZWN0ZWQg
d2l0aCB5b3VyCj4+Pj4gcGF0Y2godXNlcnNwYWNlIHBhdGNoKSwgYnV0LCB1bmZvcnR1bmF0ZWx5
LCB0aGUgdm1jb3JlLWRtZXNnKGtleGVjLXRvb2xzKQo+Pj4+IGNhbid0IGNvcnJlY3RseSByZWFk
IHRoZSBwcmludGsgcmluZyBidWZmZXIgaW5mb3JtYXRpb24sIGFuZCBnZXQgdGhlCj4+Pj4gZm9s
bG93aW5nIGVycm9yOgo+Pj4+Cj4+Pj4gIk1pc3NpbmcgdGhlIGxvZ19idWYgc3ltYm9sIgo+Pj4+
Cj4+Pj4gVGhlIGtleGVjLXRvb2xzKHZtY29yZS1kbWVzZykgc2hvdWxkIGFsc28gaGF2ZSBhIHNp
bWlsYXIgcGF0Y2gsIGp1c3QgbGlrZQo+Pj4+IGluIHRoZSBtYWtlZHVtcGZpbGUgYW5kIGNyYXNo
LXV0aWxpdHkuCj4+Pgo+Pj4gWWVzLCBhIHBhdGNoIGZvciB0aGlzIGlzIG5lZWRlZCAoYXMgd2Vs
bCBhcyBmb3IgYW55IG90aGVyIHJlbGF0ZWQKPj4+IHNvZnR3YXJlIGZsb2F0aW5nIGFyb3VuZCB0
aGUgaW50ZXJuZXQpLgo+Pj4KPj4+IEkgaGF2ZSBubyBSRkMgcGF0Y2hlcyBmb3Igdm1jb3JlLWRt
ZXNnLiBMb29raW5nIGF0IHRoZSBjb2RlLCBJIHRoaW5rIGl0Cj4+PiB3b3VsZCBiZSBxdWl0ZSBz
dHJhaWdodCBmb3J3YXJkIHRvIHBvcnQgdGhlIG1ha2VkdW1wZmlsZSBwYXRjaC4gSSB3aWxsCj4+
Cj4+IFllcywgaXQgc2hvdWxkIGJlIGEgc2ltaWxhciBwYXRjaC4KPj4KPj4+IHRyeSB0byBtYWtl
IHNvbWUgdGltZSBmb3IgdGhpcy4KPj4+Cj4+IFRoYXQgd291bGQgYmUgbmljZS4gVGhhbmsgeW91
LCBKb2huIE9nbmVzcy4KPj4KPj4+IEkgZG8gbm90IHdhbnQgdG8gcGF0Y2ggYW55IG90aGVyIHNv
ZnR3YXJlIGZvciB0aGlzLiBJIHRoaW5rIHdpdGggMwo+Pj4gZXhhbXBsZXMgKGNyYXNoLCBtYWtl
ZHVtcGZpbGUsIHZtY29yZS1kbWVzZyksIG90aGVycyBzaG91bGQgYmUgYWJsZSB0bwo+Pgo+PiBJ
dCdzIGdvb2QgZW5vdWdoIHRvIGhhdmUgdGhlIHBhdGNoIGZvciB0aGUgbWFrZWR1bXBmaWxlLCBj
cmFzaCBhbmQgdm1jb3JlLWRtZXNnLAo+PiB3aGljaCBjYW4gZW5zdXJlIHRoZSBrZHVtcCh1c2Vy
c3BhY2UpIHdvcmsgd2VsbC4KPiAKPiBJIGFncmVlIHRoYXQgdGhpcyB0aHJlZSBhcmUgdGhlIG1v
c3QgaW1wb3J0YW50IG9uZXMgYW5kIHNob3VsZCBiZQo+IGVub3VnaC4KPiAKPiBUaGFua3MgYSBs
b3QgZm9yIHdvcmtpbmcgb24gaXQgYW5kIHRlc3RpbmcgaXQuCj4gCk15IHBsZWFzdXJlLiBJIHdp
bGwgdGVzdCB0aGUgdm1jb3JlLWRtZXNnIGxhdGVyLgoKVGhhbmtzLgpMaWFuYm8KCj4gQmVzdCBS
ZWdhcmRzLAo+IFBldHIKPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
