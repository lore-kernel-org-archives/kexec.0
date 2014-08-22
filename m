Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKoMC-0007QZ-PW
 for kexec@lists.infradead.org; Fri, 22 Aug 2014 12:54:17 +0000
Date: Fri, 22 Aug 2014 08:53:54 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
Message-ID: <20140822125354.GH5954@redhat.com>
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com>
 <20140822031941.GB2651@dhcp-17-37.nay.redhat.com>
 <20140822123811.GD5954@redhat.com> <53F73BEB.40001@whissi.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53F73BEB.40001@whissi.de>
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
To: "Thomas D." <whissi@whissi.de>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Kees Cook <keescook@chromium.org>, WANG Chao <chaowang@redhat.com>

On Fri, Aug 22, 2014 at 02:47:39PM +0200, Thomas D. wrote:
> On 2014-08-22 14:38, Vivek Goyal wrote:
> > So may be this failure happens because new kernel stomps over page tables
> > of old kernel. But if that theory is right, then we should be able to
> > kexec using 32bit entry point of bzImage.
> > 
> > Thomas, have you had any success with that?
> 
> When I execute kexec with "--entry-32bit" (I understand that you asked
> me to try that) the new kernel will boot as expected.

Good to know that --entry-32bit option makes kexec work with kASLR
enabled. So this indeed sounds like the issue of page tables being
stomped over by new kernel.

IIUC, there are bootloaders which can use 64bit entry point of kernel. I
think they must run into similar issue too.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
