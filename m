Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKXdJ-0003AO-Gt
 for kexec@lists.infradead.org; Thu, 21 Aug 2014 19:02:50 +0000
Date: Thu, 21 Aug 2014 15:02:26 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
Message-ID: <20140821190226.GE21891@redhat.com>
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140821181000.GB21891@redhat.com>
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
To: Kees Cook <keescook@chromium.org>
Cc: "Thomas D." <whissi@whissi.de>, Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>

On Thu, Aug 21, 2014 at 02:10:00PM -0400, Vivek Goyal wrote:

[..]
> Also, I vaguely recall that there was a kernel parameter to disable kASLR.
> And kexec/kdump initially can use that paramter as a work around. What was
> that parameter.

I see that "nokaslr" will disable it at run time. I remember that we
had discussions that it can be used as a work around. But I don't see
kexec-tools or fedora kdump scripts appending "nokaslr" in kdump case.
That's strange.

Chao, would you remember anything about it. 

Thomas, can you please test kexec with "nokaslr" specified in command
line. This can atleast get you going for now till the problem is actually
fixed.

Thanks
Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
