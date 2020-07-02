Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqzKM-0006UL-SR
 for kexec@lists.infradead.org; Thu, 02 Jul 2020 13:32:35 +0000
Date: Thu, 2 Jul 2020 15:31:10 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 3/3] printk: use the lockless ringbuffer
Message-ID: <20200702133110.GE14288@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <ba338fab-9e98-366b-8fd4-05d4daa14f6d@redhat.com>
 <87zh8imgs5.fsf@jogness.linutronix.de>
 <585a6a1b-931c-1034-e2cc-da2c4381751e@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <585a6a1b-931c-1034-e2cc-da2c4381751e@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Paul McKenney <paulmck@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

T24gVGh1IDIwMjAtMDctMDIgMTc6NDM6MjIsIGxpamlhbmcgd3JvdGU6Cj4g5ZyoIDIwMjDlubQw
N+aciDAy5pelIDE3OjAyLCBKb2huIE9nbmVzcyDlhpnpgZM6Cj4gPiBPbiAyMDIwLTA3LTAyLCBs
aWppYW5nIDxsaWppYW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+IEFib3V0IHRoZSBWTUNPUkVJ
TkZPIHBhcnQsIEkgbWFkZSBzb21lIHRlc3RzIGJhc2VkIG9uIHRoZSBrZXJuZWwgcGF0Y2gKPiA+
PiB2MywgdGhlIG1ha2VkdW1wZmlsZSBhbmQgY3Jhc2gtdXRpbGl0eSBjYW4gd29yayBhcyBleHBl
Y3RlZCB3aXRoIHlvdXIKPiA+PiBwYXRjaCh1c2Vyc3BhY2UgcGF0Y2gpLCBidXQsIHVuZm9ydHVu
YXRlbHksIHRoZSB2bWNvcmUtZG1lc2coa2V4ZWMtdG9vbHMpCj4gPj4gY2FuJ3QgY29ycmVjdGx5
IHJlYWQgdGhlIHByaW50ayByaW5nIGJ1ZmZlciBpbmZvcm1hdGlvbiwgYW5kIGdldCB0aGUKPiA+
PiBmb2xsb3dpbmcgZXJyb3I6Cj4gPj4KPiA+PiAiTWlzc2luZyB0aGUgbG9nX2J1ZiBzeW1ib2wi
Cj4gPj4KPiA+PiBUaGUga2V4ZWMtdG9vbHModm1jb3JlLWRtZXNnKSBzaG91bGQgYWxzbyBoYXZl
IGEgc2ltaWxhciBwYXRjaCwganVzdCBsaWtlCj4gPj4gaW4gdGhlIG1ha2VkdW1wZmlsZSBhbmQg
Y3Jhc2gtdXRpbGl0eS4KPiA+IAo+ID4gWWVzLCBhIHBhdGNoIGZvciB0aGlzIGlzIG5lZWRlZCAo
YXMgd2VsbCBhcyBmb3IgYW55IG90aGVyIHJlbGF0ZWQKPiA+IHNvZnR3YXJlIGZsb2F0aW5nIGFy
b3VuZCB0aGUgaW50ZXJuZXQpLgo+ID4gCj4gPiBJIGhhdmUgbm8gUkZDIHBhdGNoZXMgZm9yIHZt
Y29yZS1kbWVzZy4gTG9va2luZyBhdCB0aGUgY29kZSwgSSB0aGluayBpdAo+ID4gd291bGQgYmUg
cXVpdGUgc3RyYWlnaHQgZm9yd2FyZCB0byBwb3J0IHRoZSBtYWtlZHVtcGZpbGUgcGF0Y2guIEkg
d2lsbAo+IAo+IFllcywgaXQgc2hvdWxkIGJlIGEgc2ltaWxhciBwYXRjaC4KPiAKPiA+IHRyeSB0
byBtYWtlIHNvbWUgdGltZSBmb3IgdGhpcy4KPiA+IAo+IFRoYXQgd291bGQgYmUgbmljZS4gVGhh
bmsgeW91LCBKb2huIE9nbmVzcy4KPiAKPiA+IEkgZG8gbm90IHdhbnQgdG8gcGF0Y2ggYW55IG90
aGVyIHNvZnR3YXJlIGZvciB0aGlzLiBJIHRoaW5rIHdpdGggMwo+ID4gZXhhbXBsZXMgKGNyYXNo
LCBtYWtlZHVtcGZpbGUsIHZtY29yZS1kbWVzZyksIG90aGVycyBzaG91bGQgYmUgYWJsZSB0bwo+
IAo+IEl0J3MgZ29vZCBlbm91Z2ggdG8gaGF2ZSB0aGUgcGF0Y2ggZm9yIHRoZSBtYWtlZHVtcGZp
bGUsIGNyYXNoIGFuZCB2bWNvcmUtZG1lc2csCj4gd2hpY2ggY2FuIGVuc3VyZSB0aGUga2R1bXAo
dXNlcnNwYWNlKSB3b3JrIHdlbGwuCgpJIGFncmVlIHRoYXQgdGhpcyB0aHJlZSBhcmUgdGhlIG1v
c3QgaW1wb3J0YW50IG9uZXMgYW5kIHNob3VsZCBiZQplbm91Z2guCgpUaGFua3MgYSBsb3QgZm9y
IHdvcmtpbmcgb24gaXQgYW5kIHRlc3RpbmcgaXQuCgpCZXN0IFJlZ2FyZHMsClBldHIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
