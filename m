Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from borg.tf-network.de ([62.75.218.204])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKoGA-0005lg-NS
 for kexec@lists.infradead.org; Fri, 22 Aug 2014 12:48:03 +0000
Message-ID: <53F73BEB.40001@whissi.de>
Date: Fri, 22 Aug 2014 14:47:39 +0200
From: "Thomas D." <whissi@whissi.de>
MIME-Version: 1.0
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com>
 <20140822031941.GB2651@dhcp-17-37.nay.redhat.com>
 <20140822123811.GD5954@redhat.com>
In-Reply-To: <20140822123811.GD5954@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, WANG Chao <chaowang@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Kees Cook <keescook@chromium.org>

On 2014-08-22 14:38, Vivek Goyal wrote:
> So may be this failure happens because new kernel stomps over page tables
> of old kernel. But if that theory is right, then we should be able to
> kexec using 32bit entry point of bzImage.
> 
> Thomas, have you had any success with that?

When I execute kexec with "--entry-32bit" (I understand that you asked
me to try that) the new kernel will boot as expected.

I'll now try the kernel patch...


-Thomas


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
